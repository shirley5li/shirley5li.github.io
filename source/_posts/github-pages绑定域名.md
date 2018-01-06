---
title: github pages自定义域名及DNS相关介绍
date: 2017-12-29 14:49:39
tags: [github pages]
categories: github pages
---
在帆锅的启示下，试着给github pages买个域名，毕竟github.io还是有点长哦。以下域名购买、绑定设置，以及DNS的相关知识得益于帆锅给自己博客绑定域名的笔记以及各位大佬的博客，感谢！
<!--more-->
## 域名相关知识 ##
### 域名是什么 ###
根据百度百科，域名（Domain Name），是由一串用“点”分隔的字符组成的Internet上某一台计算机或计算机组的名称。用于在数据传输时标识计算机的电子方位。

对于每一级域名长度的限制是63个字符，域名总长度则不能超过253个字符。域名同时也仅限于ASCII字符的一个子集，这使得很多其他语言无法正确表示他们的名字和单词。

在域名中大小写是没有区分的。域名一般不能超过5级，从左到右域的级别变高，高的级域包含低的级域。域名在整个Internet中是唯一的，当高级子域名相同时，低级子域名不允许重复。一台服务器只能有一个IP地址，但是却可以有多个域名。

任何一个使用IP的计算机网络可以使用DNS来实现他自己的私有名称系统。这是基于13个全球范围的“根服务器”，其维护组织除了当中的3个以外，其他都位于美国。从这13个根服务器开始，余下的Internet DNS命名空间被委托给其他的DNS服务器， 这些服务器提供DNS名称空间中的特定部分。
### 域名级别 ###
整个DNS系统是由许多域所组成，每个域下又细分更多的域，DNS域构成了层次树状结构，自上而下分别是根域、顶级域名、二级域名…，最后是主机名。

顶级域名（一级域名）——如：.com、.net、.edu、.gov、.cn等。二级域名我们常常能够申请到的域名，在顶级域名的左侧加上的一个自定义的文字段，例如shirley5li.me，通常所说申请的域名，往往指的是这个二级域名。

以www.sina.com.cn为例，该域名是三级域名，其中sina.com.cn为新浪Web服务器的【域名】，www不是域名的组成部分而是URL的组成部分。所以该例中， 一级域名.cn、二级域名.com.cn、三级域名.sina.com.cn。
主机名www（表示该主机所提供的服务为www服务，即Web服务器。

URL的构成——http://主机名 . 域名（端口号、参数、查询等可选。 域名(Domain Name)可由若干部份组成,各部份之间用圆点分开，域名前加上【主机类型信息】（如：www、ftp）和【传输协议信息】就构成了网址（URL）http://www.xxxx.cn。

**子域名(sbudomain name)**

相对于上文所提到的“我们通常所说的域名”（二级域名）的基础上，又加入了子域名的概念，就是在一个域名的前面，加上新的字段，代表这个域名下的某个特定的主机或者协议。最常用的就是WWW协议，所以，我的子域名www.shirley5li.me就是shirley5li.me的WWW子域名。
## DNS相关知识 ##
网域名称系统（DNS，Domain Name System，有时也简称为域名）是因特网的一项核心服务，它作为可以将域名和IP地址相互映射的一个分布式数据库，能够使人更方便的访问互联网，而不用去记住能够被机器直接读取的IP地址数串。

例如，www.wikipedia.org是一个域名，和IP地址208.80.152.2相对应。DNS就像是一个自动的电话号码簿，我们可以直接拨打wikipedia的名字来代替电话号码（IP地址）。我们直接调用网站的名字以后，DNS就会将便于人类使用的名字（如www.wikipedia.org）转化成便于机器识别的IP地址（如208.80.152.2）。

域名服务器分不同的组来负责各子系统的名字。系统中的每一层叫做一个域，每个域用一个点分开。所谓域名服务器（即Domain Name Server，简称Name Server、DNS）实际上就是装有域名系统的主机。它是一种分层结构数据库，能够执行名字解析（name resolution）。

DNS服务器上都存了些啥？最主要的就是能够完成域名解析的一些记录
### A记录（A record) ###
A记录在DNS中的意义就是，域名到ip地址的转换。所以，当我们在DNS服务器中添加一个A记录时，是告诉服务器，将某个特定的域名映射到一个ip地址。
### CNAME记录（CNAME record) ###
CNAME的意义，简单说就是别名，即将一个域名射到另一个域名（区别于A记录的ip）。所以，CNAME通常有两种用法:

(1)不同顶级域名之间的跳转。例如：我的域名是 shirley5li.me(顶级域名为me)。如果希望当访问这个域名的时候，实际上是访问的shirley5li.github.io（顶级域名为io）的主页时，虽然他们在不同的顶级域名，但是可以用CNAME记录映射。

(2)将一个子域名映射到域名。例如：你想当访问者输入www.shirley5li.me（一个WWW子域名）的时候，仍旧访问shirley5li.me这个域名所指向的内容时，可以将www.shirley5li.me利用CNAME记录映射到shirley5li.me。
### NS记录（Name Server） ###
指定了负责解析我这个域名的服务器的地址。这条记录赋予我们一个特殊的能力，就是，我可以让自己指定的一个DNS解析服务器，而不一定是域名提供商自带的域名解析服务器。简单来说，就是在godaddy买的域名，默认是使用godaddy的域名服务器来进行域名解析的，但是如果我想让别的server解析（例如NDSPod），而不受godaddy服务器的限制呢？那就是更改这个NS记录的内容。一般来讲，是两条记录，一条主服务器，一条副服务器。

因此很多人推荐Godaddy注册购买域名，DNSpod负责解析，即修改NS记录。
## 域名服务器哪家强 ##
域名通过向域名注册商购买获得，如今有很多域名注册商，比如国内的[万网](https://wanwang.aliyun.com)以及国外的[GoDaddy](https://sg.godaddy.com)。
考虑各种因素，在GoDaddy上购买域名相比万网的好处是不需要各种审核，很多人推荐使用godaddy，Godaddy注册购买域名，DNSpod解析。雅蠛蝶，那我也用狗爹了~[2017年Godaddy域名注册教程](http://godaddy.idcspy.com/domain-regist)

先来狗爹注册个账号，然后搜索想要的域名购买。这里又在选择什么样的域名后缀纠结半天，什么.me .cc .org .com，最后选择了shirley5li.me，因为价格最低。。。然后支付宝付款就好了。

## github pages绑定域名详细步骤##
既然域名已经买完了，直接是没法用的，因为没有进行DNS解析，别人是没法正常通过域名访问你的界面的，这里使用DNS进行解析。

域名绑定的含义就是当你访问你的域名时，浏览器会自动跳转到刚才创建的 Github Pages(username.github.io)。实现绑定的关键在于设置 DNS 解析。在 GoDaddy 注册的域名，由于 GFW 的存在，需要使用第三方 DNS 服务来解析域名。推荐使用鹅厂的 DNSPOD。鹅厂的服务可靠性高同时也不会被墙。

域名购买完成后，回到Github项目上，即搭建博客那个项目，点击设置Settings，找到Custom domain，填入申请的域名，并保存。

![1](/images/github-pages绑定域名/1.png)
这个操作等同于在项目根目录下创建一个名为CNAME的文件，文件内容为上述填写的域名。

回到GoDaddy的主页上，点击个人用户-->管理域名。

![2](/images/github-pages绑定域名/2.png)

再点击那三个点点（真的对用户超不友好，找半天！！！），选择管理DNS。

![3](/images/github-pages绑定域名/3.png)

默认的DNS记录如下所示：

![4](/images/github-pages绑定域名/4.png)

关于A记录的修改，在名称@这条记录中，将值改为Github博客的IP地址（由ping得到，即`151.101.77.147`。操作如下：

![5](/images/github-pages绑定域名/5.png)

关于CNAME记录的修改，在名称www这条记录中，将值改为github博客默认的域名，即shirley5li.github.io。

该阶段修改后修的DNS管理记录如下：

![6](/images/github-pages绑定域名/6.png)

上图中两条NS记录的值为狗爹默认的域名服务器的地址，为防止背墙以及速度等原因，采用第三方国内域名服务器NDSPod来解析我们在狗爹申请的域名。

接下来我们到[NDSPod](https://www.dnspod.cn/)来注册账号，注册完账号后，在DNSPOD首页-->管理控制台-->域名解析-->添加域名，将在狗爹申请的域名填入，点确定。如下所示。

![7](/images/github-pages绑定域名/7.png)

然后点击刚刚添加的域名，来管理DNS记录。DNS记录各参数含义：(1)主机记录， @：不通过任何前缀访问域名 ， www：通过www前缀访问域名。(2)记录类型， A：在记录值处写主机IP地址，NS：记录值是DNSPOD提供的Name Server地址，CNAME：记录值是域名的别名。

添加一条A记录，主机类型是@，记录值填ping Github博客得到的ip地址。再将狗爹上的两条CNAME记录添加上。最后DNSPOD上的DNS各条记录如下所示:

![8](/images/github-pages绑定域名/8.png)

然后将上图中的两条NS记录值（DNSPOD默认的域名服务器地址），填入Godaddy的自定义域名服务器。
即：

![9](/images/github-pages绑定域名/9.png)

狗爹更改后，再刷新一下，域名服务器如下：

![10](/images/github-pages绑定域名/10.png) 

等待一段时间就可以成功用DNSPod解析域名到Github博客，在浏览器地址栏输入shirley5li.me，可以看到如下github pages博客主页：

![11](/images/github-pages绑定域名/11.png) 

至此大功告成。

PS:参考一些博客，他们在域名注册成功后，在github博客本地目录source下创建CNAME文件，里面填入自己申请的域名即shirley5li.me，保存后`hexo g -d`上传至Github Repo中。此步骤相当于在搭建博客那个项目，点击设置Settings，在Custom domain，填入申请的域名的过程，因为上面已经操作了Custom domain填入申请域名的过程，所以没有此步骤也可以正常解析shirley5li.me，但再添加也无妨。
## reference ##
[域名--wikipedia](https://zh.wikipedia.org/wiki/%E5%9F%9F%E5%90%8D)

[怎么区分域名级别，举例说明更易懂](http://blog.csdn.net/f87089/article/details/51480278)

[从DNS到github pages自定义域名 -- 漫谈域名那些事](http://winterttr.me/2015/10/23/from-dns-to-github-custom-domain/)

[老左所理解的建站域名的选择以及域名投资的一些看法](http://www.laozuo.org/7198.html)

[想注册一个作个人博客用的域名，应该使用哪个域名注册提供商？](https://www.zhihu.com/question/19735598?sort=created&page=1)

[使用 Hexo + Github Pages 搭建独立博客](http://yanshengjia.com/2017/01/31/%E4%BD%BF%E7%94%A8Hexo-Github-Pages%E6%90%AD%E5%BB%BA%E7%8B%AC%E7%AB%8B%E5%8D%9A%E5%AE%A2/)

[Blog绑定域名——Godaddy + DNSPod](https://www.jianshu.com/p/252b542b1abf)