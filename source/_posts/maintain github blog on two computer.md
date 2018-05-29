---
title: 在两台电脑上更新维护Github Pages + Hexo博客
date: 2018-01-07 21:10:12
tags: [Github Pages, Hexo]
categories: 搭建博客
---

之前在台式机上通过GitHub pages 和Hexo搭建了静态博客，一直用台式机写文章更新博客，这几天想着是不是也可以用笔记本写文章维护下博客，毕竟笔记本带着方便啊。于是就看了一些博客，尝试着在笔记本上实现跟台式机一样的发博客过程，也遇到了一些问题，特将过程总结下来。这篇文章即在笔记本上完成的。

<!--more-->

## 实现思路

主要思路利用git分支实现。利用Hexo框架生成的静态博客文件默认放在博客repo的master分支，即台式机上初次搭建好的本地博客环境Hexo文件夹下的public文件夹的内容对应github上博客repo的master分支内容。现在我们需要在博客repo新建一个hexo分支，用来放Hexo源文件，即放台式机上Hexo文件夹下的全部文件，而不只是public文件夹（public用来存放静态网站文件）。

现在我们的博客repo即xxxx.github.io这个仓库有了两个分支，一个master分支用来放Hexo生成的静态网站，一个hexo分支放Hexo的源文件。相当于用hexo分支备份了之前台式机上本地的Hexo环境，在笔记本上将hexo分支clone下来，然后写文章、更新博客到hexo分支（`git push`到hexo分支，使得备份源文件最新），保证hexo分支的内容最新，然后执行`hexo g -d`命令，生成的静态文件会被默认push到master分支，更新博客站点内容。

下面来叙述一下具体的操作步骤。

## 原来台式机上的操作

- 在Github的xxx.github.io仓库上新建一个hexo分支，并切换到该分支，并在该仓库->Settings->Branches->Default branch中将默认分支设为hexo（之前的默认分支是master），save保存。


- 然后将该仓库克隆到本地，进入该xxx.github.io文件目录。在当前目录使用Git Bash，执行`git branch`命令查看当前文件夹下内容所在的分支，查询结果应为新建的分支hexo。


- 接下来，将本地博客的部署文件（**Hexo目录下的全部文件**，即Hexo源文件）全部拷贝进xxx.github.io文件目录中去。最后将xxx.github.io目录下的全部文件push到hexo分支，即完成了Hexo源文件的备份过程。

**注意：**将themes目录以内中的主题的.git目录删除（如果有），因为一个git仓库中不能包含另一个git仓库，提交主题文件夹会失败。可能有人会问，删除了themes目录中的.git不就不能`git pull`更新主题了吗，很简单，需要更新主题时在另一个地方`git clone`下来该主题的最新版本，然后将内容拷到当前主题目录即可。

上面的注意点中的情形我没有遇到，直接把本地Hexo文件夹下的全部内容复制到新clone下来的xxx.github.io文件夹下，然后通过git命令push到博客repo的hexo分支。

**push到hexo分支的git命令介绍:**`git status`可以查看当前目录下哪些文件被改动过了，被改动过但还未被git管理的显示红色，被改动过但已经add添加到暂存区的显示绿色；`git add .`可以将当前目录下的全部改动文件添加到暂存区，以待被提交；`git commit -m "back up hexo files"`将暂存区的内容提交至HEAD，以待被push到远端；`git push`将HEAD内容push到远端github博客仓库的hexo分支。至此完成了台式机本地Hexo源文件备份到xxx.github.io仓库的hexo分支。

## 新的笔记本上的操作

由于上面过程已经完成了原来电脑上本地Hexo源文件的备份，所以博客现在可以在其他电脑上维护和更新了。

由于笔记本上没有安装node.js、git等，所以需要像初次搭建博客那样，先安装配置好环境。参考之前的文章[基于hexo和github搭建个人博客概述](http://shirley5li.me/2017/08/06/hello-world/)，先下载安装node.js，下载安装git。（如果电脑有这两个工具可以忽略这一步）

- 将新电脑即笔记本生成的ssh key添加到GitHub账户上（因为通过SSH url方式，使用git客户端第一次git clone github.com代码需要验证ssh key），具体的添加SSH key方法参考[github设置添加SSH](http://blog.csdn.net/binyao02123202/article/details/20130891)。

- 在笔记本上克隆xxx.github.io仓库的hexo分支到本地，此时本地git仓库处于hexo分支，使用`git branch`命令查看。


- 切换到xxx.github.io目录，执行npm install(由于仓库有一个.gitignore文件，里面默认是忽略掉 node_modules文件夹的，也就是说仓库的hexo分支并没有存储该目录，所以需要install下)。

另外可以看到仓库hexo分支themes/next主题文件夹是空的，所以clone到本地的next主题文件夹也是空的（原因还没搞清楚，为什么备份的时候单单next主题文件夹push不上去），所以只好将台式机上的next主题文件夹拷贝一份到笔记本上，替换clone下来的空next主题文件夹。这个地方算是遇到的一个坑，因为本地测试的时候提示无法渲染index.html，搜索了原因有人回答是不是主题文件没有，这才发现next文件夹是空的。

还有就是，由于还需要Hexo框架帮我们生成静态网站并push到master分支，而此时你有没有发现我们还忘记装Hexo了，没装Hexo我们怎么能用`hexo g -d`这样的命令呢。所以最后一步，把Hexo装上。Hexo的下载安装同样参考之前的博客[基于hexo和github搭建个人博客概述](http://shirley5li.me/2017/08/06/hello-world/)。之前我以为备份好Hexo源文件，再clone下来就自带Hexo环境，可以执行`hexo g`这样命令，我参考的那篇博文也没重装Hexo这一步，但当我试着写了文章执行本地`hexo s`测试时，提示找不到`hexo`这样的命令，然后我照初次搭建博客那样`$ npm install hexo --save`，又装了一下Hexo，就可以执行`hexo s`命令了，并测试了一下正确。

至此就可以在笔记本上写博客了。

在xxx.github.io目录下，执行`hexo new post "the first post on laptop"`，可以新建一篇文章，然后编辑撰写，或者改动以前的文章。

- 然后用执行`git status`可以查看当前目录下哪些文件被改动过了，即新写的文章、添加的文件、修改的文件等；执行`git add .`将当前目录下的全部改动文件添加到暂存区，以待被提交；执行`git commit -m "back up hexo files"`将暂存区的内容提交至HEAD，以待被push到远端；执行`git push`将HEAD内容push到远端github博客仓库的hexo分支。至此完成了笔记本本地Hexo源文件备份到xxx.github.io仓库的hexo分支的过程，即不管是在台式机操作还是在笔记本操作，都要保证hexo分支的内容是最新的。

- 最后执行`hexo g -d`命令，即将本地编辑好的.md形式的文件生成静态博客文件并push到博客repo的master分支，这一步完成了博客站点的更新。


## 再回到台式机上更新博客时的操作

**注意： 每次换电脑进行博客更新时，不管上次在其他电脑有没有更新，最好先执行`git pull hexo`命令**，即将远端最新的hexo分支拉到本地，使本地与远端达到同步。

另外看到一篇讲解[Hexo的版本控制与持续集成](https://formulahendry.github.io/2016/12/04/hexo-ci/)的文章，将本地push到hexo分支和利用hexo部署博客静态文件到master分支的两个步骤合二为一，使用GitHub进行版本控制，又能做到一键发布。即用到了持续集成，也就是用CI来完成一键发布：当有新的change push到Source Repo时，自动执行CI脚本，生成最新的静态网站发布到Content Repo。自己还没有实际操作过，等操作过后再作总结。

## reference

[利用Hexo在多台电脑上提交和更新github pages博客](https://www.jianshu.com/p/0b1fccce74e0)

