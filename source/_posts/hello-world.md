---
title: 基于 Hexo 和 Github 搭建个人博客概述
date: 2017-08-6
tags: [Node.js, Npm, Git, Hexo, Github]
categories: 搭建博客
---
前言：第一次写博客，小激动~~~分享总结下用hexo+github搭建个人博客的过程，以及过程中遇到的问题。（我用的win10 64位系统）
<!--more-->

# 环境介绍 #

* hexo 

根据[hexo官网](https://hexo.io/)的介绍，hexo是一个快速简洁且高效的博客框架。hexo利用markdown等渲染引擎解析文章，快速生成静态网页。

Hexo是基于node.js的, 在安装它之前需要用到npm安装工具, 这个工具是 node.js 安装包的工具, 所以需要先安装 node.js。

关于hexo搭建博客原理进一步了解-[hexo原理浅析](https://segmentfault.com/a/1190000008784436)。

* node.js 

node.js是运行在服务端的javascript，是一个允许开发人员使用javascript语言编写服务端代码的框架。

* npm 

npm是随同node.js一起安装的包管理工具，能解决node.js代码部署上的很多问题。
允许用户从npm服务器下载别人编写的第三方包到本地使用。 允许用户从NPM服务器下载并安装别人编写的命令行程序到本地使用。
允许用户将自己编写的包或命令行程序上传到NPM服务器供别人使用。

新版的node.js已经集成了npm，所以下载安装node.js也一并将npm安装好了。

* git 

git是一种非常流行的分布式版本控制系统，它和其他版本控制系统的主要差别在于git只关心文件数据的整体是否发生变化，而大多数版本其他系统只关心文件内容的具体差异。

我们利用git将hexo生成的静态博客页面，部署到github pages上。关于git的[更多了解](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/001373962845513aefd77a99f4145f0a2c7a7ca057e7570000)。

* github 

随着git迅速成为最流行的分布式版本控制系统，github网站上线了。github是一个基于git的代码托管平台，它为开源项目免费提供git存储，无数开源项目开始迁移至GitHub，包括jQuery，PHP，Ruby等等。

github pages 是github提供给用户用来展示个人或者项目主页的静态网页系统。每个用户都可以使用自己的github项目创建，上传静态页面的html文件，github会帮你自动更新你的页面。


# 搭建步骤 #


1.环境准备（node.js，git，github相关设置）  

2.hexo下载安装  

3.hexo相关配置 

4.hexo与github pages链接     

5.发布第一篇博文

6.hexo主题介绍及配置  

7.hexo第三方服务集成（disqus评论，百度分享，访客记录等）

## 环境准备 ##
### node.js下载安装 ###
[node.js下载](http://nodejs.cn/download/)

下载完成后一路默认next即可。利用win+R打开命令窗口，在命令窗口中输入以下命令，可以查看node和npm的版本信息。如果可以正确显示版本信息，说明安装正确，否则检查安装过程，重新安装。

	node -v
	npm -v
结果如下图所示。

![node版本检查](/images/blog1/b1.png)

### git下载安装 ###
[git下载](https://git-scm.com/downloads)

下载完成后一路默认next即可。在命令窗口中输入以下命令，可以查看git的版本信息。

	git --version
结果如下图所示。

![git版本检查](/images/blog1/b2.png)
### github注册相关 ###
若没有注册过github账号，在[github官网](https://github.com/)按照步骤注册成功就好。

注册登录后，在页面右上角+号选择New repository创建新的代码仓库。

![新建仓库](/images/blog1/b3.png)

在Create a new repository页面下，填写Repository name框框，框框中填写yourname.github.io，其中yourname为Owner框框中的那个名字。再勾选一下Initialize this repository with a README 。

![新建仓库](/images/blog1/b4.png)

正确创建代码仓库后，需要开启github pages功能。在刚刚新建的代码仓库界面点击Settings，就会打开这个库的设置页面，向下拖动，会看见GitHub Pages，点击Launch Automatic page generator，github 自动创建出一个github pages页面。然后你可以试着访问yourname.github.io这个网址。

## hexo下载安装 ##

在合适的盘，例如以E盘为例，在E盘根目录下新建hexo文件夹，然后右键点击选中hexo,选择Git Bash Here,在git命令窗口中输入以下命令：

	$ npm install hexo-cli -g

然后输入

	$ npm install hexo --save
建议将hexo以下插件一起安装了

	$ npm install hexo-generator-index --save #索引生成器
    $ npm install hexo-generator-archive --save #归档生成器 
	$ npm install hexo-generator-category --save #分类生成器
	$ npm install hexo-generator-tag --save #标签生成器 
	$ npm install hexo-server --save #本地服务 
	$ npm install hexo-deployer-git --save #hexo通过git发布（必装） 
	$ npm install hexo-renderer-marked@0.2.7--save #渲染器 
	$ npm install hexo-renderer-stylus@0.3.0 --save #渲染器
(或者可以执行 npm install命令，npm会自动安装部分组件，但自己试了下，用npm命令不能安装全组件，部分组件还需自己手动安装，比如最重要的用于部署功能的组件 hexo-deployer-git 用 npm install命令就没装上。可以在hexo/node_modules文件下查看已经安装了的组件。)

安装完成后可查看下所安装的hexo版本信息。在hexo文件夹下右键进入git bash,输入以下命令:

    $ hexo -v

若看到类似如图所示版本信息说明hexo安装成功。

![hexo版本信息](/images/blog1/b5.png)
	
## hexo相关配置 ##

* hexo初始化 ->在hexo文件夹下右键进入git bash,输入以下初始化命令： `$ hexo init`
* hexo生成 ->输入以下命令生成静态页面: `$ hexo g`
* 本地服务 ->输入以下命令建立本地hexo预览： `$ hexo s`
(确保已经安装了hexo-server组件，否则该命令无效）

执行完 hexo s 命令后会提示

	INFO Hexo is running at http://0.0.0.0:4000/. Press Ctrl+C to stop.
在浏览器中打开上述链接地址，会看到hexo默认的主题页面，至此hexo本地配置完成。

PS：注意！！！安装了福昕阅读器的朋友，福昕阅读器会占用4000端口，导致 hexo s 命令后出错提示4000端口被占用。你可以在hexo/_config.yml站点配置文件里修改端口号，换成自己想设置的端口即可，如下修改：

	server:
	  port: 4001
	  compress: true
	  header: true


## hexo与github pages链接 ##

* deployment配置  ->在hexo/_config.yml站点配置文件里，修改下面的字段内容如下：

		deploy:     
		  type: git 
		  repo: https://github.com/yourname/yourname.github.com.git #yourname即为创建仓库时的那个yourname    
		  branch: master
PS:注意.yml格式文件冒号后面有一个空格。


## 发布第一篇博文 ##

在hexo文件夹下右键进入git bash,输入以下命令即可生成一篇新文章：

	hexo new post "post_title"   #其中post_title为你想新建文章的文件名
此时在 E:\hexo\source\ _posts 下生成一个 post_title.md 文件（此后你可以用markdown编辑器打开该.md文件就可以编辑文章了）。

然后运行下面两条命令即可将新建的文章生成->部署到github上。

	hexo g  #生成
	hexo d  #部署
部署完毕后，即可访问https://yourname.github.io看到刚刚生成部署到github的文章。

PS：以后每次用markdown编辑器修改post_title.md文件后，记得用 `hexo g -d` 命令来生成和部署。修改完配置后也要`hexo g -d`一下。

PPS:hexo常用命令

	hexo new post "postName" #新建文章 
	hexo new page "pageName" #新建页面 
	hexo generate #生成静态页面至public目录 
	hexo server #开启预览访问端口（默认端口4000，'ctrl + c'关闭server）
	hexo deploy #将.deploy目录部署到GitHub 
	hexo help  #查看帮助 
	hexo version #查看Hexo的版本
简写

	hexo n == hexo new
	hexo g == hexo generate
	hexo s == hexo server
	hexo d == hexo deploy



## hexo主题介绍及配置   ##

我选用的较为简洁大方的next主题。

* next主题下载 ->在hexo文件夹下右键进入git bash,输入以下命令：
	
	`git clone https://github.com/iissnan/hexo-theme-next themes/next`
* 启用next主题 ->在hexo/_config.yml站点配置文件下，修改如下字段：

 	`theme: next`
* 测试主题启用是否成功 ->执行 `hexo s`命令，在浏览器访问 http://localhost:4000查看主题效果。

PS：主题的其他相关设置可以参考该博客，写的很详细[手把手教你用Hexo+Github 搭建属于自己的博客](http://blog.csdn.net/gdutxiaoxu/article/details/53576018)。
##  hexo第三方服务集成 ##
### 添加disqus评论 ###
由于以前国内使用较多的多说评论下架了，所以选用了国外较为稳定的disqus，但使用该评论功能需要“科学上网”！

* 注册disqus账号[https://disqus.com](https://disqus.com)
* 在disqus设置页面中点 Add Disqus to your site 添加你的网站地址(即为https://yourname.github.io), 和设置Choose your unique Disqus URL, 你所填写的unique Disqus URL即为hexo配置文件中需要修改的short_name字段。
* 打开hexo/themes/next/_config.yml主题配置文件，修改下面字段：

		#Disqus
		disqus:
		  enable: true
		  shortname:     #shortname即为你上面填写的唯一disqus路径，填上就好
		  count: true

### 添加百度分享功能 ###
百度分享功能的添加可以参考下面这篇博客。[Hexo+Github搭建个人博客(三)——百度分享集成](http://blog.csdn.net/cl534854121/article/details/76121105)
### 百度统计访客访问量功能 ###
其他酷炫小功能参考[hexo的next主题个性化教程:打造炫酷网站](http://www.jianshu.com/p/f054333ac9e6)。

## 参考博客 ##
[手把手教你用Hexo+Github 搭建属于自己的博客 ](http://blog.csdn.net/gdutxiaoxu/article/details/53576018)

[记录第一次搭建hexo](http://www.jianshu.com/p/017e01718d41)

嘤嘤嘤~~~~~~~THE END!




