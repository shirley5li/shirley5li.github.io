---
title: JSONP简要了解
date: 2017-11-15 21:08:22
tags: [JSONP, JavaScript, JSON]
categories: JSONP
---
在freeCodeCamp上学习使用twith TV API获取频道信息时，在freeCodeCamp的指导中提到若使用`$.getJSON(()`方法会因为跨域资源共享(CORS)问题发生错误信息。[ freeCodeCamp Challenge Guide: How to Use the TwitchTV API ](https://forum.freecodecamp.org/t/freecodecamp-challenge-guide-how-to-use-the-twitchtv-api/19541)中建议使用jQuery的JSONP方法来解决CORS问题。
<!--more-->
## JSONP的诞生 ##
传统ajax无法跨域，而<script\>标签的src属性是可以跨域的,可以通过把跨域服务器写成**调用本地的函数** ，回调数据回来。

json刚好被js支持（**object**）

调用跨域服务器上动态生成的js格式文件（**不管是什么类型的地址，最终生成的返回值都是一段js代码**）

这种获取远程数据的方式看起来非常像ajax，但其实并不一样，便于客户端使用数据，逐渐形成了一种非正式传输协议，人们把它称作**JSONP**。

传递一个**callback参数**给跨域服务端，然后跨域服务端返回数据时会将这个callback参数作为函数名来包裹住json数据即可。

## 例子 ##
（1）**跨域服务器**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文件：**remote.js**

	alert("我是远程文件");

**本地**

	<script type="text/javascript" src="跨域服务器/remote.js"></script>
在本地<script\>标签直接引入一个js文件，页面将会弹出警告框。

（2）**跨域服务器**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文件：**remote.js**

	localHandler({"result":"我是远程js带来的数据"});

**本地**

	<script type="text/javascript"> 
	    var localHandler = function(data){
	        alert('我是本地函数，可以被跨域的remote.js文件调用，远程js带来的数据是：' + data.result); 
	    }; 
	</script> 
	<script type="text/javascript" src="跨域服务器/remote.js"></script>

该例子中在本地定义了一个函数`localHandler`，在本地通过<script\>标签的`src`属性引入了跨域服务器上的一个js文件`remote.js`，在引入的js文件里调用了本地定义的函数`localHandler`。

**问题**：如何让远程js文件知道它应该调用的本地函数的名字呢？毕竟jsonp的服务者都要面对很多服务对象，而这些服务对象各自的本地函数都不相同。

（3）**跨域服务器**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文件：**flightResult.php**

	flightHandler({
	    "code":"CA1998",
	    "price": 1780,
	    "tickets": 5
	});
**本地**

	<script type="text/javascript"> 
	    // 得到航班信息查询结果后的回调函数 
	    var flightHandler = function(data){
	        alert('你查询的航班结果是：票价 ' + data.price + ' 元，' + '余票 ' + data.tickets + ' 张。');
	    }; 
	    // 提供jsonp服务的url地址（不管是什么类型的地址，最终生成的返回值都是一段javascript代码） 
	    var url = "跨域服务器/flightResult.php?code=CA1998&callback=flightHandler";
	    // 创建script标签，设置其属性 
	    var script = document.createElement('script'); 
	    script.setAttribute('src', url); 
	    // 把script标签加入head，此时调用开始 
	    document.getElementsByTagName('head')[0].appendChild(script); 
	</script>

在该例中动态创建<script\>标签（动态创建脚本）； url中传递了一个code参数，服务器去做查询CA1998次航班的信息，callback参数告诉服务器，我的本地回调函数叫做flightHandler； 跨域服务端调用这个函数flightHandler，页面将会弹出一个提示窗体，显示出票价和余票。

## JSONP方法中服务器做的事情 ##
	
	// 数据
	$data = [
	    "name":"anonymous66",
	    "age":"18",
	    "like":"jianshu"
	];
	// 接收callback函数名称
	$callback = $_GET['callback'];
	// 输出
	echo $callback . "(" . json_encode($data) . ")";
服务器端做的就是获取url中的callback参数，并将callback参数作为函数名来包裹json数据，动态生成js文件，再返回给客户端。

## JSONP与AJAX的区别 ##

ajax的核心是通过XMLHttpRequest获取非本页内容。

jsonp的核心则是动态添加<script\>标签来调用服务器提供的js脚本。
## JSONP优缺点 ##
优点：它不像XMLHttpRequest对象实现的Ajax请求那样受到同源策略的限制；它的兼容性更好，在更加古老的浏览器中都 可以运行，不需要XMLHttpRequest或ActiveX的支持；并且在请求完毕后可以通过调用callback的方式回传结果。

缺点：它只支持GET请求而不支持POST等其它类型的HTTP请求；它只支持跨域HTTP请求这种情况，不能解决不同域的两个页面之间如何进行JavaScript调用的问题。JSONP是一种脚本注入(Script Injection)行为，所以有一定的安全隐患。


转自：segmentfault专栏[JSONP是什么](https://segmentfault.com/a/1190000007935557)

参考：[JSONP原理优缺点(只能GET不支持POST) ](http://blog.csdn.net/z69183787/article/details/19191385)