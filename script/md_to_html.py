import os
import markdown
import json
import re


def replace_img_path(md_file, path):
    """
    在 md 文件中将图片链接拼接为绝对路径
    :param md_file: string -> md文件内容
    :param path: string  -> 拼接的 path
    :return: string -> 图片链接替换后的新 md 文件
    """
    img_patten = r'!\[.*?\]\((.*?)\)|<img.*?src=[\'\"](.*?)[\'\"].*?>'
    matches = re.compile(img_patten).findall(md_file)

    if matches and len(matches) > 0:
        for match in matches:
            old_path = match[0] if match[0] else match[1]
            # print(old_path)
            start = old_path.split('/')[0]
            if start == '..':
                if old_path.split('/')[1] == '..':
                    if old_path.split('/')[2] == '..':
                        new_path = '/'.join(path[:-3]) + '/' + '/'.join(old_path.split('/')[3:])
                    else:
                        new_path = '/'.join(path[:-2]) + '/' + '/'.join(old_path.split('/')[2:])
                else:
                    new_path = '/'.join(path[:-1]) + '/' + '/'.join(old_path.split('/')[1:])
            elif start == '.':
                new_path = '/'.join(path) + '/' + old_path[2:]
            else:
                new_path = '/'.join(path) + '/' + old_path
            new_path = os.getcwd() + '/' + new_path  # '' 这里字符串是拼接绝对路径
            # print(new_path)
            md_file = md_file.replace(old_path, new_path)
    return md_file


def md_to_html(md_url_list):
    """
    将 md 转换为 html
    :param md_url_list:
    :return:
    """
    exts = [
        'markdown.extensions.extra',
        'markdown.extensions.codehilite',
        'markdown.extensions.tables',
        'markdown.extensions.toc'
    ]
    html = '''
    <html lang="zh-cn">
    <head>
    <meta content="text/html; charset=utf-8" http-equiv="content-type" />
    <link href="{}/default.css" rel="stylesheet">
    </head>
    <body>
    {}
    </body>
    </html>
    '''
    ret = ''
    for md_url in md_url_list:
        with open(md_url, encoding='utf-8') as f:
            md = f.read()
            path = md_url.split('/')[:-1]
            # print(path)
            md = replace_img_path(md, path)

            ret += markdown.markdown(md, extensions=exts)
            #ret += markdown.markdown(md) 如果有参数报错请用此配置

    return html.format(os.getcwd(), ret)


def get_catalog(file_path):
    with open(file_path, 'rb') as f:
        catalog = json.load(f)
    return catalog


def get_md_list(catalog):
    def read_md(catalog, md_list):
        for chapter in catalog:
            if chapter['have_children']:
                read_md(chapter['children'], md_list)
            else:
                md_path = chapter['path']
                md_list.append(
                    md_path
                )
        return md_list

    md_list = read_md(catalog['catalog'], [])

    return md_list


if __name__ == '__main__':
    exts = [
        'markdown.extensions.extra',
        'markdown.extensions.codehilite',
        'markdown.extensions.tables',
        'markdown.extensions.toc'
    ]
    for home, dirs, files in os.walk('bookcatalog'):
        for filename in files:
            file_path = os.path.join(home, filename)
            catalog = get_catalog(file_path)
            md_list = get_md_list(catalog)
            print(md_list)
            html = md_to_html(md_list)
            # href_patten = r'<a href="(.*?)">'
            # hrefs = re.compile(href_patten).findall(html)
            # print(hrefs)
            # if hrefs:
            #     for href in hrefs:
            #         print(href)
            #         if href.endswith('md'):
            #             html.replace(href,'')
            with open(
                './HTML/{}.html'.format(file_path.split('\\')[-1].split('.')[0]),
                'w',
                encoding='utf-8'
            ) as f:
                f.write(html)

