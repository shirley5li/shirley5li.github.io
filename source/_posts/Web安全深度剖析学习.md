---
title: （一）Web安全深度剖析学习【基础+HTTP】
date: 2018-05-16 19:55:17
tags: [Web Security, HTTP]
categories: Web Security
---
《Web安全深度剖析》学习总结, 本部分主要包括WEB安全的基础知识和HTTP协议相关。
<!--more-->
# Web安全简介 #
Web服务默认运行在服务器的80端口之上(http服务器)，https服务器默认443端口。

服务器风险点如下图：
![服务器风险点](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/web%E5%AE%89%E5%85%A8%E6%B7%B1%E5%BA%A6%E5%89%96%E6%9E%90%E5%AD%A6%E4%B9%A0/%E6%9C%8D%E5%8A%A1%E5%99%A8%E5%AE%89%E5%85%A8%E7%82%B9.png)
直接对目标攻击的三种手段：
- **C段渗透**： 攻击者通过渗透同一网段内的一台主机，对目标主机进行ARP等手段的渗透。

**ARP攻击：** ARP（地址解析协议）位于TCP/IP协议栈中的网络层，负责将某个IP地址解析成对应的MAC地址。ARP攻击仅能在以太网（局域网如：机房、内网、公司网络等）进行，无法对外网（互联网、非本区域内的局域网）进行攻击。

**ARP攻击原理：** ARP攻击就是通过伪造IP地址和MAC地址实现ARP欺骗，能够在网络中产生大量的ARP通信量使网络阻塞，攻击者只要持续不断的发出伪造的ARP响应包就能更改目标主机ARP缓存中的IP-MAC条目，造成网络中断或中间人攻击。

攻击者向电脑A发送一个伪造的ARP响应，告诉电脑A：电脑B的IP地址192.168.0.2对应的MAC地址是00-aa-00-62-c6-03，电脑A信以为真，将这个对应关系写入自己的ARP缓存表中，以后发送数据时，将本应该发往电脑B的数据发送给了攻击者。同样的，攻击者向电脑B也发送一个伪造的ARP响应，告诉电脑B：电脑A的IP地址192.168.0.1对应的MAC地址是00-aa-00-62-c6-03，电脑B也会将数据发送给攻击者。至此攻击者就控制了电脑A和电脑B之间的流量，他可以选择被动地监测流量，获取密码和其他涉密信息，也可以伪造数据，改变电脑A和电脑B之间的通信内容。

为了解决ARP攻击问题，可以在网络中的交换机上配置802.1x协议。IEEE 802.1x是基于端口的访问控制协议，它对连接到交换机的用户进行认证和授权。在交换机上配置802.1x协议后，攻击者在连接交换机时需要进行身份认证（结合MAC、端口、帐户、VLAN和密码等），只有通过认证后才能向网络发送数据。攻击者未通过认证就不能向网络发送伪造的ARP报文。

- **社会工程学**：渗透服务器有时不只靠技术，即"攻城为下，攻心为上"，果然社会！！！

- **Services**: 很多传统攻击方式直接针对服务进行溢出。Web作为服务之一，有多种渗透方式。

**缓冲区溢出攻击：** 缓冲区溢出是指当计算机向缓冲区内填充数据位数时超过了缓冲区本身的容量，溢出的数据覆盖在合法数据上。理想的情况是：程序会检查数据长度，而且并不允许输入超过缓冲区长度的字符。但是绝大多数程序都会假设数据长度总是与所分配的储存空间相匹配，这就为缓冲区溢出埋下隐患。操作系统所使用的缓冲区，又被称为“堆栈”，在各个操作进程之间，指令会被临时储存在“堆栈”当中，“堆栈”也会出现缓冲区溢出。

缓冲区溢出攻击利用了缓冲区溢出的漏洞，通过往程序的缓冲区写超出其长度的内容，造成缓冲区的溢出，从而破坏程序的堆栈，使程序转而执行其它指令，以达到攻击的目的。利用缓冲区溢出攻击，可以导致程序运行失败、系统关机、重新启动等后果。

# HTTP协议 #
URL(统一资源定位符)，格式: `协议://服务器IP[:端口]/路径/[?查询]`

Linux系统下， `curl http网址` 命令可以发起http请求，会返回页面的HTML数据。添加`-I`参数，即 `curl http网址 -I` 返回http响应头。

HTTP协议经历了三个版本：
- HTTP/0.9: 只接受GET一种请求方法，没有在通讯中指定版本号，且不支持请求头。由于该版本不支持POST方法，因此客户端无法向服务器传递太多信息。
- HTTP/1.0: 第一个在通讯中指定版本号的HTTP协议版本，至今仍被广泛采用，特别是在代理服务器中。相对于HTTP 0.9 ,增加了POST和HEAD命令，增加了头信息，支持长连接（但默认还是使用短连接），缓存机制，以及身份认证，响应对象不只限于HTML，增加了状态码等。
- HTTP/1.1: 目前主流的HTTP协议版本,使用最广泛。相对于HTTP 1.0，默认采用长连接，支持以管道方式在同时发送多个请求，以便降低线路负载，提高传输速度，请求与响应支持Host头域，Content-Length字段，分块传输编码，增加了PUT、DELETE等方法。
- HTTP/2： 下一代HTTP协议，目前应用还比较少。特点，二进制协议、多路复用、数据流、头部压缩、随时复位、Server Push、优先权和依赖。

## HTTP协议详解 ##
以HTTP/1.1为例，描述HTTP请求与响应如下。

**HTTP请求：** 包括请求行(请求方法)、请求头(消息报头)、请求正文(请求体)。
![http请求](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/web%E5%AE%89%E5%85%A8%E6%B7%B1%E5%BA%A6%E5%89%96%E6%9E%90%E5%AD%A6%E4%B9%A0/http%E8%AF%B7%E6%B1%82.png)
HTTP请求的第一行为请求行，由三部分组成，`POST`表示请求方法，`/login.php`表示请求路径(该域名根目录下的login.php)，`HTTP/1.1`表示HTTP版本。

第二行至空白行为HTTP请求头，`HOST`表示请求的主机地址，`User-Agent`表示浏览器标识。请求头由客户端自行设定。Google访问[http://shirley5li.me/IFE-2018-CSS/animate.css_log/index.html](http://shirley5li.me/IFE-2018-CSS/animate.css_log/index.html)的HTTP GET请求行和请求头如下：
```
GET /IFE-2018-CSS/animate.css_log/index.html HTTP/1.1
Host: shirley5li.me
Connection: keep-alive
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36
Upgrade-Insecure-Requests: 1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: zh-CN,zh;q=0.9
Cookie: _ga=GA1.2.2018838122.1520044936; _gid=GA1.2.1506554401.1526462676; Hm_lvt_06185a244e6f872c8aeab11a4e7b5db4=1526478354; Hm_lpvt_06185a244e6f872c8aeab11a4e7b5db4=1526528658
If-Modified-Since: Sun, 06 May 2018 03:32:14 GMT
```
空白行之后为请求正文(请求体)，请求正文是可选的，通常出现在POST方法中，GET方法不含请求体。

**HTTP响应：** 包括响应行、响应头(消息报头)、响应正文(响应体)。
![http响应](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/web%E5%AE%89%E5%85%A8%E6%B7%B1%E5%BA%A6%E5%89%96%E6%9E%90%E5%AD%A6%E4%B9%A0/http%E5%93%8D%E5%BA%94.png)
Google访问[http://shirley5li.me/IFE-2018-CSS/animate.css_log/index.html](http://shirley5li.me/IFE-2018-CSS/animate.css_log/index.html)的HTTP 响应行和响应头如下：
```
HTTP/1.1 200 OK
Server: GitHub.com
Content-Type: text/html; charset=utf-8
Last-Modified: Sun, 06 May 2018 03:32:14 GMT
Access-Control-Allow-Origin: *
Expires: Thu, 17 May 2018 05:20:22 GMT
Cache-Control: max-age=600
Content-Encoding: gzip
X-GitHub-Request-Id: FEEA:43E7:353D5D:46B7F2:5AFD0EBD
Content-Length: 629
Accept-Ranges: bytes
Date: Thu, 17 May 2018 05:20:41 GMT
Via: 1.1 varnish
Age: 0
Connection: keep-alive
X-Served-By: cache-hkg17927-HKG
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1526534441.070496,VS0,VE229
Vary: Accept-Encoding
X-Fastly-Request-ID: da54366ec4de37d5adfc39dede5b758996befa2c
```
### HTTP请求方法 ###
- GET
GET方法用于获取请求页面的指定信息(以实体的格式)，如果请求资源为动态脚本(非HTML)，则返回文本是Web容器解析后的HTML源代码，而不是源文件。如请求`index.jsp`，返回的不是`index.jsp`的源文件，而是经过解析后的HTML代码。GET方法可以通过查询参数携带数据传递给服务器端，但发送的数据会显示在浏览器，并且有长度限制。

- HEAD
该方法除了服务器不返回响应体外，其他与GET相同。通常用来测试超链接的有效性、可访问性、最近的改变，攻击者编写扫描工具时通常用此方法，只测试资源是否存在，不返回消息主体，速度最快。

- POST
POST与GET类似，区别是，GET没有请求体，POST包含请求体。POST多用于向服务器发送大量数据，安全性也较高一点。如上传文件、提交留言等。

- PUT
请求服务器将请求中的实体存储在请求资源下。通常服务器会关闭PUT方法，因为会在服务器建立文件，属于危险方法之一。

- DELETE
请求服务器删除请求的指定资源。通常服务器会关闭DELETE方法，属于危险方法之一。

- TRACE
允许客户端查看服务器端接收消息的情况，回显服务器收到的请求，此方法很少见。

- CONNECT
为了能动态切换到隧道代理。
【HTTP隧道：】是HTTP/1.1中引入的功能，主要为了解决明文的HTTP代理无法代理跑在TLS中的流量(https)的问题，同时提供了作为任意流量的TCP通道的能力。[什么是HTTP隧道，怎么理解HTTP隧道](https://www.zhihu.com/question/21955083)。
HTTP隧道技术可以理解为把所有要传送的数据全部封装到HTTP协议里进行传送。
客户端与服务器之间的中间层：代理，网关，或者隧道。

- OPTIONS
用于请求由URI标识的资源在通信过程中可以使用的功能选项。
![OPTIONS请求与响应](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/web%E5%AE%89%E5%85%A8%E6%B7%B1%E5%BA%A6%E5%89%96%E6%9E%90%E5%AD%A6%E4%B9%A0/OPTIONS.png)

### HTTP状态码 ###
- 1XX: 信息提示，表示请求已被成功接收，继续处理。100~101
- 2XX：成功，服务器成功处理了请求。200~206
- 3XX: 重定向。300~305
- 4XX: 客户端错误，客户端发送一些服务器无法处理的信息，例如格式错误的请求、请求一个不存在的URL。400~415
- 5XX: 服务器错误。500~505

![常见状态码错误](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/web%E5%AE%89%E5%85%A8%E6%B7%B1%E5%BA%A6%E5%89%96%E6%9E%90%E5%AD%A6%E4%B9%A0/%E7%8A%B6%E6%80%81%E7%A0%81.png)

### HTTP与HTTPS的区别 ###
HTTPS在HTTP之下加入SSL层，可以保护数据的隐私性和完整性。
- HTTP传输的是明文，HTTPS则是具有安全性的SSL加密传输协议
- HTTP 80端口，HTTPS 443端口
- HTTPS需要申请CA证书