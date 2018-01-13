---
title: 【interview questions about HTML】 from牛客网
date: 2018-01-08 15:16:53
tags: [interview questions]
categories: interview questions
---
来自牛客网[前端面试常考知识点 HTML+CSS](https://www.nowcoder.com/ta/review-frontend?query=&asc=true&order=&page=1) 篇学习总结。
<!--more-->
### 浏览器页面有哪三层构成 ###
**浏览器页面有哪三层构成，分别是什么，作用是什么?**
浏览器页面有结构层、表示层、行为层，三层构成，分别是HTML、CSS、JavaScript，作用是HTML实现页面结构(骨架)，CSS完成页面的表现与风格(肌肤)，JavaScript实现一些客户端的功能与业务(动作)，对用户事件作出反应。
不过，在这三种技术之间存在着一些潜在的**重叠区域**，如DOM技术可以用来改变网页的结构；CSS诸如`:hover`和`:focus`之类的class伪类，使我们可以根据用户触发事件来改变呈现效果。
改变元素的呈现效果当然是表示层的“势力范围”，但对用户触发事件做出反应却是行为层的领地。表示层和行为层的这种重叠形成了一个灰色地带。class伪类是 CSS 正在深入DOM领地证据，但 DOM在这方面也不是毫无作为，完全可以利用 DOM 技术把样式信息施加在HTML元素身上。
分离的效果要做到即使去掉表示层和行为层，文档的内容也依然可以访问，因为“内容才是一切”。而且网页的行为层(javascript)与其结构(HTML)是彼此互不干扰的，不能混杂在一起。还要给行为层“预留退路”，要考虑到如果你的用户禁用了Javascript会怎样？网页是否还可以正常运作。做到**平稳退化，渐进增强**。
### HTML5的优点与缺点 ###
**HTML5是什么:**  HTML5指的是包括HTML、CSS和JavaScript在内的一套技术组合。它希望能够减少网页浏览器对于需要插件的丰富性网络应用服务（ Plug-in-Based Rich Internet Application ，RIA），例如：AdobeFlash 、Microsoft Silverlight与Oracle JavaFX的需求，并且提供更多能有效加强网络应用的标准集。 HTML5 HTML 最新版本，2014 年10月由万维网联盟（ W3C ）完成标准制定。目标是替换 1999 年所制定的 HTML 4.01和XHTML 1.0标准，以期能在互联网应用迅速发展的时候，使网络标准达到匹配当代的网络需求。
**为什么有HTML5的出现：** HTML4陈旧不能满足日益发展的互联网需要，特别是移动互联网。为了增强浏览器功能 Flash 被广泛使用，但安全与稳定堪忧，不适合在移动端使用（耗电、触摸、不开放）。HTML5增强了浏览器的原生功能，符合HTML5规范的浏览器功能将更加强大，减少了 Web应用对插件的依赖，让用户体验更好，让开发更加方便，另外W3C 从推出 HTML4.0到5.0之间共经历了17年，HTML的变化很小，这并不符合一个好产品的演进规则。
**优点：**

- 网络标准统一
HTML5本身是由W3C推荐出来的，它的开发是通过谷歌、苹果，诺基亚、中国移动等几百家公司一起酝酿的技术，这个技术最大的好处在于它是一个公开的技术。换句话说，每一个公开的标准都可以根据W3C的资料库找寻根源。另一方面，W3C通过的HTML5标准也就意味着每一个浏览器或每一个平台都会去实现。
- 多设备跨平台，可移植性好
HTML5的优点主要在于，这个技术可以进行跨平台的使用。比如你开发了一款HTML5的游戏，你可以很轻易地移植到UC的开放平台、Opera的游戏中心、Facebook应用平台,甚至可以通过封装的技术发放到AppStore或GooglePlay上，所以它的跨平台性非常强大，这也是大多数人对HTML5有兴趣的主要原因。
- 自适应网页设计
即“一次设计，普遍适用”，让同一张网页自动适应不同大小的屏幕，根据屏幕宽度，自动调整布局(layout)。
- 即时更新
游戏客户端每次都要更新，很麻烦。可是更新HTML5游戏就好像更新页面一样，是马上的、即时的更新。
- 提高可用性和改进用户的友好体验
- 增加几个新的标签，这将有助于开发人员定义重要的内容
- 可以给站点带来更多的多媒体元素(视频和音频)
- 可以很好的替代FLASH和Silverlight
Silverlight是一个跨浏览器、跨平台的插件，为网络带来下一代基于.NET媒体体验，和丰富的交互式应用程序。
- 当涉及到网站的抓取和索引的时候，对于SEO很友好
SEO，即搜索引擎优化是一种利用搜索引擎的搜索规则来提高目前网站在有关搜索引擎内的自然排名的方式。
- 将被大量应用于移动应用程序和游戏
**缺点：**

- 安全方面
像之前Firefox4的web socket和透明代理的实现存在严重的安全问题，同时web storage、web socket这样的功能很容易被黑客利用，来盗取用户的信息和资料。
- 完善性方面
许多特性各浏览器的支持程度也不一样。
- 技术门槛方面
HTML5技术开发者工作的同时，有许多新的属性和API需要开发者学习，像[web worker、web socket、web storage](http://blog.csdn.net/leledexixi/article/details/55210717)等新特性，甚至后台及浏览器原理的知识。这是机遇的同时也是巨大的挑战。
- 性能方面
某些平台上的引擎问题导致HTML5性能低下.
- 浏览器兼容性方面
IE9以下浏览器几乎不支持。

### Doctype作用 ###
**Doctype作用? 严格模式与混杂模式如何区分？它们有何意义?**
告诉浏览器应该用什么文档类型规范来解析这个文档。doctype不存在或格式不正确会导致文档以混杂模式呈现。严格模式的排版和js运作模式是以浏览器最高标准运行。混杂模式， 页面以宽松的向后兼容的形式展示。
参考博客[DOCTYPE声明](http://blog.csdn.net/Vivian_jay/article/details/61933580)。
### HTML5有哪些新特性、移除了哪些元素 ###
HTML5新增了27个元素，废弃了16个元素，根据现有的标准规范，把HTML5的元素按优先级定义为结构性元素、级块性元素、行内语义性元素和交互性元素4大类。
**结构性元素**主要负责web上下文结构的定义：
`section`：在 web 页面应用中，该元素也可以用于区域的章节描述。
`header`：页面主体上的头部， header 元素往往在一对 body 元素中。
`footer`：页面的底部（页脚），通常会标出网站的相关信息。
`nav`：专门用于菜单导航、链接导航的元素，是 navigator 的缩写。
`article`：用于表现一篇文章的主体内容，一般为文字集中显示的区域。

**级块性元素**主要完成web页面区域的划分，确保内容的有效分割。 
`aside`：用于表达注记、贴士、侧栏、摘要、插入的引用等作为补充主体的内容。
`figure`：是对多个元素进行组合并展示的元素，通常与 ficaption 联合使用。
`code`：表示一段代码块。
`dialog`：用于表达人与人之间的对话，该元素包含 dt 和 dd 这两个组合元素， dt 用于表示说话者，而 dd 用来表示说话内容。

**行内语义性元素**主要完成web页面具体内容的引用和描述，是丰富内容展示的基础。
`meter`：表示特定范围内的数值，可用于工资、数量、百分比等。
`time`：表示时间值。
`progress`：用来表示进度条，可通过对其 max 、min 、step 等属性进行控制，完成对进度的表示和监事。
`video`：视频元素，用于支持和实现视频文件的直接播放，支持缓冲预载和多种视频媒体格式。
`audio`：音频元素，用于支持和实现音频文件的直接播放，支持缓冲预载和多种音频媒体格式。

**交互性元素**主要用于功能性的内容表达，会有一定的内容和数据的关联，是各种事件的基础。 
`details`：用来表示一段具体的内容，但是内容默认可能不显示，通过某种手段（如单击）与 legend 交互才会显示出来。
`datagrid`：用来控制客户端数据与显示，可以由动态脚本及时更新。
`menu`：主要用于交互菜单（曾被废弃又被重新启用的元素）。
`command`：用来处理命令按钮。 

**移除的元素**
纯表现的元素：`<basefont>` 默认字体，不设置字体，以此渲染; `<font>` 字体标签; `<center>`水平居中; `<u>`下划线; `<big>` 大字体; `<strike>`中横线; `<tt>`文本等宽;
框架集：`<frameset>` `<noframes>` `<frame>` 
### HTML5行内元素、块级元素、空元素 ###
**行内元素**
`a ` - 锚点
`abbr` - 缩写 
`br` - 换行
`em` - 强调
`strong` - 粗体强调
`i` - 斜体
`cite` - 引用
`code` - 计算机代码 ( 在引用源码的时候需要 )
`img` - 图片
`span` - 常用内联容器，定义文本内区块
`input` - 输入框
`textarea` - 多行文本输入框
`label` - 表格标签
**块级元素**
`div` - 常用块级容易，也是 css layout 的主要标签
`p` - 段落
`h1~h6` - 大标题
`form` - 交互表单
`table` - 表格
`ol` - 排序表单
`ul` - 非排序列表
`address` - 地址
`blockquote` - 块引用
**空元素**
`<br/>` //换行
`<hr>` //分隔线
`<input>` //文本框等
`<img> <link> <meta>`
### 浏览器的内核分类 ###
IE: Trident 内核
Firefox： Gecko 内核(开源)
Safari: Webkit 内核(开源)
Chrome: Webkit 
Opera: 以前是Presto内核，现已改用Blink内核(基于Webkit, Google与Opera Software共同开发)
### 对WEB标准以及W3C的理解与认识 ###
WEB标准 不是某一个标准，而是一系列标准的集合。网页主要由三部分组成：结构（Structure）、表现（Presentation）和行为（Behavior）。对应的标准也分三方面：结构化标准语言主要包括XHTML和XML，表现标准语言主要包括CSS，行为标准主要包括对象模型（如W3C DOM）、ECMAScript等。这些标准大部分由 万维网联盟 （W3C）起草和发布，也有一些是其他标准组织制订的标准，比如ECMA（European Computer Manufacturers Association）的ECMAScript标准。
标签闭合、标签小写、不乱嵌套---》XHTML；
提高搜索机器人搜索几率--》DOM；
使用外 链css和 js 脚本---》结构行为表现的分离；
文件下载与页面速度更快、内容能被更多的用户所访问、内容能被更广泛的设备所访问；
容易维护、改版方便；
提高网站易用性。
### 什么是WebGL,它有什么优点 ###
WebGL(Web Graphics Library) 是一种 3D 绘图标准，这种绘图技术标准允许把 JavaScript 和 OpenGL ES 2.0 结合在一起，通过增加 OpenGL ES 2.0 的一个 JavaScript 绑定，WebGL 可以为 HTML5 Canvas 提供硬件 3D 加速渲染，这样 Web 开发人员就可以借助系统显卡来在浏览器里更流畅地展示3D场景和模型了，还能创建复杂的导航和数据视觉化。
WebGL 技术标准免去了开发网页专用渲染插件的麻烦，可被用于创建具有复杂 3D 结构的网站页面，甚至可以用来设计 3D 网页游戏等等。
WebGL完美地解决了现有的 Web 交互式三维动画的两个问题：第一，它通过HTML脚本本身实现Web交互式三维动画的制作，无需任何浏览器插件支持;第二，它利用底层的图形硬件加速功能进行的图形渲染，是通过统一的、标准的、跨平台的OpenGL接口实现的。
通俗的说WebGL是canvas绘图中的3D版本。因为原生的WebGL很复杂，我们经常会使用一些三方的库，如 three.js 等，这些库多数用于 HTML5 游戏开发。 
### cookie，sessionStorage 和 localStorage 的区别 ###
共同点：都是保存在浏览器端，且同源的。

区别：

 - cookie数据始终在同源的http请求中携带（即使不需要），即cookie在浏览器和服务器间来回传递。而sessionStorage和localStorage不会自动把数据发给服务器，仅在本地保存。
 - cookie数据还有路径（path）的概念，可以限制cookie只属于某个路径下。
 - 存储大小限制也不同。cookie数据不能超过4k，同时因为每次http请求都会携带cookie，所以cookie只适合保存很小的数据，如会话标识。sessionStorage和localStorage 虽然也有存储大小的限制，但比cookie大得多，可以达到5M或更大。
 - 数据有效期不同。sessionStorage：仅在当前浏览器窗口关闭前有效，自然也就不可能持久保持；localStorage：始终有效，窗口或浏览器关闭也一直保存，因此用作持久数据；cookie只在设置的cookie过期时间之前一直有效，即使窗口或浏览器关闭。
 - 作用域不同。sessionStorage不在不同的浏览器窗口中共享，即使是同一个页面；localStorage 在所有同源窗口中都是共享的；cookie也是在所有同源窗口中都是共享的。
 - WebStorage 支持事件通知机制，可以将数据更新的通知发送给监听者。Web Storage 的 api 接口使用更方便。
sessionStorage 和 localStorage 是 HTML5 Web Storage API 提供的，可以方便的在web请求之间保存数据。有了本地数据，就可以避免数据在浏览器和服务器间不必要地来回传递。
sessionStorage、 localStorage 、 cookie 都是在浏览器端存储的数据，其中 sessionStorage 的概念很特别，引入了一个“浏览器窗口”的概念。 sessionStorage 是在同源的同窗口（或 tab ）中，始终存在的数据。也就是说只要这个浏览器窗口没有关闭，即使刷新页面或进入同源另一页面，数据仍然存在。关闭窗口后，sessionStorage即被销毁。同时“独立”打开的不同窗口，即使是同一页面， sessionStorage 对象也是不同的。
cookies 会发送到服务器端。其余两个不会。
Cookie 每个域名存储量比较小（各浏览器不同，大致 4K ）；所有域名的存储量有限制（各浏览器不同，大致 4K ）； 有个数限制（各浏览器不同）；会随请求发送到服务器。
LocalStorage 永久存储；单个域名存储量比较大（推荐 5MB ，各浏览器不同）；总体数量无限制。
SessionStorage 只在 Session 内有效；存储量更大（推荐没有限制，但是实际上各浏览器也不同）。

### 对HTML语义化的理解 ###
- 什么是 HTML 语义化
<基本上都是围绕着几个主要的标签，像标题（ H1~H6 ）、列表（ li ）、强调（ strong em ）等等 >
根据**内容的结构化**（内容语义化），选择**合适的标签**（代码语义化）便于**开发者阅读**和写出更优雅的代码的同时**让浏览器的爬虫和机器很好地解析**。
- 为什么要语义化
 为了在没有CSS的情况下，页面也能呈现出很好地内容结构、代码结构 : 为了裸奔时好看； 
 用户体验：例如title、 alt 用于解释名词或解释图片信息、 label 标签的活用；
 有利于SEO：和搜索引擎建立良好沟通，有助于爬虫抓取更多的有效信息，爬虫依赖于标签来确定上下文和各个关键字的权重；
方便其他设备解析（如屏幕阅读器、盲人阅读器、移动设备）以意义的方式来渲染网页；
 便于团队开发和维护，语义化更具可读性，是下一步网页的重要动向，遵循W3C标准的团队都遵循这个标准，可以减少差异化。 
- 语义化标签
`<header></header>` `<footer></footer>` `<nav></nav>` `<section></section>` 
`<article></article>` 用来在页面中表示一套结构完整且独立的内容部分
`<aside></aside>` 主题的附属信息 ( 用途很广，主要就是一个附属内容 ) ，如果 article 里面为一篇文章的话，那么文章的作者以及信息内容就是这篇文章的附属内容了
`<figure></figure>` 媒体元素，比如一些视频，图片等等
`<datalist></datalist>` 选项列表，与 input 元素配合使用，来定义 input 可能的值
`<details></details>` 用于描述文档或者文档某个部分的细节

### link和@import的区别 ###
HTML代码link:
`<link rel='stylesheet' rev='stylesheet' href='CSS文件 ' type='text/css' media='all' />`

HTML代码@import:

    <style type='text/css' media='screen'>
    @import url('CSS文件 ');
    </style> 
    
- 首先link和import语法结构不同，前者<link>是html标签，只能放入html源代码中使用，后者可看作为css样式，作用是引入css样式功能。
- import在html使用时候需要`<style type="text/css">`标签，同时可以直接`@import url(CSS文件路径地址)`放入css文件或css代码里引入其它css文件。
- 本质上两者使用选择区别不大，但为了软件中编辑布局网页html代码，一般使用link较多，也推荐使用link。

两者都是外部引用CSS的方式，但是存在一定的**区别：**
 区别1： link 是 XHTML 标签，除了加载 CSS 外，还可以定义 RSS 等其他事务； @import 属于 CSS 范畴，只能加载 CSS 。
区别2： link 引用 CSS 时，在页面载入时同时加载； @import 需要页面网页完全载入以后加载。
区别3： link 是 XHTML 标签，无兼容问题； @import 是在 CSS2.1 提出的，低版本的浏览器不支持。
区别4： link 支持使用 Javascript 控制 DOM 去改变样式；而 @import 不支持。
### 对SVG的理解 ###
SVG可缩放矢量图形（ Scalable Vector Graphics ）是基于可扩展标记语言（ XML ），用于描述二维矢量图形的一种图形格式。 SVG 是 W3C 在 2000 年 8 月制定的一种新的二维矢量图形格式，也是规范中的网络矢量图形标准。 SVG 严格遵从 XML 语法，并用文本格式的描述性语言来描述图像内容，因此是一种和图像分辨率无关的矢量图形格式。 SVG 于 2003 年 1 月 14 日成为 W3C 推荐标准。
特点：
 (1)任意放缩：用户可以任意缩放图像显示，而不会破坏图像的清晰度、细节等。
 (2)文本独立：SVG图像中的文字独立于图像，文字保留可编辑和可搜寻的状态。也不会再有字体的限制，用户系统即使没有安装某一字体，也会看到和他们制作时完全相同的画面。
 (3)较小文件： 总体来讲，SVG文件比那些 GIF 和 JPEG 格式的文件要小很多，因而下载也很快。
 (4)超强显示效果：SVG图像在屏幕上总是边缘清晰，它的清晰度适合任何屏幕分辨率和打印分辨率。
 (5)超级颜色控制：SVG图像提供一个 1600 万种颜色的调色板，支持 ICC 颜色描述文件标准、 RGB 、线 X 填充、渐变和蒙版。
 (6)交互 X 和智能化：SVG面临的主要问题一个是如何和已经占有重要市场份额的矢量图形格式 Flash 竞争的问题，另一个问题就是 SVG 的本地运行环境下的厂家支持程度。
  Internet Explorer9，火狐，谷歌 Chrome ， Opera 和 Safari 都支持 SVG 。IE8和早期版本都需要一个插件 - 如 Adobe SVG 浏览器，这是免费提供的

### HTML全局属性(global attribute)有哪些 ###
参考[HTML 全局属性](http://www.w3school.com.cn/tags/html_ref_standardattributes.asp)。例如`class`, `id`, `style`, `title`, `lang`等等。
### 超链接target属性的取值和作用
target属性指定所链接的页面在浏览器窗口中的打开方式。
参数值主要有：
_blank ：浏览器总在一个新打开、未命名的窗口中载入目标文档。
_parent ：在父框架集中打开被链接文档。如果含有该链接的框架不是嵌套的，则在浏览器全屏窗口中载入链接的文件，就象 _self 参数一。
_self ：默认。在相同的框架中打开被链接文档。
_top ： 在整个窗口中打开被链接文档。这个目标使得文档载入包含这个超链接的窗口，用 _top 目标将会清除所有被包含的框架并将文档载入整个浏览器窗口。
framename：在指定的框架中打开被链接文档。
### data- 属性的作用 ###
data-* 属性赋予我们在所有 HTML 元素上嵌入自定义 data 属性的能力。
data-* 属性用于存储页面或应用程序的私有自定义数据。
存储的（自定义）数据能够被页面的 JavaScript利用，以创建更好的用户体验（不进行 Ajax 调用或服务器端数据库查询）。

`data-`为HTML5新增的为前端开发者提供自定义的属性，这些属性集可以通过对象的 `dataset` 属性获取，不支持该属性的浏览器可以通过 `getAttribute` 方法获取： 
需要注意的是：`data-`之后的以连字符分割的多个单词组成的属性，获取的时候使用驼峰风格。 所有主流浏览器都支持 data-* 属性。即：当没有合适的属性和元素时，自定义的 data 属性是能够存储页面或 App 的私有的自定义数据。 
### 浏览器内核 ###
主要分成两部分：渲染引擎(layout engineer或 Rendering Engine) 和 JS 引擎。 
**渲染引擎：**负责取得网页的内容（HTML、 XML 、图像等等）、整理讯息（例如加入 CSS 等），以及计算网页的显示方式，然后会输出至显示器或打印机。
浏览器内核的不同对于网页的语法解释会有不同，所以渲染的效果也不相同。所有网页浏览器、电子邮件客户端以及其它需要编辑、显示网络内容的应用程序都需要内核。
**JS引擎：** 解析和执行 javascript 来实现网页的动态效果。
最开始渲染引擎和JS引擎并没有区分的很明确，后来JS引擎越来越独立，内核就倾向于只指渲染引擎。
### iframe的缺点 ###
* iframe会阻塞主页面的 Onload 事件
* 搜索引擎的检索程序无法解读这种页面，不利于 SEO;
* iframe和主页面共享[连接池](blog.csdn.net/u012152619/article/details/46287419)，而浏览器对相同域的连接有限制，所以会影响页面的并行加载。

如果需要使用 iframe ，最好是通过 javascript动态给iframe添加 src 属性值，这样可以绕开以上两个问题。 


历史上，iframe 常被用于复用部分界面，但是多数情况下并不合适。
现在，应该使用 iframe 的例子如：
1. 沙箱隔离。参考 [写js沙箱原来如此简单](https://www.imooc.com/article/17353)
2. 引用第三方内容。
3. 独立的带有交互的内容，比如幻灯片。
4. 需要保持独立焦点和历史管理的子窗口，如复杂的Web应用。

使用 iframe 是不是一个好的用法（good practice），不能一概而论，但是可以肯定是，现在的大部分网站避免采用这种方式的。
比较早期的网站使用iframe，主要是用于导航栏（navigator）。因为一个网站很多页面的导航栏部分是相同的，在避免切换页面的时候重复下载，将导航栏和正文分开在 iframe 中，是一个方便的做法。同时带来的不利是，默认情况下，使用了 iframe 的网站的URL不会随着页面的变化而变化。这就意味着一旦刷新，网站可能又回到首页。那么现在的网站是如何解决不同页面使用相同的 navigator 而避免重复编码呢？不同后台技术都有自己的方法，比如 ASP 有 SSI，PHP 有 require、require_once 或 include 函数，JSP 也有 include 指令。
iframe 一直是浏览器标准规范之一，只有很早期的浏览器不支持 iframe，现在几乎已绝迹。所以从兼容性上来说，iframe 是没问题的。
那么现在什么时候会用到 iframe 呢？
因为 iframe 的页面和父页面（parent）是分开的，所以它意味着，这是一个独立的区域，不受 parent 的 CSS 或者全局的 JavaScript 的影响。
典型的，比如所见即所得的网页编辑器（WYSIWYG Online HTML Editor），因为它们需要 reset 自己的 CSS 到自己的标准，而不被 parent CSS 的 override。 顺便说一下，知乎的这个编辑器不是用 iframe，它使用了一种叫 contentEditable 的属性，用来启用页面元素的编辑，在早期版本 IE 下不支持的。
正是因为刚刚提到的 iframe 等于新建了一个全新的，不受 parent 影响的页面上下文，所以在一定程度上，类似于沙箱隔离（sandbox）。除此之外，如果有可以不用 iframe 来解决的问题，还是避免使用 iframe。替代方案一般就是动态语言的 include 机制、ajax 动态填充内容，以及以后会普及的 [contentEditable](http://www.w3school.com.cn/html5/att_global_contenteditable.asp)。
### label标签的作用 ###
对鼠标用户而言增进了可用性。
label标签用来定义表单控制间的关系 , 当用户选择该标签时，浏览器会自动将焦点转到和标签相关的表单控件上。

    <label for='Name'>Number:</label>
    <input type="text" name="Name" id="Name"/>
注意:label的for属性值要与后面对应的input标签id属性值相同。
### 浏览器内多个标签页之间的通信 ###
调用localstorge、cookies等本地存储方式。
方法一：localstorge在一个标签页里被添加、修改或删除时，都会触发一个storage事件，通过在另一个标签页里监听storage事件，即可得到localstorge存储的值，实现不同标签页之间的通信。例如
标签页1：

    <input id="name">  
    <input type="button" id="btn" value="提交">  
    <script type="text/javascript">  
        $(function(){    
            $("#btn").click(function(){    
                var name=$("#name").val();    
                localStorage.setItem("name", name);   
            });    
        });    
    </script>  
标签页2：

    <input id="name">  
    <input type="button" id="btn" value="提交">  
    <script type="text/javascript">  
        $(function(){    
            $("#btn").click(function(){    
                var name=$("#name").val();    
                localStorage.setItem("name", name);   
            });    
        });    
    </script>  
    
方法二：使用cookie+setInterval，将要传递的信息存储在cookie中，每隔一定时间读取cookie信息，即可随时获取要传递的信息。
标签页1：

    <input id="name">  
    <input type="button" id="btn" value="提交">  
    <script type="text/javascript">  
        $(function(){    
            $("#btn").click(function(){    
                var name=$("#name").val();    
             document.cookie="name="+name;    
            });    
        });    
    </script>
标签页2：

    <script type="text/javascript">  
        $(function(){   
            function getCookie(key) {    
                return JSON.parse("{\"" + document.cookie.replace(/;\s+/gim,"\",\"").replace(/=/gim, "\":\"") + "\"}")[key];    
            }     
            setInterval(function(){    
                console.log("name=" + getCookie("name"));    
            }, 10000);    
        });  
    </script> 
### 在页面上实现一个圆形的可点击区域 ###
第一种 使用image map

    <img id="blue" class="click-area" src="blue.gif" usemap="#Map" /> 
    <map name="Map" id="Map" class="click-area">
        <area shape="circle" coords="50,50,50"/>
    </map>
    #blue{
        cursor:pointer;
        width:100px;
        height:100px;
}
第二种 使用CSS border-radius

    <div id="red" class="click-area" ></div>
    #red{  
     cursor:pointer;
     background:red;  
     width:100px;  
     height:100px;  
     border-radius:50%;  
    } 
第三种 使用js检测鼠标位置,获取鼠标点击位置坐标，判断其到圆点的距离是否不大于圆的半径，来判断点击位置是否在圆内。

    <div id="yellow" class="click-area" ></div>
    $("#yellow").on('click',function(e) {    
      var r = 50; 
      var x1 = $(this).offset().left+$(this).width()/2;            
      var y1 = $(this).offset().top+$(this).height()/2;   
      var x2= e.clientX;  
      var y2= e.clientY;    
      var distance = Math.abs(Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2)));    
      if (distance <= 50)  
        alert("Yes!");    
    }); 
### title与h3、b与strong、及i与em的区别 ###
`<strong>` 表示html页面上的强调（emphasized text）， `<em>` 表示句子中的强调（即强调语义）
**1.b和strong的区别**
盲人朋友使用阅读设备阅读网络时：`<strong>`会重读，`<b>`不会。两者虽然在网页中显示效果一样，但实际目的不同。
`<b>`这个标签对应 bold，即文本加粗，其目的仅仅是为了加粗显示文本，是一种样式／风格需求；`<strong>`这个标签意思是加强字符的语气，表示该文本比较重要，提醒读者／终端注意。为了达到这个目的，浏览器等终端将其加粗显示；
总结：`<b>`为了加粗而加粗，`<strong>`为了标明重点而加粗，也可以用其它方式来强调，比如下划线，比如字体加大，比如红色，等等，可以通过css来改变strong的具体表现。
**2.i和em的区别**
同样，I是Italic(斜体)，而em是emphasize(强调)。
**3.title与h1的联系与区别：**
从网站角度看，title更重于网站信息。title可以直接告诉搜索引擎和用户这个网站是关于什么主题和内容的。
从文章角度看，h1则是用于概括文章主题。用户进入内容页，想看到的当然就是文章的内容，h1文章标题就是最重要的。文章标题最好只有一个，多个h1会导致搜索引擎不知道这个页面哪个标题内容最重要，导致淡化这个页面的标题和关键词，起不到突出主题的效果。
区别：
h1突出文章主题，面对用户，更突出其视觉效果，突出网站标题或关键字用title。一篇文章，一个页面最好只用一个h1，多个h1会稀释主题。一个网站可以有多个title,最好一个单页用一个title，以便突出网站页面主体信息，从seo看，title权重比h1高，适用性比h1广。标记了h1的文字页面给予的权重会比页面内其他权重高很多。一个好的网站是h1和title并存，既突出h1文章主题，又突出网站主题和关键字。达到双重优化网站的效果。
### 不使用border画出1px高的线，考虑兼容性 ###
实现不使用 border 画出1px高的线，在不同浏览器的标准模式与怪异模式下都能保持一致的效果？ 

    <div style="width:100%;height:1px;background-color:black"></div>
### src属性与href属性的区别 ###
src用于替换当前元素， href 用于在当前文档和引用资源之间确立联系。
src是 source 的缩写，指向外部资源的位置，指向的内容将会嵌入到文档中当前标签所在位置；在请求 src 资源时会将其指向的资源下载并应用到文档内，例如 js 脚本， img 图片和 frame 等元素。
`<script src ='js.js'></script>`，当浏览器解析到该元素时，会暂停其他资源的下载和处理，直到将该资源加载、编译、执行完毕，图片和框架等元素也如此，类似于将所指向资源嵌入当前标签内。这也是为什么将js脚本放在底部而不是头部。 
 href是 Hypertext Reference的缩写，指向网络资源所在位置，建立和当前元素（锚点）或当前文档（链接）之间的连接，如果我们在文档中添加`<link href='common.css' rel='stylesheet'/>`，那么浏览器会识别该文档为css文件，就会并行下载资源并且不会停止对当前文档的处理。这也是为什么建议使用 link 方式来加载 css ，而不是使用 @import 方式。 
### 对canvas的理解 ###
canvas是HTML5中新增一个HTML5标签与操作canvas的javascript API，它可以实现在网页中完成动态的2D与3D图像技术。canvas标记和 SVG以及 VML 之间的一个重要的不同是，有一个基于 JavaScript 的绘图 API，而 SVG 和 VML 使用一个 XML 文档来描述绘图。SVG 绘图很容易编辑与生成，但功能明显要弱一些。 canvas可以完成动画、游戏、图表、图像处理等原来需要Flash完成的一些功能。
### WebSocket与消息推送 ###
B/S架构的系统多使用HTTP协议。 
**HTTP协议的特点：** 1 无状态协议； 2 用于通过 Internet 发送请求消息和响应消息； 3 使用端口接收和发送消息，默认为80端口； 4 底层通信还是使用Socket
![HTTP协议请求响应](https://uploadfiles.nowcoder.com/images/20170112/826546_1484203855304_198713B681803E835F62D3D3E22D5BBB)
HTTP协议决定了服务器与客户端之间的连接方式，无法直接实现消息推送（ F5 已坏） , 一些变相的解决办法实现 双向通信与消息推送 ：
**轮询：** 客户端定时向服务器发送Ajax请求，服务器接到请求后马上返回响应信息并关闭连接。
优点：后端程序编写比较容易。
缺点：请求中有大半是无用，浪费带宽和服务器资源。
实例：适于小型应用
**长轮询：** 客户端向服务器发送Ajax请求，服务器接到请求后 hold 住连接，直到有新消息才返回响应信息并关闭连接，客户端处理完响应信息后再向服务器发送新的请求。
优点：在无消息的情况下不会频繁的请求，耗费资小。
缺点：服务器hold连接会消耗资源，返回数据顺序无保证，难于管理维护。 Comet 异步的 ashx ，
实例：WebQQ、 Hi 网页版、 Facebook IM 
**长连接：** 在页面里嵌入一个隐蔵iframe，将这个隐蔵 iframe 的 src 属性设为对一个长连接的请求或是采用xhr请求，服务器端就能源源不断地往客户端输入数据。
优点：消息即时到达，不发无用请求；管理起来也相对便。
缺点：服务器维护一个长连接会增加开销。
实例：Gmail聊天
**Flash Socket：** 在页面中内嵌入一个使用了 Socket 类的 Flash 程序， JavaScript 通过调用此 Flash 程序提供的 Socket 接口与服务器端的 Socket 接口进行通信， JavaScript 在收到服务器端传送的信息后控制页面的显示。
优点：实现真正的即时通信，而不是伪即时。
缺点：客户端必须安装Flash插件；非 HTTP 协议，无法自动穿越防火墙。
实例：网络互动游戏。 
**Websocket:**
WebSocket是 HTML5 开始提供的一种浏览器与服务器间进行全双工通讯的网络技术。依靠这种技术可以实现客户端和服务器端的长连接，双向实时通信。
特点:事件驱动；异步；使用 ws 或者 wss 协议的客户端 socket；能够实现真正意义上的推送功能
缺点：少部分浏览器不支持，浏览器支持的程度与方式有区别
**参考文章：**
[WebSocket 教程-阮一峰](http://www.ruanyifeng.com/blog/2017/05/websocket.html)
[html5-websocket初探](https://www.cnblogs.com/myzhibie/p/4470065.html)
### img的title和alt的区别 ###
alt 是给搜索引擎识别，在图像无法显示时的替代文本； alt属性有利于SEO，是搜索引擎搜录时判断图片与文字是否相关的重要依据。
title 是关于元素的注释信息，主要是给用户解读。当鼠标放到文字或是图片上时有title文字显示。
参考文章：[img图片标签alt和title属性的区别](http://blog.csdn.net/playkid123/article/details/44562235)
### 表单的基本组成 ###
组成：表单标签、表单域、表单按钮。
 a、表单标签：这里面包含了处理表单数据所用 CGI 程序的 URL, 以及数据提交到服务器的方法。
b、表单域：包含了文本框、密码框、隐藏域、多行文本框、复选框、单选框、下拉选择框、和文件上传框等。
c、表单按钮：包括提交按钮，复位按钮和一般按钮；用于将数据传送到服务器上的 CGI 脚本或者取消输入，还可以用表单按钮来控制其他定义了处理脚本的处理工作。
主要用途：表单在网页中主要负责数据采集的功能，和向服务器传送数据。 

    <form action="#" method="post" id="regForm">  
        <fieldset>  
            <legend>个人基本信息</legend>  
            <div>  
                <label for="userName">名称：</label>  
                <input id="useName" type="text" />  
            </div>  
            <div>  
                <label for="passWord">密码：</label>  
                <input id="passWord" type="password" />  
            </div>  
            <div>  
                <label for="msg">详细信息：</label>  
                <textarea id="msg"></textarea>  
             </div>  
        </fieldset>  
    </form> 
**form标签：** `<form action="表单提交的地址"   method="表单提交的方法"   id=""  class="">`
**fieldset标签：**作用是将表单内相关元素分组；将表单内容的一部分打包，生成一组表单的字段;在一个form表单中，可以有一个或者多个fielset标签。
**legend标签：** 作用是为fieldset标签定义标题。
**label标签：** 该标签在页面中使用不会为用户呈现任何特殊效果，但是却可以很好地为鼠标用户改进了可用性。其作用是为input元素定义标注，要注意的是label中的for属性应与input中的id属性一致，如上述代码所示。
**input标签：** 输入框，其中可以根据type的属性值改变输入框的作用。例如：`<input  type="text"/>` 是文本框，还可以是密码输入框、复选框、单选框等等。
### 表单提交中Get和Post方式的区别 ###
**原理性区别：**
1. Http 定义的与服务器交互的四种基本方法，增删改查（ put delete post get ）；从定义而言 get 用于信息获取（状态不做迁移），而且是安全幂等的（不修改信息、同一 url 多次请求结果一致），但有时候并不严格遵循规定，比如腾讯新闻的刷新操作，因为从 server端来讲，数据状态并没有发生任何改变 ，所以也可以算成是幂等； post 可以修改服务器上的资源请求（资源的状态迁移），比如新闻评论的提交，提交前后资源被修改了。
2. 关于幂等与否只是 http 的规定，实际中要看服务器端怎么写。
**表象上的区别：**
1. 提交的安全性不同： Get 将表单中的数据按照 variable=value 的形式，添加到 action 所指向的 URL 后面，并且两者使用"? "连接，而各个变量之间使用"&"连接（明文提交）； Post 是将表单中的数据放在 form 的数据体中，按照变量和值相对应的方式，传递到 action 所指向 URL （依照表单提交）。
2. Get 传输的数据量小（ 1024 字节），这主要是因为受 URL 长度限制； URL 长度在 http 协议中没有限制，只是 IE 对 URL 有长度限制，其他浏览器取决于操作系统，理论上没有限制。 Post 可以传输大量的数据（ 2M ），理论上 http 没有限制数据量长度，服务器处理程序的处理能力限制了表单域长度，而有限制
3. Get 限制 Form 表单的数据集的值必须为 ASCII 字符；而 Post 支持整个 ISO10646 字符集。
4. 传输信息所在 http 中的位置不同： Post 的信息作为 http 请求的内容，而 Get 是在 Http 头部传输的， get 请求可以有 body 但大多数服务器不会解析 get 请求的 body 。

(1)、 get 是从服务器上获取数据， post 是向服务器传送数据。
(2)、 get 是把参数数据队列加到提交表单的 ACTION 属性所指的 URL 中，值和表单内各个字段一一对应，在 URL 中可以看到。 post 是通过 HTTP post 机制，将表单内各个字段与其内容放置在 HTML HEADER 内一起传送到 ACTION 属性所指的 URL 地址 , 用户看不到这个过程。
(3)、对于 get 方式，服务器端用 Request.QueryString 获取变量的值，对于 post 方式，服务器端用 Request.Form 获取提交的数据。
(4)、 get 传送的数据量较小，不能大于 2KB 。 post 传送的数据量较大，一般被默认为不受限制。但理论上， IIS4 中最大量为 80KB ， IIS5 中为 100KB 。
(5)、 get 安全性低， post 安全性较高。
### 关于HTML5标签的几个知识点 ###
**[HTML5新增的表单元素：](http://www.w3school.com.cn/html5/html_5_form_elements.asp)**
`datalist` 元素：
datalist 元素规定输入域的选项列表；
列表是通过 datalist 内的 option 元素创建的,option 元素永远都要设置 value 属性；
如需把 datalist 绑定到输入域，请用输入域的 list 属性引用 datalist 的 id。
`keygen` 元素:
keygen 元素的作用是提供一种验证用户的可靠方法;
keygen 元素是密钥对生成器（key-pair generator）。当提交表单时，会生成两个键，一个是私钥，一个公钥。私钥（private key）存储于客户端，公钥（public key）则被发送到服务器。公钥可用于之后验证用户的客户端证书（client certificate）。
目前，浏览器对此元素的糟糕的支持度不足以使其成为一种有用的安全标准。
`output` 元素:
output 元素用于不同类型的输出，比如计算或脚本输出。
**[HTML5废弃的标签：](http://yanue.net/post-106.html)**
第一类：表现性元素
`basefont` `big` `center` `font` `s` `strike` `tt` `u`等。
建议用语义正确的元素代替他们，并使用CSS来确保渲染后的效果
第二类：框架类元素
因框架有很多可用性及可访问性问题，HTML5规范将以下元素移除:
`frame` `frameset` `noframes`
但html5支持iframe。
第三类：属性类
很多表现性的属性也被新规范移除，如下：
align
body标签上的link、vlink、alink、text属性
bgcolor
height和width
iframe元素上的scrolling属性
valign
hspace和vspace
table标签上的cellpadding、cellspacing和border属性
header标签上的profile属性
img和iframe元素的longdesc属性
第四类：其他
abbr取代acronym（用于表示缩写）
object取代了applet
ul取代了dir
**[HTML5 标准提供的新API](https://www.cnblogs.com/oneplace/p/5616197.html)**
Media API：例如video audio,Using the Camera API
Text Track API: textTracks属性;返回代表可用文本字幕的TextTrackList对象
Application Cache API： 应用程序缓存
User Interaction ：新增的语义化元素，output元素等
Data Transfer API ：webSocket
Command API
Constraint Validation API
History API : session localStorage cookie
**HTML5 存储类型有什么区别**
HTML5 能够本地存储数据，在之前都是使用 cookie。 HTML5  提供了下面两种本地存储方案：
localStorage  用于持久化的本地存储，数据永远不会过期，关闭浏览器也不会丢失。
 sessionStorage  同一个会话中的页面才能访问并且当会话结束后数据也随之销毁，因此它不是一种持久化的本地存储，仅仅是会话级别的存储
 
cookies,seesionStorage,localStorage区别：
共同点：都是保存到浏览器端，都是同源。
区别：cookies会发给服务器。其他两个不会，只在本地保存，而且比cookie存储空间要大。seesionStroage,在窗口关闭前有效，不在不同浏览器窗口共享。 localStroage,始终有效，永久数据，所有同源窗口共享。 cookie:在过期前有效，所有同源窗口共享 。
**[HTML5 应用程序缓存和浏览器缓存的区别](https://www.cnblogs.com/xjchenhao/p/4032224.html)**
使用 HTML5，通过创建 cache manifest 文件，可以轻松地创建 web 应用的离线版本。
HTML5 引入了应用程序缓存，这意味着 web 应用可进行缓存，并可在没有因特网连接时进行访问。
应用程序缓存为应用带来三个优势：离线浏览 - 用户可在应用离线时使用它们；
速度 - 已缓存资源加载得更快；减少服务器负载 - 浏览器将只从服务器下载更新过或更改过的资源。



应用程序缓存是 HTML5  的重要特性之一，提供了离线使用的功能，让应用程序可以获取本地的网站内容，例如 HTML 、 CSS 、图片以及 JavaScript 。这个特性可以提高网站性能，它的实现借助于 manifest 文件，如下：

    <!doctype html>
    <html manifest=”example.appcache”>
    …..
    </html>
与传统浏览器缓存相比，它不强制用户访问的网站内容被缓存。
**除了 audio 和 video，HTML5 还有哪些媒体标签**
`<embed>` 标签，定义嵌入的内容，比如插件。

    <embed type=” video/quicktime ” src= ” Fishing.mov ” >
`<source>` 标签，对于定义多个数据源很有用。

     <video width=” 450 ″ height= ” 340 ″ controls>
         <source src=” jamshed.mp4 ″ type= ” video/mp4 ″ >
         <source src=” jamshed.ogg ” type= ” video/ogg ” >
    </video>
`<track>`标签，为诸如 video 元素之类的媒介规定外部文本轨道。 用于规定字幕文件或其他包含文本的文件，当媒介播放时，这些文件是可见的。

     <video width=” 450 ″ height= ” 340 ″ controls>
         <source src=” jamshed.mp4 ″ type= ” video/mp4 ″ >
         <source src=” jamshed.ogg ” type= ” video/ogg ” >
         <track kind=” subtitles ” label= ” English ” src= ” jamshed_en.vtt ” srclang= ” en ” default></track>
          <track kind=” subtitles ” label= ” Arabic ” src= ” jamshed_ar.vtt ” srclang= ” ar ” ></track>
    </video> 
**HTML5 中如何嵌入视频**
和音频类似，HTML5 支持 MP4 、WebM 和 Ogg 格式的视频，通过video标签嵌入视频，下面是简单示例：

    <video width=” 450 ″ height= ” 340 ″ controls>
      <source src=” jamshed.mp4 ″ type= ” video/mp4 ″ >
       Your browser does’ nt support video embedding feature.
    </video>
**HTML5 中如何嵌入音频**
HTML5 支持 MP3 、Wav 和 Ogg 格式的音频，通过audio标签嵌入音频，示例如下：

    <audio controls>
        <source src=” jamshed.mp3 ″ type= ” audio/mpeg ” >
        Your browser does’ nt support audio embedding feature.
    </audio>
**新的 HTML5 文档类型和字符集是什么**
HTML5 文档类型：`<!doctype html>`
HTML5 使用 UTF-8 编码: `<meta charset="UTF-8" >` 

