---
title: 有默认margin，padding值的html标签
date: 2017-10-18 13:00:44
tags: [css]
categories: CSS
---
总结一下那些有默认margin及padding值的html标签，在CSS reset时，最好将这些元素的padding和margin值初始化为0，以实现不同浏览器下的样式兼容，避免后期团队开发过程因不同浏览器下默认样式不同而造成混乱。
<!--more-->
## h1~h6标签 ##
有默认margin（top,bottom且相同）值，没有默认padding值。

	在chrome中：16,15,14,16,17,19;
	
	在firefox中：16,15,14,16,17,20;
	
	在safari中：16,15,14,16,17,19;
	
	在opera中：16,15,14,14,17,21;
	
	在maxthon中：16,14,14,15,16,18;
	
	在IE6.0中：都是19；
	
	在IE7.0中：都是19；
	
	在IE8.0中：16,15,14,16,17,19;
## dl标签 ##
有默认margin（top,bottom且相同）值，没有默认padding值。
	
	在Chrome,Firefox,Safari,Opera,Maxthon,IE8.0中：margin:12px 0px;
	
	在IE6.0,7.0中：margin:19px 0px;

dd标签有默认margin-left：40px;(在所有上述浏览器中)。
## ol,ul标签 ##
有默认margin-（top,bottom且相同）值，有默认padding-left值

	在Chrome,Firefox,Safari,Opera,Maxthon,IE8.0中：margin:12px 0px;
	
	在IE6.0,7.0中：margin:19px 0px;
默认padding-left值：在Chrome,Firefox,Safari,Opera,Maxthon,IE8.0中都是padding-left：40px;在IE6.0,7.0中没有默认padding值，因为ol,ul标签的边框不包含序号。
## th,td标签 ##
th,td标签没有默认的margin值，有默认的padding值。

	在Chrome,Firefox,Safari,Opera,Maxthon中：padding：1px;
	
	在IE8.0中：padding：0px 1px 1px;
	
	在IE7.0中：padding：0px 1px；
相同内容th的宽度要比td宽，因为th字体有加粗效果。

**注意 ：table标签没有默认的margin,padding值。**
## form标签 ##
form标签在Chrome,Firefox,Safari,Opera,Maxthon,IE8.0中没有默认的margin,padding值，但在IE6.0,7.0中有默认的margin：19px 0px;
## p标签 ##
p标签有默认margin(top,bottom)值,没有默认padding值。

	在Chrome,Firefox,Safari,Opera,Maxthon,IE8.0中：margin:12px 0px;
	
	在IE6.0,7.0中：margin:19px 0px;
## textarea标签 ##
textarea标签在上述所有浏览器中：margin:2px；padding:2px；
## select标签 ##
select标签在Chrome,Safari,Maxthon中有默认的margin：2px；在Opera,Firefox,IE6.0,7.0,8.0没有默认的margin值。
## option标签 ##
option标签只有在firefox中有默认的padding-left：3px；

## CSS reset ##
	/*CSS style init*/
	body,ul,ol,dl,dd,h1,h2,h3,h4,h5,h6,p,input,select,option,textarea,form,th,td{margin: 0; padding: 0;}
	body{font:14px/1.5 "宋体";}
	img{border:none;}
	li{list-style:none;}
	input,select,textarea{outline:none;border:none;background:none;}
	textarea{resize:none;}
	a{text-decoration:none;}