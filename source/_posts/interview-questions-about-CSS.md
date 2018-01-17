---
title: 【interview questions about CSS】 from牛客网
date: 2018-01-13 15:02:40
tags: [interview questions]
categories: interview questions
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
![选择器优先权](http://images.cnblogs.com/cnblogs_com/xugang/WindowsLiveWriter/CSS_148B3/jc6_002_2.png)
1.  内联样式表的权值最高 1000；
2.  ID 选择器的权值为 100
3.  Class 类选择器的权值为 10
4.  HTML 标签选择器的权值为 1 
![css selector priority](http://ou3oh86t1.bkt.clouddn.com/blog/interview-questions-about-CSS/css%20selector%20priority.png)
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
**inline-block：** 指定对象为内联块元素。（CSS2） 
**table：** 指定对象作为块元素级的表格。类同于html标签<table>（CSS2） 
inline-table： 指定对象作为内联元素级的表格。类同于html标签<table>（CSS2） 
table-caption： 指定对象作为表格标题。类同于html标签<caption>（CSS2） 
table-cell： 指定对象作为表格单元格。类同于html标签<td>（CSS2） 
table-row： 指定对象作为表格行。类同于html标签<tr>（CSS2） 
table-row-group： 指定对象作为表格行组。类同于html标签<tbody>（CSS2） 
table-column： 指定对象作为表格列。类同于html标签<col>（CSS2） 
table-column-group： 指定对象作为表格列组显示。类同于html标签<colgroup>（CSS2） 
table-header-group： 指定对象作为表格标题组。类同于html标签<thead>（CSS2） 
table-footer-group： 指定对象作为表格脚注组。类同于html标签<tfoot>（CSS2） 
run-in： 根据上下文决定对象是内联对象还是块级对象。（CSS3） 
box： 将对象作为弹性伸缩盒显示。（伸缩盒最老版本）（CSS3） 
inline-box： 将对象作为内联块级弹性伸缩盒显示。（伸缩盒最老版本）（CSS3） 
**flexbox：** 将对象作为弹性伸缩盒显示。（伸缩盒过渡版本）（CSS3） 
inline-flexbox： 将对象作为内联块级弹性伸缩盒显示。（伸缩盒过渡版本）（CSS3） 
flex： 将对象作为弹性伸缩盒显示。（伸缩盒最新版本）（CSS3） 
inline-flex： 将对象作为内联块级弹性伸缩盒显示。（伸缩盒最新版本）（CSS3）
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

