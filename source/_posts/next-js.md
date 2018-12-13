---
title: JS笔记(一)--from next十天训练营
date: 2017-10-20 09:21:29
tags: [JavaScript]
categories: FrontEndInterview
---
NEXT十天训练营有关JS学习的笔记。
<!--more-->
## 认识JavaScript ##
JS是目前主流浏览器唯一支持的脚本语言，由以下三部分组成：

（1）ECMAScript:语言基础（核心）。

ECMA-262标准规定了ECMAScript这门语言的组成部分，例如语法、类型、语句、关键字、保留字、操作符、对象。

Web浏览器只是ECMAScript实现可能的宿主环境之一，其他宿主环境还包括Node(一种服务端JavaScript平台)和Adobe Flash。

（2）DOM（Document Object Model,文档对象模型）

通过DOM可以操作HTML元素，包括删除、添加、替换、修改节点等。DOM将整个HTML文档映射为一个多层节点结构，即DOM树。

（3）BOM（Browser Object Model,浏览器对象模型）

通过BOM获取一些浏览器的信息，以及控制浏览器的一些行为。
## 引入JavaScript ##
有三种方式可以在HTML文档里引入JavaScript。

（1）行内方式。即直接在HTML元素的属性上应用js代码。

例如以下代码中button元素的onclick属性，点击button就会弹出消息框并显示“hello"。
	
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8"/>
		<title>JavaScript引入</title>
	</head>
	<body>
		<button id="helloBtn" onclick="alert('hello');">点击弹出消息框</button>
	</body>
	</html>

但这种方式不建议使用。一是因为这种方式针对一些用户的事件触发js执行，局限性较大。二是html文档中掺杂js代码会显得文档很乱，背离了结构应与样式、行为相分离的原则。

（2）内嵌方式。即通过一对<script></script>标签在html文档中插入js代码。

	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8"/>
		<title>JavaScript引入</title>
	</head>
	<body>
		<button id="helloBtn" >点击弹出消息框</button>
		<sript>
			var helloBtn = documnet.getElementById("helloBtn");
			helloBtn.onclick = function() {
				alert("hello");
			}
		</script>
	</body>
	</html>
此种方式也有缺点。例如在不同页面使用上述<script></script>标签之间这段js代码时，即在不同页面使用同一段js代码会有冗余。根据场景判断是否使用该方式。

（3）外链方式。即将js代码从html文档中提取出来单独形成一个.js文件，并在html文档中引入这个.js文件。

例如将方法（2）中<script></script>标签之间这段js代码提取出来，保存在一个hello.js文件中，并在html文件中引入。

	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8"/>
		<title>JavaScript引入</title>
	</head>
	<body>
		<button id="helloBtn">点击弹出消息框</button>
		<script type="text/javascript" src="hello.js"></script>
	</body>
	</html>
根据场景判断是否使用该方式。
## 变量 ##
（1）语法:

	var 变量名
变量名区分大小写，首字母必须是字母、下划线或者$，非关键字和保留字。
例如，`var name = "bottle";`

（2）全局变量和局部变量：

使用var定义的变量可能是全局变量也可能是局部变量，取决于是否在一个function中。如在function中使用var定义一个变量message，此变量即为一个局部变量。局部变量在function外面访问不到。若在function内不使用var定义变量message，则在函数外可以访问到该变量。

使用var定义
	
	function test() {
		var message = "hi";//定义一个局部变量
	}
	test();
	alert(message);//错误，找不到变量message
不使用var定义
	
	function test() {
		message = "hi";//定义一个全局变量
	}
	test();
	alert(message);//hi

使用控制台console来调试js代码。alert()弹出一个提示框。console.log()打印。

利用sources里面的snippets来观察变量。如下所示。

![1](/images/next-js/1.png)

局部变量测试结果如下所示。

![2](/images/next-js/2.png)

![3](/images/next-js/3.png)

全局变量测试结果如下所示。

![4](/images/next-js/4.png)

![5](/images/next-js/5.png)
## 数据类型 ##
1、基本数据类型

（1）字符串类型String

（2）数字类型Number

（3）布尔类型Boolean ,取值true或false

（4）Null

（5）Undefined

2、复杂数据类型/引用数据类型 Object

**怎样判断数据类型**

在浏览器控制台可使用type of 操作符来判断以下数据类型。

	typeof 1//"number"
	typeof 'a'//"string"
	typeof true//"boolean"
	typeof undefined//"undefined"
	typeof null//"object" (这个比较特殊)
	typeof {}//"object"
	typeof function(){};//"function"
判断数据类型的几个例子如下。

![6](/images/next-js/6.png)
## Object对象 ##
1、创建对象

（1）使用对象字面量{}创建杯子对象。（推荐，简洁明了）

	var bottle = {
		name: "bottle", //key: value
		price: 49, 
		isKeepWarm: true 
	}
对象的每一个属性都可以用对应的键值对(key: value)来描述，其中key为任一合法字符，value为任意数据类型。如果属性名包含多个中间含空格的字符，要用引号包含起来。

（2）使用Object构造函数创建杯子对象。

	var bottle = new Object();
	bottle.name = "bottle";
	bottle.price = 49;
	bottle.isKeepWarm = true;
2、对象属性读操作

（1）使用点操作符 `console.log(bottle.name);//"bottle"`（推荐）

（2）使用中括号操作符 `console.log(bottle["name"]);//"bottle"`（如果对象属性名即key包含空格时，必须使用中括号操作符）
## 函数 ##
1、函数的定义

（1）函数声明

	function 函数名（参数1，参数2，...）{
		函数体
		return ;
	}
函数声明的特点，在相同作用域下，不管在何处声明都可以调用的到。即使声明在调用之后。

（2）函数表达式

	var 变量 = function(参数1，参数2，...){
		函数体
		return ;
	}
函数表达式的调用必须在函数表达式声明之后。这是区别于函数声明的地方。
## 作用域 ##
![7](/images/next-js/7.png)

如上图所示，bottles是在函数之外声明的，是全局作用域的一个变量，所以在函数内部可以访问到bottles。而函数内部（函数作用域）声明的num为局部变量，只可以在函数内部被访问到，在函数外部无法获取。
## 流程控制 ##
（1）if语句
	
	if(条件) {
		执行语句1;
	}
	else{
		执行语句2;
	}
（2）switch语句

	swith(n){
		case 0: 执行语句1；
		case 1: 执行语句2;
		...
		
	}
## 字符串的有关操作 ##
### 分割字符串 split ###
split()方法可以把字符串分割为字符串数组。

	"2:3:4:5".split(":")    // 将返回 ["2", "3", "4", "5"]
	
	"|a|b|c".split("|")    // 将返回 ["", "a", "b", "c"]
### 截取字符串 substring ###
substring() 方法用于提取字符串中介于两个指定下标之间的字符。语法：`str.substring(indexStart, [indexEnd])`
	
	var str = 'Hello World!';
	console.log(str.substring(3)); // 将返回 lo world!
### 字符串转换大写 toUpperCase() ###
toUpperCase() 方法用于把字符串转换为大写。
	
	var str = 'Hello World!';
	console.log(str.toUpperCase()); // 将返回 HELLO WORLD!

### 题目 ###
完善函数 convertToCamelCase 的功能。函数 convertToCamelCase 会转换传入的字符串参数 string 为驼峰格式，并返回转换后的字符串。具体要求如下：

- 参数 string 是以中划线（-）连接单词的字符串，需将第二个起的非空单词首字母转为大写，如 -webkit-border-radius 转换后的结果为 webkitBorderRadius。

- 返回转换后的字符串

解决方法：
	
	function convertToCamelCase(str){
	    var strSplit = str.split("-");//转换为字符串数组
	    if(strSplit[0] === ""){ //如果第一个字符串为空的话，左移删掉，否则的话不变
	        strSplit.shift();
	    }
	    for(var i = 1; i < strSplit.length; i++){
	            var letter = strSplit[i].charAt(0);//取得字符串数组中每个字符串的首字母
	            //使用replace方法将每个字符串的首写字母大写
	            strSplit[i] = strSplit[i].replace(letter, function replace(letter){
	                return letter.toUpperCase();
	            });
	      
	    }  
	    return strSplit.join("");//join方法串接起字符串
	}
	convertToCamelCase("-ni-hao-a");

还可以使用**正则表达式**的方法。

	function convertToCamelCase(str) {
	  return str.replace(/\-[a-z]/g , function(a, b){
	      return b == 0 ? a.replace('-','') : a.replace('-','').toUpperCase();
	  });
	}