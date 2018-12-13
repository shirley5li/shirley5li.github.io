---
title: 2018春招研发岗在线模拟笔试编程题总结
date: 2018-03-24 14:52:04
tags: [Algorithm , JavaScript]
categories: JavaScript
---
2018春季腾讯研发岗在线模拟笔试算法题目总结。
<!--more-->

### 给出四个点的坐标判断是否为正方形 ###
思路：暴力方法，求出任意两点之间的距离，如果有四条相等，剩下两条距离相等，则构成正方形。

``` js
        //给出四个点的坐标，判断这四个点能否构成一个正方形，其中四个点的横坐标存在x数组中，与横坐标对应的纵坐标存在y数组中
        function judgeSquare(x, y) { 
            var dists = []; //用来存放四边形任意两点之间的距离
            for (var i = 0; i < 4; i++) {
                for (var j = i + 1; j < 4; j++) {
                    var dist = distance(x[i], y[i], x[j], y[j]);
                    dists.push(dist);
                }
            }
            dists = dists.sort();
            if (dists[0] === dists[1] && dists[1] === dists[2] && dists[2] === dists[3] && dists[4] === dists[5]) {
                console.log('Yes, this is a square!');
            }

        }
		
		// distance表示两点之间距离的平方
        function distance(x1, y1, x2, y2) { //参数x1,y1和x2,y2分别表示两个点的横纵坐标
            var distance = Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2);
            return distance;
        }
        var xArr = [0, 2, 2, 0];
        var yArr = [0, 2, 0, 2];
        judgeSquare(xArr, yArr); //Yes, this is a square!
```

### 2^k面值的n组合问题 ###
问题描述：（记不清了，大概是这样,k和n的上限也记不得了，只记录下实现思路）有面值分别为2^k的硬币各2枚(k>=0，且k为整数)，现在要买n元的东西，问有多少种不同的硬币组合方式？

思路：从最小面额的开始考虑，

(1)如果给出的n元是偶数，那么又分为花掉面额为1的(如果花掉面额为1的肯定是花掉2个)，和不花掉面额为1的。

如果花掉两个面额为1的，那么问题的规模就缩小为求n-2的组合情况(即n-2要用2，4，8...来组合，因为此时1已经用光了)，又因为n-2也是个偶数，所以可以对半分，即(n-2)/2用1，2，4，8...来组合，可以用递归了。

如果不花掉面额为1的，那么从面额2开始花起，又n为偶数，所以问题的规模可以对半分为，求n/2用 1，2，4，8...来组合，可以用递归了。

(2)如果给出的n元是奇数，那么肯定要花掉一个面额为1的，那么n-1是个偶数，此时已经不能再花面额为1的了，即n是奇数的时候只能花掉一个面额为1的，所以问题规模就变成了n-1用面额为2，4，8...来组合，即问题规模折半为(n-1)/2用1，2，4，8...来组合，可以用递归了。

``` js
        function combination(n) {
            // 初始条件
            // if (n === 1) {
            //     return 1;
            // }
            // if (n === 2) {
            //     return 2;
            // }
            if (n <= 2) {
                return n;
            }
            // 先判断n的奇偶性
            if (n % 2 === 0) { //n为偶数
                return combination((n - 2) / 2) + combination(n / 2);
            } else {
                return combination((n - 1) / 2);
            }
        }
        combination(12); //5
```

### 头条： 打印一行数字的字符串形式 ###
思路：将0-9的数字的打印形式保存成一个二维数组，例如num[0]中保存了数字0一到第五行的打印字符串形式，然后一行一行的打印（总共打印五行，因为每个数字用五行字符串描述），每一行由给出的数组中的数字的第i行的字符串形式拼接起来再打印。

``` js
    //将0-9的数字的打印形式保存成一个二维数组，例如num[0]中保存了数字0一到第五行的打印字符串形式
    var num = [['66666', '6...6', '6...6', '6...6', '66666'],
               ['....6', '....6', '....6', '....6', '....6'],
               ['66666', '....6', '66666', '6....', '66666'],
               ['66666', '....6', '66666', '....6', '66666'],
               ['6...6', '6...6', '66666', '....6', '....6'],
               ['66666', '6....', '66666', '....6', '66666'],
               ['66666', '6....', '66666', '6...6', '66666'],
               ['66666', '....6', '....6', '....6', '....6'],
               ['66666', '6...6', '66666', '6...6', '66666'],
               ['66666', '6...6', '66666', '....6', '66666']];
    var numArr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]; //测试数组
    // 一行一行的打印，每个数字用五行表示，每两个数字之间用两个点点分隔开
    for (var i = 0; i < 5; i ++) {
        var resultStr = ''; //保存每一行结果的字符串
        // 将第numArr中的numArr.length个数字的第i行拼接起来并打印
        for (var j = 0; j < numArr.length; j ++) {
            resultStr += num[numArr[j]][i] + '..';
        }
        // 每一行最后会多两个点点，截取掉
        var len = resultStr.length - 2;
        console.log(resultStr.substring(0, len));
    }
	//打印结果
	66666......6..66666..66666..6...6..66666..66666..66666..66666..66666
	6...6......6......6......6..6...6..6......6..........6..6...6..6...6
	6...6......6..66666..66666..66666..66666..66666......6..66666..66666
	6...6......6..6..........6......6......6..6...6......6..6...6......6
	66666......6..66666..66666......6..66666..66666......6..66666..66666
```

### 百词斩： 找一个字符串中包含的最大数 ###
问题描述： 给出一个字符串，例如`'helloworld520helloworld1314'`，找出字符串中包含的最大数字，即输出为`1314`。

思路：利用正则表达式，先把字符串中的连续数字子串提取出来放到数组中，然后再求这个数字字符串数组中的最大数字。

注意：正则表达式的全局标志`g`一定要加上，不然只会找到第一个匹配。

``` js
    function searchMaxNum(str) {
    var reg = /([0-9]+)/g; //正则表达式，匹配字符串中的连续数字子串，并使用String的match方法将捕获组返回至numArr数组中
    var numArr = string.match(reg); //numArr中的元素类型为字符串，即numAr为数字字符串数组
    var maxNum = numArr[0] - 0; //将数字字符串转换为数值类型

    for (var i = 0; i < numArr.length; i ++) { //找出numArr数字字符串数组中的最大值
        var tempNum = numArr[i] - 0;
        if (tempNum >= maxNum) {
            maxNum = tempNum;
        }
    }
    console.log(maxNum);
}
var string = 'helloworld520helloworld1314';
searchMaxNum(string); //返回 1314

```

### 百词斩: 压缩连续数字1-7 ###
问题描述： 给出一个由数字1-7组成的有序数字字符串(分别代表星期一~星期天)，若这个数字字符串有三个或三个以上连续的数字，例如`234`，则返回其压缩形式`2-4`(由该段连续数字的首尾中间加一根短横线组成)，若连续的数字长度小于等于二，则将该数字直接返回就好，不用压缩。

例如给定输入 `124567`，则输出为`1,2,4-7`。 若给定输入`12`，则输出为`1,2`。

思路：(1)如果给定的字符串长度小于等于2，则直接在这段字符串中间加一个逗号 `,`返回即可。

(2)若给定的字符串长度大于2，先将数字字符串转化为数字数组，再将该数组中连续的数字提取出来放到一个二维数组中，再将数组中字符串元素处理拼接。即判断该二维数组中元素的长度，若数组中元素的长度小于2，则直接加逗号拼接，若元素长度大于2，则写成压缩形式(用该元素的首尾再加短横线)拼接。

``` js
function compressStr(str) {
        var resultStr = ''; //压缩后的字符串，即输出结果

        if (str.length <= 2) { //如果输入字符串长度<=2，则直接中间加逗号返回
            resultStr = str.split("").join(",");
            console.log(resultStr);
        } else { //输入字符串长度>=3
            // 先将数字字符串转化为数值类型并存进数组
            var numArr = [];
            for (var i = 0; i < str.length; i ++) {
                numArr.push(str[i] - 0);
            }

            // 将数组numArr中的连续数字提取出来放进一个二维数组
            var twoDimArr = extractContinuity(numArr);

            // 处理二维数组twoDimArr
            for (var i = 0; i < twoDimArr.length; i ++) {
                var len = twoDimArr[i].length; //二维数组元素的长度
                if (len <= 2) {
                    resultStr = resultStr + twoDimArr[i].join(',') + ',';
                } else {
                    resultStr = resultStr + twoDimArr[i][0] + '-' + twoDimArr[i][len-1] + ',';
                }
            }
            resultStr = resultStr.substring(0, resultStr.length - 1); //去掉最后多出的一个逗号
            console.log(resultStr);
        }
    }

    // 判断一个数组的数字是否连续，将连续的数字提取出来转化为一个二维数组
    // 例如[3, 4, 13 ,14, 15, 17, 20, 22] 转化为 [[3,4],[13,14,15],[17],[20],[22]]
    function extractContinuity(arr) {
        var result = [];
        var temp;
        while (temp = arr.shift()) {
            if (result.length === 0) { //如果二维数组为空，则直接将arr的第一个数字push进该二维数组
                result.push([temp]);
                continue;
            }

            var element = result[result.length - 1]; //二维数组中的最后一个元素
            if (temp === element[element.length - 1] + 1) {
                element.push(temp);
            } else {
                result.push([temp]);
            }
        }
        return result;
    }
    var string = '12367';
    compressStr(string); //输出 '1-3,6,7'
```
### 百词斩： 给出一组数字的从小到大的全排列形式 ###
问题描述：给出一个数字数组，数组里的数字各不相同，例如[3, 1, 5],给出这几个数字的全排列并按从小到大的形式输出，即输出为 135,153,315,351,513,531。

思路：从数组的数字里面任意选一个，放在第一项,然后将剩下的数字递归全排。

``` js
function fullSort(arr)  {
    var arr = arr.sort(); //先将数组排序
    var result = [];
    if (arr.length === 1) {
        result.push(arr);
        return result;
    }

    for (var i = 0; i < arr.length; i ++) {
        var temp = [];
        temp.push(arr[i]); //取arr的任意一项放到temp的第一项

        var remain = arr.slice(0); //深复制原数组到remain
        remain.splice(i, 1); //去掉temp中的那一项

        var temp2 = fullSort(remain).concat(); //将剩下的项全排列，返回[[3,5],[5,3]]这样的数据
        for (var j = 0; j < temp2.length; j ++) {
            temp2[j].unshift(temp[0]); //得到[[1,3,5],[1,5,3]]这样的数据
            result.push(temp2[j]);
        }
    }
    return result;
}
var arr = [3, 5, 1];
var resultArr = fullSort(arr);
for (var i = 0; i < resultArr.length; i ++) {
    var num = resultArr[i].join("") - 0;
    console.log(num);
}
//输出结果
135
153
315
351
513
531

```
### 腾讯： node如何开启一个http服务###
```js
// 引入内置http模块
var http = require('http');

// 创建一个简单服务器，访问http://127.0.0.1:1337/,显示Hello World
http.createServer(function(req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Hello World\n');
}).listen(1337, '127.0.0.1');
console.log('Server running at http://127.0.0.1:1337/');
```

### 腾讯： CSS3动画的实现方式有哪些，动手写一下将一个div在1s内移动300px###
有transition和animation动画两种方式，transition过渡动画只定义初始和最终状态，而animation动画可以逐帧设置。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style type="text/css">
        /* transition属性动画结合transform变化属性，实现元素移动一段距离的动画 */
        #transitonDiv:hover {
            transition: all 1s ease-in-out;
            -webkit-transition: all 1s ease-in-out;
            -moz-transition: all 1s ease-in-out;
            -o-transition: all 1s ease-in-out;

            transform: translateX(300px);
            -ms-transform: translateX(300px);
            -moz-transform: translateX(300px);
            -webkit-transform: translateX(300px);
            -o-transform: translateX(300px);
        }

        /* 通过animation属性，实现逐帧动画 */
        #animationDiv:hover {
            animation: animName 1s ease-in-out;
            -webkit-animation: animName 1s ease-in-out;
            -moz-animation: animName 1s ease-in-out;
            -o-animation: animName 1s ease-in-out;
        }
        
        /* 定义关键帧 */
        @keyframes animName {
            0% {
                transform: translateX(0px);
            }
            30% {
                transform: translateX(100px);
            }
            60% {
                transform: translateX(200px);
            }
            100% {
                transform: translateX(300px);
            }
        }
    </style>
</head>
<body>
    <div id="transitonDiv" style="width:40px;height:40px;background-color:red;"></div>
    <div id="animationDiv" style="width:40px;height:40px;background-color:green;"></div>
</body>
</html>
```
### 腾讯： DNS解析过程？若是新申请的域名如何查找DNS?###
DNS是应用层协议，事实上他是为其他应用层协议工作的，包括不限于HTTP和SMTP以及FTP，用于将用户提供的主机名解析为ip地址。具体过程如下：

(1)浏览器缓存: 当用户通过浏览器访问某域名时，浏览器首先会在自己的缓存中查找是否有该域名对应的IP地址（若曾经访问过该域名且没有清空缓存便存在)；

(2)系统缓存： 当浏览器缓存中无域名对应IP则会自动检查用户计算机系统Hosts文件DNS缓存是否有该域名对应IP；

(3)路由器缓存: 当浏览器及系统缓存中均无域名对应IP则进入路由器缓存中检查，以上三步均为客户端的DNS缓存；

(4)ISP（互联网服务提供商）DNS缓存: 当在用户客服端查找不到域名对应IP地址，则将进入ISP DNS缓存中进行查询。比如你用的是电信的网络，则会进入电信的DNS缓存服务器中进行查找；(或者向网络设置中指定的local DNS进行查询，如果在PC指定了DNS的话，如果没有设置比如DNS动态获取，则向ISP DNS发起查询请求)

(5)根域名服务器: 当以上均未完成，则进入根服务器进行查询。全球仅有13台根域名服务器，1个主根域名服务器，其余12为辅根域名服务器。根域名收到请求后会查看区域文件记录，若无则将其管辖范围内顶级域名（如.com）服务器IP告诉本地DNS服务器；

(6)顶级域名服务器: 顶级域名服务器收到请求后查看区域文件记录，若无则将其管辖范围内主域名服务器的IP地址告诉本地DNS服务器；

(7)主域名服务器: 主域名服务器接受到请求后查询自己的缓存，如果没有则进入下一级域名服务器进行查找，并重复该步骤直至找到正确记录；

(8)保存结果至缓存: 本地域名服务器把返回的结果保存到缓存，以备下一次使用，同时将该结果反馈给客户端，客户端通过这个IP地址与web服务器建立链接。

### 腾讯：Ajax请求状态及意义 ###
在javascript里面写AJax的时，最关键的一步是对XMLHttpRequest对象建立监听，即使用“onreadystatechange”方法。监听的时候，要对XMLHttpRequest对象的请求状态进行判断，通常是判断readyState的值为4且http返回状态status的值为200或者304时执行我们需要的操作。readyState 属性表示Ajax请求的当前状态。

```
0 代表未初始化。 还没有调用 open 方法
1 代表正在加载。 open 方法已被调用，但 send 方法还没有被调用
2 代表已加载完毕。send 已被调用。请求已经开始
3 代表交互中。服务器正在发送响应
4 代表完成。响应发送完毕
```
### 腾讯： cookie的操作，读写###
```js
(function(){
 var cookieObj = {
    //修改或是添加cookie
   'add': function(name, value, hours) { 
        var expire = "";
        if(hours != null){
            expire = new Date((new Date()).getTime() + hours * 3600000);
            expire = "; expires=" + expire.toGMTString();
        }    
    document.cookie = name + "=" + escape(value) + expire + ";path=/";
    
    //如果指定域名可以使用如下
    //document.cookie = name + "=" + escape(value) + expire + ";path=/;domain=findme.wang";
   },
   
   //读取cookie
   'get': function(c_name){
        if (document.cookie.length>0) {
            c_start = document.cookie.indexOf(c_name + "=");
            if (c_start != -1) { 
                c_start=c_start + c_name.length+1;
                c_end=document.cookie.indexOf(";",c_start);
                if (c_end == -1) {
                    c_end = document.cookie.length;
                }
                return unescape(document.cookie.substring(c_start,c_end));
            } 
        }
        return "";
   }
 };
 window.cookieObj=cookieObj;
}());
```
