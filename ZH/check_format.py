import sys
import os
import re
import json
import yaml


def get_all_summary():
    """ 
    遍历所有SUMMARY文件，将其目录添加到一个数组中
    :return: summary_list:  list <- 由所有SUMMARY文件的目录地址组成
    """
    summary_list = []
    for home, dirs, files in os.walk('6.0'):
        for filename in files:
            if filename == 'SUMMARY.md':
                summary_list.append(os.path.join(home, filename).replace('\\', '/'))
    return summary_list


def get_catalog_list(summary_list):
    """
    读取所有 SUMMARY.md 文件的内容，获取所有非空白行
    :param summary_list: list <- 由 get_all_summary 返回
    :return: catalog_list: list <- 由多个 dict 组成
        每个 dict:
            name: SUMMARY 文件所在目录名字
            catalog: 由 SUMMARY 文件的每一行组成的数组
    """
    catalog_list = []
    for summary in summary_list:
        catalog = []
        with open(summary, 'r', encoding='utf-8') as f:
            for line in f:
                if re.match(r'.*\*', line):
                   catalog.append(line.strip('\n'))
        catalog_list.append({
            'name': summary[:-10],
            'catalog': catalog
        })
    return catalog_list


def get_name_path(chapter):
    """
    正则  匹配字符串中 [] 中的内容 和 () 中的内容
    :param chapter: 每一个章节，SUMMARY 文件中的一行
    :return:(chapter_name, chapter_path)元组:
            chapter_name: [] 中的内容 代表章节明
            chapter_path: () 中的内容 章节对应md文件的位置
    """
    chapter_path = re.findall(r'[(](.*?)[)]', chapter, re.S)
    chapter_name = re.findall(r'[\[](.*?)[\]]', chapter, re.S)

    return (chapter_name, chapter_path)


def get_catalog_json(catalog_list):
    """
    通过 catalog_list 中的每个catalog, 将其转为json格式，写到 bookcatalog目录下
    :param catalog_list: get_catalog_list() 的返回值
    :return:
    """
    catalog_json_list = []
    for catalog in catalog_list:
        yaml_str = ''
        name = catalog['name']
        yaml_str += 'bookname: {}\n'.format(name.split('/')[-2])
        yaml_str += 'version: {}\n'.format(name.split('/')[0])
        yaml_str += 'catalog: \n'
        chapters = catalog['catalog']
        for chapter in chapters:
            chapter_name, chapter_path = get_name_path(chapter)
            try:
                chapter_name = chapter_name[0]
                chapter_path = chapter_path[0]
            except IndexError as e:
                print(e)
                print('{}SUMMARY.md format error, check the [] and (), error code 11'.format(name))
                # sys.exit(1)
            if not chapter_path == '' and not chapter_path.startswith('6.0'):
                chapter_path = name+chapter_path
            if chapter.startswith('*'):
                yaml_str += '- name: "{}"\n'.format(chapter_name)
                yaml_str += '  have_children: {}\n'.format('True' if chapter_path == '' else 'False')
                yaml_str += '  {}: {}\n'.format(
                    'children' if chapter_path == '' else 'path',
                    chapter_path
                )
            elif chapter.startswith('    *'):
                yaml_str += '  - name: "{}"\n'.format(chapter_name)
                yaml_str += '    have_children: {}\n'.format('True' if chapter_path == '' else 'False')
                yaml_str += '    {}: {}\n'.format(
                    'children' if chapter_path == '' else 'path',
                    chapter_path
                )
            elif chapter.startswith('        *'):
                yaml_str += '    - name: "{}"\n'.format(chapter_name)
                yaml_str += '      have_children: {}\n'.format('True' if chapter_path == '' else 'False')
                yaml_str += '      {}: {}\n'.format(
                    'children' if chapter_path == '' else 'path',
                    chapter_path
                )
            elif chapter.startswith('            *'):
                yaml_str += '      - name: "{}"\n'.format(chapter_name)
                yaml_str += '        have_children: {}\n'.format('True' if chapter_path == '' else 'False')
                yaml_str += '        {}: {}\n'.format(
                    'children' if chapter_path == '' else 'path',
                    chapter_path
                )
            elif chapter.startswith('                *'):
                yaml_str += '        - name: "{}"\n'.format(chapter_name)
                yaml_str += '          have_children: {}\n'.format('True' if chapter_path == '' else 'False')
                yaml_str += '          {}: {}\n'.format(
                    'children' if chapter_path == '' else 'path',
                    chapter_path
                )
        # print(yaml_str)
        try:
            catalog_json = yaml.safe_load(yaml_str)
        except yaml.parser.ParserError as e:
            print(e)
            print('{}SUMMARY.md format error, error code 22'.format(name))
            # sys.exit(1)
        f = open(
            './bookcatalog/{}.json'.format(name.split('/')[-2]),
            'w'
        )
        f.write(json.dumps(catalog_json))
        f.close()


def check_md():
    for home, dirs, files in os.walk('bookcatalog'):
        for filename in files:
            file_path = os.path.join(home, filename)
            with open(file_path, 'rb') as f:
                book_catalog = json.load(f)

                def read_md(catalog, md_list):
                    for chapter in catalog:
                        if chapter['have_children']:
                            read_md(chapter['children'], md_list)
                        else:
                            md_path = chapter['path']
                            md_name = chapter['name']
                            md_list.append({
                                'name': md_name,
                                'path': md_path
                            })
                    return md_list
                try:
                    md_list = read_md(book_catalog['catalog'], [])
                except TypeError as e:
                    print(e)
                    print('in {0}, Some section don\'t assign md, pls check the \'()\' in the SUMMARY of {0} '.format(filename))
                    # sys.exit(1)
                for md in md_list:
                    try:
                        f = open(md['path'], 'r')
                    except FileNotFoundError as e:
                        print(e)
                        print('pls check the file or directory.')
                        # raise NotADirectoryError
                        # sys.exit(1)

                    f.close()


if __name__ == '__main__':

    catalog_list = get_catalog_list(get_all_summary())
    get_catalog_json(catalog_list)   # 写入所有目录的 json 到 bookcatalog 目录
    check_md()
    print('build the json of catalog success !')

