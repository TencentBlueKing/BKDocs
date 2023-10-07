# 监控平台运行模式切换

> 该文档适用于社区版 6.2.1 监控平台运行模式的切换

## 确认运行模式

首先，请确认当前环境上是以哪种模式运行，再根据当前运行的模式选择对应的切换方案。

lite 代表轻量化， stable 代表完整版。

```bash
source $CTRL_DIR/utils.fc
echo $BK_MONITOR_RUN_MODE
```

## 轻量化 (lite) 切换至完整版 (stable)

### 修改运行标识

```bash
if  [[ -f "$CTRL_DIR/bin/03-userdef/bkmonitorv3.env" ]];then
    if grep -q "BK_MONITOR_RUN_MODE" "$CTRL_DIR/bin/03-userdef/bkmonitorv3.env"; then
        sed -i "s#BK_MONITOR_RUN_MODE=.*#BK_MONITOR_RUN_MODE=stable#g" "$CTRL_DIR/bin/03-userdef/bkmonitorv3.env"
    else
        echo "BK_MONITOR_RUN_MODE=stable" >> $CTRL_DIR/bin/03-userdef/bkmonitorv3.env
    fi
else
    echo "BK_MONITOR_RUN_MODE=stable" >> $CTRL_DIR/bin/03-userdef/bkmonitorv3.env
fi
```

### 重新渲染变量

```bash
./bkcli install bkenv
./bkcli sync common
```

### 重新部署监控平台

```bash
./bkcli install bkmonitorv3
```

### 检查监控平台

```bash
./bkcli check bkmonitorv3
```

## 完整版 (stable) 切换至轻量化 (lite)

### 修改运行标识

```bash
if  [[ -f "$CTRL_DIR/bin/03-userdef/bkmonitorv3.env" ]];then
    if grep -q "BK_MONITOR_RUN_MODE" "$CTRL_DIR/bin/03-userdef/bkmonitorv3.env"; then
        sed -i "s#BK_MONITOR_RUN_MODE=.*#BK_MONITOR_RUN_MODE=lite#g" "$CTRL_DIR/bin/03-userdef/bkmonitorv3.env"
    else
        echo "BK_MONITOR_RUN_MODE=lite" >> $CTRL_DIR/bin/03-userdef/bkmonitorv3.env
    fi
else
    echo "BK_MONITOR_RUN_MODE=lite" >> $CTRL_DIR/bin/03-userdef/bkmonitorv3.env
fi
```

### 重新渲染变量

```bash
./bkcli install bkenv
./bkcli sync common
```

### 重新部署监控平台

```bash
./bkcli install bkmonitorv3
```

### 检查监控平台

```bash
./bkcli check bkmonitorv3
```
