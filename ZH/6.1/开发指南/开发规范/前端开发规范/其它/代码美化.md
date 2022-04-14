如果快速地对项目的代码进行美化呢，推荐使用 gulp + jsbeautifier

- 安装 Node 运行环境，查看是否成功
```bash
node -v
```

- 进入项目根目录，运行终端，初始化 package.json
```bash
npm init
```

- 安装 gulp（如果有网络问题可以使用 tnpm）
```bash
npm install --save-dev gulp
```

- 安装 jsbeautifier

```bash
npm install --save-dev gulp-jsbeautifier
```

- 在根目录配置`gulpfile.js`，以下是参考配置
```bash
var gulp = require('gulp');
var prettify = require('gulp-jsbeautifier');

gulp.task('prettify', function() {
    /**
    * source 需要美化的代码目录
    * dist 美化后保存的目录
    */
    var htmlPathConf = {
        source: ['./templates/home_app/*.html', './templates/home_app/*.part'],
        dist: './templates/home_app'
    };

    var cssPathConf = {
        source: ['./static/css/*.css'],
        dist: './static/css'
    };

    var jsPathConf = {
        source: ['./static/js/*.js'],
        dist: './static/js'
    };

    // html 配置
    gulp.src(htmlPathConf.source)
        .pipe(prettify({
            'indent_size': 4, 
            'indent_char': ' ',
            'html': {
                'file_types': ['.html', '.part']
            }
        }))
        .pipe(gulp.dest(htmlPathConf.dist));

    // css 配置
    gulp.src(cssPathConf.source)
        .pipe(prettify({
            'indent_size': 4, 
            'indent_char': ' '
        }))
        .pipe(gulp.dest(cssPathConf.dist));

    // js 配置
    gulp.src(jsPathConf.source)
        .pipe(prettify({
            'indent_size': 4, 
            'indent_char': ' '
        }))
        .pipe(gulp.dest(jsPathConf.dist));
});

```

- 在根目录运行命令

```bash
gulp prettify
```