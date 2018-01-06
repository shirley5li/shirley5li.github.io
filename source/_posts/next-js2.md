---
title: JS笔记(二)DOM操作--from next十天训练营
date: 2017-10-20 20:21:29
tags: [JavaScript]
categories: JavaScript
---
JS调用DOM接口修改样式。
<!--more-->
## DOM简介 ##
![1](/images/next-js2/1.png)

上图是一张网页的生成过程，大致分为五步：

（1）html代码转化为DOM树

（2）CSS代码转化成CSSOM（CSS Object Model）

（3）结合DOM和CSSOM，生成一棵渲染树（包含每个节点的视觉信息）

（4）生成布局（layout），即将所有渲染树的所有节点进行平面合成

（5）将布局绘制（paint）在屏幕上

"生成布局"（flow）和"绘制"（paint）这两步，合称为"渲染"（render）。

其中，在html文档生成DOM树后，JS可以通过DOM提供的接口来添加、删除、修改元素和样式。
## DOM查找 ##
查找API:

	document.getElementById()//通过元素id查找，查找一个元素
	
	[document|Element].getElementsByClassName()//通过元素类名查找，查找一组元素，得到一个类数组(html collection)
	
	[document|Element].getElementsByTagName()//通过元素标签名查找,查找一组元素，得到一个类数组
	
	[document|Element].querySelector()//通过CSS选择器查找，例如 var qId = document.querySelector('#id');
	
	[document|Element].querySelectorAll()//通过CSS选择器查找

后两者常用。
## DOM新增和删除 ##
（1）新增节点
新增一个元素时，包括插入和追加。前面插入用insertBefore()，后面追加用appendChild()。
	
	parent.appendChild(element)//新增节点到父元素的末尾
	
	parentElement.insertBefore(newElement, targetElement)//新增节点到targetElement元素的前面

注意：使用.insertBefore()方法时，不必搞清楚父元素到底是哪个，因为targetElement元素的parentNode属性值就是它。所以可以通过`targetElement.parentNode.insertBefore(newElement, targetElement)`来插入。

新增多个元素时，可以利用上述两个方法结合循环实现，但循环会导致一个问题，因为直接操作DOM会导致浏览器反复渲染。利用DocumentFragment节点解决这个反复渲染问题。

**DocumentFragment**文档片段，可以理解为“轻量级”的节点。有两个属性，分别为：nodeType = 11, nodeName = #document-fragment。
DocumentFragment作为仓库来使用，不在DOM树中，游离在DOM树之外。当增加多个节点时，可将这多个节点临时存放在DocumentFragment仓库中，最后再一次性插入DOM树中，就解决了浏览器反复渲染的问题。

（2）删除节点
删除节点使用removeChild()

（3）创建节点

此时创建出的节点即为DocumentFragment文档碎片，创建完以后再插入或者追加到DOM树中。
	
	document.createElement(nodeName)//创建元素节点,nodeName即为h1,h2,li,p,....
	
	document.creatTextNode(text)//创建文本节点
**练习题**

题目要求:现有 HTML 代码如下,

	<body>
	    <h1>按要求新增元素</h1>
	</body>

在h1元素的后面新增一个ul元素，ul元素中有一百个li元素，li的内容就是 1-100 ，如下所示：
	
	<body>
	    <h1>按要求新增元素</h1>
	    <ul>
	        <li>1</li>
	        <li>2</li>
	        <li>3</li>
	        ......
	        <li>98</li>
	        <li>99</li>
	        <li>100</li>
	    </ul>
	</body>
js代码如下：

	 var len = 100;
	 var ul = document.createElement('ul');
	 var body = document.getElementsByTagName('body')[0];
	 for(var i = 0; i < len; i++){
	     var li = document.createElement('li');
	     var liText = document.createTextNode(i+1);
	     li.appendChild(liText);
	     ul.appendChild(li);
	     
	 } 
	 body.appendChild(ul);
## DOM修改样式 ##
两种方式修改元素样式：通过元素style属性修改；通过元素class属性修改。

（1）style属性

style属性包含着元素诸如颜色大小等样式，style属性是一个对象。如访问style对象的color属性：`element.style.color`。

注意：当引用一个中间带减号的CSS属性时，DOM要求用驼峰命名法。CSS属性font-family变为了DOM属性fontFamily：`element.style.fontFamily`。这是因为减号和加号之类的操作符是保留字，不允许用在函数或变量的名字里，意味着也不能用在方法和属性的名字里。

缺点：style属性只能返回内嵌样式。即只有把CSS style属性插入到标记里，才可以用DOM style属性去获取那些属性信息。DOM style属性不能用来检索外部CSS文件里声明的样式。

（2）class属性

利用DOM修改元素的class属性（比如新增一个class或者删除一个class），使得利用外部CSS文件中的设置的样式改变元素的样式，而不是用DOM直接操作style属性修改样式。

例如要给要给elem元素设置class属性为intro，方法如下：

**a.**利用setAttribute()方法, `elem.setAttribute("class","intro")`

**b.**通过更新className属性。className属性是一个可读可写的属性，凡是元素节点都有这个属性。可以用className属性获取一个元素的class属性，`element.className`。

用className属性和赋值操作符设置一个元素的class属性：`element.className = value`

该方法的**不足**，通过className属性设置某个元素的class属性时将替换该元素原有的属性（而不是追加）。

**在需要给一个元素追加新的class时，可以按照以下思路：**

检查className属性的是否为null；

如果是，把新的class设置值直接赋值给className属性；

若不是，把一个空格和新的class设置值追加到className属性上去。

把上述步骤封装为一个函数addClass,该函数有两个参数，第一个为需要添加的新class的元素，第二个是新的class设置值。

	function addClass(element, value){
		if(!element.className){
			element.className = value;
		}else{
			newClassName = element.className;
			newClassName+= " ";
			newClassName+=value;
			element.className = newClassName;
		}
	}
## 事件模型 ##
	<!DOCTTYPE html>
	<html lang="zh-CN">
	<head>
		<meta charset="UTF-8"/>
		<title>事件简介</title>
	</head>
	<body>
		<section>
			<button id="button">点击切换背景颜色</button>
		</section>
	</body>
	</html>
针对上述代码，当点击了button后事件反应机制有两种(这两种是上古时代的做法 。 。)

第一种是点击button后，button将事件传递到section，再传递到body，再传递到html，再传递到document。该种方式即为事件冒泡机制。
如下图所示：

![2](/images/next-js2/2.png)

第二种是点击button后，从document开始一层层捕获，即为事件捕获机制。如下图所示。

![3](/images/next-js2/3.png)

目前**标准的DOM事件流**做法分为三个阶段：事件捕获阶段、处于目标阶段、事件冒泡阶段。

事件捕获阶段的结束阶段为目标元素的父元素，然后是处于目标阶段，接下来是事件冒泡阶段。在实际开发过程中，由于浏览器兼容问题，事件捕获过程基本不用，会频繁使用目标和事件冒泡。流程如下所示。

![4](/images/next-js2/4.png)
## 事件处理程序 ##
**添加**事件处理程序：

	element.addEventListener(type, handle, false)//type表示事件类型，handle为事件处理函数，false表示采用冒泡机制
**删除**事件处理程序：

	element.removeEventListener(type, handle)

例如：

	h1.addEventListener('click', function(){
		console.log(this);//this指向绑定事件处理函数的对象，即h1元素
	}, false);
**事件对象**

事件对象包含着所有与事件相关的信息。

	var h1 = document.querySelector('h1');
	var handle = function(event) {   //event即为事件处理对象，包括了触发点击事件时鼠标的位置等等信息
		console.log('event', event);  //将event对象打印出来并查看event对象包含哪些信息
	}
	h1.addEventListener('click', handle, false);
**事件冒泡**

	var h1 = document.querySelector('h1');
	var handle = function(event) {   
		console.log('event', event);  
	}
	document.body.addEventListener('click', handle, false);//将点击事件函数绑定在body上
虽然点击事件绑定在body上，但此时点击h1元素，仍会触发事件打印event对象。此为事件冒泡。

流程：当点击目标元素h1，先找h1上有没有点击事件，有则触发，没有则按照冒泡机制一层层往上找，看有没有点击事件，直到冒泡到document。

阻止事件冒泡：

	var h1 = document.querySelector('h1');
	var handle = function(event) {   
		console.log('event', event);  
	}
	document.body.addEventListener('click', handle, false);//将点击事件函数绑定在body上
	h1.addEventListener('click' function(event) {
	event.stopPropagation();//阻止事件冒泡，当点击h1元素时，不会触发点击事件
	}, false);
