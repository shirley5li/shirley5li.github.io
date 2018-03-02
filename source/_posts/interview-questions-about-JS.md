---
title: 【interview questions about JS 1】 from牛客网
date: 2018-02-27 16:35:38
tags: [interview questions]
categories: interview questions
---
来自牛客网[前端面试经典题目合集](https://www.nowcoder.com/ta/front-end-interview?query=&asc=true&order=&page=1) 篇学习总结。
<!--more-->
### Cookie的弊端  ###
cookie虽然在持久保存客户端数据提供了方便，分担了服务器存储的负担，但还是有很多局限性的。 
**优点：**
1) 数据持久性。
2) 不需要任何服务器资源。 Cookie 存储在客户端并在发送后由服务器读取。
3) 可配置到期规则。 控制 cookie 的生命期，使之不会永远有效。偷盗者很可能拿到一个过期的 cookie 。
4) 简单性。 基于文本的轻量结构。
5) 通过良好的编程，控制保存在 cookie 中的 session 对象的大小。
6) 通过加密和安全传输技术（ SSL ），减少 cookie 被破解的可能性。
7) 只在 cookie 中存放不敏感数据，即使被盗也不会有重大损失。
**缺点：**
1) Cookie 数量和长度的限制 。
数量：每个域的 cookie 总数有限。

	a) IE6 或更低版本最多 20 个 cookie
	b) IE7 和之后的版本最后可以有 50 个 cookie
	c) Firefox 最多 50 个 cookie
	d) chrome 和 Safari 没有做硬性限制
长度：每个 cookie 长度不超过 4KB （ 4096B ），否则会被截掉。
2) 潜在的安全风险。 Cookie 可能被拦截、篡改。如果 cookie 被拦截，就有可能暴露所有的 session 信息。
3)额外开销。  cookie 在每次发起 HTTP 请求的时候都会被发送给服务器，一些不需要的信息也有可能会被发送，会增加开销。
4) 用户配置为禁用 。有些用户禁用了浏览器或客户端设备接受 cookie 的能力，因此限制了这一功能。
5) 有些状态不可能保存在客户端 。例如，为了防止重复提交表单，我们需要在服务器端保存一个计数器。如果我们把这个计数器保存在客户端，那么它起不到任何作用。

### 浏览器本地存储 ###
1)Cookie ：广泛应用，局限明显。支持数据存储量相对较少，每个 domain 最多只能有 20 条 cookie ，每个 cookie 长度不能超过 4KB ，否则会被截掉；同时，存在安全性问题，如果被拦截，就可以取得所有的 session 信息。
2)Flash SharedObject ：使用的是 kissy 的 store 模块来调用 Flash SharedObject 。
优点：容量适中，基本上不存在兼容性问题
缺点：要在页面中引入特定的 Flash 和 JS ，增加额外负担，处理繁琐；还是有部分机子没有 flash 运行环境。
3)Google Gears ：  Google 的离线方案，已经停止更新，官方推荐使用 HTML5 的 localStorage 方案。
4)User Data ：   是微软为 IE 专门在系统中开辟的一块存储空间，只支持 Windows+IE 的组合。单个文件的大小限制是 128KB ，一个域名下总共可以保存 1024KB 的文件，文件个数应该没有限制。在受限站点里这两个值分别是 64KB 和 640KB 。（所以如果考虑到各种情况的话，单个文件最好能控制 64KB 以下。）
（实际测试 2000(IE5.5)、 XP(IE6 、 IE7)， Vista(IE7)下都是可正常使用。）
5)indexedDB : indexedDB是适合在本地存储大量非关系型数据（NOSQL），采取的是事件+异步回调进行操作。 
**6)Web Storage**
在较高版本的浏览器中， JS 提供了 sessionStorage 和 globalStorage 。在 HTML5 中提供了 sessionStorage 和 **localStorage** 。
sessionStorage 用于本地存储一个会话（ session ）中的数据，这些数据只有在同一个会话中的页面才能访问，会话结束后数据随之销毁。因此 sessionStorage 不是一种持久化的本地存储，仅仅是会话级别的存储。
globalStorage 跨越会话存储数据。有特定访问限制，要指定哪些域可访问该数据。

**localStorage** 用于持久化的本地存储，除非主动删除数据，否则数据是永远不会过期的。不能给 localStorage 指定任何规则，要访问同一个 localStorage ，页面必须使用同一个域名，使用同一种协议，在同一个端口上，即要求同源，不能跨域。

优点：容量大、易用、强大、原生支持
缺点： a) 兼容性差（ Chrome,Safari,Firefox,Opera,IE8+ 支持 ， IE8 以下版本不支持）
b) 安全性差（所以请勿使用 localStorage 保存敏感信息）
c)跨域限制
用途：
localStorage 可以利用持久化数据本地存储的特点来做网站优化，把一些静态资源，存储在本地，但是这个意义对PC端可能相对小一些，PC端的网速一般比较理想，读取本地localStorage的消耗 和读取服务器的消耗优化不了多少，而且存在本地localstorage的维护成本，总体性价比一般，移动端是可以利用这一点做一些优化，移动端的网络环境还是没达到理想，所以读取localstorage的代价应该小于服务器加载。 

### Web Storage 与 Cookie 的区别 ###
1 、 Web Storage 中的数据仅在存在本地，不与服务器发生交互。Cookie 中的数据会在浏览器和服务器中来回传递。
2 、 Web Storage 存储空间更大，可以达到 5M。Cookie 数据大小不超过 4KB 。
3 、 Web Storage 提供更多丰富易用的接口，如 setItem ， getItem ， removeItem ， clear 等方法，操作数据更方便。Cookie 需要自己封装方法。
4 、 cookie 需要指定作用域，不可以跨域调用，同样Web Storage 也存在跨域问题。
5、 cookie 中的数据在过期时间之前均有效， Web Storage 则不同， sessionStorage 中的数据在当前浏览器窗口关闭后自动删除， localStorage持久存储数据，除非主动删除数据。

注： 但 Cookie 是不可以或缺的，Cookie 的作用是与服务器进行交互，作为 HTTP 规范的一部分而存在 ，而 Web Storage 仅仅是为了在本地 “ 存储 ” 数据而生。

### position的absolute与fixed共同点与不同点 ###
共同点：
1.改变行内元素的呈现方式，display被置为inline-block；
2.让元素脱离普通流，不占据空间；
3.默认会覆盖到非定位元素上

不同点：
absolute的“根元素”是可以设置的，在父元素上设定定位relative；而fixed的“根元素”固定为浏览器窗口。
当滚动网页，fixed元素与浏览器窗口之间的距离是不变的。

### CSS 哪些属性可以继承? CSS3新增伪类? ###
可继承的样式：
1.font-size
2.font-family
3.color
4.text-indent
不可继承的样式：
1.border
2.padding
3.margin
4.width
5.height 
CSS3新增伪类举例：

	p:first-of-type 选择属于其父元素的首个 <p> 元素的每个 <p> 元素。
	p:last-of-type  选择属于其父元素的最后 <p> 元素的每个 <p> 元素。
	p:only-of-type  选择属于其父元素唯一的 <p> 元素的每个 <p> 元素。
	p:only-child    选择属于其父元素的唯一子元素的每个 <p> 元素。
	p:nth-child(2)  选择属于其父元素的第二个子元素的每个 <p> 元素。
	:enabled :disabled 控制表单控件的禁用状态。
	:checked        单选框或复选框被选中。 

### CSS3的新特性 ###
答题套路：在我们的项目中经常用CSS3中的XX属性来实现XX特效。

1. CSS3实现圆角（border-radius），阴影（box-shadow）
2. 对文字加特效（text-shadow、），线性渐变（gradient）
3. transform变换: rotate(9deg); scale(0.85,0.90); translate(0px,-30px); skew(-9deg,0deg) // 旋转,缩放,定位,倾斜
4. 动画animation
5. 增加了更多的CSS选择器  多背景 rgba()
6. 在CSS3中唯一引入的伪类是 ::selection.
7. 媒体查询，多栏布局
8. border-image

### CSS sprites 的理解及使用 ###
CSS Sprites 其实就是把网页中一些背景图片整合到一张图片文件中，再利用 CSS 的"background-image"，"background-repeat"，"background-position" 的组合进行背景定位，background-position 可以用数字能精确的定位出背景图片的位置。这样可以减少很多图片请求的开销，因为请求耗时比较长；请求虽然可以并发，但是也有限制，一般浏览器都是6个。对于未来而言，就不需要这样做了，因为有了 http2。 

HTTP/1.x 有个问题叫线端阻塞(head-of-line blocking), 它是指一个连接(connection)一次只提交一个请求的效率比较高, 多了就会变慢。 HTTP/1.1 试过用流水线(pipelining)来解决这个问题, 但是效果并不理想(数据量较大或者速度较慢的响应, 会阻碍排在他后面的请求). 此外, 由于网络媒介(intermediary )和服务器不能很好的支持流水线, 导致部署起来困难重重。
而多路传输(Multiplexing)能很好的解决这些问题, 因为它能同时处理多个消息的请求和响应; 甚至可以在传输过程中将一个消息跟另外一个掺杂在一起。 所以客户端只需要一个连接就能加载一个页面。
参见博客[HTTP1.0、HTTP1.1和HTTP2.0的区别](http://www.sohu.com/a/161201715_714863)。

### Doctype文档类型 ###
1. 该标签可声明三种 DTD 类型，分别表示严格版本、过渡版本以及基于框架的 HTML 文档。
2. HTML 4.01 规定了三种文档类型：Strict、Transitional 以及 Frameset。
3. XHTML 1.0 规定了三种 XML 文档类型：Strict、Transitional 以及 Frameset。
4. Standards （标准）模式（也就是严格呈现模式）用于呈现遵循最新标准的网页，而 Quirks（包容）模式（也就是松散呈现模式或者兼容模式）用于呈现为传统浏览器而设计的网页。

### HTML与XHTML之间的区别 ###
1、XHTML 元素必须被正确地嵌套，不正确嵌套会报错。
错误：`<p><span>this is example.</p></span>`
正确：`<p><span>this is example.</span></p>`
而html不被正确嵌套也不会报错。
2、 XHTML 元素必须被关闭，即使是空标签`</br>`，否则报错。而html可以写成`<br>`而不报错。
3、 XHTML 标签名必须用小写字母。html可以大写。
4、 XHTML 文档必须拥有根元素html，所有的 XHTML 元素必须被嵌套于 <html> 根元素中。
而html不是必须的。

### DOM操作——怎样添加、移除、移动、复制、创建和查找节点 ###
1、 创建新节点

	createDocumentFragment() // 创建一个DOM片段
	createElement() // 创建一个具体的元素
	createTextNode() // 创建一个文本节点
2、 添加、移除、替换、插入

	appendChild()
	removeChild()
	replaceChild()
	insertBefore() // 在已有的子节点前插入一个新的子节点
3、查找

	getElementsByTagName() // 通过标签名称
	getElementsByName() // 通过元素的Name属性的值(IE容错能力较强，会得到一个数组，其中包括id等于name值的)
	document.getElementById() // 通过元素Id，唯一性
	getElementsByClassName() //通过类名
	queryselector()  
	querySeletorAll() // (IE67 不支持)

### html5 的新特性以及新标签的浏览器兼容问题 ###
**新特性：**
HTML5 现在已经不是 SGML 的子集，主要是关于图像，位置，存储，多任务等功能的增加。
1、拖拽释放(Drag and drop) API 
2、语义化更好的内容标签（header,nav,footer,aside,article,section）
3、 音频、视频API(audio,video)
4、 画布(Canvas) API
5、 地理(Geolocation) API
6、 本地离线存储 localStorage 长期存储数据，浏览器关闭后数据不丢失；
7、 sessionStorage 的数据在浏览器关闭后自动删除
8、 表单控件，calendar、date、time、email、url、search  
9、 新的技术webworker, websocket, Geolocation
**移除的元素：**
1、 纯表现的元素：basefont，big，center，font, s，strike，tt，u；
2、 对可用性产生负面影响的元素：frame，frameset，noframes；
**支持HTML5新标签：**
 IE8/IE7/IE6支持通过 document.createElement 方法产生的标签，可以利用这一特性让这些浏览器支持 HTML5 新标签，浏览器支持新标签后，还需要添加标签默认的样式（当然最好的方式是直接使用成熟的框架、使用最多的是html5shiv框架）：

	<!--[if lt IE 9]> 
	<script> src="http://html5shiv.googlecode.com/svn/trunk/html5.js"</script> 
	<![endif]--> 

**如何区分：** 
DOCTYPE声明新增的结构元素、功能元素

### iframe的优缺点 ###
优点：
1、 解决加载缓慢的第三方内容如图标和广告等的加载问题
2、 Security sandbox
3、 并行加载脚本
4、 重载页面时不需要重载整个页面，只需要重载页面中的一个框架页(减少了数据的传输，增加了网页下载速度)
5、 方便制作导航栏
缺点：
1、 iframe会阻塞主页面的Onload事件
2、 即时内容为空，加载也需要时间
3、 没有语意
4、 会产生很多页面，不容易管理
5、 不容易打印 
6、 浏览器的后退按钮无效
7、 代码复杂,无法被一些搜索引擎索引到 
8、 多数小型的移动设备（PDA 手机）无法完全显示框架
9、 多框架的页面会增加服务器的http请求
10、 由于上面诸多缺点，因此不符合标准网页设计的理念,已经被标准网页设计抛弃

### webSocket 如何兼容低浏览器 ###
Adobe Flash Socket 、 ActiveX HTMLFile (IE) 、 基于 multipart 编码发送 XHR 、 基于长轮询的 XHR 

### 线程与进程的区别  ###
进程是系统进行资源分配和调度的一个独立单位。线程是进程的一个实体,是CPU调度和分派的基本单位。
1、 一个程序至少有一个进程,一个进程至少有一个线程
2、 线程的划分尺度小于进程，使得多线程程序的并发性高
3、 另外，进程在执行过程中拥有独立的内存单元，而多个线程共享内存，从而极大地提高了程序的运行效率
4、 线程在执行过程中与进程还是有区别的。每个独立的线程有一个程序运行的入口、顺序执行序列和程序的出口。但是线程不能够独立执行，必须依存在应用程序中，由应用程序提供多个线程执行控制 
5、 从逻辑角度来看，多线程的意义在于一个应用程序中，有多个执行部分可以同时执行。但操作系统并没有将多个线程看做多个独立的应用，来实现进程的调度和管理以及资源分配。这就是进程和线程的重要区别

### 如何对网站的文件和资源进行优化 ###
1、 文件合并
2、 文件最小化/文件压缩
3、 使用 CDN 托管
4、 缓存的使用（多个域名来提供缓存） 
雅虎军规：
1、尽可能减少http请求次数，将css, js, 图片各自合并 
2、使用CDN，降低通信距离 
3、添加Expire/Cache-Control头 
4、启用Gzip压缩文件 
5、将css放在页面最上面 
6、将script放在页面最下面 
7、避免在css中使用表达式 
8、将css, js都放在外部文件中 
9、减少DNS查询 
10、最小化css, js，减小文件体积 
11、避免重定向 
12、移除重复脚本 
13、配置实体标签ETag 
14、使用AJAX缓存，让网站内容分批加载，局部更新

### 三种减少页面加载时间的方法 ###
1、 优化图片 
2、 图像格式的选择（GIF：提供的颜色较少，可用在一些对颜色要求不高的地方） 
3、 优化CSS（压缩合并css，如 margin-top, margin-left...) 
4、 网址后加斜杠（如www.campr.com/目录，会判断这个目录是什么文件类型，或者是目录。） 
5、 标明高度和宽度（如果浏览器没有找到这两个参数，它需要一边下载图片一边计算大小，如果图片很多，浏览器需要不断地调整页面。这不但影响速度，也影响浏览体验。 
当浏览器知道了高度和宽度参数后，即使图片暂时无法显示，页面上也会腾出图片的空位，然后继续加载后面的内容。从而加载时间快了，浏览体验也更好了） 
6、 减少http请求（合并文件，合并图片）CSS精灵，将JS代码写在body后面 

### 测试JS代码性能的工具 ###
[如何测试javascript代码的性能？---知乎](https://www.zhihu.com/question/20704098)
1、 浏览器debug中现在都有原生的profile功能，可定位那个函数调用得多，用的时间多，这个可以比较精确定位耗时的函数。
2、JSPerf  [使用Benchmark.js和jsPerf分析代码性能](http://blog.csdn.net/meloseven/article/details/61615591?utm_source=itdadao&utm_medium=referral)
3、 Dromaeo

前端性能测试：
**Page Speed Online**
Google Page Speed 是当下很流行的在线测试网站性能工具，基于Google的一套最佳的前端性能的规则，你可以很方便得到大量的性能信息，甚至还提供了移动设备的最佳实践报告
**WebPagetest**
WebPagetest 是性能测试的黄金标准，它提供了多方面的量化指标用于性能测试，比如有一个基本的评分，用于评价当前页面优化的水平；有一个截图，显示页面加载后的视觉效果；还有一个浏览器加载资源的瀑布流...
根据用户浏览器真实的连接速度，在全球范围内进行网页速度测试，并提供详细的优化建议。
[前端性能测试必备工具清单](http://www.51testing.com/index.php?action-viewnews-itemid-3720205-php-1)
[前端性能优化和测试工具总结](https://www.jianshu.com/p/cdf777f13ff6)
[推荐10个免费在线测试网页性能工具](http://www.daqianduan.com/3962.html)

### 什么是 FOUC？ 如何来避免 FOUC？###
FOUC - Flash Of Unstyled Content 文档样式闪烁
使用`<style type="text/css" media="all">@import "../fouc.css";</style>  ` @import导入外部样式文件时，IE会先加载整个HTML文档的DOM，然后再去导入外部的CSS文件，因此，在页面DOM加载完成到CSS导入完成中间会有一段时间页面上的内容是没有样式的，这段时间的长短跟网速，电脑速度都有关系。
解决办法：将@import换成link，link是顺序加载，这样页面就会等css下载完之后再下载html文件，这样就先布好了局，所以就不会出现focus闪烁问题。

### null和undefined的区别 ###
null是一个表示"无"的对象，转为数值时为0
undefined是一个表示"无"的原始值，转为数值时为NaN

当声明的变量还未被初始化时，变量的默认值为undefined
null用来表示尚未存在的对象，常用来表示函数企图返回一个不存在的对象

undefined表示 “缺少值”，就是此处应该有一个值，但是还没有定义。典型用法是：
1、 变量被声明了，但没有赋值时，就等于 undefined
2、 调用函数时，应该提供的参数没有提供，该参数等于 undefined
3、 对象没有赋值的属性，该属性的值为 undefined
4、 函数没有返回值时，默认返回 undefined

null表示“没有对象”，即该处不应该有值。典型用法是：
1、 作为函数的参数，表示该函数的参数不是对象
2、 作为对象原型链的终点

### new操作符具体干了什么 ###
1、 创建一个空对象，并且 this 变量引用该对象，同时还继承了该函数的原型
2、 属性和方法被加入到 this 引用的对象中
3、 新创建的对象由 this 所引用，并且最后隐式的返回 this

	//var obj = new Base();	
	var obj  = {};
	obj.__proto__ = Base.prototype;
	Base.call(obj);
 
### JSON ###
JSON(JavaScript Object Notation) 是一种轻量级的数据交换格式。它是基于JavaScript的一个子集。数据格式简单, 易于读写, 占用带宽小。`{"age":"12", "name":"back"}`

	json.stringify({a:10,b:20}); //json对象转换成字符串 
	json.parse('{"a":10,"b":20}') //字符串转换成json对象
[博客---对json的理解](http://blog.csdn.net/qq_32528231/article/details/52783210)

### js延迟加载的方式 ###
JS延迟加载，也就是等页面加载完成之后再加载 JavaScript 文件。
JS延迟加载有助于提高页面加载速度。

        defer 属性
        async 属性
        动态创建DOM方式
        使用jQuery的getScript方法
        使用setTimeout延迟方法
        让JS最后加载
1、 defer
HTML 4.01 为 `<script>`标签定义了 defer属性。
用途：表明脚本在执行时不会影响页面的构造。也就是说，脚本会被延迟到整个页面都解析完毕之后再执行。
defer属性只适用于外部脚本文件。支持 HTML5 的实现会忽略嵌入脚本设置的 defer属性。
2、 async
HTML5 为 `<script>`标签定义了 async属性。与defer属性类似，都用于改变处理脚本的行为。同样，只适用于外部脚本文件。
目的：不让页面等待脚本下载和执行，从而异步加载页面其他内容。
异步脚本一定会在页面 load 事件前执行。
不能保证脚本会按顺序执行。
3、 动态创建DOM方式（创建script，插入到DOM中，加载完毕后callBack）
4、 按需异步载入js(可以将js文件加载绑定到一个事件上，这样当事件发生时，才会加载相应的js文件)
[JS延迟加载的几种方式](http://blog.csdn.net/meijory/article/details/76389762)

### 解决跨域问题 ###
	1、 通过jsonp跨域
	2、 document.domain + iframe跨域
	3、 location.hash + iframe
	4、 window.name + iframe跨域
	5、 postMessage跨域
	6、 跨域资源共享（CORS）
	7、 nginx代理跨域
	8、 nodejs中间件代理跨域
	9、 WebSocket协议跨域
[前端常见跨域解决方案（全）](https://segmentfault.com/a/1190000011145364)
[关于跨域的简单demo集合--github](https://github.com/shirley5li/cross-domain)

### documen.write和 innerHTML 的区别 ###
document.write 只能同步执行，如果在window.onload之前执行则在文档流中绘制内容，如果在window.onload之后则会重绘整个页面（之前内容被冲刷掉）
innerHTML 则是绘制某个元素内的内容，没有这个限制 

### .call() 和 .apply() 的作用 ###
改变上下文，即this的指向。
apply:方法能劫持另外一个对象的方法，继承另外一个对象的属性.

Function.apply(obj,args)方法能接收两个参数
obj：这个对象将代替Function类里this对象
args：这个是数组，它将作为参数传给Function（args-->arguments）

call:和apply的意思一样,只不过是参数列表不一样.

Function.call(obj,[param1[,param2[,…[,paramN]]]])
obj：这个对象将代替Function类里this对象
params：这个是一个参数列表

### 哪些操作会造成内存泄漏 ###
内存泄漏指任何对象在您不再拥有或需要它之后仍然存在。
垃圾回收器定期扫描对象，并计算引用了每个对象的其他对象的数量。如果一个对象的引用数量为 0（没有其他对象引用过该对象），或对该对象的惟一引用是循环的，那么该对象的内存即可回收。 
1. setTimeout 的第一个参数使用字符串而非函数的话，会引发内存泄漏。
2. 闭包
3. 全局变量引起的内存泄漏
4. 循环（在两个对象彼此引用且彼此保留时，就会产生一个循环）
5. dom清空或删除时，事件未清除导致的内存泄漏，脱离 DOM 的引用
[JavaScript内存泄露的4种方式及如何避免](http://developer.51cto.com/art/201605/511624.htm#topx)
[JavaScript常见的内存泄漏原因](https://www.cnblogs.com/libin-1/p/6013490.html)
[JavaScript 内存泄漏教程---阮一峰](http://www.ruanyifeng.com/blog/2017/04/memory-leak.html)

### 如何判断当前脚本运行在浏览器还是node环境中 ###
通过判断 Global 对象是否为window，如果不为window，当前脚本没有运行在浏览器中。即在node中的全局变量是global ,浏览器的全局变量是window。 可以通过该全局变量是否定义来判断宿主环境。

	exports = typeof window === 'undefined' ? global : window ;
	//获取全局对象的方式
	//同理可得，typeof window可以用来判断是不是在浏览器环境中

### Node.js的优缺点 ### 
优点：
　　　1、 高并发。采用事件驱动，异步编程，为网络服务而设计。NodeJS能支持比Java、PHP程序更高的并发量，虽然维护事件队列也需要成本，再由于NodeJS是单线程，事件队列越长，得到响应的时间就越长，并发量上还是会力不从心。
　　　2、 适合I/O密集型应用。 node.js非阻塞模式的IO处理给node.js带来在相对较低的资源耗用下的高性能与出众的负载能力,适合处理并发请求。
　　　3、 node.js轻量高效，可以认为是数据密集型实时应用系统的完美解决方案。
　　　4、 js语言适合前端工程师上手。
　　　5、 社区活跃发展速度快
缺点：
　　　1、 单线程，单进程，只支持单核CPU，不能充分的利用多核CPU服务器。
　　　2、 对程序员要求高一旦进程崩溃，那么整个web服务器就崩溃了。 解决方案：（1）Nnigx反向代理，负载均衡，开多个进程，绑定多个端口；（2）开多个进程监听同一个端口，使用cluster模块；
　　　3、 不适合做复杂性很高的计算。
　　　4、 不适合CPU密集型应用；CPU密集型应用给Node带来的挑战主要是：由于JavaScript单线程的原因，如果有长时间运行的计算（比如大循环），将会导致CPU时间片不能释放，使得后续I/O无法发起；
　　　5、 开源组件库质量参差不齐，更新快，向下不兼容
　　　6、 Debug不方便，错误没有stack trace
NodeJS适合运用在高并发、I/O密集、少量业务逻辑的场景。
[NodeJS优缺点及适用场景讨论](http://blog.csdn.net/xiaemperor/article/details/38234979)

### 前端界面工程师 理解及前景###
 前端是最贴近用户的程序员，比后端、数据库、产品经理、运营、安全都近。
1、 实现界面交互
2、 提升用户体验
3、 有了Node.js，前端可以实现服务端的一些事情 
4、 前端是最贴近用户的程序员，前端的能力就是能让产品从 90分进化到 100 分，甚至更好
5、 参与项目，快速高质量完成实现效果图，精确到1px；
6、 与团队成员，UI设计，产品经理的沟通；
7、 做好的页面结构，页面重构和用户体验；
8、 处理hack，兼容、写出优美的代码格式；
9、 针对服务器的优化、拥抱最新前端技术。 

### http状态码 ###
1xx: 信息性状态码，表示服务器接收到请求正在处理。 
2xx: 成功状态码，表示服务器正确处理完请求。 
3xx: 重定向状态码，表示请求的资源位置发生改变，需要重新请求。301永久重定向，302临时重定向。 
4xx: 客户端错误状态码，服务器无法处理该请求。 404 not found 
5xx: 服务器错误状态码，服务器处理请求出错。

100 Continue  继续，一般在发送post请求时，已发送了http header之后服务端将返回此信息，表示确认，之后发送具体参数信息
200 OK   正常返回信息
201 Created  请求成功并且服务器创建了新的资源
202 Accepted  服务器已接受请求，但尚未处理
301 Moved Permanently  请求的网页已永久移动到新位置
302 Found  临时性重定向
303 See Other  临时性重定向，且总是使用 GET 请求新的 URI
304 Not Modified  自从上次请求后，请求的网页未修改过
400 Bad Request  服务器无法理解请求的格式，客户端不应当尝试再次使用相同的内容发起请求
401 Unauthorized  请求未授权
403 Forbidden  禁止访问
404 Not Found  找不到如何与 URI 相匹配的资源
500 Internal Server Error  最常见的服务器端错误
503 Service Unavailable 服务器端暂时无法处理请求（可能是过载或维护）

### 页面加载过程 ###
1、 当发送一个 URL 请求时，不管这个 URL 是 Web 页面的 URL 还是 Web 页面上每个资源的 URL，浏览器都会开启一个线程来处理这个请求，同时在远程 DNS 服务器上启动一个 DNS 查询。这能使浏览器获得请求对应的 IP 地址。(DNS查询方式：浏览器缓存->系统缓存->路由器缓存)
2、 浏览器与远程 Web 服务器通过 TCP 三次握手协商来建立一个 TCP/IP 连接。该握手包括一个同步报文，一个同步-应答报文和一个应答报文，这三个报文在 浏览器和服务器之间传递。该握手首先由客户端尝试建立起通信，而后服务器应答并接受客户端的请求，最后由客户端发出该请求已经被接受的报文。
3、 一旦 TCP/IP 连接建立，浏览器会通过该连接向远程服务器发送 HTTP 的 GET 请求。远程服务器找到资源并使用 HTTP 响应返回该资源，值为 200 的 HTTP 响应状态表示一个正确的响应。
4、 此时，Web 服务器提供资源服务，客户端开始下载资源。

请求返回后，便进入了我们关注的前端模块
浏览器会解析 HTML 生成 DOM Tree，其次会根据 CSS 生成 CSS Rule Tree，而 javascript 又可以根据 DOM API 操作 DOM

### 如何管理项目 ###
1、 先期团队必须确定好全局样式（globe.css），编码模式(utf-8) 等
2、 编写习惯必须一致（例如都是采用继承式的写法，单样式都写成一行）
3、 标注样式编写人，各模块都及时标注（标注关键样式调用的地方）
4、 页面进行标注（例如 页面 模块 开始和结束）
5、 CSS 跟 HTML 分文件夹并行存放，命名都得统一（例如 style.css）
6、 JS 分文件夹存放 命名以该 JS 功能为准的英文翻译
7、 图片采用整合的 images.png png8 格式文件使用 尽量整合在一起使用方便将来的管理
 
### javascript对象的几种创建方式 ###
1、工厂模式
2、构造函数模式 
3、原型模式 

### javascript继承的 6 种方法 ###
1、 原型链继承
2、 借用构造函数继承
3、 组合继承(原型+借用构造)
4、 原型式继承
5、 寄生式继承
6、 寄生组合式继承
[JS继承的实现方式](http://www.cnblogs.com/humin/p/4556820.html)

### ajax 的过程 ###
1、 创建XMLHttpRequest对象,也就是创建一个异步调用对象
`var xhr = new XMLHttpRequest() `
2、 创建一个新的HTTP请求,并指定该HTTP请求的方法、URL及验证信息
`xhr.open(url,"get",false);`
3、 设置响应HTTP请求状态变化的函数
`onreadyState监听`
4、 发送HTTP请求
如果是post必须发送`xhr.send(null);`(null不能为空)
5、 获取异步调用返回的数据
6、 使用JavaScript和DOM实现局部刷新

	var xhr=new XMLHttpRequest();
	    xhr.onreadystatechange=function(){
	        if(xhr.readyState===4){
	            if(xhr.status===200){
	                doResponse(xhr.responseText);
	            }
	        }
	    }
	    xhr.open('GET','URL',true);
	    xhr.send(null);
	     
	    xhr.open('POST','URL',true);
	    setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	    xhr.send('k=v&k=v');

### 异步加载和延迟加载 ###
把script标签放在head之间，意味着必须等到全部js代码都被下载，解析，执行完成之后，才开始呈现页面的内容。浏览器在遇到body标签时才开始呈现内容

1、`<script>`标签定义了defer属性，这个属性的用途表明脚本在执行的时候不会影响页面结构，相当于告诉浏览器立即下载，但延迟执行。
注意defer属性只使用于外部脚本文件，支持html5的实现会忽略给嵌入脚本设置的defer属性。因此把延迟脚本放在页面的底部仍是最佳的选择
`<script  type = "text/javascript" defer="defer" src=".js">`
2、异步脚本
async只使用于外部脚本文件，并告诉浏览器立即下载文件，但与defer不同的是，标记为async的脚本并不保证按照指定他们的先后顺序执行。
`<script  type = "text/javascript" async src=".js">`

### 前端的安全问题 ###
1、XSS指cross-site-scripting, 跨站脚本攻击，恶意攻击者往Web页面里插入恶意Script代码，当用户浏览该页之时，嵌入其中Web里面的Script代码会被执行，从而达到恶意攻击用户的目的。
 [浅谈XSS攻击的那些事（附常用绕过姿势）](https://zhuanlan.zhihu.com/p/26177815?utm_source=weibo&utm_medium=social)
2、SQL注入，指web应用程序对用户输入数据的合法性没有判断，攻击者可以在web应用程序中事先定义好的查询语句的结尾上添加额外的SQL语句，以此来实现欺骗数据库服务器执行非授权的任意查询，从而进一步得到相应的数据信息。
[SQL注入攻击原理以及基本方法](http://blog.csdn.net/qq_34858648/article/details/52750038)
3、OS命令注入攻击，指的是通过web应用，执行非法的操作系统命令达到非法攻击的目的。 
4、HTTP首部注入攻击，指攻击者通过在相应首部字段内插入换行，然后添加任意响应首部过主体的攻击。 邮件首部注入攻击，指攻击者通过向邮件首部to或subject内任意添加非法内容引起的攻击。 
[攻击服务端(4)-HTTP参数注入攻击](http://blog.csdn.net/ffm83/article/details/44222319)
5、会话劫持，指攻击者通过某种手段拿到了用户的会话id，并非法使用此会话id伪装成用户达到攻击的目的。 6、还有DoS DDoS，一种让运行中的服务成停止状态的攻击。 
7、CSRF，跨站点请求伪造攻击，指的是攻击者通过设置好的陷阱，强制对已完成认证的用户进行非预期的个人信息或设定信息等某些状态更新，属于被动攻击。
攻击者盗用了你的身份，以你的名义发送恶意请求，对服务器来说这个请求是完全合法的，但是却完成了攻击者所期望的一个操作，比如以你的名义发送邮件、发消息，盗取你的账号，添加系统管理员，甚至于购买商品、虚拟货币转账等
[ CSRF攻击与防御](http://blog.csdn.net/stpeace/article/details/53512283)

### ie 各版本和 chrome 可以并行下载多少个资源  ###
1、 IE6 2 个并发
2、 iE7 升级之后的 6 个并发，之后版本也是 6 个
3、 Firefox，chrome 也是6个

### js继承怎么实现，如何避免原型链上面的对象共享 ###
1、 原型链继承
2、 借用构造函数继承
3、 组合继承(原型+借用构造)
4、 原型式继承
5、 寄生式继承
6、 寄生组合式继承
利用空对象作为中介。
[Javascript面向对象编程（二）：构造函数的继承 ---阮一峰](http://www.ruanyifeng.com/blog/2010/05/object-oriented_javascript_inheritance.html)

### 代码压缩工具及使用方法 ###
1、Google Closure Compile
2、Yahoo Yui Compresso
3、UglifyJS
GCC压缩混淆的最彻底，但是破坏原有代码，并且不可压缩CSS文件，运行在java环境下，危险，要严格注意书写规范。
Yui可以压缩CSS文件，安全，但是压缩完的文件函数名称没有混淆，压缩混淆的作用小，运行在java环境下。
UglifyJs不可以压缩混淆CSS文件，运行在NodeJs环境下，但是压缩完的文件函数名称没有混淆，压缩混淆的作用小，安全
[JS代码压缩混淆工具使用说明](http://blog.csdn.net/nh18304030935/article/details/70846649)

### Flash、Ajax各自的优缺点，在使用中如何取舍 ###
Flash：
1、 Flash适合处理多媒体、矢量图形、访问机器
2、 对CSS、处理文本上不足，不容易被搜索
Ajax：
1、 Ajax对CSS、文本支持很好，支持搜索
2、 多媒体、矢量图形、机器访问不足
共同点：
1、 与服务器的无刷新传递消息
2、 可以检测用户离线和在线状态
3、 操作DOM

### JavaScript 的同源策略 ###
概念：
同源策略是客户端脚本（尤其是Javascript）的重要的安全度量标准。它最早出自Netscape Navigator2.0，其目的是防止某个文档或脚本从多个不同源装载。
这里的同源策略指的是：协议，域名，端口相同，同源策略是一种安全协议，指一段脚本只能读取来自同一来源的窗口和文档的属性，无法访问其它域的资源。
同源策略是浏览器为了保护用户的个人信息以及企业数据的安全而设置的一种策略，不同源的客户端脚本是不能在对方未允许的情况下访问或索取对方的数据信息。

为什么要有同源限制：
我们举例说明：比如一个黑客程序，他利用Iframe把真正的银行登录页面嵌到他的页面上，当你使用真实的用户名，密码登录时，他的页面就可以通过Javascript读取到你的表单中input中的内容，这样用户名，密码就轻松到手了。
同源政策的目的，是为了保证用户信息的安全，防止恶意的网站窃取数据。

### 什么是 "use strict" ? 使用它的好处和坏处  ###
ECMAscript 5添加了第二种运行模式："严格模式"（strict mode）。顾名思义，这种模式使得Javascript在更严格的条件下运行。
设立"严格模式"的目的，主要有以下几个：
1、 消除Javascript语法的一些不合理、不严谨之处，减少一些怪异行为;
2、 消除代码运行的一些不安全之处，保证代码运行的安全；
3、 提高编译器效率，增加运行速度；
4、 为未来新版本的Javascript做好铺垫。
注：经过测试 IE6,7,8,9 均不支持严格模式。
缺点：
现在网站的 JS 都会进行压缩，一些文件用了严格模式，而另一些没有。这时这些本来是严格模式的文件，被 merge 后，这个串就到了文件的中间，不仅没有指示严格模式，反而在压缩后浪费了字节。

### GET和POST的区别 ###
GET：一般用于信息获取，使用URL传递参数，对所发送信息的数量也有限制，一般在2000个字符
POST：一般用于修改服务器上的资源，对所发送的信息没有限制

GET方式需要使用 Request.QueryString 来取得变量的值
POST方式通过 Request.Form 来获取变量的值
也就是说 Get 是通过地址栏来传值，而 Post 是通过提交表单来传值。

在以下情况中，请使用 POST 请求：
1、 无法使用缓存文件（更新服务器上的文件或数据库）
2、 向服务器发送大量数据（POST 没有数据量限制）
3、 发送包含未知字符的用户输入时，POST 比 GET 更稳定也更可靠

HTTP方法 是根据意图区分的，HTTP中的GET，POST，PUT，DELETE就对应着对这个资源的查，改，增，删4个操作。GET一般用于获取/查询资源信息，而POST一般用于更新资源信息。
表面区别：
(1)传参方式
1、 GET可以通过URL直接传参
2、 两者都可以通过body传参
(2)长度
1、 header和body都没有对长度的限制
2、 URL的长度受到部分早期浏览器的限制
3、 URL的长度还可能受到服务器的限制，由于URL的实际超长或者设定其Content-Length较大值会引起服务器最大并发数下降或者资源空耗
4、 2和3间接限定了URL方式发起GET方法的长度
(3)安全性
1、 GET不会修改服务端数据，POST可以修改数据
2、 URL方式发起GET请求，参数会明文暴露
3、 使用GET提交数据还可能会造成Cross-site request forgery攻击
4、 本质上安全性无区别 

### css阻塞，js阻塞 ###
**js 的阻塞特性：**所有浏览器在下载 JS 的时候，会阻止一切其他活动，比如其他资源的下载，内容的呈现等等。直到 JS 下载、解析、执行完毕后才开始继续并行下载其他资源并呈现内容。为了提高用户体验，新一代浏览器都支持并行下载 JS，但是 JS 下载仍然会阻塞其它资源的下载（例如.图片，css文件等）。 
浏览器为了防止出现 JS 修改 DOM 树，需要重新构建 DOM 树的情况，所以就会阻塞其他的下载和呈现。
嵌入 JS 会阻塞所有内容的呈现，而外部 JS 只会阻塞其后内容的显示，2 种方式都会阻塞其后资源的下载。也就是说外部样式不会阻塞外部脚本的加载，但会阻塞外部脚本的执行。 

CSS 怎么会阻塞加载了？CSS 本来是可以并行下载的，在什么情况下会出现阻塞加载了(在测试观察中，IE6 下 CSS 都是阻塞加载）
当 CSS 后面跟着嵌入的 JS 的时候，该 CSS 就会出现阻塞后面资源下载的情况。而当把嵌入 JS 放到 CSS 前面，就不会出现阻塞的情况了。
根本原因：因为浏览器会维持 html 中 css 和 js 的顺序，样式表必须在嵌入的 JS 执行前先加载、解析完。而嵌入的 JS 会阻塞后面的资源加载，所以就会出现上面 CSS 阻塞下载的情况。 

 嵌入JS应该放在什么位置？
1、 放在底部，虽然放在底部照样会阻塞所有呈现，但不会阻塞资源下载。
2、 如果嵌入JS放在head中，请把嵌入JS放在CSS头部。
3、 使用 defer（只支持IE）
4、 不要在嵌入的JS中调用运行时间较长的函数，如果一定要用，可以用 setTimeout 来调用

Javascript无阻塞加载具体方式：
1、 将脚本放在底部。`<link>`还是放在head中，用以保证在js加载前，能加载出正常显示的页面。`<script>`标签放在`</body>`前。
2、 阻塞脚本：由于每个`<script>`标签下载时阻塞页面解析过程，所以限制页面的`<script>`总数也可以改善性能。适用于内联脚本和外部脚本。
3、 非阻塞脚本：等页面完成加载后，再加载js代码。也就是，在 window.onload 事件发出后开始下载代码。
4、 defer属性：支持IE4和fierfox3.5更高版本浏览器
5、 动态脚本元素：文档对象模型（DOM）允许你使用js动态创建HTML的几乎全部文档内容。代码如下：

	<script>
	    var script=document.createElement("script");
	    script.type="text/javascript";
	    script.src="file.js";
	    document.getElementsByTagName("head")[0].appendChild(script);
	</script>
此技术的重点在于：无论在何处启动下载，文件下载和运行都不会阻塞其他页面处理过程，即使在head里（除了用于下载文件的 http 链接）
**关于CSS加载造成阻塞问题**
css并不会阻塞DOM树的解析，但会阻塞DOM树渲染。css加载会阻塞后面js语句的执行。
为了避免让用户看到长时间的白屏时间，我们应该尽可能的提高css加载速度，比如可以使用以下几种方法:
1.使用CDN(因为CDN会根据你的网络状况，替你挑选最近的一个具有缓存内容的节点为你提供资源，因此可以减少加载时间)
2.对css进行压缩(可以用很多打包工具，比如webpack,gulp等，也可以通过开启gzip压缩)
3.合理的使用缓存(设置cache-control,expires,以及E-tag都是不错的，不过要注意一个问题，就是文件更新后，你要避免缓存而带来的影响。其中一个解决防范是在文件名字后面加一个版本号)
4.减少http请求数，将多个css文件合并，或者是干脆直接写成内联样式(内联样式的一个缺点就是不能缓存)
[css加载会造成阻塞吗](https://www.cnblogs.com/chenjg/p/7126822.html)

### eval() ###
1、 它的功能是把对应的字符串解析成JS代码并运行
2、 应该避免使用eval，不安全，非常耗性能（2次，一次解析成js语句，一次执行）

### 一个通用的事件侦听器函数  ###
	// event(事件)工具集，来源：github.com/markyun
	markyun.Event = {
	    // 页面加载完成后
	    readyEvent : function(fn) {
	        if (fn==null) {
	            fn=document;
	        }
	        var oldonload = window.onload;
	        if (typeof window.onload != 'function') {
	            window.onload = fn;
	        } else {
	            window.onload = function() {
	                oldonload();
	                fn();
	            };
	        }
	    },
	    // 视能力分别使用dom0||dom2||IE方式 来绑定事件
	    // 参数： 操作的元素,事件名称 ,事件处理程序
	    addEvent : function(element, type, handler) {
	        if (element.addEventListener) {
	            //事件类型、需要执行的函数、是否捕捉
	            element.addEventListener(type, handler, false);
	        } else if (element.attachEvent) {
	            element.attachEvent('on' + type, function() {
	                handler.call(element);
	            });
	        } else {
	            element['on' + type] = handler;
	        }
	    },
	    // 移除事件
	    removeEvent : function(element, type, handler) {
	        if (element.removeEnentListener) {
	            element.removeEnentListener(type, handler, false);
	        } else if (element.detachEvent) {
	            element.detachEvent('on' + type, handler);
	        } else {
	            element['on' + type] = null;
	        }
	    }, 
	    // 阻止事件 (主要是事件冒泡，因为IE不支持事件捕获)
	    stopPropagation : function(ev) {
	        if (ev.stopPropagation) {
	            ev.stopPropagation();
	        } else {
	            ev.cancelBubble = true;
	        }
	    },
	    // 取消事件的默认行为
	    preventDefault : function(event) {
	        if (event.preventDefault) {
	            event.preventDefault();
	        } else {
	            event.returnValue = false;
	        }
	    },
	    // 获取事件目标
	    getTarget : function(event) {
	        return event.target || event.srcElement;
	    },
	    // 获取event对象的引用，取到事件的所有信息，确保随时能使用event；
	    getEvent : function(e) {
	        var ev = e || window.event;
	        if (!ev) {
	            var c = this.getEvent.caller;
	            while (c) {
	                ev = c.arguments[0];
	                if (ev && Event == ev.constructor) {
	                    break;
	                }
	                c = c.caller;
	            }
	        }
	        return ev;
	    }
	};
### Node.js 的适用场景  ###
1、 高并发
2、 聊天
3、 实时消息推送   
 
1 Web开发：Express + EJS + Mongoose/MySQL
express 是轻量灵活的Nodejs Web应用框架，它可以快速地搭建网站。Express框架建立在Nodejs内置的Http模块上，并对Http模块再包装，从而实际Web请求处理的功能。
ejs是一个嵌入的Javascript模板引擎，通过编译生成HTML的代码。
mongoose 是MongoDB的对象模型工具，通过Mongoose框架，可以进行访问MongoDB的操作。
mysql 是连接MySQL数据库的通信API，可以进行访问MySQL的操作。
通常用Nodejs做Web开发，需要3个框架配合使用，就像Java中的SSH。
2 REST开发：Restify
restify 是一个基于Nodejs的REST应用框架，支持服务器端和客户端。restify比起express更专注于REST服务，去掉了express中的 template, render等功能，同时强化了REST协议使用，版本化支持，HTTP的异常处理。
3 Web聊天室(IM)：Express + Socket.io
socket.io一个是基于Nodejs架构体系的，支持websocket的协议用于时时通信的一个软件包。socket.io 给跨浏览器构建实时应用提供了完整的封装，socket.io完全由javascript实现。
4 Web爬虫：Cheerio/Request
cheerio 是一个为服务器特别定制的，快速、灵活、封装jQuery核心功能工具包。Cheerio包括了 jQuery核心的子集，从jQuery库中去除了所有DOM不一致性和浏览器不兼容的部分，揭示了它真正优雅的API。Cheerio工作在一个非常简 单，一致的DOM模型之上，解析、操作、渲染都变得难以置信的高效。基础的端到端的基准测试显示Cheerio大约比JSDOM快八倍(8x)。 Cheerio封装了@FB55兼容的htmlparser，几乎能够解析任何的 HTML 和 XML document。
5 Web博客：Hexo
Hexo 是一个简单地、轻量地、基于Node的一个静态博客框架。通过Hexo我们可以快速创建自己的博客，仅需要几条命令就可以完成。
发布时，Hexo可以部署在自己的Node服务器上面，也可以部署github上面。对于个人用户来说，部署在github上好处颇多，不仅可以省 去服务器的成本，还可以减少各种系统运维的麻烦事(系统管理、备份、网络)。所以，基于github的个人站点，正在开始流行起来….
6 Web论坛: nodeclub
Node Club 是用 Node.js 和 MongoDB 开发的新型社区软件，界面优雅，功能丰富，小巧迅速， 已在Node.js 中文技术社区 CNode 得到应用，但你完全可以用它搭建自己的社区。
7 Web幻灯片：Cleaver
Cleaver 可以生成基于Markdown的演示文稿。如果你已经有了一个Markdown的文档，30秒就可以制作成幻灯片。Cleaver是为Hacker准备的工具。
8 前端包管理平台: bower.js
Bower 是 twitter 推出的一款包管理工具，基于nodejs的模块化思想，把功能分散到各个模块中，让模块和模块之间存在联系，通过 Bower 来管理模块间的这种联系。
9 OAuth认证：Passport
Passport项 目是一个基于Nodejs的认证中间件。Passport目的只是为了“登陆认证”，因此，代码干净，易维护，可以方便地集成到其他的应用中。Web应用 一般有2种登陆认证的形式：用户名和密码认证登陆,OAuth认证登陆。Passport可以根据应用程序的特点，配置不同的认证机制。本文将介绍，用户 名和密码的认证登陆。
10 定时任务工具: later
Later 是一个基于Nodejs的工具库，用最简单的方式执行定时任务。Later可以运行在Node和浏览器中。
11 浏览器环境工具: browserify
Browserify 的出现可以让Nodejs模块跑在浏览器中，用require()的语法格式来组织前端的代码，加载npm的模块。在浏览器中，调用browserify编译后的代码，

### JavaScript 原型，原型链 ? 有什么特点？  ###
**1.什么是原型，原型有什么特点：**
JavaScript 的每个对象都继承另一个对象，后者称为“原型”（prototype）对象。只有null除外，它没有自己的原型对象。
使用原型的好处是：原型对象上的所有属性和方法，都能被对应的构造函数创建的实例对象共享（这就是 JavaScript 继承机制的基本设计），也就是说，不必在构造函数中定义对象实例的信息，而是可以将这些信息直接添加到原型对象中。
每一个构造函数都有一个prototype（原型）属性，这个属性就是使用构造函数创建出来的实例对象的原型对象。
**2.什么是原型链，原型链有什么特点**
对象的属性和方法，有可能是定义在自身，也有可能是定义在它的原型对象上。由于原型本身也是对象，又有自己的原型，所以形成了一条原型链（prototype chain）。
如果一层层地上溯，所有对象的原型最终都可以上溯到Object.prototype，即Object构造函数的prototype属性指向的那个对象。而Object.prototype对象的原型就是没有任何属性和方法的null对象，而null对象没有自己的原型。
“原型链”的作用是，读取对象的某个属性时，JavaScript 引擎先寻找对象本身的属性，如果找不到，就到它的原型去找，如果还是找不到，就到原型的原型去找。如果直到最顶层的Object.prototype还是找不到，则返回undefined。
如果对象自身和它的原型，都定义了一个同名属性，那么优先读取对象自身的属性，这叫做“覆盖”（overriding）。
需要注意的是，一级级向上，在原型链寻找某个属性，对性能是有影响的。所寻找的属性在越上层的原型对象，对性能的影响越大。如果寻找某个不存在的属性，将会遍历整个原型链。

### 怎么重构页面 ###
页面重构是一种思想，是页面的二次构造（在实现层次）：包括设计稿的重构、过时页面的重构、功能不全页面的重构、代码重构。
设计稿的重构：设计师的设计稿可能不是特别符合页面效果，当拿到设计稿时需要通过二次重构和修改达到预期效果。
功能不全页面的重构：页面功能不符合用户体验、用户交互。
过时页面的重构：使用的是过时的代码和标签，跟不上时代的发展。
代码重构：代码质量、SEO优化、页面性能、更好的语义化、浏览器兼容、CSS优化。

### WEB应用从服务器主动推送Data到客户端的方式 ###
1、**AJAX轮询**
利用XHR，通过setInterval定时发送请求，但会造成数据同步不及时及无效的请求，增加后端处理压力
2、**基于 AJAX 的长轮询**（long-polling）方式
在Ajax轮询基础上做的一些改进，在没有更新的时候不再返回空响应，而且把连接保持到有更新的时候，客户端向服务器发送Ajax请求，服务器接到请求后hold住连接，直到有新消息才返回响应信息并关闭连接，客户端处理完响应信息后再向服务器发送新的请求，通常把这种实现也叫做**comet**。 
3、**Server-sent-events(SSE)**
让服务端可以向客户端流式发送文本消息，在实现上，客户端浏览器中增加EventSource对象，使其能通过事件的方式接收到服务器推送的消息，在服务端，使用长连接的事件流协议，即请求响应时增加新数据流数据格式。 
适应于后端数据更新频繁且对实时性要求较高而又不需要客户端向服务端通信的场景下。 
缺点： 只能单向通信，服务器端向客户端推送事件；事件流协议只能传输UTF-8数据，不支持二进制流。 
4、**HTTP Streaming**
通过iframe和`<script>`标签完成数据的传输
5、**TCP 长连接**
6、**HTML5 WebSocket**
可以实现服务器主动发送数据至网页端，它和HTTP一样，是一个基于HTTP的应用层协议，跑的是TCP，所以本质上还是个长连接，双向通信，意味着服务器端和客户端可以同时发送并响应请求，而不再像HTTP的请求和响应
[服务端是如何主动推送信息到客户端的？](https://www.zhihu.com/question/24938934)
[几种web服务器端推送技术的简单介绍](http://www.daimajiayuan.com/sitejs-65893-1.html)
[HTML5服务器推送消息的各种解决办法](https://www.cnblogs.com/Herzog3/p/5939144.html)

### 事件、IE与火狐的事件机制有什么区别？ 如何阻止冒泡？ ###
1、 我们在网页中的某个操作（有的操作对应多个事件）。例如：当我们点击一个按钮就会产生一个事件。是可以被 JavaScript 侦测到的行为
2、 事件处理机制：IE是事件冒泡、firefox同时支持两种事件模型，也就是：捕获型事件和冒泡型事件
3、 ev.stopPropagation();
注意旧ie的方法：ev.cancelBubble = true;

### Ajax 是什么？Ajax 的交互模型？同步和异步的区别？如何解决跨域问题？  ###
AJAX 的全称是异步的 Javascript 和 XML ，是一种创建快速动态网页的技术，通过在后台与服务器进行少量数据交互，实现网页的异步更新，在不重新加载整个界面的情况下，做到网页的部分刷新；
**AJAX 的交互模型（ AJAX 的过程）：**
用户发出异步请求；
创建 XMLHttpRequest 对象；
告诉 XMLHttpRequest 对象，哪个函数会处理 XMLHttpRequest 对象状态的改变，为此要把对象的 onReadyStateChange 属性设置为响应该事件的 JavaScript 函数的引用；
创建请求，用 open 方法指定是 get 还是 post ，是否异步， url 地址；
发送请求， send 方法；
接收结果并分析；
实现刷新
**同步异步的区别:**
同步：脚本会停留并等待服务器发送回复然后再继续
异步：脚本允许页面继续其进程，服务器返回结果时再作处理
**跨域问题的解决**
1、 使用 document.domain+iframe 解决跨子域问题
2、 使用 window.name
3、 使用 flash
4、 使用 iframe+location.hash
5、 使用 html5 的 postMessage ；
6、 使用 jsonp （创建动态 script ）

### js对象的深度克隆代码实现 ###
	function clone(obj){
	    if(!obj || typeof(obj) != 'object') return obj;
	    var r = Array.prototype.splice === obj.splice ? []:{};
	    for(var i in obj){
	        if(obj.hasOwnProperty(i)){
	            r[i] = clone(obj[i]);
	        }
	    }
	    return r ;
	}
	//数组、对象都可以for in,同时针对对象必须需要判断hasOwnProperty属性，以防克隆原型链上的属性
[javascript中对象的深度克隆](http://www.cnblogs.com/jq-melody/p/4499333.html)

### 网站重构 ###
网站重构：在不改变外部行为的前提下，简化结构、添加可读性，而在网站前端保持一致的行为。也就是说是在不改变 UI 的情况下，对网站进行优化，在扩展的同时保持一致的 UI。 
对于传统的网站来说重构通常是：
1、 表格(table)布局改为 DIV + CSS
2、 使网站前端兼容于现代浏览器(针对于不合规范的CSS、如对 IE6 有效的)
3、 对于移动平台的优化
4、 针对于 SEO 进行优化
5、 深层次的网站重构应该考虑的方面
6、 减少代码间的耦合
7、 让代码保持弹性
8、 严格按规范编写代码
9、 设计可扩展的API
10、 代替旧有的框架、语言(如VB)
11、 增强用户体验
12、 通常来说对于速度的优化也包含在重构中
13、 压缩JS、CSS、image等前端资源(通常是由服务器来解决)
14、 程序的性能优化(如数据读写)
15、 采用CDN来加速资源加载
16、 对于JS DOM的优化
17、 HTTP服务器的文件缓存
 
### 如何获取UA  ###
浏览器标识（UA,User Agent）可以使得服务器能够识别客户使用的操作系统及版本、CPU 类型、浏览器及版本、浏览器渲染引擎、浏览器语言、浏览器插件，从而判断用户是使用电脑浏览还是手机浏览，让网页作出自动的适应。
使用navigator对象:
1、Navigator.appCodeName,浏览器代码名的字符表示
2、appName，浏览器的名称
3、appVersion 返回broswer平台和版本信息
4、platform，返回运行浏览器的操作系统平台
5、userAgent，返回客户机发送给服务器的useragent头部的值

	<script> 
	function whatBrowser() {  
	    document.Browser.Name.value=navigator.appName;  
	    document.Browser.Version.value=navigator.appVersion;  
	    document.Browser.Code.value=navigator.appCodeName;  
	    document.Browser.Agent.value=navigator.userAgent;  
	}
	</script>

### js 数组去重  ###
1、

	function uniqArray(arr) {
		//利用es6 新的数据类型，Set() 集合来做，集合不的每个元素是不允许重复的

	    return [... new Set(arr)];

		//return Array.from(new Set(arr));
	}
2、

	Array.prototype.filterOverlap = function(){
	    var temp = [];
	    if(!this.length){
	         return [];
	    }
	    for(var i=0,len = this.length;i<len;i++){
	     if(temp.indexOf(this[i])<0){
	          temp.push(this[i]);
	      }   
	    }
	    return temp;
	}

### 网页缓存 cache-control  ###
1、http响应头信息，可以用来设置缓存，优化页面的性能。
服务器可以通过HTTP定义的几种方式来指定在文档过期之前可以将其缓存多长时间。
2、添加在HTTP响应头中
3、no-store：禁止缓存对响应进行复制
no-cache：在与原始服务器进行新鲜度再验证之前，缓存不能将其提供给客户端使用
max-age: 从服务器将文档传来之时，可以认为此文档处于新鲜状态的秒数
max-age=0;将最大使用时间设置为零，从而在每次访问的时候都进行刷新
Expires响应首部：实际的过期时间而不是秒数 (GMT格式)

[Http头介绍:Expires,Cache-Control,Last-Modified,ETag](http://www.51testing.com/html/28/116228-238337.html)
[浅谈前端性能优化（一）——Expires和Cache-Control](http://blog.csdn.net/zhouziyu2011/article/details/71312452)

### js 操作获取和设置 cookie  ###
	// 创建cookie
	function setCookie(name, value, expires, path, domain, secure) {
	    var cookieText = encodeURIComponent(name) + '=' + encodeURIComponent(value);
	    if (expires instanceof Date) {
	        cookieText += '; expires=' + expires;
	    }
	    if (path) {
	        cookieText += "; path=" + path     }
	    if (domain) {
	        cookieText += '; domain=' + domain;
	    }
	    if (secure) {
	        cookieText += '; secure';
	    }
	    document.cookie = cookieText;
	}
	// 获取cookie
	function getCookie(name) {
	    var cookieName = encodeURIComponent(name) + '=';
	    var cookieStart = document.cookie.indexOf(cookieName);
	    var cookieValue = null;
	    if (cookieStart > -1) {
	        var cookieEnd = document.cookie.indexOf(';', cookieStart);
	        if (cookieEnd == -1) {
	            cookieEnd = document.cookie.length;
	        }
	        cookieValue = decodeURIComponent(document.cookie.substring(cookieStart + cookieName.length, cookieEnd));
	    }
	    return cookieValue;
	}
	// 删除cookie
	function unsetCookie(name) {
	    document.cookie = name + "= ; expires=" + new Date(0);
	}
[前端开发中通过js设置/获取cookie的一组方法](https://www.cnblogs.com/anniey/p/6510911.html)




