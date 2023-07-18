import os

search_term = "账号"  # 搜索关键词
support_path = "."  # 当前目录

print("开始了")
# 遍历 support 文件夹下所有 .md 文件
for root, dirs, files in os.walk(os.path.join(support_path, "support")):
    for file in files:
        print("找到了")
        if file.endswith(".md"):
            
            file_path = os.path.join(root, file)
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()
                if search_term in content:
                    print("到这步")
                    print(file_path)
print("结束了")