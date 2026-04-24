#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""扫描图片目录（assets、img、images 等），并统计在产品目录中的引用情况。"""

import argparse
from pathlib import Path
import re
import sys

IMAGE_EXTS = {'.png', '.jpg', '.jpeg', '.gif', '.bmp', '.svg', '.webp', '.ico'}
SCAN_FILE_EXTS = {'.md', '.markdown', '.html', '.htm', '.yml', '.yaml', '.json', '.txt'}
IMAGE_DIRS = {'assets', 'img', 'images'}  # 支持的图片目录名称

REFERENCE_RE = re.compile(
    r"(?:src|href)=[\"'](?P<path>[^\"']*(?:assets|img|images)/[^\"']+)[\"']|"  # html src/href
    r"!\[[^\]]*\]\((?P<md>[^)]+(?:assets|img|images)/[^)]+)\)|"  # markdown ![](...)
    r"(?P<plain>(?:assets|img|images)/[^\s)\]\"']+)"  # plain assets/... or img/... or images/...
)


def collect_images(assets_dir):
    assets_dir = Path(assets_dir).expanduser().resolve()
    if not assets_dir.exists() or not assets_dir.is_dir():
        raise FileNotFoundError(f"assets 目录不存在：{assets_dir}")

    images = []
    for p in assets_dir.rglob('*'):
        if p.is_file() and p.suffix.lower() in IMAGE_EXTS:
            images.append(p)
    return sorted(images)


def collect_references(product_dir):
    product_dir = Path(product_dir).expanduser().resolve()
    if not product_dir.exists() or not product_dir.is_dir():
        return set()

    refs = set()
    for p in product_dir.rglob('*'):
        if not p.is_file():
            continue
        if p.suffix.lower() not in SCAN_FILE_EXTS:
            continue
        try:
            text = p.read_text(encoding='utf-8', errors='ignore')
        except Exception:
            continue

        for m in REFERENCE_RE.finditer(text):
            for group in ('path', 'md', 'plain'):
                candidate = m.group(group)
                if not candidate:
                    continue
                candidate = candidate.strip()
                candidate = candidate.strip('"\'')
                candidate = candidate.replace('\\', '/')
                # 去掉可能的查询参数或锚点
                candidate = re.split('[#?]', candidate, 1)[0]
                refs.add(candidate)

        # 兼容直接引用文件名的情况（图片名相同）
        for ext in IMAGE_EXTS:
            # 语法上很容易误判，但仅作为补充
            pattern = rf"\\b[^\\s\"'()]*{re.escape(ext)}\\b"
            for token in re.findall(pattern, text, flags=re.IGNORECASE):
                if 'assets/' in token:
                    token = token.split('assets/')[-1]
                    refs.add('assets/' + token)

    return refs


def image_used_in_refs(img_path, refs, assets_dir):
    img_rel = str(img_path.relative_to(assets_dir)).replace('\\', '/')
    img_name = img_path.name.lower()
    
    # 生成可能的引用前缀（assets/、img/、images/ 等）
    possible_keys = [f"{dir_name}/{img_rel}" for dir_name in IMAGE_DIRS]

    for r in refs:
        r_norm = r.strip().replace('\\', '/')
        # 检查是否匹配任何可能的目录前缀
        if any(r_norm.endswith(key) for key in possible_keys) or r_norm.endswith(img_rel) or r_norm.endswith(img_name):
            return True
    return False


def scan_specific_assets(assets_dir):
    """扫描特定的图片目录"""
    assets_dir = Path(assets_dir).expanduser().resolve()

    images = collect_images(assets_dir)
    if not images:
        print(f"未找到图片文件：{assets_dir}")
        return 1

    # 自动从图片目录路径定位到产品目录（ZH 下的第一层目录）
    auto_product_candidate = None
    zh_root = None
    
    for parent in assets_dir.parents:
        if parent.name.upper() == 'ZH':
            zh_root = parent
            break
        # 检查上一级是否为 ZH
        if parent.parent and parent.parent.name.upper() == 'ZH':
            auto_product_candidate = parent
            zh_root = parent.parent
            break

    if not auto_product_candidate or not zh_root:
        print(f"无法从图片目录路径定位到 ZH 下的产品目录：{assets_dir}")
        return 1

    products = [auto_product_candidate]

    total_unused = 0
    for product_dir in products:
        refs = collect_references(product_dir)
        unused = []

        for img_path in images:
            if not image_used_in_refs(img_path, refs, assets_dir):
                unused.append(img_path.relative_to(Path.cwd()))

        # 统一输出格式，无论有没有未引用图片
        print(f"\n产品：{product_dir.name}，图片目录位置：{assets_dir.relative_to(zh_root)}")
        print(f"图片数量：{len(images)}，未引用图片数：{len(unused)}")
        for u in unused:
            print(u)
        total_unused += len(unused)

    print(f"\n扫描完成。产品数量：{len(products)}，图片数量：{len(images)}，未引用图片总数：{total_unused}")
    return 0


def scan_all_products():
    """全量扫描：遍历 ZH 下的每个产品，找出该产品的 assets 目录并扫描"""
    zh_root = Path('ZH').expanduser().resolve()
    if not zh_root.exists() or not zh_root.is_dir():
        print(f"ZH 目录不存在：{zh_root}")
        return 1

    products = sorted([p for p in zh_root.iterdir() if p.is_dir()])
    if not products:
        print(f"未找到产品子目录：{zh_root}")
        return 1

    total_unused = 0
    global_image_count = 0

    for product_dir in products:
        # 查找该产品下的所有图片目录（assets、img、images 等）
        image_dirs = []
        for img_dir_name in IMAGE_DIRS:
            for p in product_dir.rglob(img_dir_name):
                if p.is_dir() and p.name == img_dir_name:
                    image_dirs.append(p)

        if not image_dirs:
            continue

        for assets_dir in image_dirs:
            try:
                images = collect_images(assets_dir)
            except FileNotFoundError:
                continue

            if not images:
                continue

            global_image_count += len(images)
            refs = collect_references(product_dir)
            unused = []

            for img_path in images:
                if not image_used_in_refs(img_path, refs, assets_dir):
                    unused.append(img_path.relative_to(Path.cwd()))

            # 统一输出格式，无论有没有未引用图片
            print(f"\n产品：{product_dir.name}，图片目录位置：{assets_dir.relative_to(zh_root)}")
            print(f"图片数量：{len(images)}，未引用图片数：{len(unused)}")
            for u in unused:
                print(u)
            total_unused += len(unused)

    print(f"\n扫描完成。产品数量：{len(products)}，图片总数：{global_image_count}，未引用图片总数：{total_unused}")
    return 0


def scan(assets_dir=None):
    """主扫描函数"""
    if assets_dir:
        return scan_specific_assets(assets_dir)
    else:
        return scan_all_products()


def main():
    parser = argparse.ArgumentParser(description='扫描 assets 图片在 ZH 产品目录中的引用情况')
    parser.add_argument('--assets-dir', '--asseets-dir', dest='assets_dir', default=None, help='指定特定图片目录；不指定则全量扫描 ZH 下所有产品的 assets')
    args = parser.parse_args()

    code = scan(args.assets_dir)
    sys.exit(code)


if __name__ == '__main__':
    main()
