---
title: planeGame-H5 Canvas小游戏未完成的问题
date: 2017-10-30 16:31:25
tags: [HTML5, Canvas]
categories: FrontEndDemo
---
H5 Canvas打飞机游戏中未完成以及存在疑惑的地方。
<!--more-->
## 未完成内容 ##
### 游戏设置部分 ###

音乐设置（HTML5 audio相关的学习，包括设置游戏背景音乐以及各种子弹、爆炸等声音，以及切换声音的开启和关闭）

背景设置（即切换背景图片）

战机设置（即切换战机plane的icon图片）

### 存在问题的地方 ###
点击“再玩一次”之后，敌机以及子弹的速度会越来越快，差不多第三次重玩就无法进行了。感觉是因为上一次游戏过程中的一些数据没有清除，怀疑过是不是setInterval()的原因，百度了查了好多，在end处添加了window.clearInterval()，但也是无济于事。特将此问题记录，以待后面将js学深了再来解决。
### 可以改进的地方 ###
游戏结束以后，除了“再玩一次”，再添加一个“退出游戏”功能，使页面切换到index状态。

适应手机端的，试了下在电脑上战机移动不了，应该是手指移动事件那里还未考虑鼠标移动来兼容电脑浏览器。
## 效果截图 ##
主页面如下：

![1](/images/planeGameQuestion/1.png)

游戏结束，“再玩一次”界面

![2](/images/planeGameQuestion/2.png)

## github源码 ##
github仓库地址：[demo-planegame](https://github.com/shirley5li/demo-planegame)

放在gh-pages上的样子，电脑端战机移动不了。[demo展示](https://shirley5li.github.io/demo-planegame/)