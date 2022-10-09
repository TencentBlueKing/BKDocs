# 1. 移动设备适配

## 1.1 基础概念

### 1.1.1 设备像素
 
从 iphone 4 发布会引入“视网膜屏”的概念之后，市面上移动设备显示屏的清晰度有了比较大的发展，各厂商不断推出了高分屏机型，单位面积的屏幕里被塞入了越来越多像素，正是因为这些高分屏出现的缘故，我们需要搞先清楚以下几个概念：

  1. 物理像素
物理像素是设备上实际存在的真实物理单元。设备的分辨率值表示在横纵坐标上分别有多少个物理像素点，例如 iphone X 的分辨率为 1125px*2436px，那就表示它在水平方向每一行有 1125 个物理像素点，垂直方向每一列有 2436 个物理像素点。

  2. 设备独立像素（Device Independent Pixels）
设备独立像素是一个长度单位，在页面缩放比例为 100% 时，等于前端开发者常用 css 像素单位，设备的 dips 由设备硬件和系统底层软件标定，它确定了开发者可使用的尺寸，例如 iphone X 的分辨率较高，但是实际可使用设备独立像素为 375px*812px

  3. 设备像素比（Device Pixel Ratio）
设备像素比的值为在水平或者垂直方向上，物理像素与设备独立像素的比值，可以通过 `window.devicePixelRatio` 获取。例如 iphone X 的 DPR 为 3、iphone 6/6s 的 DPR 为 2、iphone 6 plus 的 DPR 为 2.608，

### 1.1.2 视口

  1. layout viewport
移动端设备因为尺寸比较小，默认情况下，在渲染页面时通常会设置一个较大的宽度来模拟 pc 端的布局，不同的系统设置的默认值可能会不同，例如 ios 设备会设置为 980px，这个布局的视口就是 layout viewport。可通过 document.documentElement.clientWidth，document.documentElement.clientHeight 来获取页面的文档的布局宽高。
【图片占位】

  2. visual viewport
visual viweport 为视觉视口，默认等于浏览器的窗口大小， 可通过 window.innerWidth，window.innerHeight 分别获取。用户在对浏览器进行缩放时，css 像素所占的设备物理像素会发生变化，用户可见的内容也会改变，但是因为布局视口不变，页面的结构不会发生变化。

  3. ideal viewport
ideal viewport 不是固定尺寸，layout viewport 的宽度通常大于浏览器的可是区域宽度，为了确保用户能正常看到网站内容，不让页面出现横向滚动条，我们需要把 layout viewport 宽度设置为 ideal viewport 宽度。当页面缩放比例设置为 100% 时，css 像素与设备独立像素相等，ideal viewport 与 visual viewport 相等。

  4. meta 元素设置
我们可以通过 meta 元素的 viewport 来设置视口的缩放、布局宽度，从而让移动端达到理想的效果。

```html
<meta name="viewport" content="width=device-width; initial-scale=1; minimum-scale=1; maximum-scale=1; user-scalable=no;">
```
viewport 支持的属性以及值见下表：

| 属性 | 值 |
|--------|-------|
|width|viewport 宽度，支持整数或者"device-width"|
|height| viewport 高度，支持整数，一般不会手动配置|
|initial-scale|页面初始缩放比例，数字或者小数     |
|minimum-scale|允许用户缩小的最下比例，数字或者小数|
|maximum-scale|允许用户放大的最下比例，数字或者小数|
|user-scalable|是否允许用户缩放，布尔值或者"yes"、"no"|
 

## 2.1 适配方案

移动端适配不同尺寸常用的有三种方案，目前我们推荐使用 vw 布局方案。

### 2.1.1 百分比方案

对于页面结构比较简单，内容均匀分布，高度固定的场景下，可以使用百分比布局，元素的宽高、间距等大小根据父元素设置，随着设备宽高的调整，内容区域可以达到比较好的适配效果。对于图片、视频、iframe 等需要等比例缩放的元素，可以利用 padding-bottom 的值设置为百分比时，是相对于元素的 width 计算特性，采用绝对定位的方式去做处理。对于复杂的页面场景，百分比布局有比较大的局限性，百分比所参考的计算对象分散，不利于维护，图片等元素的等比例缩放需要改变原有的正常流布局等问题，所以更推荐 flexible 和 vw/vh 方案。

### 2.1.2 flexible 方案

flexible 最早是阿里应用在手机淘宝页面上的一套方案，它的核心代码比较简单，主要思路是获取浏览器的布局宽度(clientWidth)，将 html 元素的 font-size 设置为宽度的 1/10，然后页面的布局依赖 rem 单位，页面宽度变化时，通过动态设置 html 的 font-size 就可以实现多屏适配：
```js
// set 1rem = viewWidth / 10
function setRemUnit () {
    var rem = docEl.clientWidth / 10
    docEl.style.fontSize = rem + 'px'
}

setRemUnit()

// reset rem unit on page resize
window.addEventListener('resize', setRemUnit)
window.addEventListener('pageshow', function (e) {
    if (e.persisted) {
        setRemUnit()
    }
})
```

比如页面设计稿按照 iphone 6s 的分辨率为 750px*1334px 输出，设备的独立像素为 375px*617px，那么 dom 根元素 html 的 font-size 会被设置为 37.5px，那么 1 rem 等于 37.5px，设计稿上的高度为 150px 的元素，我们只需要设置为 4rem 即可。每次手动计算 px 转 rem 有点麻烦，可以利用 [postcss-px2rem](https://www.npmjs.com/package/postcss-px2rem) 插件去做自动处理。

因为移动端设备的对 vw/vh 的兼容性越来越好，得到了主流机型的支持，rem 已经被淘宝弃用，转而使用下面的 vw/vh 方案。

### 2.1.3 vw/vh 方案

vw、vh 分别表示可视视口的宽度和高度，1vw 表示视口宽度的 1/100，1vh 表示视口高度的 1/100。使用 vw 布局方案，不需要像 flexible 方案动态设置根元素的 font-size，大小单位使用 vw 即可。设计稿以 iphone 6s 分辨率为基准，设备视口宽度为 375px，那么 1vw 就等于 3.75px, 设计稿上 75px 宽度的元素，对应 20vw。同样也可以利用 [postcss-px-to-viewport](https://www.npmjs.com/package/postcss-px-to-viewport)来代替人工计算。


# 2. 静态资源优化

移动端使用的是无线网络，网络条件比较复杂，对于网页性能要求要高一些，所以需要对静态资源的请求做一些优化。

## 2.1 减少体积

图片、视频、音频拿到源文件后，一般需要压缩，保证不失真的前提下尽量减少体积。

## 2.2 CDN 缓存

对于内容基本不变化的静态资源建议放到 CDN 做缓存处理，提高资源加载速度。

## 2.3 合理切图

设计稿输出的资源，切图时拆分细一些，方便做动画效果，同时可以重复利用的 icon 可以做成 iconfont 字体文件或者拼接为 css-sprite，减少资源请求次数。

# 3. 埋点和数据统计

如果活动页面有运营数据的统计需求，开发者需要提前和相关人员确定好埋点的地方，需要上报什么数据。