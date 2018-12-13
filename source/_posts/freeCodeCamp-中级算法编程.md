---
title: freeCodeCamp JavaScript中级算法编程学习总结
date: 2017-11-16 21:49:52
tags: [Algorithm, JavaScript]
categories: JavaScript
---
几个 freeCodeCamp JS中级算法编程例题的学习总结。
<!--more-->
## Sum All Numbers in a Range ##
**题目：**传递给一个包含两个数字的数组。返回这两个数字和它们之间所有数字的和。（最小的数字并非总在最前面。）

**tips:** [Math.max()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Math/max) &nbsp;[Math.min()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Math/min)&nbsp;[Array.reduce()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)

**实现1**

	function sumAll(arr) {
	  //获取两个数中的最小值
	  var min = Math.min(arr[0], arr[1]);
	  //获取两个数中的最大值
	  var max = Math.max(arr[0], arr[1]);
	  //将区间里的整数顺序添加到数组里
	  var array = [];
	  for (i = min; i < max + 1; i++) {
	    array.push(i);
	  }
	  //利用.reduce()方法累加数组中的元素并返回
	  var total = array.reduce(function(sum,val) {
	    return sum += val;
	    
	  });
	  return total;
	}
	
	sumAll([1, 4]);
**实现2**
	
	function sumAll(arr) {  
	  var max = Math.max(arr[0],arr[1]);  
	  var min = Math.min(arr[0],arr[1]);  
	  var total = 0;
	  //不使用.reduce()方法实现累加，直接使用for循环实现累加  
	  for(var i = min; i < max + 1; i++) {  
	    total += i;  
	  }  
	  return total;  
	} 
## Diff Two Arrays ##
**题目：**比较两个数组，然后返回一个新数组，该数组的元素为两个给定数组中所有独有的数组元素。换言之，返回两个数组的差异。

**tips：**[Comparison Operators](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Comparison_Operators) &nbsp;[Array.slice()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/slice) &nbsp; [Array.filter()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/filter) &nbsp; [Array.indexOf()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf) &nbsp; [Array.concat()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/concat)

**实现1**

	function diff(arr1, arr2) {
	  var newArr = [];
	  //比较两个数组大小，判断较长的数组中的每个元素是否在短数组中出现过，若没有出现过则.indexOf()方法返回-1
	  if (arr1.length >= arr2.length) {  
	    for (i = 0; i < arr1.length; i++) {
	      if (arr2.indexOf(arr1[i]) === -1) {
	        newArr.push(arr1[i]);
	      }
	    }
	  }
	  for (i = 0; i < arr2.length; i++) {
	    if (arr1.indexOf(arr2[i]) === -1) {
	      newArr.push(arr2[i]);
	    }
	  }
	  
	  return newArr;
	}
	//测试，返回4
	diff([1, 2, 3, 5], [1, 2, 3, 4, 5]);

**实现2**

	function diff(arr1, arr2) {  
	  var newArr = [];  
	  var arr3 = [];  
	  for (var i=0;i<arr1.length;i++) {  
	    if(arr2.indexOf(arr1[i]) === -1)     
	      arr3.push(arr1[i]);  
	  }  
	   var arr4 = [];  
	  for (var j=0;j<arr2.length;j++) {  
	    if(arr1.indexOf(arr2[j]) === -1)  
	      arr4.push(arr2[j]);  
	  }  
	   newArr = arr3.concat(arr4);  
	  return newArr;  
	} 
实现1是自己的想法，只用一次for循环即可得到比较结果。实现2是看到部分博主用的方法。
## Roman Numeral Converter ##	
**题目：**将给定的数字转换成罗马数字。

**tips：**[Roman Numerals](http://www.shuxuele.com/roman-numerals.html) &nbsp; [Array.splice()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/splice) &nbsp; [Array.indexOf()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf) &nbsp; [Array.join()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/join)

**实现1**

	function convert(num) {
	  //只转换小于4000的数字为罗马数字，大于4000的罗马数字上面要加横线，在此暂不考虑转换
	  if (num >= 4000) {
	    console.log("please convert a number less than 4000!");
	  }
	  //将num的各位提取出来，即num = thousands * 1000 + hundreds * 100 + tens * 10 + units;
	  var thousands = Math.floor(num / 1000) ;
	  var hundreds = Math.floor((num % 1000) / 100);
	  var tens = Math.floor((num % 100) / 10);
	  var units = num % 10;
	  var roman = [];
	  //当千位不为0时，将千位转化为罗马数字
	  while (thousands !== 0) {
	    switch(thousands) {
	      case 1: roman.splice(0, 0, "M");
	        break;
	      case 2: roman.splice(0, 0, "M","M");
	        break;
	      case 3: roman.splice(0, 0, "M", "M", "M");
	        break;
	    }
	    thousands = 0;    
	  }
	  // 当百位不为0时，将百位转化为罗马数字
	  while (hundreds !== 0) {
	    // 记录最后一个千位罗马数字索引加一
	    var lastIdxT = roman.length;
	    switch(hundreds) {
	      case 1: roman.splice(lastIdxT, 0, "C");
	        break;
	      case 2: roman.splice(lastIdxT, 0, "C", "C");
	        break;
	      case 3: roman.splice(lastIdxT, 0, "C", "C", "C");
	        break;
	      case 4: roman.splice(lastIdxT, 0, "C", "D");
	        break;
	      case 5: roman.splice(lastIdxT, 0, "D");
	        break;
	      case 6: roman.splice(lastIdxT, 0, "D", "C");
	        break;
	      case 7: roman.splice(lastIdxT, 0, "D", "C", "C");
	        break;
	      case 8: roman.splice(lastIdxT, 0, "D", "C", "C", "C");
	        break;
	      case 9: roman.splice(lastIdxT, 0, "C", "M");
	        break;
	    }
	    hundreds = 0;
	  }
	  // 当十位不为0时，将十位转化为罗马数字
	  while(tens !== 0) {
	    // 记录最后一个百位罗马数字索引加一
	    var lastIdxH = roman.length;
	    switch(tens) {
	      case 1: roman.splice(lastIdxH, 0, "X");
	        break;
	      case 2: roman.splice(lastIdxH, 0, "X", "X");
	        break;
	      case 3: roman.splice(lastIdxH, 0, "X", "X", "X");
	        break;
	      case 4: roman.splice(lastIdxH, 0, "X", "L");
	        break;
	      case 5: roman.splice(lastIdxH, 0, "L");
	        break;
	      case 6: roman.splice(lastIdxH, 0, "L", "X");
	        break;
	      case 7: roman.splice(lastIdxH, 0, "L", "X", "X");
	        break;
	      case 8: roman.splice(lastIdxH, 0, "L", "X", "X", "X");
	        break;
	      case 9: roman.splice(lastIdxH, 0, "X", "C");
	        break;
	    }
	    tens = 0;
	  }
	  // 记录最后一个十位罗马数字索引加一
	  var lastIdxTen = roman.length; 
	  switch(units) {
	    case 1: roman.splice(lastIdxTen, 0, "I");
	      break;
	    case 2: roman.splice(lastIdxTen, 0, "I", "I");
	      break;
	    case 3: roman.splice(lastIdxTen, 0, "I", "I", "I");
	      break;
	    case 4: roman.splice(lastIdxTen, 0, "I", "V");
	      break;
	    case 5: roman.splice(lastIdxTen, 0, "V");
	      break;
	    case 6: roman.splice(lastIdxTen, 0, "V", "I");
	      break;
	    case 7: roman.splice(lastIdxTen, 0, "V", "I", "I");
	      break;
	    case 8: roman.splice(lastIdxTen, 0, "V", "I", "I", "I");
	      break;
	    case 9: roman.splice(lastIdxTen, 0, "I", "X");
	      break;
	  }
	 return roman.join(""); 
	}
	convert(36);
**实现2**

    function convert(num) { 
	  //将分割数和对应的罗马字符分别存入两个数组 
      var nums = [1000,900,500,400,100,90,50,40,10,9,5,4,1];  
      var romans =["m","cm","d","cd","c","xc","l","xl","x","ix","v","iv","i"];  
      var str = "";  
      nums.forEach(function(item,index,array){  
        while(num >= item){  
          str += romans[index];  
          num -= item;  
        }  
      });         
     return str.toUpperCase();  
    }        
    convert(36);  
实现2是来自一位博主[将给定的数字转换为罗马数字](http://blog.csdn.net/qq_37399074/article/details/68922119)，代码精简易懂，自己的实现看起来冗长幼稚，需要学习的还很多哇！
## Where art thou ##
**题目：**写一个 function，它遍历一个对象数组（第一个参数）并返回一个包含相匹配的属性-值对（第二个参数）的所有对象的数组。如果返回的数组中包含 source 对象的属性-值对，那么此对象的每一个属性-值对都必须存在于 collection 的对象中。

例如，如果第一个参数是 `[{ first: "Romeo", last: "Montague" }, { first: "Mercutio", last: null }, { first: "Tybalt", last: "Capulet" }]`，第二个参数是 `{ last: "Capulet" }`，那么你必须从数组（第一个参数）返回其中的第三个对象，因为它包含了作为第二个参数传递的属性-值对。

**tips：**[Global Object](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object)&nbsp;  [Object.hasOwnProperty()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/hasOwnProperty) &nbsp; [Object.keys()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/keys)&nbsp; [Array.prototype.filter()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)

**实现**

	function where(collection, source) {
	var arr = [];
	//获取source对象的所有属性名并保存在数组keys中 
	var keys = Object.keys(source);
	//filter() 方法创建一个新数组, 其包含通过所提供函数测试的所有元素,callback用来测试数组的每个元素，返回true则保留该元素
	arr = collection.filter(function(element) {
	  for(var i = 0; i < keys.length; i++) {
	    if(!element.hasOwnProperty(keys[i]) || element[keys[i]] !== source[keys[i]]) return false;
	  }
	  return true;
	});
	return arr;
	}
	//返回 [{ first: "Tybalt", last: "Capulet" }]
	where([{ first: "Romeo", last: "Montague" }, { first: "Mercutio", last: null }, { first: "Tybalt", last: "Capulet" }], { last: "Capulet" });
## Search and Replace ##
**题目：**使用给定的参数对句子执行一次查找和替换，然后返回新句子。

第一个参数是将要对其执行查找和替换的句子。

第二个参数是将被替换掉的单词（替换前的单词）。

第三个参数用于替换第二个参数（替换后的单词）。

注意：替换时保持原单词的大小写。例如，如果你想用单词 "dog" 替换单词 "Book" ，你应该替换成 "Dog"。

**tips：**[Array.splice()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/splice) [String.replace()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/replace) [Array.join()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/join)

**实现**

	function myReplace(str, before, after) {
	  //获取需被替换的单词before的首字母的位置index，indexOf()方法可返回某个指定的字符串值在字符串中首次出现的位置。  
	  var index = str.indexOf(before);      
	  //判断before首字母是否为大写，若为大写，则让after首字母也大写  
	  if(str[index]===str[index].toUpperCase()){  
	    after = after[0].toUpperCase() + after.substring(1);  //也可以用slice(1)  
	  }
	  //替换，stringObject.replace(regexp/substr,replacement)
	  return str.replace(before, after);  
	}
	/***
	判断字母是否为大写
	function isUpperCase(ch){
	    return ch >= 'A' && ch <= 'Z';
	}
	判断字母是否为小写
	function isLowerCase(ch){
	    return ch >= 'a' && ch <= 'z';
	}
	将单词的首字母大写
	function firstUpperCase(str) {
	  var afterStr = str.toLowerCase().replace(/^\w/g,function(s){return s.toUpperCase();});
	  return afterStr;
	}
	***/
	// charAt()方法可返回字符串指定位置的字符，stringObject.charAt(index)
	myReplace("A quick brown fox jumped over the lazy dog", "jumped", "leaped");
## Pig Latin ##
**题目：**把指定的字符串翻译成 pig latin。

[Pig Latin](https://en.wikipedia.org/wiki/Pig_Latin) 把一个英文单词的第一个辅音或辅音丛（consonant cluster）移到词尾，然后加上后缀 "ay"。

如果单词以元音开始，你只需要在词尾添加 "way" 就可以了。

**tips：**[Array.indexOf()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf) [Array.push()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/push) [Array.join()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/join) [String.substr()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/substr) [String.split()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/split)

**实现1**

	function translate(str) {
	  // 元音
	  var vowel = ['a', 'e', 'i', 'o', 'u'];
	  // 如果单词首字母以元音开头，直接在单词后面加'way'
	  if(vowel.indexOf(str.substr(0,1)) !== -1) {
	    return str + "way";
	  }
	  /*** 只要单词是以辅音或辅音丛开始，将该辅音移到后面，最后加'ay'。
	  while循环每次都检查移动辅音后的单词，移动一个辅音字母后若还不是元音字母，继续移动，移完后再加"ay"***/
	  while(vowel.indexOf(str.substr(0,1)) == -1) {
	    str = str.substr(1) + str.substr(0,1);
	  }
	  return str + "ay";
	}
	translate("glove");//测试数据"california"，"paragraphs"，"algorithm"，"eight"

**实现2**
	
	function translate(str) {
	    var tempArr = [];
	    var answer;
	    tempArr = str.split('');//将str分解为单个字符存入数组
	    var i = 0;
	    //如果首个字符不是元音则 i++，如果首个字符是元音则退出while循环
	    while (tempArr[i] != 'a' && tempArr[i] != 'o' && tempArr[i] != 'i' && tempArr[i] != 'e' && tempArr[i] != 'u') {
	      i++;
	    }
	    answer = str.substr(i);//将str辅音或辅音丛后面的部分提取出来
	    answer += str.substr(0,i);//再将辅音或辅音丛部分追加在answer后
	    //i=0时，首字母为元音，在变换之后加"way"
	    if(i === 0) {
	      answer += "way";
	    }
	    //i不为0时，首字母为辅音或辅音丛，在变换后加"ay"
	    else {
	      answer += "ay";
	    }
	    return answer;
	}
## DNA Pairing ##
**题目：**DNA 链缺少配对的碱基。依据每一个碱基，为其找到配对的碱基，然后将结果作为第二个数组返回。

[Base pairs（碱基对）](https://en.wikipedia.org/wiki/Base_pair) 是一对 AT 和 CG，为给定的字母匹配缺失的碱基。

在每一个数组中将给定的字母作为第一个碱基返回。字母和与之配对的字母在一个数组内，然后所有数组再被组织起来封装进一个数组。例如，对于输入的 GCG，相应地返回 [["G", "C"], ["C","G"],["G", "C"]]

**tips：**[Array.push()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/push) [String.split()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/split)

**实现1**

	function pair(str) {
	  var inputArr = [];
	  var resultArr = [];
	  //将输入字符串按单个字母拆分为数组
	  inputArr = str.split('');
	  //对输入数组的每一种情况配对，GC,CG,AT,TA
	  inputArr.forEach(function(item, index) {
	    switch(item) {
	      case "G":
	        resultArr.push(["G","C"]);
	        break;
	      case "C":
	        resultArr.push(["C","G"]);
	        break;
	      case "A":
	        resultArr.push(["A","T"]);
	        break;
	      case "T":
	        resultArr.push(["T","A"]);
	        break;        
	    }
	  });  
	  return resultArr;
	}
	pair("GCG");//返回 [["G", "C"], ["C","G"],["G", "C"]]
实现2和实现3来自[博客](http://blog.csdn.net/wangmc0827/article/details/72630469)。

**实现2**

解题思路：把字符串进行匹配和对应关系进行匹配，将匹配到的字符推入该数组。最后将所有的数组推入一个新的数组。

匹配方式：用对象存储对应关系。

	function pair(str) {  
	  var obj = {'A':'T','T':'A','G':'C','C':'G'};  
	  var arr = [];  
	  for(var i in str){  
	    arr.push([str[i],obj[str[i]]]);  
	  }  
	  return arr;  
	}  	  
	pair("GCG"); 
**实现3**

用[map](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/map)函数来进行优化,其实就是简化了写法。map函数可以改变原有的数组，给予指定的方法就可以了。

	function pair(str) {  
	  var obj = {'A':'T','T':'A','G':'C','C':'G'};  
	  //ES6 的写法 
	  return str.split('').map(e => [e,obj[e]]);  
	}  	  
	pair("GCG");
ES5 的写法

	function pair(str) {  
	  var obj = {'A':'T','T':'A','G':'C','C':'G'};  
	  return str.split('').map(function(e){   
	    return [e,obj[e]];  
	  });  
	}        
	pair("GCG"); 
## Missing letters ##
**题目：**从传递进来的字母序列中找到缺失的字母并返回它。如果所有字母都在序列中，返回 undefined。

**tips：**[String.charCodeAt()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/charCodeAt) [String.fromCharCode()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/fromCharCode)

**实现**
	
	function fearNotLetter(str) {
	  var resultStr = "";
	  //先判断所有字母是否都在序列中,若都在则返回undefined
	  if((str.charCodeAt(0) + str.length - 1) === str.charCodeAt(str.length - 1) ) {
	    return undefined;
	  } else {
	    //若不然，则根据str每个字母的编码是否连续来返回缺失字母
	    for (i = 0; i < str.length - 1; i++) { 
	      var startCode = str.charCodeAt(i);
	      var nextCode = str.charCodeAt(i + 1);
	      //如果相邻两个字母之间的编码不连续，则将两个字母之间缺失的字母追加到resultStr中
	      while ( nextCode - startCode !== 1) {
	         resultStr += String.fromCharCode(startCode + 1);
	        startCode ++;
	      }     
	    }
	  }  
	  return resultStr;
	}
	fearNotLetter("abce");//返回"d"
	fearNotLetter("abch");//返回"defg"
关于此题目的回答，比较了一些博主的答案，他们的答案大多只满足两个输入相邻字母之间只缺少一个字母的情况，对于缺失多个字母的情况没有考虑。自己的回答考虑到了两个相邻字母之间缺失多个字母的情况。
## Boo who ##
**题目：**检查一个值是否是基本布尔类型，并返回 true 或 false。基本布尔类型即 true 和 false。

**tips:**[Boolean Objects](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Boolean)

**补充：**5种简单数据类型（基本数据类型）：Undefined、Null、Boolean、Number、String。 1种复杂数据类型Object（包括Function、Array、Date等）。

	typeof操作符返回下列某个字符串：
	"undefined"---未定义
	"boolean"---布尔值
	"string"---字符串
	"number"---数值
	"object"---对象或null
	"function"---函数
**实现**

	function boo(bool) {
	  //使用typeof操作符检测数据类型
	  return typeof(bool) === "boolean" ? true : false;//可直接写为 return typeof bool==='boolean';  
	}
	boo(null);//返回false
## Sorted Union ##
**题目：**写一个 function，传入两个或两个以上的数组，返回一个以给定的原始数组排序的但不包含重复值的新数组。

换句话说，新数组中的所有值都应该以原始顺序被包含在内，但是不包含重复值。即非重复的数字应该以它们原始的顺序排序。例如unite([1, 3, 2], [5, 2, 1, 4], [2, 1]) 应该返回 [1, 3, 2, 5, 4]。unite([1, 3, 2], [1, [5]], [2, [4]]) 应该返回 [1, 3, 2, [5], [4]]。

**tips:**[Arguments object](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/arguments) [Array.reduce()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)

**实现1**

	function unite(arr1, arr2, arr3) {
	  //unite函数的输入参数类对象数组arguments
	  for(i = 1; i < arguments.length; i ++) {
	    for (j = 0; j < arguments[i].length; j ++) {
	      //若第i个输入数组的第j个数字在第一个数组中没出现过，则追加到第一个数组中，否则什么也不做
	      if (arr1.indexOf(arguments[i][j]) == -1) {
	        arr1.push(arguments[i][j]);
	      }
	    }
	  }
	  return arr1;
	}
	unite([1, 3, 2], [5, 2, 1, 4], [2, 1]);//返回[1,3,2,5,4]
**实现2**

思路：先将多个输入参数（数组）合并，再去重。来源于[简书](http://www.jianshu.com/p/51301859043c)。

	function unite(arr1, arr2, arr3) {
	  //Array.from() 方法从一个类似数组或可迭代对象中创建一个新的数组实例，即返回[arr1, arr2, arr3]的形式
	  var args = Array.from(arguments);
	  //reduce() 方法对累加器和数组中的每个元素（从左到右）应用一个函数，将其减少为单个值。
	  var arr = args.reduce(function(accumulator,cur){
	    //将多个输入数组合并为一个数组arr,即返回[1,3,2,5,2,1,4,2,1]的形式
	    return accumulator.concat(cur);
	  });
	  var resultArr = [];
	  //对合并后的数组arr去重
	  return resultArr = arr.filter(function(item,index){
	    //返回true则filter到结果数组，indexOf()方法返回第一个匹配元素的index，
	    //后面重复元素的indexOf返回值为该元素第一次出现时的index（比如对第二个2应用indexOf返回2）
	    return arr.indexOf(item) === index;
	  });
	}
## Convert HTML Entities ##
**题目：**将字符串中的字符 &、<、>、" （双引号）, 以及 ' （单引号）转换为它们对应的 HTML 实体。

**tips:**[RegExp](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/RegExp) [HTML Entities](https://dev.w3.org/html5/html-author/charref)

**实现**

	function convert(str) {
	  //替换规则映射对象
	  var entityMap = {  
	    '&' : '&amp;', 
	    '<' : '&lt;',  
	    '>' : '&gt;',  
	    '\"' : '&quot;',  
	    '\'' : '&apos;' ,
	  };
	  //使用string的replace规则，将匹配到的字符根据替换规则替换掉
	  return str.replace(/[&<>"']/g, function(matched) {
	    return entityMap[matched];
	  });  
	}  
	convert("Dolce & Gabbana");//输出结果"Dolce &amp; Gabbana"
## Spinal Tap Case ##
**题目：**将字符串转换为 spinal case。Spinal case 是 all-lowercase-words-joined-by-dashes 这种形式的，也就是以连字符连接所有小写单词。

**tips:**[RegExp](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/RegExp) [String.replace()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/replace)

**实现**

	function spinalCase(str) {
	  //将str分为两类，一类是以空格、下划线、短横线连接的字符串；一类是驼峰形式的字符串
	  //驼峰形式的字符串
	  if(str.split(/\W|_/).length === 1) {
	    for (i = 0; i < str.length; i++) {
	      //找到所有单词的首写大写字母，并用短横线和对应小写替换
	      if (str[i].toUpperCase() === str[i]) {
	        str = str.replace(str[i], "-"+str[i].toLowerCase());
	      }
	    }
	  }
	  //以空格、下划线、短横线连接的字符串，先转换为小写再替换
	  else {
	    //注意匹配模式加上全局标志，否则只会找到第一个匹配
	    str = str.toLowerCase().replace(/\W|_/g, "-");    
	  }
	  return str;
	}
	spinalCase('This Is Spinal Tap');//返回 "this-is-spinal-tap"
	spinalCase("The_Andy_Griffith_Show");//返回 "the-andy-griffith-show"
	spinalCase("Teletubbies say Eh-oh");//返回 "teletubbies-say-eh-oh"
	spinalCase("thisIsSpinalTap");//返回 "this-is-spinal-tap"
## Sum All Odd Fibonacci Numbers ##
**题目：**给一个正整数num，返回小于或等于num的斐波纳契奇数之和。

斐波纳契数列中的前几个数字是 1、1、2、3、5 和 8，随后的每一个数字都是前两个数字之和。

例如，sumFibs(4)应该返回 5，因为斐波纳契数列中所有小于4的奇数是 1、1、3。

提示：此题不能用递归来实现斐波纳契数列。因为当num较大时，内存会溢出，推荐用数组来实现。

**tips:**[Remainder](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_(.25)) [参考文档](http://www.cnblogs.com/meteoric_cry/archive/2010/11/29/1891241.html)

**实现**

	function sumFibs(num) {
	  //先找到所有小于num的斐波那契数，并存在数组fibsArr中
	  var fibsArr = [1, 1, 2];
	  for(i = 2; i < num; i++) {
	    if (fibsArr[i] + fibsArr[i-1] <= num) {
	      fibsArr.push(fibsArr[i] + fibsArr[i-1]);
	    }
	  }
	  //筛选出fibsArr中的奇数并求和
	  var sum = fibsArr.filter(function(element, index) {
	    //若为奇数则返回
	    return element % 2 !== 0;
	  }).reduce(function(prev, curr) {
	    return prev += curr;
	  });
	  return sum;
	}
	sumFibs(1);//返回2
## Sum All Primes ##
**题目：**求小于等于给定数值的质数之和。 给定的数不一定是质数。

只有 1 和它本身两个约数的数叫质数。例如，2 是质数，因为它只能被 1 和 2 整除。1 不是质数，因为它只能被自身整除。

**tips:**[For Loops](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/for) [Array.push()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/push)

**实现**

	//判断一个数是不是素数
	function isPrime(num) {
	  //判断输入是否为number类型，是否为整数
	  if(typeof(num) !== 'number' || !Number.isInteger(num)) {
	    return false;
	  }
	  //num小于2时，不是素数
	  if(num < 2) {return false;}
	  //num等于2时，是素数
	  if(num === 2) {return true;}
	  //num大于2时，如果num可以被2整除（即num为偶数），不是素数
	   else if(num % 2 === 0) {return false;}
	  //num大于2时，依次判断num能否被奇数整除，最大循环为num的开方 
	  var range = Math.ceil(Math.sqrt(num));
	  for(var i = 3; i <= range; i+=2) {
	  if(num % i === 0) {return false;}
	  }
	  return true;
	}
	//求小于等于给定数值的质数之和
	function sumPrimes(num) {
	  var sum = 0;
	  for(var i = 0; i <= num; i ++) {
	    //对于小于num的每个数先判断是否为素数，若为素数则叠加
	    if(isPrime(i)) {
	      sum += i;
	    }
	  }
	  return sum;
	}
	sumPrimes(977);//返回73156
## Smallest Common Multiple ##
**题目：**找出能被两个给定参数和它们之间的连续数字整除的最小公倍数。

范围是两个数字构成的数组，两个数字不一定按数字顺序排序。

例如对 1 和 3 —— 找出能被 1 和 3 和它们之间所有数字整除的最小公倍数。

**tips:**[Smallest Common Multiple](https://www.mathsisfun.com/least-common-multiple.html) [辗转相除法](https://baike.baidu.com/item/%E8%BE%97%E8%BD%AC%E7%9B%B8%E9%99%A4%E6%B3%95/4625352?fr=aladdin)

**思路：**最小公倍数 = 两个数的积 / 最大公约数

最大公约数用辗转相除法（欧几里得算法）求得，即当 `a mod b=0`时，`gcd(a,b)=0`,否则`gcd(a,b)=gcd(b,a mod b)`。

求连续几个数的最小公倍数，可以先求得边界两个数的最小公倍数，再用此最小公倍数依次和中间的数值求最小公倍数，从而得到所有数的最小公倍数。

**实现**

	function smallestCommons(arr) {
	  //首先对两个给定参数排序,按从小到大排序
	  arr.sort(function(a, b) {
	    return a - b;
	  });
	  //求a和b的最小公倍数
	  var a = arr[0];
	  var b = arr[1];
	  //flag表示边界两个数的最小公倍数
	  var flag = smallestCommonMultiple(a, b);
	  //用flag依次和中间的数值求最小公倍数，即得最终的最小公倍数
	  for(var i = a +1; i < b; i ++) {
	    flag = smallestCommonMultiple(flag, i);
	  }
	  return flag;
	}
	//欧几里得算法求两个数的最大公约数,a<=b
	function gcd (a, b) {
	  //当除数为零时，最大公约数为被除数a
	  if(!b) {return a;}
	  //否则辗转相除
	  return gcd(b, a%b);
	}
	//求两个数的最小公倍数
	function smallestCommonMultiple(a, b) {
	  return a * b / gcd(a, b);
	}
	smallestCommons([1,5]);//返回60
## Finders Keepers ##
**题目：**写一个 function，它遍历数组 arr，并返回数组中第一个满足 func 返回值的元素。举个例子，如果 arr 为 [1, 2, 3]，func 为 function(num) {return num === 2; }，那么 find 的返回值应为 2。

**tips:**[Array.filter()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)

**实现**

	function find(arr, func) {
	  var num = 0;
	  //注意filter()方法创建一个新数组, 其包含通过所提供函数实现的测试的所有元素。
	  //而我们只需要返回第一个满足func的元素
	  num = arr.filter(func).length === 0 ? undefined : arr.filter(func)[0];
	  return num;
	}
	find([1, 2, 3, 4], function(num){ return num % 2 === 0; });//返回2
## Drop it ##
**题目：**丢弃数组(arr)的元素，从左边开始，直到回调函数return true就停止。

第二个参数，func，是一个函数。用来测试数组的第一个元素，如果返回fasle，就从数组中抛出该元素(注意：此时数组已被改变)，继续测试数组的第一个元素，如果返回fasle，继续抛出，直到返回true。

最后返回数组的剩余部分，如果没有剩余，就返回一个空数组。

**tips:**[Arguments object](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/arguments) [Array.shift()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/shift) [Array.slice()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/slice)

**实现**

	function drop(arr, func) {
	  //只要func返回false就左移抛出该元素，继续判断左移后的第一个元素是否满足条件
	    while(!func(arr[0])) {
	      //shift() 方法从数组中删除第一个元素，并返回该元素的值。shift()方法会改变原数组
	      arr.shift();
	    }    
	  return arr;
	}
	drop([1, 2, 3], function(n) {return n < 3; });
## Steamroller ##
**题目：**对嵌套的数组进行扁平化处理。你必须考虑到不同层级的嵌套。

**tips:**[Array.isArray()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/isArray)

**实现**

	function steamroller(arr) {
	  //扁平化处理后的数组
	  var afterArr = [];
	  for(var i = 0; i < arr.length; i ++) {
	    //依次判断数组中元素类型是否为数组
	    //如果元素是数组类型，继续对该元素做数组扁平化处理
	    if(Array.isArray(arr[i])) {
	      var midArr = steamroller(arr[i]);
	      afterArr = afterArr.concat(midArr);
	     //如果不是数组类型，则将该元素push进afterArr储存 
	    }else {
	      afterArr.push(arr[i]);        
	      }
	    } 
	  return afterArr;
	}
	steamroller([1, [2], [3, [[4]]]]);//返回[1,2,3,4]
## Binary Agents ##
**题目：**传入二进制字符串，翻译成英语句子并返回。二进制字符串是以空格分隔的。

**tips:**[String.charCodeAt()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/charCodeAt) [String.fromCharCode()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/fromCharCode)

**实现**

	function binaryAgent(str) {
	  var strToArr = [];
	  var afterTrans = "";
	  //将二进制字符串按空格划分为字符串数组，并转化为number类型，十进制形式
	  str.split(" ").forEach(function(item,index) {
	    //将二进制形式转化为十进制形式
	    strToArr.push(parseInt(item, 2));
	  });
	  afterTrans = strToArr.reduce(function(prev, curr) {
	    //将数组中的十进制Unicode码通过String.fromCharCode()方法转换为字母，利用reduce()方法依次处理数组元素并拼接成字符串
	    return prev + String.fromCharCode(curr);
	  },"");
	  return afterTrans;
	}
	binaryAgent("01001001 00100000 01101100 01101111 01110110 01100101 00100000 01000110 01110010 01100101 01100101 01000011 01101111 01100100 01100101 01000011 01100001 01101101 01110000 00100001");//返回"I love FreeCodeCamp!"
## Everything Be True ##
**题目：**完善编辑器中的every函数，如果集合(collection)中的所有对象都存在对应的属性(pre)，并且属性(pre)对应的值为真。函数返回ture。反之，返回false。

记住：你只能通过中括号来访问对象的变量属性(pre)。

**tips:**可以有多种实现方式，最简洁的方式莫过于[Array.prototype.every()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/every)

every 方法为数组中的每个元素执行一次 callback 函数，直到它找到一个使 callback 返回 false（表示可转换为布尔值 false 的值）的元素。如果发现了一个这样的元素，every 方法将会立即返回 false。否则，callback 为每一个元素返回 true，every 就会返回 true。

callback 被调用时传入三个参数：元素值，元素的索引，原数组。

**实现**

	function every(collection, pre) {
	  //使用every() 方法测试数组的所有元素是否都通过了指定函数的测试。
	  var flag = collection.every(function(item, index) {
	    //如果对象不存在pre属性，则返回false
	    if(!item.hasOwnProperty(pre)) {return false;}
	    //测试pre属性的值是否为true
	    if(!item[pre]) {return false;}
	    return true;    
	  });
	  return flag;
	}
	every([{"user": "Tinky-Winky", "sex": "male"}, {"user": "Dipsy", "sex": "male"}, {"user": "Laa-Laa", "sex": "female"}, {"user": "Po", "sex": "female"}], "sex");//返回true
换一种简洁的写法：

	function every(collection, pre) {
	  return collection.every(function(elements){
	    return elements.hasOwnProperty(pre) && Boolean(elements[pre]);
	  });
	}
## Arguments Optional ##
**题目：**创建一个计算两个参数之和的 function。如果只有一个参数，则返回一个 function，该 function 请求一个参数然后返回求和的结果。

例如，`add(2, 3)` 应该返回 5，而 add(2) 应该返回一个 function。调用这个有一个参数的返回的 function，返回求和的结果：`var sumTwoAnd = add(2)`;`sumTwoAnd(3)` 返回 5。如果两个参数都不是有效的数字，则返回 undefined。

**tips:**[Closures](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Closures) [Arguments object](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/arguments)

**实现**

	function add() {
	    //如果add有两个参数，则返回两个参数的和
	    if(arguments.length === 2 && typeof arguments[0] === "number" && typeof arguments[1] === "number") {
	      return arguments[0] + arguments[1];
	    }
	    //如果add有一个参数，则通过闭包方式返回一个函数
	    if(arguments.length === 1 && typeof arguments[0] === "number") {
	      var x = arguments[0];
	      //通过闭包方式返回只有一个参数的函数
	      return function(y) {
	        if(typeof y === "number") {
	          return x + y;}
	        return undefined;
	        };
	    }    
	  return undefined;
	}
	add(2,3);//返回5
	add(2)(3);//返回5
	add(2)([3]);//返回undefined
	add(2, "3");//返回undefined
	add("http://bit.ly/IqT6zt");//返回undefined

 


	
