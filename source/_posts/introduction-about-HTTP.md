---
title: HTTP基础学习总结
date: 2018-01-09 00:15:58
tags: [HTTP]
categories: HTTP
---

关于HTTP协议相关知识的学习总结。

<!--more-->

## 简介

HTTP协议（Hyper Text Transfer Protocol，超文本传输协议）,是用于从万维网（WWW:World    Wide Web ）服务器传输超文本到本地浏览器的传送协议。

HTTP基于TCP/IP通信协议来传递数据。  

HTTP基于客户端/服务端（C/S）架构模型，通过一个可靠的链接来交换信息，是一个无状态的请求/响应协议。

## 特点

（1）HTTP是无连接：无连接的含义是限制每次连接只处理一个请求。服务器处理完客户的请求，并收到客户的应答后，即断开连接。采用这种方式可以节省传输时间。   

（2）HTTP是媒体独立的：只要客户端和服务器知道如何处理的数据内容，任何类型的数据都可以通过HTTP发送。客户端以及服务器指定使用适合的MIME-type内容类型。   

（3）HTTP是无状态：无状态是指协议对于事务处理没有记忆能力。缺少状态意味着如果后续处理需要前面的信息，则它必须重传，这样可能导致每次连接传送的数据量增大。另一方面，在服务器不需要先前信息时它的应答就较快。

## 通信流程

![http协议通信流程图](https://uploadfiles.nowcoder.com/files/20160727/213669_1469604624728_cgiarch.gif)

## 消息结构

HTTP使用统一资源标识符（Uniform Resource Identifiers, URI）来传输数据和建立连接。一旦建立连接后，数据消息就通过类似Internet邮件所使用的格式[RFC5322]和多用途Internet邮件扩展（MIME）[RFC2045]来传送。

客户端请求消息：请求行、请求头部、空行和请求数据。  
	GET /hello.txt HTTP/1.1
	User-Agent: curl/7.16.3 libcurl/7.16.3          
	OpenSSL/0.9.7l zlib/1.2.3          
	Host: www.example.com Accept-Language: en, mi
服务端响应消息：状态行、消息报头、空行和响应正文。
	HTTP/1.1 200 OK
	Date: Mon, 27 Jul 2009 12:28:53 GMT
	Server: Apache
	Last-Modified: Wed, 22 Jul 2009 19:15:56 GMT
	ETag: "34aa387-d-1568eb00"
	Accept-Ranges: bytes
	Content-Length: 51
	Vary: Accept-Encoding
	Content-Type: text/plain

## 请求方法

​    GET 请求指定的页面信息，并返回实体主体。   

​    HEAD    类似于get请求，只不过返回的响应中没有具体的内容，用于获取报头   

​    POST   向指定资源提交数据进行处理请求（例如提交表单或者上传文件）。数据被包含在请求体中。     POST请求可能会导致新的资源的建立和/或已有资源的修改。   

​    PUT 从客户端向服务器传送的数据取代指定的文档的内容。   

​    DELETE  请求服务器删除指定的页面。   

​    CONNECT HTTP/1.1协议中预留给能够将连接改为管道方式的代理服务器。   

​    OPTIONS 允许客户端查看服务器的性能。   

​    TRACE   回显服务器收到的请求，主要用于测试或诊断

## 状态码

**HTTP状态码分类** 
​        1xx  信息，服务器收到请求，需要请求者继续执行操作   
​        2xx 成功，操作被成功接收并处理   
​        3xx 重定向，需要进一步的操作以完成请求   
​        4xx 客户端错误，请求包含语法错误或无法完成请求   
​        5xx 服务器错误，服务器在处理请求的过程中发生了错   

**HTTP状态码列表**  
​    100 Continue    继续。客户端应继续其请求   

​    101 Switching Protocols      切换协议。服务器根据客户端的请求切换协议。只能切换到更高级的协议，例如，切换到HTTP的新版本协议   

​      200 OK  请求成功。一般用于GET与POST请求    

​    201 Created 已创建。成功请求并创建了新的资源   

​    202 Accepted    已接受。已经接受请求，但未处理完成   

​    203 Non-Authoritative Information        非授权信息。请求成功。但返回的meta信息不在原始的服务器，而是一个副本   

​    204 No Content       无内容。服务器成功处理，但未返回内容。在未更新网页的情况下，可确保浏览器继续显示当前文档   

​    205 Reset Content        重置内容。服务器处理成功，用户终端（例如：浏览器）应重置文档视图。可通过此返回码清除浏览器的表单域   

​    206 Partial Content 部分内容。服务器成功处理了部分GET请求   

​    300 Multiple Choices         多种选择。请求的资源可包括多个位置，相应可返回一个资源特征与地址的列表用于用户终端（例如：浏览器）选择   

​      301 Moved Permanently   永久移动。请求的资源已被永久的移动到新URI，返回信息会包括新的URI，浏览器会自动定向到新URI。今后任何新的请求都应使用新的URI代替    

​    302 Found   临时移动。与301类似。但资源只是临时被移动。客户端应继续使用原有URI   

​    303 See Other   查看其它地址。与301类似。使用GET和POST请求查看   

​      304 Not Modified    未修改。所请求的资源未修改，服务器返回此状态码时，不会返回任何资源。客户端通常会缓存访问过的资源，通过提供一个头信息指出客户端希望只返回在指定日期之后修改的资源    

​    305 Use Proxy   使用代理。所请求的资源必须通过代理访问   

​    306 Unused  已经被废弃的HTTP状态码   

​      307 Temporary Redirect  临时重定向。与302类似。使用GET请求重定向    

​    400 Bad Request 客户端请求的语法错误，服务器无法理解   

​    401 Unauthorized    请求要求用户的身份认证   

​    402 Payment Required    保留，将来使用   

​    403 Forbidden   服务器理解请求客户端的请求，但是拒绝执行此请求   

​      404 Not Found   服务器无法根据客户端的请求找到资源（网页）。通过此代码，网站设计人员可设置"您所请求的资源无法找到"的个性页面    

​    405 Method Not Allowed  客户端请求中的方法被禁止   

​    406 Not Acceptable  服务器无法根据客户端请求的内容特性完成请求   

​    407 Proxy Authentication Required        请求要求代理的身份认证，与401类似，但请求者应当使用代理进行授权   

​    408 Request Time-out    服务器等待客户端发送的请求时间过长，超时   

​    409 Conflict    服务器完成客户端的PUT请求是可能返回此代码，服务器处理请求时发生了冲突   

​    410 Gone         客户端请求的资源已经不存在。410不同于404，如果资源以前有现在被永久删除了可使用410代码，网站设计人员可通过301代码指定资源的新位置   

​    411 Length Required 服务器无法处理客户端发送的不带Content-Length的请求信息   

​    412 Precondition Failed 客户端请求信息的先决条件错误   

​    413 Request Entity Too Large         由于请求的实体过大，服务器无法处理，因此拒绝请求。为防止客户端的连续请求，服务器可能会关闭连接。如果只是服务器暂时无法处理，则会包含一个Retry-After的响应信息   

​    414 Request-URI Too Large   请求的URI过长（URI通常为网址），服务器无法处理   

​    415 Unsupported Media Type  服务器无法处理请求附带的媒体格式   

​    416 Requested range not satisfiable 客户端请求的范围无效   

​    417 Expectation Failed  服务器无法满足Expect的请求头信息   

​      500 Internal Server Error   服务器内部错误，无法完成请求    

​    501 Not Implemented 服务器不支持请求的功能，无法完成请求   

​    502 Bad Gateway 充当网关或代理的服务器，从远端服务器接收到了一个无效的请求   

​    503 Service Unavailable      由于超载或系统维护，服务器暂时的无法处理客户端的请求。延时的长度可包含在服务器的Retry-After头信息中   

​    504 Gateway Time-out    充当网关或代理的服务器，未及时从远端服务器获取请求   

​    505 HTTP Version not supported  服务器不支持请求的HTTP协议的版本，无法完成处理   