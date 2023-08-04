#!/bin/bash

# 源文件和目标文件夹路径
source_file="LogSearch/4.3/UserGuide/ProductFeatures/data-visualization/query_log.md" 
destination_folder="BestPractices/7.1/Monitor"

# 如果目标文件夹不存在，则创建它
mkdir -p "$destination_folder"

# 将文件移动到目标文件夹
cp "$source_file" "$destination_folder"

# 如果源文件包含图片，将图片复制到目标文件夹
image_extensions=("jpg" "jpeg" "png" "gif" "bmp")
source_image_folder="LogSearch/4.3/UserGuide/ProductFeatures/data-visualization/media"
destination_image_folder="BestPractices/7.1/BASIC"

for ext in "${image_extensions[@]}"; do
    for image in $(grep -oE "[^/]*\.$ext" "${destination_folder}/query_log.md"); do
        # 如果目标图片文件夹不存在，则创建它
        mkdir -p "$destination_image_folder"

        # 复制图片到目标文件夹
        cp "${source_image_folder}/${image}" "${destination_image_folder}"
    done
done

echo "文件和图片已成功移动！"
echo 1 
