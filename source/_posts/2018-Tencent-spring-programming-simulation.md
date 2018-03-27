---
title: 2018春招研发岗在线模拟笔试编程题总结
date: 2018-03-24 14:52:04
tags: [js算法题]
categories: js算法题
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

