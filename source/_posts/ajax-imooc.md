---
title: Ajax基础用法---from imooc
date: 2017-11-06 16:13:39
tags: [Ajax]
categories: JavaScript
---
ajax,即异步JavaScript和XML，通过在后台和服务器少量的数据交换实现页面的异步局部加载更新。
ajax中一个关键的对象 **XMLHttpRequest**对象，作为网页和服务器之间交换数据的桥梁，来实现网页的异步请求、局部刷新。
<!--more-->
## 创建XMLHttpRequest对象 ##
在现代浏览器中创建XMLHttpRequest对象

    var request = new XMLHttpRequest();//现代浏览器
若在早期老版本浏览器中，考虑兼容性，创建XMLHttpRequest对象方式如下：

    var request;
    if(window.XMLHttpRequest) {
    request = new XMLHttpRequest();
    } else {
    request = new ActiveXObject("Microsoft.XMLHTTP");//IE6,IE5
    }
## HTTP协议 ##
HTTP是一种无状态协议。一个HTTP请求包括以下7个步骤：

 - 建立TCP连接
 - WEB浏览器向WEB服务器发送请求命令
 - WEB浏览器发送请求头信息
 - WEB服务器应答
 - WEB服务器发送应答头信息
 - WEB服务器向浏览器发送数据
 - WEB服务器关闭TCP连接
 
**HTTP请求**
一个HTTP请求一般由四部分组成：
 - HTTP请求的方法和动作，比如GET或POST请求
 - 正在请求的URL
 - 请求头，包含一些客户端环境信息、身份验证信息等
 - 请求体，即请求正文，包含客户提交的查询字符串信息、表单信息等
一般来说请求头和请求正文之间有一个空行，表示请求头结束。
[一篇关于GET、POST请求的博文详解](http://blog.csdn.net/findsafety/article/details/47129021)
**GET:**一般用于信息获取，使用URL传递参数，对所发送信息的数量也有限制，一般在2000个字符。(用于查询，一般不用于新建和修改。默认为GET提交)
**POST:**一般用于修改服务器上的资源，对所发送信息的数量无限制。
**HTTP响应**
一个HTTP响应一般由三部分组成：
 - 一个数字和文字组成的状态码，表示请求成功还是失败
 - 响应头，包含服务器类型、日期时间、内容类型、长度等
 - 响应体，即响应正文
HTTP状态码的类型：
![1](/images/ajax-imooc/1.png)

## XMLHttpRequest发送请求 ##
两个方法，open和send
 - open(method, url, async)
 - send(string)
open方法用于设置请求，第一个参数method表示请求的类型，即GET或POST；第二个参数url即请求的地址，绝对地址或相对地址；第三个参数表示是否异步请求，默认为true。
send方法用于发送请求，当使用get请求时，send可不给出参数，而使用post请求时必须有参数。
例如：

    request.open("POST","create.php",true);
    request.setRequestHeader("Content-type","application/x-www-form-urlencoded ")//设置HTTP头信息，一定要写在open()和send()之间
    request.send("name=xxxx&sex=xxx");

## XMLHttpRequest取得响应 ##
![2](/images/ajax-imooc/2.png)
通过监听XMLHttpRequest对象readyState属性的变化，判断服务器的状态变化信息。
![3](/images/ajax-imooc/3.png)
通过.onreadystatechange()方法监听readyState属性的变化，当readyState为4（响应完成）并且status为200(请求成功)时，再对响应数据做处理：

    var request = new XMLHttpRequest();
    request.open("POST","get.php",true);
    request.send();
    request.onreadystatechange = function() {
      if(request.readyState == 4 && request.status == 200) {
      //做一些处理，例如request.responseText
     }
    }
## PHP ##
![4](/images/ajax-imooc/4.png)

 

    

