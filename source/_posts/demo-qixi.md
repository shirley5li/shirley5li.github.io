---
title: 慕课网七夕动画学习总结 + Github Pages展示
date: 2017-09-29 20:31:33
tags: [Animation, Github Pages]
categories: github
---
这段时间照着慕课网上的一个动画案例-[H5+JS+CSS3实现七夕言情](http://www.imooc.com/learn/453)学习，
<!--more-->
并将学习的各部分的代码进行整合，最后将代码托管到github上，并通过github pages展示这个动画demo。一些地方自己修改以后没有老师的效果好，但这是自己第一个敲出来的前端小demo，成就感满满，哈哈。。。

# 关于动画案例 #

里面用到一些jQuery和ajax相关的知识，由于自己学习js不久，很多深一点的概念理解不到位，比如一开始代码的封装和流程的编写，都是照葫芦画瓢，不是很理解，但是慢慢的看得多了，这个过程也就熟悉起来了。

页面布局部分比较容易理解，但是三个主题页面滚动起来最开始对自己还是有点难度。该案例很多部分都利用了CSS3的transform属性和animation属性。而且这个案例的思想是，把实现特定动作或者动能的代码封装起来，暴露一个接口出来，增强了安全性简化了编程过程。

具体的学习过程和用到的知识点，大家可以跟着[H5+JS+CSS3实现七夕言情](http://www.imooc.com/learn/453)学习，边看边学的效果比抱着书一直看的效果要好一些。但js高级教程的基础必须打牢，很多师兄师姐给的建议，也是网上一些大佬的建议。

关于画面自己做的一点小改动，button的样式做了修改，并增加了链接到github仓库的logo（shirly与猫）,嘤嘤嘤。如下，左下角和右下角辣么一点点。

![1](/images/demo-qixi/1.png)


# 关于将页面搭建在github pages上 #

关于动画制作的学习过程如果说困难和迷惑的话，那这最后一步展示在github pages上的过程，就应该是差点死在最后的1%上。在网上看了很多博客和教程，总会遇到很多小问题，无法显示自己在本地的效果。最后看到了这篇博客，[【 js 工具 】如何在Github Pages搭建自己写的页面？](http://www.cnblogs.com/lijiayi/p/githubpages.html)，这篇博客对于利用github pages搭建自己写的网页描述很详细，从在github上建仓库，到github pages的设置，再到利用git命令克隆github上的仓库到本地，最后push到远程master分支上。

更多关于github的使用可参考[Github 简明教程](http://www.runoob.com/w3cnote/git-guide.html),其中讲解的git维护的本地仓库的工作流很清晰，对于我这个初步使用git的菜鸟十分友好。而且关于branch和更新与合并功能也讲的比较清楚。

本地仓库由git维护的“三棵树”组成。第一个是工作目录，使用`$ git status`可以查看，列出了当前目录下所有还未被git管理的文件，以及被git管理了且被修改过但还未添加（add）的文件，也即所有改动文件，用红色字体标出。如下所示，当我在本地仓库demo-qixi用`$ git status`命令查看后，可以看到红色文件均为未提交的。

![2](/images/demo-qixi/2.png)

第二个是暂存区（Index），它类似一个缓存区，临时保存你的改动。通过`$ git add .`命令添加当前目录下的所有文件和子目录到暂存区。注意`.`表示当前目录下的所有文件和子目录。也可以指定文件添加到暂存区，使用`$ git add <filename>`。如下使用`$ git add .`添加文件到暂存区：

![3](/images/demo-qixi/3.png)

此时我们再使用`$ git status`命令查看下工作目录，你会发现所有的文件都变绿了，这就表示这些文件已被添加到暂存区准备好被提交（commit）了。

![4](/images/demo-qixi/4.png)

第三个是HEAD，它指向你最后一次提交的结果。使用`$ git commit -m "代码提交说明信息"`命令，将暂存区最后一次添加更改情况提交到HEAD。如下所示。

![5](/images/demo-qixi/5.png)

上述“三棵树”的工作流程如下所示。

![6](/images/demo-qixi/6.png)

此时改动虽然已经提交到了HEAD，但是还没到远端仓库。使用`$ git push `命令将这些改动提交到远端仓库的default master分支。也可以使用`$ git push origin master`命令，把改动提交到master分支。可以把master换成自己想要推送的任何分支。

# 动画demo展示 #

demo网页展示链接[慕课七夕主题网页展示](https://shirley5li.github.io/demo-qixi/index.html)。

该动画demo在github上的代码仓库[demo-qixi](https://github.com/shirley5li/demo-qixi)。


tips:在打开demo页面展示链接时，浏览器链接窗口出现提示“此页面上部分内容不安全，例如图像”，并且网页内容不能完整显示，我使用的firefox浏览器。如下所示，

![7](/images/demo-qixi/7.png)

原因是我们用来展示demo的github pages站点是使用https协议的安全站点，而demo中的一些图片链接是使用的http协议，浏览器不会渲染混合内容（即来自安全站点的不安全数据）。如果我们浏览https网页，浏览器会拒绝加载不安全的内容（例如这里的demo-qixi中图片使用的http协议），浏览器将向用户发出“此页面上部分内容不安全”的警告。可以参考这篇讲web安全的文章，[绕过混合内容警告 - 在安全的页面加载不安全的内容](https://paper.seebug.org/112/)。

解决办法：我用的火狐浏览器，点浏览器链接窗口左侧的黄色警告三角形->点右侧箭头显示连接细节->点暂时解除保护，就可以看到完整的动画demo了。

然后点击 Go!开始动画啦。。。。。。







