---
title: AngularJS学习笔记01
date: 2017-12-08 16:41:16
tags: [Angular]
categories: FrontEndFrame
---
 AngularJS是Google开源的一款JavaScript MVC的前端框架，弥补了HTML在构建应用方面的不足，其通过使用指令（directives）结构来扩展HTML词汇，且通过表达式绑定数据到 HTML，使开发者可以使用HTML来声明动态内容，从而使得Web开发和测试工作变得更加容易。
<!--more-->
 AngularJS 是一个为动态WEB应用设计的结构框架，提供给大家一种新的开发应用方式，这种方式可以让你扩展HTML的语法，以弥补在构建动态WEB应用时静态文本的不足，从而在web应用程序中使用HTML声明动态内容。Angular可以帮助你组织JavaScript代码，可以创建响应式网站（会对用户的请求产生快速的反应），Angular可以和JQuery很好的协调、方便测试（搭建可维护的应用）。

简单的解释Angular就是一个可以给HTML加上互动性的客户端JS框架。

关于传统网页请求和AngularJS网页请求之间的区别，参见博客[AngularJS系列——简介](http://blog.csdn.net/xiaoyao0909/article/details/51419078)。
## AngularJS简介 ##
	AngularJS 通过 ng-directives 扩展了 HTML。
	ng-app 指令定义一个 AngularJS 应用程序。
	ng-model 指令把元素值（比如输入域的值）绑定到应用程序变量。
	ng-bind 指令把应用程序数据绑定到 HTML 视图。
例如：

	<body>
		<div ng-app="">
	    	<p>名字 : <input type="text" ng-model="name"></p>
	    	<h1>Hello {{name}}</h1>
		</div>
	</body>
ng-app 指令告诉 AngularJS，<div\> 元素是 AngularJS 应用程序 的"所有者"。ng-model 指令把输入域的值绑定到应用程序变量 name。ng-bind 指令把应用程序变量 name 绑定到某个段落的 innerHTML。

AngularJS 使得开发现代的单一页面应用程序（SPAs：Single Page Applications）变得更加容易。

    AngularJS 把应用程序数据绑定到 HTML 元素。
    AngularJS 可以克隆和重复 HTML 元素。
    AngularJS 可以隐藏和显示 HTML 元素。
    AngularJS 可以在 HTML 元素"背后"添加代码。
    AngularJS 支持输入验证。
## 表达式 ##
AngularJS 使用表达式把数据绑定到 HTML。

AngularJS 表达式写在双大括号内：{{ expression }}。AngularJS表达式很像JavaScript表达式：它们可以包含文字、运算符和变量。

	<body>
		<div ng-app="">
	    	<p>我的第一个表达式: {{ 5 + 5 }}</p>
		</div> 
	</body>
AngularJS 表达式把数据绑定到 HTML，这与 ng-bind 指令有异曲同工之妙。例如：

	
	<div ng-app="" ng-init="quantity=1;cost=5">
		<p>总价： {{ quantity * cost }}</p>
	</div>
使用 ng-bind 的相同实例：

	<div ng-app="" ng-init="quantity=1;cost=5"> 
		<p>总价： <span ng-bind="quantity * cost"></span></p>
	</div>
**AngularJS表达式与JavaScript表达式比较**
	
	类似于 JavaScript 表达式，AngularJS 表达式可以包含字母，操作符，变量。
	与 JavaScript 表达式不同，AngularJS 表达式可以写在 HTML 中。
	与 JavaScript 表达式不同，AngularJS 表达式不支持条件判断，循环及异常。
	与 JavaScript 表达式不同，AngularJS 表达式支持过滤器。
## 指令 ##
AngularJS 通过**指令**新属性来扩展 HTML，指令带有前缀 ng-。

AngularJS 通过内置的指令来为应用添加功能，允许自定义指令。

	ng-app 指令初始化一个 AngularJS 应用程序。
	ng-init 指令初始化应用程序数据。
	ng-model 指令把元素值（比如输入域的值）绑定到应用程序。
	ng-repeat 指令对于集合中（数组中）的每个项会 克隆一次 HTML 元素
例如：

	<div ng-app="" ng-init="firstName='John'">
	     <p>在输入框中尝试输入：</p>
	     <p>姓名：<input type="text" ng-model="firstName"></p>
	     <p>你输入的为： {{ firstName }}</p>
	</div>
使用 .directive 函数来添加自定义的指令。要调用自定义指令，HTML 元素上需要添加自定义指令名。
使用驼峰法来命名一个指令， runoobDirective, 但在使用它时需要以 - 分割, runoob-directive。
	
	<body ng-app="myApp">
		<runoob-directive></runoob-directive>
		<script>
			var app = angular.module("myApp", []);
			app.directive("runoobDirective", function() {
	    		return {
	       		 template : "<h1>自定义指令!</h1>"
	    		};
			});
		</script>
	</body>
你可以通过以下方式来调用指令：元素名、属性、类名、注释。

	<runoob-directive></runoob-directive>
	<div runoob-directive></div>
	<div class="runoob-directive"></div>
	<!-- directive: runoob-directive -->
## AngularJS模型 ng-model指令 ##
ng-model 指令用于绑定应用程序数据到 HTML 控制器(input, select, textarea)的值。ng-model 指令可以将输入域的值与 AngularJS 创建的变量绑定。
