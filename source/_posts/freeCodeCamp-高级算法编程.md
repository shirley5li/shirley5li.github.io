---
title: freeCodeCamp JavaScript高级算法编程学习总结
date: 2017-11-26 11:07:43
tags: [Algorithm, JavaScript]
categories: JavaScript
---
几个 freeCodeCamp JS高级算法编程例题的学习总结。
<!--more-->
## Validate US Telephone Numbers ##
**题目：**如果传入字符串是一个有效的美国电话号码，则返回 true.

用户可以在表单中填入一个任意有效美国电话号码. 下面是一些有效号码的例子(还有下面测试时用到的一些变体写法):

    555-555-5555
    (555)555-5555
    (555) 555-5555
    555 555 5555
    5555555555
    1 555 555 5555
在本节中你会看见如 800-692-7753 or 8oo-six427676;laskdjf这样的字符串. 你的任务就是验证前面给出的字符串是否是有效的美国电话号码. 区号是必须有的. 如果字符串中给出了国家代码, 你必须验证其是 1. 如果号码有效就返回 true ; 否则返回 false.

**tips:**[RegExp](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp)

**实现**

	function telephoneCheck(str) {
	  //^1?表示以1开头，1匹配0次或1次
	  //\s?表示空白字符匹配0次或1次
	  //\d{3}匹配一个0-9的数字三次
	  //\(\d{3}\)匹配（一个0-9的数字三次），比上面多一个括号，左右括号分别需要加上转义字符\
	  //[ -]?表示空格或者连字符-匹配0次或1次
	  //\d{4}$表示已4位数字结尾($)
	  var re=/^1?\s?(\d{3}|\(\d{3}\))[ -]?\d{3}[ -]?\d{4}$/;
	  return re.test(str);
	}
	telephoneCheck("1 555)555-5555");//返回false
## Symmetric Difference ##
**题目：**创建一个函数，接受两个或多个数组，返回所给数组的 对等差分(symmetric difference) (△ or ⊕)数组.

给出两个集合 (如集合 A = {1, 2, 3} 和集合 B = {2, 3, 4}), 而数学术语 "对等差分" 的集合就是指由所有只在两个集合其中之一的元素组成的集合(A △ B = C = {1, 4}). 对于传入的额外集合 (如 D = {2, 3}), 你应该安装前面原则求前两个集合的结果与新集合的对等差分集合 (C △ D = {1, 4} △ {2, 3} = {1, 2, 3, 4}).

**tips:**[Array.reduce()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)

**实现**

	function sym(args) {
	  //将多个参数合并为一个数组arr
	  var arr = [];
	  for(var i = 0; i < arguments.length; i++) {
	    arr.push(arguments[i]);
	  }
	  //也可以使用Array.from()将输入参数合并为一个数组
	  //var arr = Array.from(arguments);
	  
	  //temp为所有项都没同时出现在两个相邻数组的数组，但temp内部可能有重复元素，因为单个数组内部可能元素重复
	  //pre是前一个数组，cur是当前数组
	  var temp = arr.reduce(function(prev, cur, index) {
	    //a数组由prev数组在cur中没有出现过的元素组成
	    var a = prev.filter(function(item) {
	      return cur.indexOf(item) < 0;
	    });
	    //b数组由cur数组在prev中没有出现过的元素组成
	    var b = cur.filter(function(item){
	      return prev.indexOf(item) < 0;
	    });
	    //合并a和b作为新的prev
	    return a.concat(b);
	  });
	  //对temp去重
	  return temp.filter(function(item, index, array){
	    return array.indexOf(item) == index;
	  });
	}
	sym([1, 2, 3], [5, 2, 1, 4]);
## Exact Change ##

**题目：**设计一个收银程序 checkCashRegister() ，其把购买价格(price)作为第一个参数 , 付款金额 (cash)作为第二个参数, 和收银机中零钱 (cid) 作为第三个参数.

cid 是一个二维数组，存着当前可用的找零.

当收银机中的钱不够找零时返回字符串 "Insufficient Funds". 如果正好则返回字符串 "Closed".否则, 返回应找回的零钱列表,且由大到小存在二维数组中.

**tips:**[Global Object](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object)

**思路：**输入为商品价格，实际付款，收银机零钱的余额。然后返回值有三种，如果找不开返回"Insufficient Funds"；如果正好找开，收银机余额空了，返回"Closed"；其余则返回找零的数组。

先将美元的各面额存入数组，对面额数组由大到小遍历，如果待找零钱大于该面额且该面额在收银机中存在的话，则进行该面额的找零操作，否则进入下一面额的找零操作。本面额的找零操作过程为：先根据待找零钱计算出该面额需要的张数，如果待找零钱>=该面额的总值，则将该面额的钱全部给出，然后待找零钱更新，将该面额的找零结果输出；如果待找零钱小于该面额的总值，则从该面额总值中给出需要找出的那几张，然后更新待找零钱，输出该面额的找零结果。

**实现**

	function checkCashRegister(price, cash, cid) {
	  var change = cash - price;//待找零钱数目
	  var denominationArr = [0.01, 0.05, 0.1, 0.25, 1, 5, 10, 20, 100];//将不同面额存入数组，对应于cid[i][0]
	  var total = 0;//用来记录收银机总共的零钱数
	  var money = change;//将待找零钱数change备份，因为下面找零过程中会更新change
	  var resultArr = [];//用来输出找零列表
	  //从大面额到小面额遍历
	  for(var i = cid.length - 1; i >= 0; i--) {
	    total += cid[i][1];//记录收银机的总钱数
	    //如果待找零钱大于等于某个面额，并且该面额的钱数大于0，则需要给出该面额的零钱
	    if(change > denominationArr[i] && cid[i][1] > 0) {//denominationArr[i] 表示第i种面额钱的面值，cid[i][1]表示收银机中该面额的总额
	      //num表示需要给出的该面额的数量   
	      var num = parseInt(change / denominationArr[i]);
	      //如果change需要的第i种面额的钱数大于等于收银机中该面额的实际钱数，则将收银机中该面额的钱全部给出,更新change和resultArr
	      if(denominationArr[i] * num >= cid[i][1]) {
	        change -= cid[i][1];
	        resultArr.push(cid[i]);
	      } else {
	        //否则change需要的第i种面额的钱小于收银机中该面额的实际钱数，则找出change需要的该面额数目，更新change和resultArr
	        change -= denominationArr[i] * num;
	        resultArr.push([cid[i][0], denominationArr[i] * num]);
	      }
	      //操作过程中会使得change变为一个无限小数，因此使用.toFixed(2)方法保留两位小数
	      change = change.toFixed(2);//四舍五入保留两位小数
	    }
	  }  
	  //如果收银机中的总钱数正好等于待找零钱数，返回"Closed" 
	  if(total=== money) {
	     return "Closed";
	  }
	  //如果收银机中的总钱数不够找，或者不能正好找整即change不能最后更新到0，则返回"Insufficient Funds"
	  else if(total < money || (change-0) !== 0) { //使用(cahnge-0)将0.00转化为0   
	    return "Insufficient Funds";
	    }
	  return resultArr;
	}
	checkCashRegister(3.26, 100.00, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.10], ["QUARTER", 4.25], ["ONE", 90.00], ["FIVE", 55.00], ["TEN", 20.00], ["TWENTY", 60.00], ["ONE HUNDRED", 100.00]]);
	//返回[["TWENTY", 60.00], ["TEN", 20.00], ["FIVE", 15], ["ONE", 1], ["QUARTER", 0.50], ["DIME", 0.20], ["PENNY", 0.04]]
**注意：** js计算浮点数精度不准确容易导致一些小问题，老是有几个测试例子通不过，使用.toFixed(2)方法四舍五入保留两位小数，但该方法也不严谨。具体见博客[关于js浮点数计算精度不准确问题的解决办法](https://www.cnblogs.com/xinggood/p/6639022.html)。

另外由于`change = change.toFixed(2)`，使得找零完毕后`change="0.00"`，因此使用(cahnge-0)将0.00转化为0，否则使用严格不等`change！==0`是错误的，因为0.00和0不完全相等。当然若不使用 `(change-0) !== 0`，也可以使用不严格不等`change != 0`。
## Inventory Update ##
**题目：**依照一个存着新进货物的二维数组，更新存着现有库存(在 arr1 中)的二维数组. 如果货物已存在则更新数量 . 如果没有对应货物则把其加入到数组中，更新最新的数量. 返回当前的库存数组，且按货物名称的字母顺序排列.

**tips:**[Global Array Object](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array)

**实现**

	function updateInventory(arr1, arr2) {
	   //将现有库存的货物名称存入数组curGoodsArr
	  var curGoodsArr = [];
	  for(var i = 0; i < arr1.length; i++) {
	    curGoodsArr.push(arr1[i][1]);
	  }
	  for(var j = 0; j < arr2.length; j++) {
	    //若现有库存中没有新进货物类型，则将新货物名称和数量一并添加到库存数组，名称需按字母顺序排序
	    //将新货物名称追加到数组curGoodsArr,再对数组排序。sort()方法在原数组上排序，不生成副本
	    if(curGoodsArr.indexOf(arr2[j][1]) === -1) {
	      //注意push()方法可向数组的末尾添加一个或多个元素，返回新的长度。注意是长度，不是返回新的数组！！！
	      curGoodsArr.push(arr2[j][1]);
	      //给货物名称按字母排序
	      curGoodsArr.sort();
	      //找到该新货物名称在排序后出现在curGoodsArr数组中的索引，该索引值也是新货物应该出现在库存数组中的顺序
	      var indexNewGoods = curGoodsArr.indexOf(arr2[j][1]);
	      //将新货物名称和数量一并插入到库存数组,使用.splice()方法,该方法会改变原始数组
	      arr1.splice(indexNewGoods, 0, [arr2[j][0], arr2[j][1]]);
	    }
	    //如果现有库存货物中已经新进货物的类型，则更新库存数量
	    else {
	      //index为已有货物在库存货物名称数组中的索引，也即货物在库存数组中出现的顺序
	      var index = curGoodsArr.indexOf(arr2[j][1]);
	      //更新库存数量，即等于原来的库存数量+新进的数量
	      arr1[index][0] =arr1[index][0] + arr2[j][0];
	    }    
	  }  
	    return arr1;
	}
	// 仓库库存示例
	var curInv = [
	    [21, "Bowling Ball"],
	    [2, "Dirty Sock"],
	    [1, "Hair Pin"],
	    [5, "Microphone"]
	];
	var newInv = [
	    [2, "Hair Pin"],
	    [3, "Half-Eaten Apple"],
	    [67, "Bowling Ball"],
	    [7, "Toothpaste"]
	];
	updateInventory(curInv, newInv);//返回[[88, "Bowling Ball"], [2, "Dirty Sock"], [3, "Hair Pin"], [3, "Half-Eaten Apple"], [5, "Microphone"], [7, "Toothpaste"]]
## No repeats please ##
**题目：**把一个字符串中的字符重新排列生成新的字符串，返回新生成的字符串里没有连续重复字符的字符串个数.连续重复只以单个字符为准。

例如, aab 应该返回 2 因为它总共有6中排列 (aab, aab, aba, aba, baa, baa), 但是只有两个 (aba and aba)没有连续重复的字符 (在本例中是 a).

**考察全排列**

**tips:**[Permutations](https://www.mathsisfun.com/combinatorics/combinations-permutations.html) [RegExp](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/RegExp) [全排列算法原理和实现](https://www.cnblogs.com/nokiaguy/archive/2008/05/11/1191914.html)

**实现**

	//求一个字符串的全排列字符串中，不含连续重复字符的字符串个数
	function permAlone(str) {
	  //将输入字符串转化为数组
	  strArr = str.split("");
	  //求该字符串数组的全排列形式
	  permResultArr = [];
	  perm(strArr, 0, strArr.length-1);
	  //找出全排列后非连续重复的字符串个数
	  var count = 0;
	  for(var i = 0; i < permResultArr.length; i++) {
	    if(conRepCharacter(permResultArr[i])) {
	      count += 1;
	    }
	  }
	  return count;
	}
	
	//判断一个字符串是否含连续重复的字符，若不包含连续重复字符，则返回true
	function conRepCharacter(str) {
	  if(str.length === 1) {
	    return true;
	  }
	  for(var i = 0; i < str.length-1; i++) {
	    if(str[i+1] === str[i]) {
	      return false;
	    }
	  }
	  return true;
	}
	
	//交换数组中两个字符的位置
	function swapCharacter(arr, i, j) {
	  var temp = arr[i];
	  arr[i] = arr[j];
	  arr[j] = temp;
	  return arr;
	}
	
	//求给定字符串数组的全排列,其中strArr表示输入字符串转化成的数组，flag表示递归到哪一位，end表示递归结束的位即字符串长度减1
	function perm(strArr, flag, end) {
	  //递归结束输出结果
	  if(flag === end) {
	    permResultArr.push(strArr.join(""));
	  }
	  for(var i = flag; i <= end; i++) {
	    //将字符串中的所有字母分别与第一个字母交换
	    strArr = swapCharacter(strArr, flag, i);
	    //对交换后的字符串继续递归排列，由于第一个字母已经排列，因此从一个字母开始排列，即flag+1
	    perm(strArr, flag+1, end);
	    //由于在进入到下一次循环时序列是被改变了，可如果要假定第一个字母的所有可能性的话，必须是建立在这些序列的初始状态一致的情况下
	    //因此通过再次交换恢复之前的排列顺序
	     strArr = swapCharacter(strArr, flag, i);  
	  }
	  return permResultArr;
	}
	permAlone("abc");//返回6
## Friendly Date Ranges ##
**题目：**把常见的日期格式如：YYYY-MM-DD 转换成一种更易读的格式。
易读格式应该是用月份名称代替月份数字，用序数词代替数字来表示天 (1st 代替 1).

如果一个日期区间里结束日期与开始日期相差小于一年，则结束日期就不用写年份了；在这种情况下，如果月份开始和结束日期如果在同一个月，则结束日期月份也不用写了。另外, 如果开始日期年份是当前年份，且结束日期与开始日期小于一年，则开始日期的年份也不用写。

例如:包含当前年份和相同月份的时候，makeFriendlyDates(["2017-01-02", "2017-01-05"]) 应该返回 ["January 2nd","5th"]。不包含当前年份，makeFriendlyDates(["2003-08-15", "2009-09-21"]) 应该返回 ["August 15th, 2003", "September 21st, 2009"]。

考虑清楚所有可能出现的情况，包括传入的日期区间是否合理。对于不合理的日期区间，直接返回 undefined 即可。

**tips:**[String.split()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/split) [String.substr()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/substr) [parseInt()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/parseInt)

**实现**

	function makeFriendlyDates(arr) {
	  var resultArr = [];
	  //开始日期数组
	  var startArr = arr[0].split("-");
	  //结束日期数组
	  var endArr = arr[1].split("-");
	  
	  //开始日期的年月日
	  var sYear = parseInt(startArr[0], 10);
	  var sMonth = parseInt(startArr[1], 10);
	  var sDay = parseInt(startArr[2], 10);
	  //结束日期的年月日
	  var eYear = parseInt(endArr[0], 10);
	  var eMonth = parseInt(endArr[1], 10);
	  var eDay = parseInt(endArr[2], 10);
	  
	  //开始日期与结束日期之间相差的天数
	  var distDays = (eYear-sYear)*365 + (eMonth-sMonth)*30 + eDay-sDay;
	  
	  //获取当前日期的年份
	  var currDate = new Date();
	  var currYear = currDate.getFullYear();
	  
	  //月份字符串数组
	  var monthsArr = ["January","February","March","April","May","June","July","August","September","October","November","December"];
	  //日字符串数组
	  var daysArr = ["1st","2nd","3rd","4th","5th","6th","7th","8th","9th","10th","11th","12th","13th","14th","15th","16th","17th","18th","19th","20th","21st","22nd","23rd","24th","25th","26th","27th","28th","29th","30th","31st"];
	  //先判断日期区间是否合理,若不合理返回undefined
	  if(distDays < 0) {
	    return "undefined";
	  }
	  //如果开始日期和结束日期一样，则返回一个
	  if(sYear === eYear && sMonth === eMonth && sDay === eDay) {
	    resultArr = [monthsArr[sMonth-1] + " " + daysArr[sDay-1] + ", " + sYear];
	    return resultArr;
	  }
	  //如果开始日期年份是当前年份,结束日期与开始日期相差小于一年，月份开始和结束日期如果在同一个月，则开始日期年份、结束日期年份和月份也不用写了
	  if(currYear === sYear && distDays < 365 && sMonth === eMonth) {
	    resultArr = [monthsArr[sMonth-1] + " "+ daysArr[sDay-1], daysArr[eDay-1]];
	    return resultArr;
	  }
	  //如果开始日期年份是当前年份,结束日期与开始日期相差小于一年，月份开始和结束日期不在同一个月,则开始日期年份、结束日期年份不用写了
	  if(currYear === sYear && distDays < 365 && sMonth !== eMonth) {
	    resultArr = [monthsArr[sMonth-1] + " " + daysArr[sDay-1], monthsArr[eMonth-1] + " " + daysArr[eDay-1]];
	    return resultArr;
	  }
	  //如果开始日期年份不是当前年份,结束日期与开始日期相差小于一年，月份开始和结束日期在同一个月,则结束日期年份和月份不用写了
	  if(currYear !== sYear && distDays < 365 && sYear === eYear && sMonth === eMonth) {
	    resultArr = [monthsArr[sMonth-1] + " " + daysArr[sDay-1] + ", " + sYear, daysArr[eDay-1]];
	    return resultArr;
	  }
	  //如果开始日期年份不是当前年份,结束日期与开始日期相差小于一年，月份开始和结束日期不在同一个月,则结束日期年份不用写了
	  if(currYear !== sYear && distDays < 365 && sYear !== eYear && distDays > 30) {
	    resultArr = [monthsArr[sMonth-1] + " " + daysArr[sDay-1] + ", " + sYear, monthsArr[eMonth-1] + " " + daysArr[eDay-1]];
	    return resultArr;
	  }
	   //如果开始日期年份不是当前年份,结束日期与开始日期相差大于等于一年
	  if(distDays >= 365) {
	    resultArr = [monthsArr[sMonth-1] + " " + daysArr[sDay-1] + ", " + sYear, monthsArr[eMonth-1] + " " + daysArr[eDay-1] + ", " + eYear];
	    return resultArr;
	  }
	
	}
	makeFriendlyDates(["2001-12-20", "2001-12-20"]);//返回["December 20th, 2001"]

## Make a Person ##
**题目：**用下面给定的方法构造一个对象.

方法有 getFirstName(), getLastName(), getFullName(), setFirstName(first), setLastName(last), and setFullName(firstAndLast).

所有有参数的方法只接受一个字符串参数.所有的方法只与实体对象交互.

**tips:**[Closures](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Closures) [Details of the Object Model](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Details_of_the_Object_Model)

**实现**

	var Person = function(firstAndLast) {
	  this.getFirstName = function() {
	    var arr = firstAndLast.split(" ");
	    return arr[0];
	  };
	  this.getLastName = function() {
	    var arr = firstAndLast.split(" ");
	    return arr[1];
	  };
	  this.getFullName = function() {
	    return firstAndLast;
	  };
	  this.setFirstName = function(first) {
	    var arr = firstAndLast.split(" ");
	    arr[0] = first;
	    firstAndLast = arr.join(" ");
	  };
	  this.setLastName = function(last) {
	    var arr = firstAndLast.split(" ");
	    arr[1] = last;
	    firstAndLast = arr.join(" ");
	  };
	  this.setFullName = function(firstAndLast2) {
	    firstAndLast = firstAndLast2;
	  };
	    
	};
	var bob = new Person('Bob Ross');
	bob.getFirstName();//返回"Bob"
## Map the Debris ##
**题目：**返回一个数组，其内容是把原数组中对应元素的平均海拔转换成其对应的轨道周期.原数组中会包含格式化的对象内容，像这样 {name: 'name', avgAlt: avgAlt}.

求得的值应该是一个与其最接近的整数，轨道是以地球为基准的.

地球半径是 6367.4447 kilometers, 地球的GM值是 398600.4418, 圆周率为Math.PI

**tips:**[Math.pow()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Math/pow) [Math.round()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Math/round)

**实现**

	function orbitalPeriod(arr) {
	  var GM = 398600.4418;
	  var earthRadius = 6367.4447;
	  
	  //轨道周期公式 T=2π√(a^3/GM)
	  for(var i = 0; i < arr.length; i++) {
	    //a为轨道半径，等于地球半径加平均海拔
	    var  a = earthRadius + arr[i].avgAlt;
	    var T1 = Math.sqrt(4 * Math.pow(Math.PI, 2) * Math.pow(a, 3) / GM);
	    //将求得的周期转化为整数
	    var T = Math.round(T1);
	    //删除原有属性海拔
	    delete arr[i].avgAlt;
	    //添加新的属性轨道周期
	    arr[i].orbitalPeriod = T;
	  }  
	  return arr;
	}
	orbitalPeriod([{name : "sputnik", avgAlt : 35873.5553}]);//返回[{name: "sputnik", orbitalPeriod: 86400}]
## Pairwise ##
**题目：**举个例子：有一个能力数组[7,9,11,13,15]，按照最佳组合值为20来计算，只有7+13和9+11两种组合。而7在数组的索引为0，13在数组的索引为3，9在数组的索引为1，11在数组的索引为2。

所以我们说函数：pairwise([7,9,11,13,15],20) 的返回值应该是0+3+1+2的和，即6。

**tips:**[Array.reduce()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)自己没有用上reduce()方法

**实现**

	function pairwise(arr, arg) {
	  var sumIndex = 0;
	  for(var i = 0; i < arr.length; i++) {
	    //与当前元素应该配对的元素值
	    var pairVal = arg - arr[i];
	    //配对元素应有的索引值,配对元素不能为自己
	    var pairIndex = arr.indexOf(pairVal);
	    //如果找到与当前元素配对的，则将这一对的索引值累加，并将当前元素和与之配对的元素值置为-1
	    if(pairIndex !== -1 && pairIndex !== i) {
	      arr[i] = -1;
	      arr[pairIndex] = -1;
	      sumIndex += i + pairIndex;
	    }
	  }
	  return sumIndex;
	}
	pairwise([1, 3, 2, 4], 4);//返回1

