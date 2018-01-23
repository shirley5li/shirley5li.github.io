---
title: CSS3 calc()的使用
date: 2018-01-23 20:15:51
tags: [CSS3]
categories: CSS3
---
参考转自博客[CSS3的calc()使用](https://www.w3cplus.com/css3/how-to-use-css3-calc-function.html)。
<!--more-->
### 为什么使用calc() ###
平时在制作页面的时候，总会碰到有的元素是100%的宽度。众所周知，如果元素宽度(这里的宽度是盒模型content的宽度)为100%时，其自身不带其他盒模型属性设置还好，要是有别的（比如添加了padding和border），那将导致盒子撑破。

比如说，有一个边框，或者说有margin和padding，这些都会让你的盒子撑破。我们换句话来说，如果你的元素宽度是100%时，只要你在元素中添加了border,padding,margin任何一值，都将会把元素盒子撑破（标准模式下，除IE怪异模式）。这样一来就会相当的麻烦，平时我们碰到这样的现象时，也是相当的谨慎，有时甚至无法解决，只能通过改变结构来实现。就算你通过繁琐的方法实现了，但有于浏览器的兼容性而导致最终效果不一致。虽然前面介绍的CSS3属性中的box-sizing在一定程度上解决这样的问题，其实今天的calc()函数功能实现上面的效果来得更简单。
### 什么是calc() ###
calc()是css3的一个新增的功能，用来指定元素的长度。比如说，你可以使用calc()给元素的border、margin、pading、font-size和width等属性设置动态值。为何说是动态值呢?因为我们使用的表达式来得到的值。不过calc()最大的好处就是用在流体布局上，可以通过calc()计算得到元素的宽度。
### calc() 能做什么 ###
calc()能让你给元素的做计算，你可以给一个div元素，使用百分比、em、px和rem单位值计算出其宽度或者高度，比如说 `width: calc(50% + 2em);`，这样一来你就不用考虑元素DIV的宽度值到底是多少，而把这个烦人的任务交由浏览器去计算。
### calc()语法 ###
	.element {
	  width: calc(expression);
	}
其中"expression"是一个表达式，用来计算长度的表达式。
### calc()运算规则 ###
calc()使用通用的数学运算规则，但是也提供更智能的功能：

- 使用“+”、“-”、“*” 和 “/”四则运算；
- 可以使用百分比、px、em、rem等单位；
- 可以混合使用各种单位进行计算；
- 表达式中有“+”和“-”时，其前后必须要有空格，如`widht: calc(12%+5em);`这种没有空格的写法是错误的；
- 表达式中有“*”和“/”时，其前后可以没有空格，但建议留有空格。
### 浏览器兼容性 ###
浏览器对calc()的兼容性还算不错，在IE9+、FF4.0+、Chrome19+、Safari6+都得到较好支持，同样需要在其前面加上各浏览器厂商的识别符，不过可惜的是，移动端的浏览器还没仅有“firefox for android 14.0”支持，其他的全军覆没。
大家在实际使用时，同样需要添加浏览器的前缀

	 .element {
		/*Firefox*/
		-moz-calc(expression);
		/*chrome safari*/
		-webkit-calc(expression);
		/*Standard */
		calc();
	 }

通过上面的了解，大家对calc()不在那么陌生，但对于实际的运用可能还是不太了解，那么大家就接下来跟我一起动手，通过实例来了解他吧。首先我们来看一个最常用的实例：

	<div class="demo">
		 <div class="box"></div>
	</div>	

上面的结构很简单，就是一个div.demo的元素中包含了一个div.box的元素，接下来我们一步一步来看其中的变化。
**第一步：添加普通样式：**

	.demo {
		width: 300px;
		background: #60f;
	}
	.box {
	  width: 100%;
		background: #f60;
		height: 50px;
	}

此时的效果很简单，就是div.box完全遮盖了div.demo，如下图所示：

![calc-step1](http://www.w3cplus.com/sites/default/files/201202/css3-calc-step1.jpg)

**第二步，在div.box上添加border和padding**

这一步很棘手的事情来了，在div.box上添加10px的内距padding，同时添加5px的border：

	.demo {
		width: 300px;
		background: #60f;
	}
	.box {
	  width: 100%;
	  background: #f60;
	  height: 50px;
	  padding: 10px;
	  border: 5px solid green;
	}

为了更好的说明问题，我在div.demo上添加了一个 `padding：3px 0;`

	.demo {
		width: 300px;
		background: #60f;
	padding: 3px 0;	
	}
	.box {
	  width: 100%;
	  background: #f60;
	  height: 50px;
	  padding: 10px;
	  border: 5px solid green;
	}

这个时候大家不知道能否想到问题会发生在哪？其实很简单，这个时候div.box的宽度大于了其容器div.demo的总宽度，从而撑破容器伸出来了，如图所示：

![calc-step2](http://www.w3cplus.com/sites/default/files/201202/css3-calc-step2.jpg)

**第三步，calc()的运用**

为了解决撑破容器的问题，以前我们只能去计算div.box的宽度，用容器宽度减去padding和border的值，但有时候，我们苦于不知道元素的总宽度，比如说是自适应的布局，只知道一个百分值，但其他的值又是px之类的值，这就是难点，死卡住了。随着CSS3的出现，其中利用box-sizing来改变元素的盒模型类型实使实现效果，但今天我们学习的calc()方法更是方便。

知道总宽度是100%，在这个基础上减去boder的宽度（5px * 2 = 10px）,在减去padding的宽度（10px * 2 = 20px），即"100% - (10px + 5px) * 2 = 30px" ，最终得到的值就是div.box的width值：

	.demo {
		width: 300px;
		background: #60f;
		padding: 3px 0;
	}
	.box {
		background: #f60;
		height: 50px;
		padding: 10px;
		border: 5px solid green;
	width: 90%;/*写给不支持calc()的浏览器*/
		width:-moz-calc(100% - (10px + 5px) * 2);
		width:-webkit-calc(100% - (10px + 5px) * 2);
		width: calc(100% - (10px + 5px) * 2);
	}

这样一来，通过calc()计算后，div.box不在会超出其容器div.demo的宽度，如图所示：

![calc-step3](http://www.w3cplus.com/sites/default/files/201202/css3-calc-step3.jpg)
### 采用calc()方法的自适应布局demo ###
在这个布局中，采用了自适应布局。整个布局包含了“头部”、“主内容”、“边栏”和“脚部”，并且“主内容”居左，“边栏”靠右。html结构如下：

	<!-- 头部 -->
    <div id="header">我是头部</div>
    <!-- 内容区容器 -->
    <div class="wrapper">
        <!-- 主内容 -->
        <div id="main">我是主内容区</div>
        <!-- 右边栏 -->
        <div id="accessory">我是右边栏</div>
    </div>
    <!-- 脚部 -->
    <div id="footer">我是脚部</div>
**1、在body中设置一个内距，并附上一些基本的样式**

	body {
	    background: #E8EADD;
	    color: #3C323A;
	    padding: 20px; 
	}

**2、设置主容器“wrapper”的样式**

主容器的宽度是“100% - 20px * 2”,并且水平居中：

		.wrapper {
	    width: 1024px; /* Fallback for browsers that don't support the calc() function */
	    width: -moz-calc(100% - 40px);
	    width: -webkit-calc(100% - 40px);
	    width: calc(100% - 40px);
	    margin: auto; 
	}

给不支持calc()的浏览器设置了一个固定宽度值“1024px”。

**3、给header和footer设置样式**

这个例子中的header和footer很简单，给他们添加了一个内距为20px，其他就是一些基本的样式设置，那么其对应的宽度应该是`100% - 20px * 2`

	#header {
	    background: #f60;
	    padding: 20px;
	    width: 984px;/*Fallback for browsers that don't support the calc() function*/
	    width: -moz-calc(100% - 40px);
	    width: -webkit-calc(100% - 40px);
	    width: calc(100% - 40px);
	}
	#footer {
	    clear:both;
	    background: #000;
	    padding: 20px;
	    color: #fff;
	    width: 984px;/* Fallback for browsers that don't support the calc() function */
	    width: -moz-calc(100% - 40px);
	    width: -webkit-calc(100% - 40px);
	    width: calc(100% - 40px);
	}

**4、给主内容设置样式**

给主内容设置了一个8px的边框，20px的内距，并且向左浮动，同时设置了一个向右的外边距“20”px，关键之处，我们主内容占容器宽度的75%，这样一来，主内容的宽度应该是`75% - 8px * 2 - 20px * 2`

	#main {
	    border: 8px solid #B8C172;
	    float: left;
	    margin-bottom: 20px;
	    margin-right: 20px;
	    padding: 20px;
	    width: 704px; /* Fallback for browsers that don't support the calc() function */
	    width: -moz-calc(75% - 20px * 2 - 8px * 2);
	    width: -webkit-calc(75% - 20px * 2 - 8px * 2);
	    width: calc(75% - 20px * 2 - 8px * 2); 
	}

**5、设置右边栏样式**

给边栏设置了一个25%的宽度，其除了包含8px的边框，10px的内距外，还有主内容外距20px也要去掉，不然整个宽度与容器会相差20px,换句话说就会撑破容器掉下来。因此边栏的实际宽度应该是`25% - 10px * 2 - 8px * 2 -20px`

	#accessory {
	    border: 8px solid #B8C172;
	    float: right;
	    padding: 10px;
	    width: 208px; /* Fallback for browsers that don't support the calc() function */
	    width: -moz-calc(25% - 10px * 2 - 8px * 2 - 20px);
	    width: -webkit-calc(25% - 10px * 2 - 8px * 2 - 20px);
	    width: calc(25% - 10px * 2 - 8px * 2 - 20px);
	}

完整代码见[github](https://github.com/shirley5li/someDemosForExercise)。

另附一篇[移动端页面布局](https://www.cnblogs.com/mracale/p/7170385.html)，讲得比较好。