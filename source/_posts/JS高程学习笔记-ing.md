---
title: JS高程（3）学习笔记
date: 2017-12-25 17:17:54
tags: [JavaScript]
categories: JavaScript
---
JavaScript学习笔记。
<!--more-->
## 模仿块级作用域 ##
JS没有块级作用域，即在块语句中定义的变量，实际是在包含函数中创建的，而非在块语句中创建的。如下：

	function outputNumbers(count) {
		for( var i = 0; i < count; i++) {
			console.log(i);
		}
		console.log(i);
	}
	outputNumbers(4);//打印值为0 1 2 3 4
在Java、C++等语言中，for循环中定义的变量i只存在于for循环语句块中，循环一旦结束，变量i就会被销毁。而在JS中，变量i是定义在outputNumbers()这个包含函数的活动对象中的，因此从它被定义开始，就可以在函数内部随处访问它。

即使在一个函数中重新声明同一个变量，也不会改变它的值。如下：

	function outputNumbers(count) {
		for( var i = 0; i < count; i++) {
			console.log(i);
		}
		var i;
		console.log(i);
	}
	outputNumbers(4);//打印值为0 1 2 3 4
JS不会提醒是否多次声明了同一个变量，在此情况下，它对后续重复的变量声明视而不见，但会执行后续声明中的变量初始化。可以通过**匿名函数模仿块级作用域**来避免多次声明同一个变量的问题。

用作**块级作用域（私有作用域）**的匿名函数语法如下：

	(function() {
		//这里为块级作用域
	})();
无论在什么地方，只要临时需要一些变量，就可以使用私有作用域。使用私有作用域如下：

	function outputNumbers(count) {
		(function() {
			for( var i = 0; i < count; i++) {
			console.log(i);
			}
		})();
		console.log(i);//导致一个错误！！！
	}
这种技术经常在全局作用域中被用在函数外部，从而限制向全局作用域中添加过多的变量和函数。
## 私有变量 ##
严格来讲，JS中没有私有成员的概念，所有对象属性都是公有的。但有一个私有变量的概念，任何在函数中定义的变量，都可以认为是私有变量，因为在函数外部无法访问这些变量，包括函数参数、局部变量、在函数中定义的其他函数。

把有权访问上述私有变量和私有函数的公有方法称为**特权方法**，有两种在对象上创建特权方法的方式。

**第一种：在构造函数中定义特权方法**，基本模式如下

	function MyObject() {
		//私有变量
		var privateVariable = 10;
		//私有函数
		function privateFunction() {
			return false;
		}
	
		//特权方法
		this.publicMethod = function() {
			privateVariable++;
			return privateFunction();
		};
	}
能够在构造函数中定义特权方法，是因为特权方法作为闭包有权访问在构造函数中定义的所有变量和函数。

在创建构造函数实例后，除了使用特权方法，没有其他方式可以直接访问构造函数内部的私有变量和私有函数。

利用私有和特权成员，可以隐藏那些不应该被直接修改的数据。

在构造函数中定义特权方法的缺点，就是必须使用构造函数模式来实现特权方法，而构造函数的缺点是针对每个实例都会创建同样一组新方法，而使用**静态私有变量**来实现特权方法可以避免这一问题。

**第二种：使用静态私有变量实现特权方法**

通过在私有作用域中定义私有变量或函数，也可以创建特权方法。基本模式如下：

	(function() }{
		//私有变量
		var privateVariable = 10;
		//私有函数
		function privateFunction() {
			return false;
		}
	
		//构造函数
		MyObject = function() {
		};
	
		//公有方法/特权方法
		MyObject.prototype.publicMethod = function() {
			privateVariable++;
			return privateFunction();
		};
	
	})();
公有方法是在构造函数原型上定义的，体现了典型的原型模式。注意：该模式在定义构造函数时并没有使用函数声明，而是使用了函数表达式。函数声明只能创建局部函数，并不是我们想要的，因此也没有使用关键字var声明MyObject。初始化未经声明的变量，总会创建一个全局变量，因此MyObject就变成了一个全局变量，能够在私有作用域之外被访问到。但在严格模式下，给未经声明的变量赋值会导致错误。

该模式与在构造函数中定义特权方法的主要区别在于，私有变量和函数由实例共享，在一个实例上调用公有方法，会影响所有实例。
以该方式创建静态私有变量会因为使用原型而增进代码复用，但每个实例都没有自己的私有变量。因此选择使用实例变量，还是静态私有变量，视具体需求而定。
## BOM-window对象 ##
BOM的核心对象是window，它表示浏览器的一个实例。在浏览器中，window对象既是通过JavaScript访问浏览器窗口的一个接口，又是ECMAScript规定的global对象。
### 全局作用域 ###
所有在全局作用域中声明的变量、函数都会变成window对象的属性和方法。例如：

	var age = 29;
	function sayAge() {
		alert(this.age);
	}
	alert(window.age);   //29
	sayAge();            //29
	window.sayAge();     //29
全局变量会变为window对象的属性，定义全局变量与在window对象上直接定义属性的差别：全局变量不能通过delete操作符删除，而直接在window对象上定义的属性可以。
### 窗口关系及框架 ###
如果页面中包含框架，则每个框架都拥有自己的window对象，并且保存在frames集合中。