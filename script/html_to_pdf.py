import pdfkit
import os
import sys 


args = sys.argv[1]

path_wk = args #安装位置 , wkhtmltopdf程序位置
# path_wk = r'D:\wkhtmltopdf\bin\wkhtmltopdf.exe' #安装位置 , wkhtmltopdf程序位置

config = pdfkit.configuration(wkhtmltopdf = path_wk)

options = {
    'page-size': 'Letter',
    'margin-top': '0.85in',
    'margin-right': '0.85in',
    'margin-bottom': '0.85in',
    'margin-left': '0.85in',
    'encoding': "utf-8",
    'enable-local-file-access': None  #如果有301报错加上此配置
}


for home, dirs, files in os.walk('html'):
    for filename in files:
        file_path = os.path.join(home, filename)
        try:
            with open(file_path, encoding='utf-8') as f:
                pdfkit.from_file(
                    f,
                    '../ZH/{0}/{0}.pdf'.format(filename.split('.')[0]),
                    configuration=config,
                    options=options
                )
        except OSError:
            continue


