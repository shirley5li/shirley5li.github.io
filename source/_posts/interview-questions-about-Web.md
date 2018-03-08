---
title: 【interview questions about Web】
date: 2018-03-04 15:20:40
tags: [interview questions]
categories: interview questions
---
Web方面的知识盲区补漏。
<!--more-->

### 匹配URL的正则表达式 ###
URL由三部分组成：资源类型(协议)、存放资源的主机域名、资源文件名。
URL的一般语法格式为(带方括号[ ]的为可选项)：
`protocol :// hostname[:port] / path / [;parameters][?query]#fragment`
据说比较好用匹配较全面的是这个：
`(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]`
参考自博客[正确匹配URL的正则表达式](https://www.cnblogs.com/speeding/p/5097790.html)、[匹配URL的正则表达式解析](http://blog.csdn.net/t_1007/article/details/52293475)。

### React虚拟DOM的优势，为什么虚拟DOM操作比原生方式快 ###
将数据的变化实时反映到UI上，这时需要对DOM进行操作，但复杂或频繁的DOM操作(会造成重排、重绘)通常是性能瓶颈产生的原因，为此，React引入了虚拟DOM（Virtual DOM）的机制。

**虚拟DOM?**
 在React中，render执行的结果得到的并不是真正的DOM节点，结果仅仅是轻量级的JavaScript对象，称之为virtual DOM。(是不是跟文档片段有异曲同工之妙？[dom中的文档碎片](https://www.cnblogs.com/sdfcbs/p/6438784.html))

虚拟DOM是React的一大亮点，具有batching(批处理)和高效的Diff算法 ([深入浅出React（四）：虚拟DOM Diff算法解析](http://www.infoq.com/cn/articles/react-dom-diff/#))。这让我们可以无需担心性能问题而”毫无顾忌”的随时“刷新”整个页面，由虚拟 DOM来确保只对界面上真正变化的部分进行实际的DOM操作。

**虚拟DOM对比原生操作DOM**
原生操作DOM方式，使用 innerHTML。在一个大型列表所有数据都变了的情况下，还算是合理，但当只有一行数据发生变化时，它也需要重置整个 innerHTML，这时候显然就造成了大量浪费。
innerHTML: render html string + 重新创建所有 DOM 元素
Virtual DOM: render Virtual DOM + diff + 必要的 DOM 更新 
和 DOM 操作比起来，js 计算是非常便宜的。Virtual DOM render + diff 显然比渲染 html 字符串要慢，但是，它依然是纯 js 层面的计算，比起后面的 DOM 操作来说，依然便宜了太多。

**存疑**
React虚拟DOM的工作机制还不太理解，深入学习以后需要再回顾。
[React虚拟DOM浅析](https://www.cnblogs.com/chris-oil/p/6160985.html)
[React 的 diff 算法](https://segmentfault.com/a/1190000000606216)
[为什么 React 的 virtual DOM 比原生的DOM 渲染性能更好？](https://segmentfault.com/q/1010000000762295)

### RESTful ###
REST(Representational State Transfer)，“表述性状态转移”，是一种网络应用架构规范，目标是构建可扩展的web service。
REST规范可以提高架构的性能和可维护性。REST是一种更简单的[SOAP协议](https://www.cnblogs.com/leijiangtao/p/5137351.html)及以[WSDL](http://blog.csdn.net/liguocai2005/article/details/4402350)为基础的web service的替代。(SOAP暴露接口，REST暴露资源)
参考博客[WebService两种发布协议--SOAP和REST的区别](http://blog.csdn.net/zl834205311/article/details/62231545?ABstrategy=codes_snippets_optimize_v3)。
[RESTful](https://blog.igevin.info/posts/restful-architecture-in-general/)（采用REST架构规范的）系统通常是通过HTTP协议，并且使用HTTP的GET,POST,PUT,DELETE等动词来收发数据。
W3C TAG开发了REST架构，基于HTTP 1.0。万维网代表了最大的REST架构实现，你可以认为所有的网页服务器都是采用REST架构的RESTful系统。
目前在三种主流的Web服务实现方案中，因为REST模式的Web服务与复杂的SOAP和XML-RPC对比来讲明显的更加简洁，越来越多的web服务开始采用REST风格设计和实现。
[常见的三种Web服务架构](https://www.cnblogs.com/bluewhale84/p/4443353.html)。

### WebView相关 ###
[先了解什么是Hybrid APP](https://www.cnblogs.com/dailc/p/5930231.html)。所谓Hybrid,即混合开发,意味着半原生半Web,其实在H5兴盛之前,Hybrid模式就已经比较成熟了,但是一直不愠不火(因为系统的一些现在以及html本身功能的限制)。
怎么样的开发模式才算是Hybrid模式呢：
- Hybrid是半Native半web开发模式
Hybrid模式中,底层功能API均由原生容器通过某种方式提供,然后业务逻辑由H5页面完成,最终原生容器加载H5页面,完成整个App
- 成熟的Hybrid模式意味着业务逻辑均由H5实现 
一款成熟的Hybrid框架,意味着各种类型的api都很完善,那么这时候几乎所有与业务相关的逻辑都是放在H5页面中的,原生只作为容器存在
- 成熟的Hybrid模式可复用性非常高,可以跨平台开发
成熟的Hybrid框架,那么原生只会提供底层API,也就是说所有的业务是H5完成,不管是什么项目,业务只由H5实现,这时候就可以发现,业务代码是可以跨平台的,也就是说,开发一次,就可以和各自原生容器结合,组成两种原生安装包了,达到了跨平台开发效果

[APP三种开发模式--之--HybridApp解决方案](http://blog.csdn.net/qibanxuehua/article/details/69944087?locationNum=12&fps=1)

原生APP开发中有一个webview的组件(Android中是webview,iOS7以下有UIWebview,7以上有WKWebview),这个组件可以加载Html文件。
在Html5没有兴盛之前,加载的Html往往只能用来做一些简单的静态资源显示,但是H5大行其道以后,Html5中有很多新增的功能,炫酷的效果,特别是iOS中H5支持一直都很良好,Android 4.4以上支持也足够,所以这时候发现可以将一些主要的逻辑都用H5页面来编写,然后原生直接用webview加载显示,这样大大提高了开发效率,而且体验也很不错。
webview用来展示网页的view组件，该组件是你运行自己的浏览器或者在你的线程中展示线上内容的基础。使用webkit渲染引擎来展示，并且支持前进后退等基于浏览历史，放大缩小，等更多功能。
简单来说WebView是手机中内置了一款高性能 webkit 内核浏览器,在 SDK 中封装的一个组件。不给过没有提供地址栏和导航栏，只是单纯的展示一个网页界面。
参考文章[前端解读Webview](https://www.cnblogs.com/pqjwyn/p/7120342.html)、[WebView JavascriptBridge机制解析](https://www.jianshu.com/p/8bd6aeb719ff)、[JS交互与WebView的工作原理浅析](http://blog.csdn.net/rookie_small/article/details/68488335)。

### 软件开发模式之“快速迭代”开发 ###
几种常见的软件开发模式对比参考博客[软件开发模式对比(瀑布、迭代、螺旋、敏捷)](https://www.cnblogs.com/tianguook/p/4004726.html)。
迭代成本比较低，一般采用敏捷开发的模式，产品快速的推动上线，上线后会通过用户反馈和用户行为分析不断的进行产品改进，并且每次改进的周期比较短，如果把“快速迭代”理解为快速并持续的更新和改进产品。

[敏捷开发-快速迭代](http://blog.csdn.net/xiaoxian8023/article/details/8883791)

### 线程和进程的区别 ###
[线程和进程的区别是什么？--知乎](https://www.zhihu.com/question/25532384)
进程和线程都是一个时间段的描述，是CPU工作时间段的描述，不过是颗粒大小不同。
进程就是包换上下文切换的程序执行时间总和 = CPU加载上下文+CPU执行+CPU保存上下文。
线程是共享了进程的上下文环境的更为细小的CPU时间段。
[进程和线程的区别](https://www.cnblogs.com/lgk8023/p/6430592.html)
[进程与线程的一个简单解释--阮一峰](http://www.ruanyifeng.com/blog/2013/04/processes_and_threads.html)

**[浅谈js运行机制(线程）](http://blog.csdn.net/w2765006513/article/details/53743051)**
js运作在浏览器中,是单线程的，即js代码始终在一个线程上执行，这个线程称为js引擎线程。
浏览器是多线程的，除了js引擎线程，它还有：

 	UI渲染线程
    浏览器事件触发线程
    http请求线程
    EventLoop轮询的处理线程
	....

单线程的含义是js只能在一个线程上运行，也就说，js同时只能执行一个js任务，其它的任务则会排队等待执行。
js是单线程的,并不代表js引擎线程只有一个。js引擎有多个线程，一个主线程，其它的后台配合主线程。
多线程之间会共享运行资源，浏览器端的js会操作dom，多个线程必然会带来同步的问题，所有js核心选择了单线程来避免处理这个麻烦。js可以操作dom，影响渲染，所以js引擎线程和UI线程是互斥的。这也就解释了js执行时会阻塞页面的渲染。

**[JavaScript 运行机制详解：再谈Event Loop--阮一峰](http://www.ruanyifeng.com/blog/2014/10/event-loop.html)**
**[Javascript异步编程的4种方法--阮一峰](http://www.ruanyifeng.com/blog/2012/12/asynchronous%EF%BC%BFjavascript.html)**
**[关于javascript的单线程和异步的一些问题](https://www.cnblogs.com/nidaye/p/4604147.html)**
[Node.js的线程和进程](https://www.cnblogs.com/chris-oil/p/5339305.html)