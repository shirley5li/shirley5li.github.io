---
title: CSS清除浮动的几种方法
date: 2017-10-17 16:09:35
tags: [CSS]
categories: CSS
---
几种定位方式，以及CSS清除浮动的几种方法。
<!--more-->
# 几种定位方式 #
## 普通流定位 static ##
普通流定位即文档流定位，是页面元素的默认定位方式。按照元素在文档流中的出现顺序以默认形式呈现元素。

	页面中的块级元素：按照从上到下的方式逐个排列 。
	页面中的行内元素：按照从左到右的方式逐个排列 。

此时考虑如何让多个块级元素显示在一行，就引出了浮动的概念。
## 浮动定位 float ##
float属性取值为 left/right。这个属性原本不是用来布局的，而是用来做文字环绕的，但是后来人们发现做布局也不错，就一直这么用了，甚至有些时候都忘了用他做文字环绕。
## 相对定位 relative ##
元素会相对于它原来的位置偏移某个距离。**使元素偏离原来位置后，元素原本的空间依然会被保留**。

	语法
	属性：position
	取值：relative
	再配合 偏移属性top/right/bottom/left实现位置改变
## 绝对定位 absolute ##
若元素被设置为绝对定位，具备以下几个特征：

	1、脱离文档流-不占据页面空间
	2、通过偏移属性固定元素位置
	3、相对于 最近的已定位的祖先元素实现位置固定
	4、如果没有已定位祖先元素，那么就相对于最初的包含块(body,html)去实现位置的固定 
	语法
	属性：position
	取值：absolute
	再配合 偏移属性(top/right/bottom/left)实现位置的固定
## 固定定位 fixed ##
将元素固定在页面的某个位置处，不会随着滚动条而发生位置移动。

	语法
	属性：position
	取值：fixed
	配合着 偏移属性(top/right/bottom/left)实现位置的固定
# 浮动的效果
	1、浮动定位元素会被排除在文档流之外-脱离文档流(不占据页面空间),其余的元素要上前补位
	2、浮动元素会停靠在父元素的左边或右边，或停靠在其他已浮动元素的边缘上(元素只能在当前所在行浮动)
	3、浮动元素依然位于父元素之内
	4、浮动元素处理的问题-解决多个块级元素在一行内显示的问题 
	注意
	1、一行内，显示不下所有的已浮动元素时，最后一个将换行
	2、元素一旦浮动起来之后，那么宽度将变成自适应(宽度由内容决定)
	3、元素一旦浮动起来之后，那么就将变成块级元素,尤其对行内元素，影响最大（块级元素：允许修改尺寸；行内元素：不允许修改尺寸 ） 
	4、文本，行内元素，行内块元素时采用环绕的方式来排列的，是不会被浮动元素压在底下的，会巧妙的避开浮动元素

浮动的影响：由于浮动元素会脱离文档流，所以导致不占据页面空间，所以会对父元素高度带来一定影响。如果一个元素中包含的元素全部是浮动元素，那么该元素高度将变成0（高度塌陷）。
# 清除浮动 #
## 方法1 ##
直接设置父元素的高度。
优势：极其简单；
弊端：必须要知道父元素高度是多少
## 方法2 ##
在父元素中，追加空子元素，并设置其clear属性为both。clear是css中专用于清除浮动的属性。
作用：清除当前元素前面的元素浮动所带来的影响

	取值：
	1、none
	默认值，不做任何清除浮动的操作
	2、left
	清除前面元素左浮动带来的影响
	3、right
	清除前面元素右浮动带来的影响
	4、both
	清除前面元素所有浮动带来的影响
优势：代码量少 容易掌握 简单易懂
弊端：会添加许多无意义的空标签，有违结构与表现的分离，不便于后期的维护
## 方法3 ##
设置父元素浮动。

优势：简单，代码量少，没有结构和语义化问题；
弊端：对后续元素会有影响 
## 方法4 ##
为父元素设置overflow属性。

	取值：hidden 或 auto
优势：简单，代码量少
弊端：如果有内容要溢出显示(弹出菜单)，也会被一同隐藏
## 方法5 ##
父元素设置display:table.

优势：不影响结构与表现的分离，语义化正确，代码量少；
弊端：盒模型属性已经改变，会造成其他问题
## 方法6 ##
使用内容生成的方式清除浮动。

	.clearfix:after {
		content:"";
		display:block;
		clear:both;
	}

:after 选择器向选定的元素之后插入内容 

	content:""; 生成内容为空
	display: block; 生成的元素以块级元素显示,
	clear:both; 清除前面元素浮动带来的影响
相对于空标签闭合浮动的方法，
优势：不破坏文档结构，没有副作用；
弊端：代码量多
## 方法7 ##
	.cf:before,.cf:after {
	   content:"";
	   display:table;
	}
	.cf:after { clear:both; }

优势：不破坏文档结构，没有副作用；
弊端： 代码量多 