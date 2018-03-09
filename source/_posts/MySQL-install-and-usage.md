---
title: MySQL数据库的安装及基本的使用方法
date: 2018-03-09 10:37:30
tags: [MySQL]
categories: MySQL
---
关于MySQL数据库基本的安装和操作方法。
<!--more-->
## 安装 ##
安装步骤可参考博客[mysql数据库下载、安装、使用](http://blog.csdn.net/pansanday/article/details/51321178)前部分，我选择安装的是MySQL Server组件，其他基本照着默认方式就好了。
## 基本的使用方法 ##
参考博客[ MySql基本使用方法 ](http://blog.csdn.net/whq19890827/article/details/48752517)。
1．显示当前数据库服务器中的数据库列表: `mysql> SHOW DATABASES;`

	mysql> show databases;
	+--------------------+
	| Database           |
	+--------------------+
	| information_schema |
	| mysql              |
	| performance_schema |
	| sys                |
	+--------------------+
2.显示某个数据库中的数据表: 

	 mysql> USE 库名；//使用某个库
	 mysql> SHOW TABLES；//列出库中所有的表
3.显示数据表的结构:

    mysql> DESCRIBE 表名；
4.**建立数据库**: `mysql> CREATE DATABASE 库名；` 例如新建一个名为test的数据库，再查看下数据库列表，多了个新的test数据库

	mysql> CREATE DATABASE test;
	Query OK, 1 row affected (0.01 sec)
	
	mysql> show databases;
	+--------------------+
	| Database           |
	+--------------------+
	| information_schema |
	| mysql              |
	| performance_schema |
	| sys                |
	| test               |
	+--------------------+
5.**建立数据表**:

	mysql> USE 库名;
	mysql> CREATE TABLE 表名 (字段名 VARCHAR(20), 字段名 CHAR(1))；
	//CREATE TABLE table_name (column_name column_type);
新建一个名为Websites的数据表，字段值分别为id, name, url, alexa, country。关于MySQL建表字段的类型参考博客[MySQL建表字段类型](http://blog.sina.com.cn/s/blog_80613dc40100s0c8.html)。

	mysql> CREATE TABLE Websites(id int,name varchar(18),url varchar(100),alexa int,country varchar(18));
	Query OK, 0 rows affected (0.04 sec)
6.删除数据库: `mysql> DROP DATABASE 库名；`

7.删除数据表：` mysql> DROP TABLE 表名;`

8.将表中记录清空： `mysql> DELETE FROM 表名;`

9.显示表中的所有记录： `mysql> SELECT * FROM 表名;`

10.往表中插入记录： `mysql> INSERT INTO 表名 VALUES ("hyq","M");`
往名为Websites的表中插入第一条记录，各字段值分别为：`id=1,name="Google",url="https://www.google.com/", alexa=1,country="USA"`。然后查看添加记录后表中的记录显示如下所示：

	mysql> INSERT INTO Websites VALUES (1,"Google","https://www.google.com/",1,"USA");
	Query OK, 1 row affected (0.02 sec)
	
	mysql> SELECT * FROM Websites;
	+------+--------+-------------------------+-------+---------+
	| id   | name   | url                     | alexa | country |
	+------+--------+-------------------------+-------+---------+
	|    1 | Google | https://www.google.com/ |     1 | USA     |
	+------+--------+-------------------------+-------+---------+
添加完菜鸟教程中SQL示例代码数据表中的5条示例记录后，Websites数据表显示如下：

	mysql> SELECT * FROM Websites;
	+------+--------------+--------------------------+-------+---------+
	| id   | name         | url                      | alexa | country |
	+------+--------------+--------------------------+-------+---------+
	|    1 | Google       | https://www.google.com/  |     1 | USA     |
	|    2 | 淘宝         | https://www.taobao.com/  |    13 | CN      |
	|    3 | 菜鸟教程     | http://www.runoob.com     |  4689 | CN      |
	|    4 | 微博         | http://weibo.com         |    20 | CN      |
	|    5 | Facebook     | http://www.facebook.com/ |     3 | USA     |
	+------+--------------+--------------------------+-------+---------+
11.更新表中数据： `mysql-> UPDATE 表名 SET 字段名1='a',字段名2='b' WHERE 字段名3='c'；`

12.用文本方式将数据装入数据表中: `mysql> LOAD DATA LOCAL INFILE "D:/mysql.txt" INTO TABLE 表名;`

13.导入.sql文件命令:

	mysql> USE 数据库名;
	mysql> SOURCE d:/mysql.sql;
14.显示正在use的数据库名: `mysql> SELECT DATABASE();` 
如下所示，在新建的test数据库中建立的Websites数据表，因此正在使用的数据库是test。

	mysql> SELECT DATABASE();
	+------------+
	| DATABASE() |
	+------------+
	| test       |
	+------------+
15.显示当前的user： `mysql> SELECT USER();`

	mysql> SELECT USER();
	+----------------+
	| USER()         |
	+----------------+
	| root@localhost |
	+----------------+
