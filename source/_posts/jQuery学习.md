---
title: jQuery学习
date: 2018-03-28 09:02:51
tags: [jQuery]
categories: jQuery
---
JQuery是一个轻量级的JavaScript库。核心是JavaScript，不仅兼容CSS3，还兼容各种浏览器。
<!--more-->
# jQuery对象与DOM对象 #
jQuery对象与DOM对象是不一样的。jQuery对象是一个类数组对象，而DOM对象就是一个单独的DOM元素。

**如何把jQuery对象转成DOM对象？** (1)利用数组下标的方式读取到jQuery中的DOM对象 (2)通过jQuery自带的get()方法，例如`$div.get(0)。

**DOM对象转化成jQuery对象** 传递给$(DOM)函数的参数是一个DOM对象，jQuery方法会把这个DOM对象给包装成一个新的jQuery对象，就可以调用jQuery的方法了。

# jQuery各种选择器 #
**id选择器：** `$("#id")`

**类选择器：** `$(".class")`

**元素选择器：** `$("element")`

**全选择器：** `$("*")`

**层级选择器：** 子选择器`$("parent > child")`、 后代选择器`$("ancestor descendant")`、 相邻兄弟选择器`$("pre + next")`、 一般兄弟选择器`$("pre ~ siblings")`

**基本筛选选择器：**

![基本筛选选择器](http://ou3oh86t1.bkt.clouddn.com/jQuery%E5%AD%A6%E4%B9%A0/images/jq%E5%9F%BA%E6%9C%AC%E7%AD%9B%E9%80%89%E9%80%89%E6%8B%A9%E5%99%A8.png)

**内容筛选选择器：** 

![内容筛选选择器](http://ou3oh86t1.bkt.clouddn.com/jQuery%E5%AD%A6%E4%B9%A0/images/%E5%86%85%E5%AE%B9%E7%AD%9B%E9%80%89%E9%80%89%E6%8B%A9%E5%99%A8.png)

**可见性筛选选择器：** `$(":visible")`与`$(":hidden")`。:hidden选择器，不只包括display:none的元素，还包括隐藏表单、visibility等。

![隐藏元素](http://ou3oh86t1.bkt.clouddn.com/jQuery%E5%AD%A6%E4%B9%A0/images/%E9%9A%90%E8%97%8F%E5%85%83%E7%B4%A0.png)

**属性选择器：** 

![属性选择器](http://ou3oh86t1.bkt.clouddn.com/jQuery%E5%AD%A6%E4%B9%A0/images/%E5%B1%9E%E6%80%A7%E9%80%89%E6%8B%A9%E5%99%A8.png)

**子元素筛选选择器：** 

![子元素筛选选择器](http://ou3oh86t1.bkt.clouddn.com/jQuery%E5%AD%A6%E4%B9%A0/images/%E5%AD%90%E5%85%83%E7%B4%A0%E7%AD%9B%E9%80%89%E9%80%89%E6%8B%A9%E5%99%A8.png)

**表单元素选择器:** 

![表单元素选择器](http://ou3oh86t1.bkt.clouddn.com/jQuery%E5%AD%A6%E4%B9%A0/images/%E8%A1%A8%E5%8D%95%E5%85%83%E7%B4%A0%E9%80%89%E6%8B%A9%E5%99%A8.png)

**表单对象属性筛选选择器:**

![表单对象属性筛选选择器](http://ou3oh86t1.bkt.clouddn.com/%E8%A1%A8%E5%8D%95%E5%AF%B9%E8%B1%A1%E5%B1%9E%E6%80%A7%E7%AD%9B%E9%80%89%E9%80%89%E6%8B%A9%E5%99%A8.png)

**this选择器:**

	$('p').click(function() {
		//将p元素转化为jQuery对象
		var $this = $(this);
		$this.css('color', 'red');
	});

# 操作jQuery DOM的方法 #
1、 .attr()与.removeAttr()

2、 .html()及.text()

3、 .val()处理表单元素的值

4、 .addClass() .removeClass() 增加增加/删除类名改变样式

5、 .toggleClass() 切换样式

6、  .css() 样式操作

7、  .data() 数据存储，类似于原生DOM通过自定义属性data-来传递数据

8、 通过 `$("html结构")`创建节点

9、 .append()与 .appendTo()、 .prepend()与 .prependTo() DOM内部插入

10、 .after()与 .before()、 .insertAfter()与.insertBefore() DOM外部插入

11、 .empty()只清空指定元素所有子节点

12、 .remove() 会将自身也移除，可传递一个筛选表达式

13、 .detach() 临时删除页面上的节点，但是又不希望节点上的数据与事件丢失，事件及数据不删除，仅显示效果不在，在内存中还存在

14、 .clone() 克隆节点，深复制

15、 .replaceWith()和.replaceAll() DOM替换

16、 .wrap() /.wrapAll() 将元素用其他元素包裹起来，也就是给它增加一个父元素

17、 .unwrap() 将匹配元素集合的父级元素删除，保留自身（和兄弟元素，如果存在）在原来的位置

18、 .wrapInner()  将合集中的元素内部所有的子元素用其他元素包裹起来，并当作指定元素的子元素

19、 .children() 查找合集里面的第一级子元素

20、 .find() 查找后代元素

21、 .parent()  查找合集里面的每一个元素的父元素

22、 .parents() 查找合集里面的每一个元素的所有祖辈元素

23、 .closest() 查找当前元素的最近的父辈祖辈元素

24、 .next() 查找指定元素集合中每一个元素紧邻的后面同辈元素的元素集合

25、 .prev() 查找指定元素集合中每一个元素紧邻的前面同辈元素的元素集合

26、 .siblings() 查找指定元素集合中每一个元素的同辈元素

27、 .add() 用来创建一个新的jQuery对象 ，将元素添加到匹配的元素集合中

28、 .each() 

# jQuery事件 #

1、 click与dbclick 鼠标点击

	$("#ele").click(function() {
	
	});
	//传递数据进去
	$("#ele").click([eventData,] function() {
	
	});

2、 mousedown与mouseup、 mousemove、 mouseover与mouseout、 mouseenter与mouseleave

3、 hover

4、 focusin与focusout(支持冒泡)、 blur与focus(不支持冒泡)

5、 change 用于监听`<input>`元素，`<textarea>`和`<select>`元素的值

6、 select 当 textarea 或文本类型的 input 元素中的文本被选择时触发

7、 submit

8、 keydown()与keyup()、 keypress()

9、 on() 多事件绑定，所有的快捷事件在底层的处理都是通过一个"on"方法来实现。支持事件委托。

	$("#ele").click(function() { //快捷方式
	
	});
	$("#ele").on('click', function() { //on方式
	
	});

10、 off() 卸载事件

**11、 jQuery事件对象的属性和方法**

	event.type //获取事件类型
	event.pageX 和event.pageY //获取鼠标当前相对于页面的坐标
	event.preventDefault() //阻止默认行为
	event.stopPropagation() //阻止事件冒泡
	event.which  //单击的鼠标的哪个键
	event.currentTarget //在冒泡过程中的当前DOM元素
	event.target //事件的目标DOM元素

12、 自定义事件 trigger(会冒泡)。 trigger除了能够触发浏览器事件，同时还支持自定义事件，并且自定义事件还支持传递参数。

13、 自定义事件 triggerHandler(不冒泡)

# 动画方法 #
1、 .hide("fast/slow")

2、 .show()

3、 .toggle()

4、 .slideDown() 下拉动画

5、 .slideUp() 上卷动画

6、 .slideToggle() 上卷下拉切换

7、 .fadeIn()、 .fadeOut() 淡入淡出动画, opacity为0-1

8、 .fadeTo()可以到自定义的opacity

9、 .fadeToggle() 切换淡入淡出

10、 .animate() 动画

11、 .stop() 停止动画

# 其他常用方法 #
1、 .inArray() 查找数组中的索引 `$.inArray(value, array [, fromIndex])`

2、 .trim() 去空格

3、 .get()  单独操作合集中的的某一个元素，可以通过.get([index])方法获取到。

4、 .index() 从匹配的元素中搜索给定元素的索引值