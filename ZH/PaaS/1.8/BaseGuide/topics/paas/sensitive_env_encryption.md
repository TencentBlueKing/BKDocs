# 敏感环境变量加密

## 功能说明

开启「敏感环境变量加密」功能开关后，平台会对容器中注入的敏感环境变量进行加密存储和展示，例如增强服务提供的数据库密码、开发者标记为敏感的自定义环境变量等。这样可以避免敏感信息以明文形式出现在平台页面和配置记录中。

应用启动时，平台还会注入解密所需的信息。使用蓝鲸 Go / Python 开发框架的应用会自动完成解密，业务代码仍可按原有方式读取环境变量，无需改造。

该功能只改变敏感变量在平台侧和容器启动时的传递方式，不改变变量名、业务代码读取方式或变量的生效环境。修改环境变量或开关配置后，需重新部署应用，新的配置才会注入到运行容器中。

## 使用前须知

- 仅已被平台识别或标记为敏感的环境变量会加密；普通环境变量不受影响。
- 加密保护的是变量的存储与展示。应用运行过程中仍需要使用明文，因此请继续遵循最小权限原则，避免在日志、异常信息和调试输出中打印敏感变量。
- `BKPAAS_ENCRYPT_SECRET_KEY` 和 `BKPAAS_ENCRYPTED_ENV_KEYS` 是平台为解密流程注入的内部环境变量，请勿在应用中修改、覆盖或输出其值。
- 未使用蓝鲸开发框架的应用需要自行解密，并且必须在应用入口、读取任何敏感变量之前执行。否则包级变量、初始化逻辑或依赖库可能会读到密文。

> 提示：若未开启此功能，或当前应用没有需解密的敏感变量，以下示例会直接返回，不会影响应用启动。

## Python 解密示例

```python
import os

from blue_krill.encrypt.handler import EncryptHandler
from blue_krill.encoding import force_bytes

CIPHER_PREFIX = "bkpaas_enc$"


def decrypt_encrypted_environment():
    """解密 PaaS 平台注入的加密环境变量（原地替换为明文）。

    必须在应用入口最先调用，确保后续所有 os.environ.get 读到的是明文。
    """
    key = os.environ.get("BKPAAS_ENCRYPT_SECRET_KEY")
    encrypted_keys = os.environ.get("BKPAAS_ENCRYPTED_ENV_KEYS", "")
    if not key or not encrypted_keys:
        return  # 平台未开启加密，无需处理

    handler = EncryptHandler(secret_key=force_bytes(key))
    for name in encrypted_keys.split(","):
        name = name.strip()
        if not name:
            continue
        raw = os.environ.get(name, "")
        if raw.startswith(CIPHER_PREFIX):
            os.environ[name] = handler.decrypt(raw[len(CIPHER_PREFIX):])
```

在 WSGI、ASGI 或其他 Python 应用中，请将 `decrypt_encrypted_environment()` 放在加载 Django、Flask 等框架配置，以及导入可能读取环境变量的业务模块之前。

## Go 解密示例

> 提示：若已有 `init()` 或包级变量在 `main()` 之前读取敏感变量，需把读取推迟到 `DecryptEncryptedEnvironment()` 之后，或把解密调用前置到最早的 `init()` 中。

```go
package main

import (
    "crypto/cipher"
    "encoding/base64"
    "fmt"
    "log"
    "os"
    "strings"

    "github.com/emmansun/gmsm/sm4"
    "github.com/fernet/fernet-go"
)

const (
    paasEncryptSecretKeyEnv = "BKPAAS_ENCRYPT_SECRET_KEY" // 平台注入的解密密钥
    paasEncryptedEnvKeysEnv = "BKPAAS_ENCRYPTED_ENV_KEYS" // 平台注入的、需解密的环境变量名（逗号分隔）
    paasCipherPrefix        = "bkpaas_enc$"               // PaaS 加密密文前缀
    fernetCipherPrefix      = "bkcrypt$"                  // Fernet 算法前缀
    sm4CTRCipherPrefix      = "sm4ctr$"                   // SM4-CTR 算法前缀
)

// DecryptEncryptedEnvironment 原地解密 PaaS 平台注入的加密环境变量。
// 必须在应用入口最先调用，确保后续所有 os.Getenv 读到的是明文。
func DecryptEncryptedEnvironment() error {
    secretKey := os.Getenv(paasEncryptSecretKeyEnv)
    encryptedKeys := os.Getenv(paasEncryptedEnvKeysEnv)
    if secretKey == "" || encryptedKeys == "" {
        return nil // 平台未开启加密，无需处理
    }

    for _, name := range strings.Split(encryptedKeys, ",") {
        name = strings.TrimSpace(name)
        if name == "" {
            continue
        }

        raw := os.Getenv(name)
        if !strings.HasPrefix(raw, paasCipherPrefix) {
            continue // 非平台加密的值，跳过
        }

        plaintext, err := decryptEncryptedValue(secretKey, strings.TrimPrefix(raw, paasCipherPrefix))
        if err != nil {
            return fmt.Errorf("decrypt environment variable %s: %w", name, err)
        }
        if err := os.Setenv(name, plaintext); err != nil {
            return fmt.Errorf("set decrypted environment variable %s: %w", name, err)
        }
    }
    return nil
}

// decryptEncryptedValue 按密文前缀选择解密算法，与 PaaS 平台 EncryptHandler 对齐。
func decryptEncryptedValue(secretKey, payload string) (string, error) {
    switch {
    case strings.HasPrefix(payload, fernetCipherPrefix):
        return decryptFernet(secretKey, payload)
    case strings.HasPrefix(payload, sm4CTRCipherPrefix):
        return decryptSM4CTR(secretKey, payload)
    default:
        return payload, nil // 兼容无前缀的历史密文，按原文返回
    }
}

func decryptFernet(secretKey, payload string) (string, error) {
    key, err := fernet.DecodeKey(secretKey)
    if err != nil {
        return "", fmt.Errorf("decode Fernet key: %w", err)
    }
    token := []byte(strings.TrimPrefix(payload, fernetCipherPrefix))
    plaintext := fernet.VerifyAndDecrypt(token, 0, []*fernet.Key{key})
    if plaintext == nil {
        return "", fmt.Errorf("invalid Fernet token")
    }
    return string(plaintext), nil
}

func decryptSM4CTR(secretKey, payload string) (string, error) {
    if len(secretKey) < sm4.BlockSize {
        return "", fmt.Errorf("invalid PaaS SM4 encryption secret key")
    }
    ciphertextWithIV, err := base64.StdEncoding.DecodeString(strings.TrimPrefix(payload, sm4CTRCipherPrefix))
    if err != nil {
        return "", fmt.Errorf("decode SM4-CTR token: %w", err)
    }
    if len(ciphertextWithIV) < sm4.BlockSize {
        return "", fmt.Errorf("invalid SM4-CTR token length")
    }
    block, err := sm4.NewCipher([]byte(secretKey[:sm4.BlockSize]))
    if err != nil {
        return "", fmt.Errorf("initialize SM4 cipher: %w", err)
    }
    plaintext := make([]byte, len(ciphertextWithIV)-sm4.BlockSize)
    cipher.NewCTR(block, ciphertextWithIV[:sm4.BlockSize]).XORKeyStream(plaintext, ciphertextWithIV[sm4.BlockSize:])
    return string(plaintext), nil
}

func main() {
    // 关键：在读取任何敏感环境变量之前，于应用入口最先执行解密。
    if err := DecryptEncryptedEnvironment(); err != nil {
        log.Fatalf("decrypt encrypted environment failed: %v", err)
    }

    // 此后业务代码照常读取，拿到的即为明文。
    // dbPassword := os.Getenv("DB_PASSWORD")
    // _ = dbPassword
}
```

## 排查建议

如果应用启动后读取到以 `bkpaas_enc$` 开头的值，通常表示解密逻辑执行过晚或未执行。请确认应用使用了支持该功能的蓝鲸开发框架；否则，检查解密函数是否在所有配置加载、包初始化和业务代码之前调用。解密失败时应让应用启动失败并保留错误上下文，但不要在错误信息中打印密文或解密密钥。
