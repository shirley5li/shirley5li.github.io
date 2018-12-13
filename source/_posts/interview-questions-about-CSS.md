---
title: 【interview questions about CSS】 from牛客网
date: 2018-01-13 15:02:40
tags: [面试题, CSS]
categories: 面试题
---
来自牛客网[前端面试常考知识点 HTML+CSS](https://www.nowcoder.com/ta/review-frontend?query=&asc=true&order=&page=1) 篇学习总结。
<!--more-->
### CSS 盒子模型
CSS盒子模型组成：外边距（margin）、边框（border）、内边距（padding）、内容（content）。
CSS盒子模型有两种，分别是标准 W3C 盒子模型和 IE 盒子模型。
**W3C标准盒子模型:**
![标准盒子模型示意图](http://img.blog.csdn.net/20140124141001609?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvenl1eml4aWFv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
标准W3C 盒子模型的范围包括 margin、border、padding、content， content 部分不包含其他部分。
width(content) = content
盒子模型占据的宽度= width + padding + border + margin
盒子的实际宽度大小=  width + padding + border 
**IE盒子模型:**
![IE盒子模型示意图](http://img.blog.csdn.net/20140124141131218?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvenl1eml4aWFv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
IE 盒子模型的范围也包括 margin、border、padding、content，和标准 W3C 盒子模型不同的是：IE 盒子模型的 content 部分包含了 border 和 pading。
width(content) = content + padding-left + padding-right + border-left + border-right
盒子模型占据的宽度= width + margin
盒子的实际宽度大小=  width
参考[标准盒子模型和IE盒子模型](http://blog.csdn.net/zyuzixiao/article/details/18733463)。
### CSS选择器的类型
类型：基础的选择器、组合选择器、属性选择器、伪类、伪元素。
参考[CSS选择器笔记-阮一峰](http://www.ruanyifeng.com/blog/2009/03/css_selectors.html)。
### CSS优先级、计算特殊值 ###
**优先级**
(1) 同类型，同级别的样式后者先于前者
(2) ID选择器(#example) > 类选择器(.example)|属性选择器([type="radio"])|伪类(:hover) > 标签选择器(h1)|伪元素(::before)
(3) 内联 > ID选择器 > 类|伪类|属性 > 标签|伪元素 > 继承 > 通用选择器(*)
(4) 具体 > 泛化的，特殊性即css优先级
(5) 近的 > 远的 (内联样式 > 内部样式表 > 外部样式表)
  内联样式：内嵌在元素中，`<span style="color:red">span</span>`
  内部样式表：在页面中的样式，写在`<style></style>`中的样式
  外部样式表：单独存在一个css文件中，通过link引入或import导入的样式
有个例外的情况，就是如果外部样式放在内部样式的后面，则外部样式将覆盖内部样式。
(6) !important 权重最高，比 inline style 还要高 
**选择器的优先权-计算特殊性值**
![选择器优先权](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/%E9%9D%A2%E8%AF%95%E9%A2%98%E7%9B%AE%E6%80%BB%E7%BB%93CSS%E7%AF%87/selecter%20weight.png)
1.  内联样式表的权值最高 1000；
2.  ID 选择器的权值为 100
3.  Class 类选择器的权值为 10
4.  HTML 标签选择器的权值为 1 
![css selector priority](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/%E9%9D%A2%E8%AF%95%E9%A2%98%E7%9B%AE%E6%80%BB%E7%BB%93CSS%E7%AF%87/css%20selector%20priority.png)
CSS 优先级法则：
A  选择器都有一个权值，权值越大越优先；
B  当权值相等时，后出现的样式表设置要优于先出现的样式表设置；
C  创作者的规则高于浏览者：即网页编写者设置的CSS 样式的优先权高于浏览器所设置的样式；
D  继承的CSS 样式不如后来指定的CSS 样式；
E  在同一组属性设置中标有“!important”规则的优先级最大

### 动态改变层中内容的方法 ###
通过innerHTML()，innerText()方法动态添加内容和文本。
### 常见浏览器兼容性问题与解决方案 ###
**(1)一：不同浏览器的标签默认的margin和padding不同**
问题症状：随便写几个标签，不加样式控制的情况下，各自的margin 和padding差异较大。
碰到频率:100%
解决方案：CSS样式初始化，即将使用到的有默认margin,padding值的标签的默认值置为0；或者用 `*{margin:0;padding:0;}`。但第二种方式不推荐，全局重置浏览器的默认样式，是一种粗暴的方式，会降低效率，使用第一种方式重置部分样式就可以了。
**(2)二：块属性标签float后，又有横向的margin情况下，在IE6显示margin比设置的大**
问题症状:常见症状是IE6中后面的一块被顶到下一行
碰到频率：90%（稍微复杂点的页面都会碰到，float布局最常见的浏览器兼容问题）
解决方案：在float的标签样式控制中加入 display:inline;将其转化为行内属性
备注：我们最常用的就是div+CSS布局了，而div就是一个典型的块属性标签，横向布局的时候我们通常都是用div float实现的，横向的间距设置如果用margin实现，这就是一个必然会碰到的兼容性问题。
**(3)三：设置较小高度标签（一般小于10px），在IE6，IE7，遨游中高度超出自己设置高度**
问题症状：IE6、7和遨游里这个标签的高度不受控制，超出自己设置的高度
碰到频率：60%
解决方案：给超出高度的标签设置overflow:hidden;或者设置行高line-height 小于你设置的高度。
备注：这种情况一般出现在我们设置小圆角背景的标签里。出现这个问题的原因是IE8之前的浏览器都会给标签一个最小默认的行高的高度。即使你的标签是空的，这个标签的高度还是会达到默认的行高。
**(4)四：行内属性标签，设置display:block后采用float布局，又有横向的margin的情况，IE6间距bug**
问题症状：IE6里的间距比超过设置的间距
碰到几率：20%
解决方案 ： 在display:block;后面加入display:inline;display:table;
备注：行内属性标签，为了设置宽高，我们需要设置display:block;(除了input标签比较特殊)。在用float布局并有横向的margin后，在IE6下，他就具有了块属性float后的横向margin的bug。不过因为它本身就是行内属性标签，所以我们再加上display:inline的话，它的高宽就不可设了。这时候我们还需要在display:inline后面加入display:talbe。
**(5)五：图片默认有间距**
问题症状：几个img标签放在一起的时候，有些浏览器会有默认的间距，加了问题一中提到的通配符也不起作用。
碰到几率：20%
解决方案：使用float属性为img布局
备注 ： 因为img标签是行内属性标签，所以只要不超出容器宽度，img标签都会排在一行里，但是部分浏览器的img标签之间会有个间距。去掉这个间距使用float是正道。（使用负margin，虽然能解决，但负margin本身就是容易引起浏览器兼容问题的用法，所以不建议使用）
**(6)六：标签最低高度设置min-height不兼容**
问题症状：因为min-height本身就是一个不兼容的CSS属性，所以设置min-height时不能很好的被各个浏览器兼容
碰到几率：5%
解决方案：如果我们要设置一个标签的最小高度200px，需要进行的设置为：{min-height:200px; height:auto !important; height:200px; overflow:visible;}
备注：在B/S系统前端开时，有很多情况下我们有这种需求。当内容小于一个值（如300px）时，容器的高度为300px；当内容高度大于这个值时，容器高度被撑高，而不是出现滚动条。这时候我们就会面临这个兼容性问题。
**(7)七：透明度的兼容CSS设置**
一般在ie中用的是filter:alpha(opacity=0);这个属性来设置div或者是块级元素的透明度，而在firefox中，一般就是直接使用opacity:0,对于兼容的，一般的做法就是在书写css样式的将2个都写上就行，就能实现兼容。
### 列出display的值并说明作用 ###


display： none | inline | block | list-item | inline-block | table | inline-table | table-caption | table-cell | table-row | table-row-group | table-column | table-column-group | table-footer-group | table-header-group | run-in | box | inline-box | flexbox | inline-flexbox | flex | inline-flex
默认值：inline

**none：** 隐藏对象。与visibility属性的hidden值不同，其不为被隐藏的对象保留其物理空间 
**inline：** 指定对象为内联元素。 
**block：** 指定对象为块元素。 
list-item： 指定对象为列表项目。 
**inline-block：** 指定对象为内联块元素。(CSS2)
**table：** 指定对象作为块元素级的表格。类同于html标签`<table>`(CSS2) 
inline-table： 指定对象作为内联元素级的表格。类同于html标签`<table>`(CSS2)
table-caption： 指定对象作为表格标题。类同于html标签`<caption>`(CSS2)
table-cell： 指定对象作为表格单元格。类同于html标签`<td>`(CSS2) 
table-row： 指定对象作为表格行。类同于html标签`<tr>`(CSS2) 
table-row-group： 指定对象作为表格行组。类同于html标签`<tbody>`(CSS2) 
table-column： 指定对象作为表格列。类同于html标签`<col>`(CSS2)
table-column-group：指定对象作为表格列组显示。类同于html标签`<colgroup>`(CSS2) 
table-header-group： 指定对象作为表格标题组。类同于html标签`<thead>`(CSS2)
table-footer-group：指定对象作为表格脚注组。类同于html标签`<tfoot>`(CSS2) 
run-in： 根据上下文决定对象是内联对象还是块级对象。(CSS3) 
box： 将对象作为弹性伸缩盒显示。（伸缩盒最老版本）(CSS3)  
inline-box： 将对象作为内联块级弹性伸缩盒显示。（伸缩盒最老版本）(CSS3) 
**flexbox：** 将对象作为弹性伸缩盒显示。（伸缩盒过渡版本）(CSS3) 
inline-flexbox： 将对象作为内联块级弹性伸缩盒显示。（伸缩盒过渡版本）(CSS3) 
flex： 将对象作为弹性伸缩盒显示。（伸缩盒最新版本）(CSS3)  
inline-flex： 将对象作为内联块级弹性伸缩盒显示。（伸缩盒最新版本）(CSS3) 
参考[display的32种写法](https://segmentfault.com/a/1190000012833458)。
### 居中div，居中一个浮动元素 ###
(1)非浮动元素居中：div为块级元素，居中块级元素首先要设置宽度,然后` margin:0 auto;`就居中了；还可以通过定位 方式；父级元素设置`text-align:center;`的方式等等。
参考[CSS居中完整指南](https://www.w3cplus.com/css/centering-css-complete-guide.html)。
(2)、浮动元素居中:
方法一:设置当前div的宽度，然后设置`margin-left:50%; position:relative; left:-width/2 px;`其中的left是宽度的一半。
方法二:父元素和子元素同时左浮动，然后父元素相对左移动50%，再然后子元素相对左移动-50%。
方法三:position定位等等。 
例如：

    <style>
        .box{
            position: relative;
            left:50%;
            float:left;
        }
        .item{
            position: relative;
            left:-50%;
            float:left;
            background: red;
        }
    </style>
    <div class="box">
        <div class="item">123</div>
    </div>
注：`left:50%;`这个left按照百分比来设置left值实际移动是按父容器的宽度来算，可以先看成box容器为body宽度为也就是浏览器宽度，`left:50%;`就是向右移动到中间，现在还要向左移动浮动元素item一半的距离，box的float是为了让box自身收缩，这样item的父容器的宽度就是本身的宽度了，再设置为`left:-50%;`也就是向左移动自身宽度的一半。
### 几种清除浮动的方法 ###
两种思路，五种方法。 思路1：父级定义；思路2：结尾定义。
**(1)、父级div定义 height**
原理：父级div手动定义height，就解决了父级div无法自动获取到高度的问题。 
优点：简单、代码少、容易掌握 
缺点：只适合高度固定的布局，要给出精确的高度，如果高度和父级div不一样时，会产生问题 
建议：不推荐使用，只建议高度固定的布局时使用
**(2)、结尾处加空div标签 clear:both**
原理：在父元素中，追加空子元，即添加一个空div，并利用css提供的clear:both清除浮动，让父级div能自动获取到高度 
优点：简单、代码少、浏览器支持好、不容易出现怪问题 
缺点：不少初学者不理解原理；如果页面浮动布局多，就要增加很多空div，让人感觉很不好 
建议：不推荐使用，但此方法是以前主要使用的一种清除浮动方法 
**(3)、父级div定义 伪类:after 和 zoom** 
原理：IE8以上和非IE浏览器才支持:after，原理和方法2有点类似，zoom(IE专有属性)可解决ie6,ie7浮动问题 
优点：浏览器支持好、不容易出现怪问题（目前：大型网站都有使用，如：腾迅，网易，新浪等等） 
缺点：代码多、不少初学者不理解原理，要两句代码结合使用才能让主流浏览器都支持。
建议：推荐使用，建议定义公共类，以减少CSS代码。
**(4)、父级div定义 overflow:hidden**
原理：必须定义width或zoom:1，同时不能定义height，使用overflow:hidden时，浏览器会自动检查浮动区域的高度 
优点：简单、代码少、浏览器支持好 
缺点：不能和position配合使用，因为超出的尺寸的会被隐藏。 
建议：只推荐没有使用position或对overflow:hidden理解比较深的朋友使用。 
**(5)、父级div定义 overflow:auto**
原理：必须定义width或zoom:1，同时不能定义height，使用overflow:auto时，浏览器会自动检查浮动区域的高度 
优点：简单、代码少、浏览器支持好 
缺点：内部宽高超过父级div时，会出现滚动条。 
建议：不推荐使用，如果你需要出现滚动条或者确保你的代码不会出现滚动条就使用吧。
**(6)、使用内容生成的方式清除浮动**

    .clearfix:after {
       content:""; 
       display: block; 
       clear:both; 
    }
:after 选择器向选定的元素之后插入内容
content:""; 生成内容为空
display: block; 生成的元素以块级元素显示,
clear:both; 清除前面元素浮动带来的影响
相对于空标签闭合浮动的方法
优势：不破坏文档结构，没有副作用
弊端：代码量多
参考 [详解 清除浮动 的多种方式（clearfix）](http://blog.csdn.net/FE_dev/article/details/68954481)、 [解读浮动闭合最佳方案：clearfix](http://www.daqianduan.com/3606.html)。
### block，inline和inlinke-block细节对比 ###
- display:block
a、block元素会独占一行，多个block元素会各自新起一行。默认情况下，block元素宽度自动填满其父元素宽度。
b、block元素可以设置width,height属性。块级元素即使设置了宽度,仍然是独占一行。
c、block元素可以设置margin和padding属性。
- display:inline
a、inline元素不会独占一行，多个相邻的行内元素会排列在同一行里，直到一行排列不下，才会新换一行，其宽度随元素的内容而变化。
b、inline元素设置width,height属性无效。
c、inline元素的margin和padding属性，水平方向的padding-left, padding-right, margin-left, margin-right都产生边距效果；但竖直方向的padding-top, padding-bottom, margin-top, margin-bottom不会产生边距效果。
- display:inline-block
a、简单来说就是将对象呈现为inline对象，但是对象的内容作为block对象呈现。之后的内联对象会被排列在同一行内。比如我们可以给一个链接（a元素）inline-block属性值，使其既具有block的宽度高度特性又具有inline的同行特性。
**补充说明**
a、一般我们会用display:block，display:inline或者display:inline-block来调整元素的布局级别，其实display的参数远远不止这三种，仅仅是比较常用而已。
b、IE（低版本IE）本来是不支持inline-block的，所以在IE中对内联元素使用display:inline-block，理论上IE是不识别的，但使用display:inline-block在IE下会触发layout，从而使内联元素拥有了display:inline-block属性的表象。 
### 优雅降级和渐进增强的含义 ###
**优雅降级：** Web站点在所有新式浏览器中都能正常工作，如果用户使用的是老式浏览器，则代码会检查以确认它们是否能正常工作。为那些无法支持功能的浏览器增加候选方案，使之在旧式浏览器上以某种形式降级体验却不至于完全失效。
**渐进增强：** 从被所有浏览器支持的基本功能开始，逐步地添加那些只有新式浏览器才支持的功能,向页面增加无害于基础浏览器的额外样式和功能的。当浏览器支持时，它们会自动地呈现出来并发挥作用。 
### 浮动元素引起的问题及相应解决办法 ###
**浮动的工作原理：** 浮动元素脱离文档流，不占据空间。浮动元素碰到包含它的边框或者浮动元素的边框停留。
 **问题：**
（1）父元素的高度无法被撑开，影响与父元素同级的元素
（2）与浮动元素同级的非浮动元素会跟随其后
（3）若非第一个元素浮动，则该元素之前的元素也需要浮动，否则会影响页面显示的结构
**解决方法：**
使用CSS中的clear:both;属性来清除元素的浮动可解决问题(2)、(3)，对于问题(1)，添加如下样式，给父元素添加clearfix样式：

    .clearfix:after {
        content: ".";
        display: block;
        height: 0;
        clear: both;
        visibility: hidden;
    }
    .clearfix {
        display: inline-block; /* for IE/Mac */
    }
**清除浮动的几种方法：**
(1)、额外标签法(使用空标签清除浮动)
`<div style="clear:both;"></div>`（缺点：会增加额外的标签，使HTML结构看起来不够简洁。）
(2)、使用after伪类

    #parent:after{
      content:" ";
      height:0;
      visibility:hidden;
      display:block;
      clear:both;
    }
(3)、浮动外部元素
(4)、设置`overflow`为`hidden`或者`auto` 
### 性能优化的方法 ###
**总结一：**
（1）、减少http请求次数：CSS Sprites, JS、CSS源码压缩、图片大小控制合适；网页Gzip，CDN托管，data缓存 ，图片服务器。
（2）、前端模板 JS+数据，减少由于HTML标签导致的带宽浪费，前端用变量保存AJAX请求结果，每次操作本地变量，不用请求，减少请求次数。
（3）、用innerHTML代替DOM操作，减少DOM操作次数，优化javascript性能。
（4）、当需要设置的样式很多时设置className而不是直接操作style。
（5）、少用全局变量、缓存DOM节点查找的结果。减少IO读取操作。
（6）、避免使用CSS Expression（css表达式)又称Dynamic properties(动态属性)。
（7）、图片预加载，将样式表放在顶部，将脚本放在底部 加上时间戳。
**回答二：**
(1)、减少HTTP请求次数 
(2)、使用CDN
(3)、避免空的src和href
(4)、为文件头指定Expires
(5)、使用gzip压缩内容
(6)、把CSS放到顶部
(7)、把JS放到底部
(8)、避 免使用CSS表达式 
(9)、将CSS和JS放到外部文件中 
(10)、避免跳转 
(11)、可缓存的AJAX 
(12)、使用GET来完成AJAX请求
### 初始化CSS样式的意义 ###
因为浏览器的兼容问题，不同浏览器对有些标签的默认值是不同的(比如标签默认的margin、padding值不同等情况)，如果没对CSS初始化往往会出现浏览器之间的页面显示差异。
当然，初始化样式会对SEO有一定的影响，但鱼和熊掌不可兼得，力求影响最小的情况下初始化。
最简单的初始化方法就是： `* {padding: 0; margin: 0;}` （不建议）
### CSS中的刻度 ###
在CSS中刻度是用于设置元素尺寸的单位。
a、特殊值**0**可以省略单位。例如：`margin:0px;`可以写成`margin:0;` 
b、一些属性可能允许有**负长度**值，或者有一定的范围限制。如果不支持负长度值，那应该变换到能够被支持的最近的一个长度值。
c、**长度单位**包括：**相对单位**和**绝对单位**。 
相对长度单位有： em, ex, ch, rem, vw, vh, vmax, vmin 
绝对长度单位有： cm, mm, q, in, pt, pc, px
绝对长度单位：1in = 2.54cm = 25.4 mm = 72pt = 6pc = 96px
**文本相对长度单位：em**
相对长度单位是相对于当前对象内文本的字体尺寸，如果当前行内文本的字体尺寸未被人为设置，则相对于浏览器的默认字体尺寸。(**相对父元素的字体大小倍数**)

    body { font-size: 14px; }
    h1 { font-size: 16px; }
    .size1 p { font-size: 1em; }
    .size2 p { font-size: 2em; }
    .size3 p { font-size: 3em; }
**文本相对长度单位：rem**
rem是CSS3新增的一个相对单位（root em，根em），相对于根元素(即html元素)font-size计算值的倍数。只**相对于根元素(html元素)**的大小。
浏览器的默认字体大小为16像素，浏览器默认样式也称为user agent stylesheet，就是所有浏览器内置的默认样式，多数是可以被修改的，但chrome不能直接修改，可以被用户样式覆盖。
作用：利用rem可以实现简单的响应式布局，可以利用html元素中字体的大小与屏幕间的比值设置font-size的值实现当屏幕分辨率变化时让元素也变化，以前的天猫tmall就使用这种办法。
em与rem的重要区别：它们计算的规则一个是依赖父元素另一个是依赖根元素计算。
### box-sizing属性的用法 ###
a、`box-sizing:content-box`
padding和border不被包含在定义的width和height之内。
对象的实际宽度等于设置的width值和border、padding之和，即 ( Element width = width + border + padding，但占有页面位置还要加上margin )。
此属性表现为标准模式下的盒模型。
b、`box-sizing:border-box`
padding和border被包含在定义的width和height之内。
对象的实际宽度就等于设置的width值，即使定义有border和padding也不会改变对象的实际宽度，即 ( Element width = width )。 此属性表现为怪异模式下的盒模型。 
### 浏览器标准模式和怪异模式之间的区别 ###
所谓的标准模式是指，浏览器按W3C标准解析执行代码；
怪异模式则是使用浏览器自己的方式解析执行代码，因为不同浏览器解析执行的方式不一样，所以我们称之为怪异模式。
浏览器解析时到底使用标准模式还是怪异模式，与你网页中的DTD声明直接相关，DTD声明定义了标准文档的类型(标准模式解析)，会使浏览器使用相应的方式加载网页并显示，忽略DTD声明,将使网页进入怪异模式(quirks mode)。
### 怪异Quirks模式是什么，它和标准Standards模式有什么区别 ###
从IE6开始，引入了Standards模式，标准模式中，浏览器尝试给符合标准的文档在规范上的正确处理达到在指定浏览器中的程度。
在IE6之前CSS还不够成熟，所以IE5等之前的浏览器对CSS的支持很差， IE6将对CSS提供更好的支持，然而这时的问题就来了，因为有很多页面是基于旧的布局方式写的，而如果IE6 支持CSS则将令这些页面显示不正常，如何在即保证不破坏现有页面，又提供新的渲染机制呢？
在写程序时我们也会经常遇到这样的问题，如何保证原来的接口不变，又提供更强大的功能，尤其是新功能不兼容旧功能时。遇到这种问题时的一个常见做法是增加参数和分支，即当某个参数为真时，我们就使用新功能，而如果这个参数 不为真时，就使用旧功能，这样就能不破坏原有的程序，又提供新功能。IE6也是类似这样做的，它将DTD当成了这个“参数”，因为以前的页面大家都不会去写DTD，所以IE6就假定 如果写了DTD，就意味着这个页面将采用对CSS支持更好的布局，而如果没有，则采用兼容之前的布局方式。这就是Quirks模式（怪癖模式，诡异模式，怪异模式）。 **区别：**总体会有布局、样式解析和脚本执行三个方面的区别。
**盒模型：** 在W3C标准中，如果设置一个元素的宽度和高度，指的是元素内容的宽度和高度，而在Quirks模式下，IE的宽度和高度还包含了padding和border。
**设置行内元素的高宽：**在Standards模式下，给`<span>`等行内元素设置wdith和height都不会生效，而在quirks模式下，则会生效。
**设置百分比的高度：**在standards模式下，一个元素的高度是由其包含的内容来决定的，如果父元素没有设置百分比的高度，子元素设置一个百分比的高度是无效的。
**用margin:0 auto设置水平居中：**使`用margin:0 auto;`在standards模式下可以使元素水平居中，但在quirks模式下却会失效。
（还有很多，答出什么不重要，关键是看他答出的这些是不是自己经验遇到的，还是说都是看文章看的，甚至完全不知道。） 
### 边距折叠 ###
**外边距折叠：** 相邻的两个或多个外边距 (margin) 在垂直方向会合并成一个外边距（margin）
**相邻：** 没有被非空内容、padding、border 或 clear 分隔开的margin特性. 非空内容就是说这元素之间要么是兄弟关系或者父子关系
**垂直方向外边距合并计算:**
a、参加折叠的margin都是正值：取其中 margin 较大的值为最终 margin 值。
b、参与折叠的 margin 都是负值：取的是其中绝对值较大的，然后，从 0 位置，负向位移。
c、参与折叠的 margin 中有正值，有负值：先取出负 margin 中绝对值中最大的，然后，和正 margin 值中最大的 margin 相加。
### 隐藏元素的方式 ###
a、使用CSS的display:none，不会占有原来的位置
b、使用CSS的visibility:hidden，会占有原来的位置
c、使用HTML5中的新增属性hidden="hidden"，不会占有原来的位置 
### 为什么重置浏览器默认样式，如何重置默浏览器认样式 ###
每种浏览器都有一套默认的样式表，即user agent stylesheet，网页在没有指定的样式时，按浏览器内置的样式表来渲染。这是合理的，像word中也有一些预留样式，可以让我们的排版更美观整齐。不同浏览器甚至同一浏览器不同版本的默认样式是不同的。但这样会有很多兼容问题。
a、最简单的办法：（不推荐使用）`*{margin: 0;padding: 0;}`。
b、使用CSSReset可以将所有浏览器默认样式设置成一样。
c、normalize：也许有些cssreset过于简单粗暴，有点伤及无辜，normalize是另一个选择。bootstrap已经引用该css来重置浏览器默认样式，比普通的cssreset要精细一些，保留浏览器有用的默认样式，支持包括手机浏览器在内的超多浏览器，同时对HTML5元素、排版、列表、嵌入的内容、表单和表格都进行了一般化。
天猫 使用的css reset重置浏览器默认样式：

    body, h1, h2, h3, h4, h5, h6, hr, p, blockquote, dl, dt, dd, ul, ol, li, pre, form, fieldset, legend, button, input, textarea, th, td {margin: 0;padding: 0}
    body, button, input, select, textarea {font: 12px "microsoft yahei";line-height: 1.5;-ms-overflow-style: scrollbar}
    h1, h2, h3, h4, h5, h6 {font-size: 100%}
    ul, ol {list-style: none}a {text-decoration: none;cursor:pointer}
    a:hover {text-decoration: underline}
    img {border: 0}
    button, input, select, textarea {font-size: 100%}
    table {border-collapse: collapse;border-spacing: 0}
    .clear {clear:both}
    .fr {float:right}
    .fl {float:left}
    .block {display:block;text-indent:-999em}

### 对BFC与IFC的理解？(是什么，如何产生，作用) ###
**(1)、什么是BFC与IFC**
a、BFC（Block Formatting Context）即"块级格式化上下文"， IFC（Inline Formatting Context）即"行内格式化上下文"。常规流（也称标准流、普通流）是一个文档在被显示时最常见的布局形态。一个框在常规流中必须属于一个格式化上下文，你可以把BFC想象成一个大箱子，箱子外边的元素将不与箱子内的元素产生作用。
b、BFC是W3C CSS 2.1规范中的一个概念，它决定了元素如何对其内容进行定位，以及与其他元素的关系和相互作用。当涉及到可视化布局的时候，Block Formatting Context提供了一个环境，HTML元素在这个环境中按照一定规则进行布局。一个环境中的元素不会影响到其它环境中的布局。比如浮动元素会形成BFC，浮动元素内部子元素主要受该浮动元素影响，两个浮动元素之间是互不影响的。也可以说BFC就是一个作用范围。
c、在普通流中的 Box(框) 属于一种 formatting context(格式化上下文) ，类型可以是 block ，或者是 inline ，但不能同时属于这两者。并且， Block boxes(块框) 在 block formatting context(块格式化上下文) 里格式化， Inline boxes(块内框) 则在 Inline Formatting Context(行内格式化上下文) 里格式化。
**(2)、如何产生BFC**
当一个HTML元素满足下面条件的任何一点，都可以产生Block Formatting Context：
a、float的值不为none
b、overflow的值不为visible
c、display的值为table-cell, table-caption, inline-block中的任何一个
d、position的值不为relative和static
CSS3触发BFC方式则可以简单描述为：在元素定位非static，relative的情况下触发，float也是一种定位方式。

**(3)、BFC的作用与特点**
a、不和浮动元素重叠，清除外部浮动，阻止浮动元素覆盖。
如果一个浮动元素后面跟着一个非浮动的元素，那么就会产生一个重叠的现象。常规流（也称标准流、普通流）是一个文档在被显示时最常见的布局形态，当float不为none时，position为absolute、fixed时元素将脱离标准流。
### 对页面中使用定位(position)的理解 ###
osition：static | relative | absolute | fixed | center | page | sticky
默认值：static，center、page、sticky是CSS3中新增加的值。
**(1)、static**
可以认为静态的，默认元素都是静态的定位，对象遵循常规流。此时4个定位偏移属性不会被应用，也就是使用left，right，bottom，top将不会生效。
**(2)、relative**
相对定位，对象遵循常规流，并且参照自身在常规流中的位置通过top，right，bottom，left这4个定位偏移属性进行偏移时不会影响常规流中的任何元素。
**(3)、absolute**
a、绝对定位，对象脱离常规流，此时偏移属性参照的是离自身最近的定位祖先元素，如果没有定位的祖先元素，则一直回溯到body元素。盒子的偏移位置不影响常规流中的任何元素，其margin不与其他任何margin折叠。
b、元素定位参考的是离自身最近的定位祖先元素，要满足两个条件，第一个是自己的祖先元素，可以是父元素也可以是父元素的父元素，一直找，如果没有则选择body为对照对象。第二个条件是要求祖先元素必须定位，通俗说就是position的属性值为非static都行。
**(4)、fixed**
固定定位，与absolute一致，但偏移定位是以窗口为参考。当出现滚动条时，对象不会随着滚动。
**(5)、center**
与absolute一致，但偏移定位是以定位祖先元素的中心点为参考。盒子在其包含容器垂直水平居中。（CSS3）
**(6)、page**
与absolute一致。元素在分页媒体或者区域块内，元素的包含块始终是初始包含块，否则取决于每个absolute模式。（CSS3）
**(7)、sticky**
对象在常态时遵循常规流。它就像是relative和fixed的合体，当在屏幕中时按常规流排版，当卷动到屏幕外时则表现如fixed。该属性的表现是现实中你见到的吸附效果。（CSS3） 
### 如何解决多个元素重叠问题 ###
使用z-index属性可以设置元素的层叠顺序。
z-index属性
语法：`z-index: auto | <integer>`
默认值：auto
适用于：定位元素。即定义了position为非static的元素
**取值：**
auto： 元素在当前层叠上下文中的层叠级别是0。元素不会创建新的局部层叠上下文，除非它是根元素。 
整数： 用整数值来定义堆叠级别。可以为负值。 说明：检索或设置对象的层叠顺序。 
z-index用于确定元素在当前层叠上下文中的层叠级别，并确定该元素是否创建新的局部层叠上下文。 
当多个元素层叠在一起时，数字大者将显示在上面。
### 页面布局的方式 ###
[页面布局方式](https://www.nowcoder.com/ta/review-frontend/review?query=&asc=true&order=&page=71)。
### overflow :hidden是否形成新的块级格式化上下文 ###
会形成，触发BFC的条件有：
float的值不为none。
overflow的值不为visible。
display的值为table-cell, table-caption, inline-block 中的任何一个。
position的值不为relative 和static。 

