---
title: phpstudy与DVWA安装与配置，WAMP等相关概念学习
date: 2018-05-17 20:58:23
tags: [web security, phpStudy, DVWA, WAMP, web容器]
categories: web security
---
[帆哥](https://ciphersaw.me/)教我玩WEB安全系列之最最开始环境配置篇。
<!--more-->
# VMware虚拟机安装 #
现在最新版本的是 VMware workstation 14，怕激活密钥不好找，就安装了VMware workstation 12 pro(激活密钥：5A02H-AU243-TZJ49-GTC7K-3C61N)。

选择一个安装目录即可双击安装程序，傻瓜式安装VMware。然后装了win7 x64系统。
## 更改虚拟机的网络配置 ##
`我的计算机`-> `Windows 7 x64` -> 右键单击 -> `设置` -> `网络适配器` -> `网络连接`，选择桥接模式。

桥接模式直接连接物理网络，相当于在主机系统和虚拟机系统之间连接了一个网桥，而网桥两端的网络都属于同一网络，主机和虚拟机是处于同一网络中的对等主机。

桥接模式通常用于利用VMWare在局域网内新建一个虚拟服务器，为局域网用户提供网络服务。

【博客[VMware下网络配置三种模式对比（桥接模式，主机模式，网络地址转换）](https://blog.csdn.net/clevercode/article/details/45934233)】

【待解决的问题:】讲道理采用桥接模式之后，虚拟机和宿主主机是处于同一局域网中的对等主机，是可以互相ping通的，不知是不是路由器防火墙的缘故，虚拟机(192.168.1.101)和宿主主机(192.168.1.124)之间ping不通，但可以通过宿主主机的浏览器访问虚拟主机(此时的虚拟主机相当于一个虚拟服务器)。
宿主主机ping虚拟服务器：
![宿主主机ping虚拟服务器](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/RpingV.png)
虚拟服务器ping宿主主机：
![虚拟服务器ping宿主主机](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/VpingR.png)
浏览器访问虚拟服务器：
![浏览器访问虚拟服务器](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/%E6%B5%8F%E8%A7%88%E5%99%A8%E8%AE%BF%E9%97%AE%E8%99%9A%E6%8B%9F%E6%9C%8D%E5%8A%A1%E5%99%A8.png)

# phpStudy安装配置 #
phpStudy是一个PHP调试环境的程序集成包，该程序包集成最新的Apache+PHP+MySQL+phpMyAdmin+ZendOptimizer,一次性安装，无须配置即可使用。可以用来模拟服务器环境，用于测试。

将phpStudy(2018版本)压缩包拖到虚拟机桌面，解压，安装即可。
![phpStudy](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/phpStudy.png)
## 更改网站目录 ##
默认运行一个.php程序必须要将该程序放在WWW文件夹下面。phpStudy下的web服务相关目录如下所示：
![phpStudy下的web服务相关目录](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/phpStudy%E7%9B%AE%E5%BD%95.png)

web服务默认的运行目录是可以修改的: `其他选项菜单` -> `phpStudy设置` -> `端口常规设置`
![端口常规设置](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/phpStudy%E7%AB%AF%E5%8F%A3%E8%AE%BE%E7%BD%AE.png)

如果更改了网站目录，要将之前WWW目录下的文件都拷过去。
## 更改默认首页 ##
还是在`端口常规设置`，`默认首页`选项中更改( localhost 访问的的时候出现的页面即为首页)。
## 更改端口号 ##
还是在`端口常规设置`，默认端口是 80 端口，如果更改为其他端口号，localhost访问时需要带上端口号(localhost:端口号/xx.html)，否则可以省略(localhost/xx.html)。

其他phpStudy的功能和用法参考博客【[phpstudy使用说明教程](http://www.php.cn/phpstudy-377909.html)】。

# DVWA #
将DVWA(Damn Vulnerable Web Application)的压缩包拖进虚拟机，解压后丢到网站目录下：
![DVWA安装](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/DVWA.png)

[DVWA](http://www.dvwa.co.uk/)是一款基于php和mysql编写的用于常规WEB漏洞教学和检测的web脆弱性测试web应用。其中包含了SQL注入，盲注，文件包含，XSS，CSRF等一些常见的WEB漏洞，对进行Web渗透有较强的指导教学意义。

## 配置 ##
(1) 首先进入设置页面，**注意：** 在phpStudy虚拟web服务器环境下安装DVWA时出现的问题如以下界面中红色字体提示部分：
![安装DVWA时出现的问题](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/DVWA%E8%AE%BE%E7%BD%AE%E6%97%B6%E7%9A%84%E9%94%99%E8%AF%AF.png)
解决方法参考博客 [DVWA安装出现的问题（phpStudy）](http://www.cnblogs.com/liuyunbuji/p/8385834.html)
其中在解决`PHP function allow_url_include：Disabled`问题，修改完php.ini配置文件后记得重启phpStudy服务，不然还是显示错误提示。

**注意：** 由于使用了phpStudy，以下(2)中的配置可以忽略(步骤（2）是用于自己配置数据库的相关操作)，phpStudy已经为我们配置好了相关端口和数据库。phpStudy默认的数据库设置如下：

```php
$_DVWA[ 'db_server' ]   = '127.0.0.1';
$_DVWA[ 'db_database' ] = 'dvwa';
$_DVWA[ 'db_user' ]     = 'root';
$_DVWA[ 'db_password' ] = 'root';
```
所以直接在setup页面点击`Create Database`按钮，初始化DVWA即可，就会跳转到login页面，WEB后台的账号是admin，密码password。

登录DVWA之后，通过`DVWA Security`设置项设置安全级别。

(2) 在设置页面，对DVWA需要的数据库进行创建和初始化。此时还没建立相关用户和数据库，那么接下来通过cmd建立数据库和用户：
- 连接数据库。`mysql -u root -p`是连接数据库服务器的命令，`-u`表示用户名(root),`-p`表示密码，即在连接数据库之前要求输入用户名和密码|（MySQL用户名和密码默认都是root）。

`win+r`->打开cmd命令行，输入用户名和密码，哦豁，又出错了：
![连接数据库出错](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/%E8%BF%9E%E6%8E%A5%E6%95%B0%E6%8D%AE%E5%BA%93%E5%87%BA%E9%94%99.png)

解决办法参考博客 [命令行中输入：mysql -u root -p 提示没有这个命令](https://blog.csdn.net/u013310517/article/details/52098479)，即将mysql的安装路径添加到系统环境变量中。

![连接数据库](http://ou3oh86t1.bkt.clouddn.com/web%E5%AE%89%E5%85%A8%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/%E8%BF%9E%E6%8E%A5%E6%95%B0%E6%8D%AE%E5%BA%93.png)

- 此时进入mysql创建数据库 dvwa，然后创建新用户dvwa，并设置密码123456。

```shell
mysql> create database dvwa;
mysql> insert into mysql.user(Host,User,Password) values("localhost",'dvwa',password('123456'));
mysql> flush privileges;
```
其中`flush privileges`本质上的作用是将当前user和privilige表中的用户信息/权限设置从mysql库(MySQL数据库的内置库)中提取到内存里。MySQL用户数据和权限有修改后，希望在"不重启MySQL服务"的情况下直接生效，那么就需要执行这个命令。通常是在修改ROOT帐号的设置后，怕重启后无法再登录进来，那么直接flush之后就可以看权限设置是否生效，而不必冒太大风险。

- 修改dvwa用户针对数据库dvwa的相关权限，授权dvwa用户拥有数据库dvwa的所有权限。格式：`grant 权限 on 数据库.* to 用户名@登录主机 identified by "密码"`。

```shell
mysql> grant all privileges on dvwa.* to dvwa@localhost identified by '123456';
mysql> flush privileges;
```
- 修改dvwa目录下的`config/config.inc.php`以下内容：

```php
$_DVWA[ 'db_server' ]   = '127.0.0.1';
$_DVWA[ 'db_database' ] = 'dvwa';
$_DVWA[ 'db_user' ]     = 'dvwa';
$_DVWA[ 'db_password' ] = '123456';
```
- 然后在setup页面点击`Create Database`按钮，初始化DVWA。

**以下是几个概念的补充学习。**

# WAMP #
Windows下的Apache+Mysql/MariaDB+Perl/PHP/Python，一组常用来搭建动态网站或者服务器的开源软件。
本身都是各自独立的程序，但是因为常被放在一起使用，拥有了越来越高的兼容度，共同组成了一个强大的Web应用程序平台。

LAMP是基于Linux，Apache，MySQL/MariaDB，Perl/PHP/Python的开放资源网络开发平台。Linux是开放系统；Apache是最通用的网络服务器；mySQL是带有基于网络管理附加工具的关系数据库；PHP是流行的对象脚本语言。

一般说来，大家都习惯 于将Apache、MySQL、PHP架设在Linux系统下，开发者在Windows操作系统下使用这些Linux环境里的工具称为使用WAMP。

目前有不少AMP（Apache\MySQL\PHP）的集成软件，可以让我们一次安装并设置好，WAMP集成环境主要有：
- XAMPP（Apache+MySQL+PHP+PERL）
XAMPP是一款具有中文说明的功能全面的集成环境，XAMPP并不仅仅针对Windows，而是一个适用于Linux、Windows、Mac OS X 和Solaris 的易于安装的Apache 发行版。软件包中包含Apache 服务器、MySQL、SQLite、PHP、Perl、FileZilla FTP Server、Tomcat等等。默认安装开放了所有功能，安全性有问题，需要进行额外的安全设定。

- WampServer 
WampServe是集成了Apache、MySQL、PHP、phpmyadmin的web服务器，支持Apache的mod_rewrite，PHP扩展、Apache模块只需要在菜单“开启/关闭”上点点就搞定，省去了修改配置文件的麻烦，是windows下的 Apache Mysql PHP集成安装环境。

- AppServ
集成了Apache、PHP、MySQL、phpMyAdmin，较为轻量，版本很久未更新了。

- phpStudy
该程序包集成最新的Apache+Nginx+IIS+MySQL+phpMyAdmin，一次性安装，无须配置即可使用，是非常方便、好用的PHP调试环境。

# web容器 #
Java Servlet 可以理解为服务器端处理数据的java小程序，web容器则负责管理servlet等。

servlet没有main方法，那我们如何启动一个servlet，如何结束一个servlet，如何寻找一个servlet等等，都受控于另一个java应用，这个应用我们就称之为web容器。

一个典型的JavaEE系统可以由两部分构成首先是Web Server 用于处理静态资源，然后是JavaEE Application Server 用于处理业务的动态资源。而这两部分可以是单独的服务器例如Nginx+WebSphere也可以在一个服务器上完成比如Tomcat(Tomcat即可以处理静态资源又可以处理动态的Servlet)。

参考博客:

[web开发中 web 容器的作用（如tomcat）](https://www.jianshu.com/p/99f34a91aefe)

[JavaEE中Web服务器、Web容器、Application服务器区别及联系](https://www.cnblogs.com/vipyoumay/p/5853694.html)