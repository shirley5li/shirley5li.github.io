---
title: 2018春季腾讯研发岗在线模拟笔试
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
