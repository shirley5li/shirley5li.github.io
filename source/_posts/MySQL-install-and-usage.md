---
title: MySQL数据库的安装及基本的使用方法
date: 2018-03-09 10:37:30
tags: [MySQL]
categories: MySQL
---
关于MySQL数据库基本的安装和操作方法。[MySQL教程--菜鸟](http://www.runoob.com/mysql/mysql-tutorial.html)。
<!--more-->
## 安装 ##
安装步骤可参考博客[mysql数据库下载、安装、使用](http://blog.csdn.net/pansanday/article/details/51321178)前部分，我选择安装的是MySQL Server组件，其他基本照着默认方式就好了。
## 基本的使用方法 ##
参考博客[ MySql基本使用方法 ](http://blog.csdn.net/whq19890827/article/details/48752517)。

### 1．显示当前数据库服务器中的数据库列表 ###
`mysql> SHOW DATABASES;`

	mysql> show databases;
	+--------------------+
	| Database           |
	+--------------------+
	| information_schema |
	| mysql              |
	| performance_schema |
	| sys                |
	+--------------------+

### 2.显示某个数据库中的数据 ###
	 mysql> USE 库名；//使用某个库
	 mysql> SHOW TABLES；//列出库中所有的表

### 3.显示数据表的结构 ###

    mysql> DESCRIBE 表名；

### 4.建立数据库 ###
 `mysql> CREATE DATABASE 库名；` 例如新建一个名为test的数据库，再查看下数据库列表，多了个新的test数据库

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

### 5.建立数据表 ###

	mysql> USE 库名;
	mysql> CREATE TABLE 表名 (字段名 VARCHAR(20), 字段名 CHAR(1))；
	//CREATE TABLE table_name (column_name column_type);
新建一个名为Websites的数据表，字段值分别为id, name, url, alexa, country。关于MySQL建表字段的类型参考博客[MySQL建表字段类型](http://blog.sina.com.cn/s/blog_80613dc40100s0c8.html)。

	mysql> CREATE TABLE Websites(id int,name varchar(18),url varchar(100),alexa int,country varchar(18));
	Query OK, 0 rows affected (0.04 sec)

### 6.删除数据库 ###
 `mysql> DROP DATABASE 库名；`

### 7.删除数据表 ###
` mysql> DROP TABLE 表名;`

### 8.将表中记录清空 ###
 `mysql> DELETE FROM 表名;`

### 9.显示表中的所有记录 ###
 `mysql> SELECT * FROM 表名;`

### 10.往表中插入记录 ###
 `mysql> INSERT INTO 表名 VALUES ("hyq","M");`
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
### 11.更新表中数据 ###
 `mysql-> UPDATE 表名 SET 字段名1='a',字段名2='b' WHERE 字段名3='c'；`

### 12.用文本方式将数据装入数据表中 ###
 `mysql> LOAD DATA LOCAL INFILE "D:/mysql.txt" INTO TABLE 表名;`

###13.导入.sql文件命令 ###

	mysql> USE 数据库名;
	mysql> SOURCE d:/mysql.sql;

### 14.显示正在use的数据库名 ###
 `mysql> SELECT DATABASE();` 
如下所示，在新建的test数据库中建立的Websites数据表，因此正在使用的数据库是test。

	mysql> SELECT DATABASE();
	+------------+
	| DATABASE() |
	+------------+
	| test       |
	+------------+

### 15.显示当前的user ###
 `mysql> SELECT USER();`

	mysql> SELECT USER();
	+----------------+
	| USER()         |
	+----------------+
	| root@localhost |
	+----------------+

### 16.SELECT TOP 子句 ###
返回规定的记录数目。MySQL语法如下：

	SELECT column_name(s)
	FROM table_name
	LIMIT number;
从 "Websites" 表中选取头两条记录如下：

	mysql> SELECT * FROM Websites
	    -> LIMIT 2;
	+------+--------+-------------------------+-------+---------+
	| id   | name   | url                     | alexa | country |
	+------+--------+-------------------------+-------+---------+
	|    1 | Google | https://www.google.com/ |     1 | USA     |
	|    2 | 淘宝   | https://www.taobao.com/ |    13 | CN      |
	+------+--------+-------------------------+-------+---------+

### 17.LIKE 操作符 ###
LIKE 操作符用于在 WHERE 子句中搜索列中的指定模式。语法如下：

	SELECT column_name(s)
	FROM table_name
	WHERE column_name LIKE pattern;
以下示例选取 name 以字母 "G" 开始的所有记录：

	mysql> SELECT * FROM Websites
	    -> WHERE name LIKE "G%";
	+------+--------+-------------------------+-------+---------+
	| id   | name   | url                     | alexa | country |
	+------+--------+-------------------------+-------+---------+
	|    1 | Google | https://www.google.com/ |     1 | USA     |
以下示例选取 name 以字母 "k" 结尾的所有客户：

	mysql> SELECT * FROM Websites
	    -> WHERE name LIKE "%k";
	+------+----------+--------------------------+-------+---------+
	| id   | name     | url                      | alexa | country |
	+------+----------+--------------------------+-------+---------+
	|    5 | Facebook | http://www.facebook.com/ |     3 | USA     |
	+------+----------+--------------------------+-------+---------+
以下示例选取 name 包含模式 "oo" 的所有记录：

	mysql> SELECT * FROM Websites
	    -> WHERE name LIKE "%oo%";
	+------+----------+--------------------------+-------+---------+
	| id   | name     | url                      | alexa | country |
	+------+----------+--------------------------+-------+---------+
	|    1 | Google   | https://www.google.com/  |     1 | USA     |
	|    5 | Facebook | http://www.facebook.com/ |     3 | USA     |
	+------+----------+--------------------------+-------+---------+
注意："%" 符号用于在模式的前后定义通配符（缺省字母），通配符可用于替代字符串中的任何其他字符。 通配符与 SQL LIKE 操作符一起使用。

	%                          替代 0 个或多个字符
	_                          替代一个字符
	[charlist]                 字符列中的任何单一字符
	[^charlist]或[!charlist]   不在字符列中的任何单一字符
搭配以上通配符可以让LIKE命令实现多种技巧：

	1、LIKE'Mc%' 将搜索以字母 Mc 开头的所有字符串（如 McBadden）。
	2、LIKE'%inger' 将搜索以字母 inger 结尾的所有字符串（如 Ringer、Stringer）。
	3、LIKE'%en%' 将搜索在任何位置包含字母 en 的所有字符串（如 Bennet、Green、McBadden）。
	4、LIKE'_heryl' 将搜索以字母 heryl 结尾的所有六个字母的名称（如 Cheryl、Sheryl）。
	5、LIKE'[CK]ars[eo]n' 将搜索下列字符串：Carsen、Karsen、Carson 和 Karson（如 Carson）。
	6、LIKE'[M-Z]inger' 将搜索以字符串 inger 结尾、以从 M 到 Z 的任何单个字母开头的所有名称（如 Ringer）。
	7、LIKE'M[^c]%' 将搜索以字母 M 开头，并且第二个字母不是 c 的所有名称（如MacFeather）。

### 18.[charlist] 通配符  ###
MySQL 中使用 REGEXP 或 NOT REGEXP 运算符 (或 RLIKE 和 NOT RLIKE) 来操作正则表达式。
下面的 SQL 语句选取 name 以 "G"、"F" 或 "s" 开始的所有网站：

	mysql> SELECT * FROM Websites
	    -> WHERE name REGEXP "^[GFs]";
	+------+---------------+----------------------------+-------+---------+
	| id   | name          | url                        | alexa | country |
	+------+---------------+----------------------------+-------+---------+
	|    1 | Google        | https://www.google.com/    |     1 | USA     |
	|    5 | Facebook      | http://www.facebook.com/   |     3 | USA     |
	|    6 | stackoverflow | https://stackoverflow.com/ |     0 | IND     |
	+------+---------------+----------------------------+-------+---------+

### 19.IN 操作符 ###
IN 操作符允许在 WHERE 子句中规定多个值，然后返回规定相应的记录。语法如下：

	SELECT column_name(s)
	FROM table_name
	WHERE column_name IN (value1,value2,...);
以下语句选取 name 为 "Google" 或 "菜鸟教程" 的所有记录：

	mysql> SELECT * FROM Websites
	    -> WHERE name IN ("Google","菜鸟教程");
	+------+--------------+-------------------------+-------+---------+
	| id   | name         | url                     | alexa | country |
	+------+--------------+-------------------------+-------+---------+
	|    1 | Google       | https://www.google.com/ |     1 | USA     |
	|    3 | 菜鸟教程     | http://www.runoob.com   |  4689 | CN      |
	+------+--------------+-------------------------+-------+---------+

**IN 与 = 的异同**：
    相同点：均在WHERE中使用作为筛选条件之一、均是等于的含义
    不同点：IN可以规定多个值，等于规定一个值

### 20.BETWEEN 操作符 ###
用于选取介于两个值之间的数据范围内的值。这些值可以是数值、文本或者日期。 语法如下：

	SELECT column_name(s)
	FROM table_name
	WHERE column_name BETWEEN value1 AND value2;
以下语句选取 alexa 介于 1 和 20 之间的所有记录：

	mysql> SELECT * FROM Websites
	    -> WHERE alexa BETWEEN 1 AND 20;
	+------+----------+--------------------------+-------+---------+
	| id   | name     | url                      | alexa | country |
	+------+----------+--------------------------+-------+---------+
	|    1 | Google   | https://www.google.com/  |     1 | USA     |
	|    2 | 淘宝     | https://www.taobao.com/  |    13 | CN      |
	|    4 | 微博     | http://weibo.com         |    20 | CN      |
	|    5 | Facebook | http://www.facebook.com/ |     3 | USA     |
	+------+----------+--------------------------+-------+---------+
NOT BETWEEN 显示不在范围内的所有记录。
以下语句语句选取alexa介于 1 和 20 之间但 country 不为 USA 和 IND 的所有记录：

	mysql> SELECT * FROM Websites
	    -> WHERE alexa BETWEEN 1 AND 20
	    -> AND NOT country IN ("USA","IND");
	+------+--------+-------------------------+-------+---------+
	| id   | name   | url                     | alexa | country |
	+------+--------+-------------------------+-------+---------+
	|    2 | 淘宝   | https://www.taobao.com/ |    13 | CN      |
	|    4 | 微博   | http://weibo.com        |    20 | CN      |
	+------+--------+-------------------------+-------+---------+

### 21.连接(JOIN) ###
参考[SQL 连接(JOIN)](http://www.runoob.com/sql/sql-join.html)。
用于把来自两个或多个表的行结合起来。基于这些表之间的共同字段。
最常见的 JOIN 类型：SQL **INNER JOIN**（简单的 JOIN）。 
SQL INNER JOIN 从多个表中返回满足 JOIN 条件的所有行。
"Websites" 表中的 "id" 列指向 "`access_log`" 表中的字段 "`site_id`"。将这两个表是通过 "`site_id`" 列联系起来的。

	mysql> SELECT Websites.id, Websites.name, access_log.count, access_log.date
	    -> FROM Websites
	    -> INNER JOIN access_log
	    -> ON Websites.id=access_log.site_id;
	+------+--------------+-------+------------+
	| id   | name         | count | date       |
	+------+--------------+-------+------------+
	|    1 | Google       |    45 | 2016-05-10 |
	|    3 | 菜鸟教程     |   100 | 2016-05-13 |
	|    1 | Google       |   230 | 2016-05-14 |
	|    2 | 淘宝         |    10 | 2016-05-14 |
	|    5 | Facebook     |   205 | 2016-05-14 |
	|    4 | 微博         |    13 | 2016-05-15 |
	|    3 | 菜鸟教程     |   220 | 2016-05-15 |
	|    5 | Facebook     |   545 | 2016-05-16 |
	|    3 | 菜鸟教程     |   201 | 2016-05-17 |
	+------+--------------+-------+------------+
不同的 SQL JOIN：

    INNER JOIN：如果表中有至少一个匹配，则返回行
    LEFT JOIN：即使右表中没有匹配，也从左表返回所有的行
    RIGHT JOIN：即使左表中没有匹配，也从右表返回所有的行
    FULL JOIN：只要其中一个表中存在匹配，则返回行
首先，连接的结果可以在逻辑上看作是由SELECT语句指定的列组成的新表。
左连接与右连接的左右指的是以两张表中的哪一张为基准，它们都是外连接。
外连接就好像是为非基准表添加了一行全为空值的万能行，用来与基准表中找不到匹配的行进行匹配。假设两个没有空值的表进行左连接，左表是基准表，左表的所有行都出现在结果中，右表则可能因为无法与基准表匹配而出现是空值的字段。

### 22.INNER JOIN  ###
在表中存在至少一个匹配时返回行。语法如下：

	SELECT column_name(s)
	FROM table1
	INNER JOIN table2
	ON table1.column_name=table2.column_name;
或：
	
	SELECT column_name(s)
	FROM table1
	JOIN table2
	ON table1.column_name=table2.column_name;
![inner join](http://www.runoob.com/wp-content/uploads/2013/09/img_innerjoin.gif)
具体例子如21所示。
注释：INNER JOIN 与 JOIN 是相同的
注释：INNER JOIN 关键字在表中存在至少一个匹配时返回行。如果 "Websites" 表中的行在 "`access_log`" 中没有匹配，则不会列出这些行。

### 23.LEFT JOIN  ###
从左表（table1）返回所有的行，即使右表（table2）中没有匹配。如果右表中没有匹配，则结果为 NULL。语法如下：

	SELECT column_name(s)
	FROM table1
	LEFT JOIN table2
	ON table1.column_name=table2.column_name;
或：

	SELECT column_name(s)
	FROM table1
	LEFT OUTER JOIN table2
	ON table1.column_name=table2.column_name;
	// 在某些数据库中，LEFT JOIN 称为 LEFT OUTER JOIN。
![left join](http://www.runoob.com/wp-content/uploads/2013/09/img_leftjoin.gif)

以下示例语句将返回所有网站及他们的访问量（如果有的话）。把 Websites 作为左表，`access_log` 作为右表：

	mysql> SELECT Websites.id, Websites.name, access_log.count, access_log.date
	    -> FROM Websites
	    -> LEFT JOIN access_log
	    -> ON Websites.id=access_log.site_id
	    -> ORDER BY access_log.count DESC;
	+------+---------------+-------+------------+
	| id   | name          | count | date       |
	+------+---------------+-------+------------+
	|    5 | Facebook      |   545 | 2016-05-16 |
	|    1 | Google        |   230 | 2016-05-14 |
	|    3 | 菜鸟教程      |   220 | 2016-05-15 |
	|    5 | Facebook      |   205 | 2016-05-14 |
	|    3 | 菜鸟教程      |   201 | 2016-05-17 |
	|    3 | 菜鸟教程      |   100 | 2016-05-13 |
	|    1 | Google        |    45 | 2016-05-10 |
	|    4 | 微博          |    13 | 2016-05-15 |
	|    2 | 淘宝          |    10 | 2016-05-14 |
	|    6 | stackoverflow |  NULL | NULL       |
	+------+---------------+-------+------------+

### 24.FULL OUTER JOIN  ###
FULL OUTER JOIN 关键字只要左表（table1）和右表（table2）其中一个表中存在匹配，则返回行。
FULL OUTER JOIN 关键字结合了 LEFT JOIN 和 RIGHT JOIN 的结果。
FULL OUTER JOIN 关键字返回左表（Websites）和右表（`access_log`）中所有的行。如果 "Websites" 表中的行在 "`access_log`" 中没有匹配或者 "`access_log`" 表中的行在 "Websites" 表中没有匹配，也会列出这些行。
语法如下：

	SELECT column_name(s)
	FROM table1
	FULL OUTER JOIN table2
	ON table1.column_name=table2.column_name;
![full outer join](http://www.runoob.com/wp-content/uploads/2013/09/img_fulljoin.gif)

**注意：** MySQL中不支持 FULL OUTER JOIN，可以在 SQL Server 测试实例。

### 25.UNION  ###
用于合并两个或多个 SELECT 语句的结果。
注意： UNION 内部的每个 SELECT 语句必须拥有相同数量的列。列也必须拥有相似的数据类型。同时，每个 SELECT 语句中的列的顺序必须相同。
语法如下：
	SELECT column_name(s) FROM table1
	UNION
	SELECT column_name(s) FROM table2;
注释：(1) 默认地，UNION 操作符选取不同的值。如果允许重复的值，请使用 UNION ALL。
(2) UNION 结果集中的列名总是等于 UNION 中第一个 SELECT 语句中的列名。
	
	mysql>  SELECT country FROM Websites
	    -> UNION
	    -> SELECT country FROM apps
	    -> ORDER BY country;
	+---------+
	| country |
	+---------+
	| CN      |
	| IND     |
	| USA     |
	+---------+
注释：UNION 不能用于列出两个表中所有的country。如果一些网站和APP来自同一个国家，每个国家只会列出一次。UNION 只会选取不同的值。请使用 UNION ALL 来选取重复的值！
使用UNION命令时需要注意，只能在最后使用一个ORDER BY命令，是将两个查询结果合在一起之后，再进行排序！绝对不能写两个ORDER BY命令。

### 26.INSERT INTO SELECT / SELECT INTO ###
从一个表复制信息插入到另一个已存在的表，目标表中任何已存在的行都不会受影响。。
**注意：**MySQL 数据库不支持 SELECT ... INTO 语句，但支持 INSERT INTO ... SELECT 。
以使用以下语句来拷贝表结构及数据：`CREATE TABLE 新表 SELECT * FROM 旧表; `
语法如下：

	INSERT INTO table2
	SELECT * FROM table1;
或者只复制希望的列插入到另一个已存在的表中：
	
	INSERT INTO table2
	(column_name(s))
	SELECT column_name(s)
	FROM table1;
以下语句复制 "apps" 中的数据插入到 "Websites" 中：
	
	mysql> INSERT INTO Websites(name,country)
	    -> SELECT app_name,country FROM apps
	    -> WHERE id=1;
	Query OK, 1 row affected (0.01 sec)
	
	mysql> SELECT * FROM Websites;
	+------+---------------+----------------------------+-------+---------+
	| id   | name          | url                        | alexa | country |
	+------+---------------+----------------------------+-------+---------+
	|    1 | Google        | https://www.google.com/    |     1 | USA     |
	|    2 | 淘宝          | https://www.taobao.com/    |    13 | CN      |
	|    3 | 菜鸟教程      | http://www.runoob.com      |  4689 | CN      |
	|    4 | 微博          | http://weibo.com           |    20 | CN      |
	|    5 | Facebook      | http://www.facebook.com/   |     3 | USA     |
	|    6 | stackoverflow | https://stackoverflow.com/ |     0 | IND     |
	| NULL | QQ APP        | NULL                       |  NULL | CN      |
	+------+---------------+----------------------------+-------+---------+
表apps中的数据如下：

	mysql> SELECT * FROM apps;
	+------+------------+------------------------+---------+
	| id   | app_name   | url                    | country |
	+------+------------+------------------------+---------+
	|    1 | QQ APP     | http://im.qq.com/      | CN      |
	|    2 | 微博 APP   | http://weibo.com/      | CN      |
	|    3 | 淘宝 APP   | http://www.taobao.com/ | CN      |
	+------+------------+------------------------+---------+

### 27.约束（Constraints） ###
SQL 约束用于规定表中的数据规则。
如果存在违反约束的数据行为，行为会被约束终止。
约束可以在创建表时规定（通过 CREATE TABLE 语句），或者在表创建之后规定（通过 ALTER TABLE 语句）。语法如下：

	CREATE TABLE table_name
	(
	column_name1 data_type(size) constraint_name,
	column_name2 data_type(size) constraint_name,
	column_name3 data_type(size) constraint_name,
	....
	);
在 SQL 中，有如下约束：

    NOT NULL - 指示某列不能存储 NULL 值。
    UNIQUE - 保证某列的每行必须有唯一的值。
    PRIMARY KEY - NOT NULL 和 UNIQUE 的结合。确保某列（或两个列多个列的结合）有唯一标识，有助于更容易更快速地找到表中的一个特定的记录。
    FOREIGN KEY - 保证一个表中的数据匹配另一个表中的值的参照完整性。
    CHECK - 保证列中的值符合指定的条件。
    DEFAULT - 规定没有给列赋值时的默认值。
(1) NOT NULL 约束
强制列不接受 NULL 值, 强制字段始终包含值。这意味着，如果不向字段添加值，就无法插入新记录或者更新记录。
(2)  UNIQUE 约束
唯一标识数据库表中的每条记录。
UNIQUE 和 PRIMARY KEY 约束均为列或列集合提供了唯一性的保证。
PRIMARY KEY 约束拥有自动定义的 UNIQUE 约束。
注意，每个表可以有多个 UNIQUE 约束，但是每个表只能有一个 PRIMARY KEY 约束。
下面的 SQL 在 "Persons" 表创建时在 "`P_Id`" 列上创建 UNIQUE 约束：

	CREATE TABLE Persons
	(
	P_Id int NOT NULL,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255),
	Address varchar(255),
	City varchar(255),
	UNIQUE (P_Id)
	);
如需命名 UNIQUE 约束，并定义多个列的 UNIQUE 约束，使用下面的 SQL 语法：

	CREATE TABLE Persons
	(
	P_Id int NOT NULL,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255),
	Address varchar(255),
	City varchar(255),
	CONSTRAINT uc_PersonID UNIQUE (P_Id,LastName)
	);
**当表已被创建时**，如需在 "`P_Id`" 列创建 UNIQUE 约束，使用下面的 SQL：

	ALTER TABLE Persons
	ADD UNIQUE (P_Id);
如需命名 UNIQUE 约束，并定义多个列的 UNIQUE 约束，使用下面的 SQL 语法：

	ALTER TABLE Persons
	ADD CONSTRAINT uc_PersonID UNIQUE (P_Id,LastName);
**撤销 UNIQUE 约束:**

	ALTER TABLE Persons
	DROP INDEX uc_PersonID
(3) PRIMARY KEY 约束
唯一标识数据库表中的每条记录。
主键必须包含唯一的值，主键列不能包含 NULL 值。
每个表都应该有一个主键，并且每个表只能有一个主键。
下面的 SQL 在 "Persons" 表创建时在 "`P_Id`" 列上创建 PRIMARY KEY 约束：

	CREATE TABLE Persons
	(
	P_Id int NOT NULL,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255),
	Address varchar(255),
	City varchar(255),
	PRIMARY KEY (P_Id)
	);
如需命名 PRIMARY KEY 约束，并定义多个列的 PRIMARY KEY 约束，使用下面的 SQL 语法：

	CREATE TABLE Persons
	(
	P_Id int NOT NULL,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255),
	Address varchar(255),
	City varchar(255),
	CONSTRAINT pk_PersonID PRIMARY KEY (P_Id,LastName)
	);
注释：在上面的实例中，只有一个主键 PRIMARY KEY（`pk_PersonID`）。然而，pk_PersonID 的值是由两个列（`P_Id` 和 `LastName`）组成的。
**当表已被创建时**，如需在 "`P_Id`" 列创建 PRIMARY KEY 约束，使用下面的 SQL：

	ALTER TABLE Persons
	ADD PRIMARY KEY (P_Id);
如需命名 PRIMARY KEY 约束，并定义多个列的 PRIMARY KEY 约束，使用下面的 SQL 语法：

	ALTER TABLE Persons
	ADD CONSTRAINT pk_PersonID PRIMARY KEY (P_Id,LastName);
**撤销 PRIMARY KEY 约束:**

	ALTER TABLE Persons
	DROP PRIMARY KEY
撤销PRIMARY KEY约束时，不论约束条件为一列还是多列，对于MySQL，撤销都是如上的语句。
(4)  FOREIGN KEY 约束
一个表中的 FOREIGN KEY 指向另一个表中的 PRIMARY KEY。
FOREIGN KEY 约束用于预防破坏表之间连接的行为。
FOREIGN KEY 约束也能防止非法数据插入外键列，因为它必须是它指向的那个表中的值之一。[参考菜鸟教程](http://www.runoob.com/sql/sql-foreignkey.html)。
(5) CHECK 约束
用于限制列中的值的范围。
如果对单个列定义 CHECK 约束，那么该列只允许特定的值。
如果对一个表定义 CHECK 约束，那么此约束会基于行中其他列的值在特定的列中对值进行限制。[参考菜鸟教程](http://www.runoob.com/sql/sql-check.html)。
(6) DEFAULT 约束
用于向列中插入默认值。如果没有规定其他的值，那么会将默认值添加到所有的新记录。
下面的 SQL 在 "Persons" 表创建时在 "City" 列上创建 DEFAULT 约束：

	CREATE TABLE Persons
	(
	P_Id int NOT NULL,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255),
	Address varchar(255),
	City varchar(255) DEFAULT 'Sandnes'
	);
通过使用类似 GETDATE() 这样的函数，DEFAULT 约束也可以用于插入系统值：

	CREATE TABLE Orders
	(
	O_Id int NOT NULL,
	OrderNo int NOT NULL,
	P_Id int,
	OrderDate date DEFAULT GETDATE()
	);
当表已被创建时，如需在 "City" 列创建 DEFAULT 约束，使用下面的 SQL:
	
	ALTER TABLE Persons
	ALTER City SET DEFAULT 'SANDNES';
撤销 DEFAULT 约束:

	ALTER TABLE Persons
	ALTER City DROP DEFAULT;

### 28.CREATE INDEX  ###
用于在表中创建索引。在不读取整个表的情况下，索引使数据库应用程序可以更快地查找数据。
用户无法看到索引，它们只能被用来加速搜索/查询。
**注释：**更新一个包含索引的表需要比更新一个没有索引的表花费更多的时间，这是由于索引本身也需要更新。因此，理想的做法是仅仅在常常被搜索的列（以及表）上面创建索引。
在表上创建一个简单的索引。允许使用重复的值：

	CREATE INDEX index_name
	ON table_name (column_name1, column_name2);
在表上创建一个唯一的索引。不允许使用重复的值(唯一的索引意味着两个行不能拥有相同的索引值)：

	CREATE UNIQUE INDEX index_name
	ON table_name (column_name);

### 29.DROP ###
使用 DROP 语句，可以轻松地删除索引、表和数据库。
DROP INDEX 语句用于删除表中的索引。MySQL 的 DROP INDEX 语法：`ALTER TABLE table_name DROP INDEX index_name;`

DROP TABLE 语句用于删除表: `DROP TABLE table_name;`

DROP DATABASE 语句用于删除数据库: `DROP DATABASE database_name;`

仅仅删除表内的数据，但并不删除表本身时： `TRUNCATE TABLE table_name;`

### 30.ALTER ###
ALTER TABLE 语句用于在已有的表中添加、删除或修改列。
**在表中添加列:**

	ALTER TABLE table_name
	ADD column_name datatype;
**删除表中的列:**

	ALTER TABLE table_name
	DROP COLUMN column_name;
**改变表中列的数据类型:**

	ALTER TABLE table_name
	MODIFY COLUMN column_name datatype;

### 31.AUTO INCREMENT  ###
`AUTO_INCREMENT` 会在新记录插入表中时生成一个唯一的数字。可用于在每次插入新记录时，自动地创建主键字段的值。
下面的 SQL 语句把 "Persons" 表中的 "ID" 列定义为 `AUTO_INCREMENT` 主键字段：

	CREATE TABLE Persons
	(
	ID int NOT NULL AUTO_INCREMENT,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255),
	Address varchar(255),
	City varchar(255),
	PRIMARY KEY (ID)
	);
默认地，`AUTO_INCREMENT` 的开始值是 1，每条新记录递增 1。
要让 `AUTO_INCREMENT` 序列以其他的值起始，请使用下面的 SQL 语法： `ALTER TABLE Persons AUTO_INCREMENT=100;`
要在 "Persons" 表中插入新记录，我们不必为 "ID" 列规定值（会自动添加一个唯一的值）：

	INSERT INTO Persons (FirstName,LastName)
	VALUES ('Lars','Monsen');

### 32.视图（Views） ###
视图是基于 SQL 语句的结果集的可视化的表。
视图包含行和列，就像一个真实的表。视图中的字段就是来自一个或多个数据库中的真实的表中的字段。
可以向视图添加 SQL 函数、WHERE 以及 JOIN 语句，也可以呈现数据，就像这些数据来自于某个单一的表一样。
CREATE VIEW 语法:

	CREATE VIEW view_name AS
	SELECT column_name(s)
	FROM table_name
	WHERE condition;
注释：视图总是显示最新的数据！每当用户查询视图时，数据库引擎通过使用视图的 SQL 语句重建数据。

### 33.日期（Dates） ###
确保所插入的日期的格式，与数据库中日期列的格式相匹配。[MySQL Date 函数](http://www.runoob.com/sql/sql-dates.html)。

### 34.NULL 值 ###
如果表中的某个列是可选的，那么我们可以在不向该列添加值的情况下插入新记录或更新已有的记录。这意味着该字段将以 NULL 值保存。
NULL 值的处理方式与其他值不同。
NULL 用作未知的或不适用的值的占位符。
无法使用比较运算符来测试 NULL 值，比如` =、< 或 <>`。必须使用 IS NULL 和 IS NOT NULL 操作符。

	SELECT LastName,FirstName,Address FROM Persons
	WHERE Address IS NULL;
### 35.NULL 函数 ###
可以使用 IFNULL() 函数

	SELECT ProductName,UnitPrice*(UnitsInStock+IFNULL(UnitsOnOrder,0))
	FROM Products;
或者：

	SELECT ProductName,UnitPrice*(UnitsInStock+COALESCE(UnitsOnOrder,0))
	FROM Products;
示例：

	//如果alexa列为null值，则赋予0，否则，取原值
	select id,name,url,ifnull(alexa,0)from websites;
	select id,name,url,COALESCE(alexa,0) from websites;

### 36.数据类型  ###
数据类型定义列中存放的值的种类。[SQL 通用数据类型](http://www.runoob.com/sql/sql-datatypes.html)。

### 37.SQL 函数 ###
(1) SQL Aggregate 函数
SQL Aggregate 函数计算从列中取得的值，返回一个单一的值。常用的如下：

    AVG() - 返回平均值            SELECT AVG(column_name) FROM table_name;
    COUNT() - 返回行数            SELECT COUNT(column_name) FROM table_name;
    FIRST() - 返回第一个记录的值   //只有 MS Access 支持 FIRST() 函数。 MySQL语法实现此函数如：SELECT name AS FirstSite FROM Websites LIMIT 1; 
    LAST() - 返回最后一个记录的值   //只有 MS Access 支持 LAST() 函数。
    MAX() - 返回最大值            SELECT MAX(column_name) FROM table_name;
    MIN() - 返回最小值
    SUM() - 返回总和
(2) SQL Scalar 函数
SQL Scalar 函数基于输入值，返回一个单一的值。常用的如下：

    UCASE() - 将某个字段转换为大写                     SELECT UCASE(column_name) FROM table_name;
    LCASE() - 将某个字段转换为小写
    MID() - 从某个文本字段提取字符，MySql 中使用        SELECT MID(column_name,start[,length]) FROM table_name;
    SubString(字段，1，end) - 从某个文本字段提取字符
    LEN() - 返回某个文本字段的长度                     //MySQL中使用方法： SELECT LENGTH(column_name) FROM table_name;
    ROUND() - 对某个数值字段进行指定小数位数的四舍五入   SELECT ROUND(column_name,decimals) FROM table_name;
    NOW() - 返回当前的系统日期和时间                   SELECT NOW() FROM table_name;
    FORMAT() - 格式化某个字段的显示方式                SELECT FORMAT(column_name,format) FROM table_name;

(3) **GROUP BY 语句**
用于结合聚合函数，根据一个或多个列对结果集进行分组。

	SELECT column_name, aggregate_function(column_name)
	FROM table_name
	WHERE column_name operator value
	GROUP BY column_name; 
如下统计 `access_log` 各个 `site_id` 的访问量：
	
	mysql> SELECT site_id,SUM(access_log.count)
	    -> FROM access_log
	    -> GROUP BY site_id;
	+---------+-----------------------+
	| site_id | SUM(access_log.count) |
	+---------+-----------------------+
	|       1 |                   275 |
	|       2 |                    10 |
	|       3 |                   521 |
	|       4 |                    13 |
	|       5 |                   750 |
	+---------+-----------------------+
GROUP BY 多表连接时，以下语句统计所有网站的访问的记录数：
	
	mysql> SELECT Websites.name,COUNT(access_log.aid) AS nums FROM access_log
	    -> LEFT JOIN Websites
	    -> ON access_log.site_id=Websites.id
	    -> GROUP BY Websites.name;
	+--------------+------+
	| name         | nums |
	+--------------+------+
	| Facebook     |    2 |
	| Google       |    2 |
	| 微博         |    1 |
	| 淘宝         |    1 |
	| 菜鸟教程     |    3 |
	+--------------+------+
以上示例中，`access_log`作为左表，`Websites`作为右表，通过 GROUP BY 对 COUNT得到的结果按`site_id`分组。

(4) **HAVING 子句**
增加 HAVING 子句原因是，WHERE 关键字无法与聚合函数一起使用。
HAVING 子句可以让我们筛选分组后的各组数据。语法如下：

	SELECT column_name, aggregate_function(column_name)
	FROM table_name
	WHERE column_name operator value
	GROUP BY column_name
	HAVING aggregate_function(column_name) operator value; 
以下语句用于查找总访问量大于 200 的网站：

	mysql> SELECT Websites.name,Websites.url,SUM(access_log.count) AS nums FROM access_log
	    -> INNER JOIN Websites
	    -> ON access_log.site_id=Websites.id
	    -> GROUP BY Websites.name
	    -> HAVING SUM(access_log.count) > 200;
	+--------------+--------------------------+------+
	| name         | url                      | nums |
	+--------------+--------------------------+------+
	| Facebook     | http://www.facebook.com/ |  750 |
	| Google       | https://www.google.com/  |  275 |
	| 菜鸟教程     | http://www.runoob.com    |  521 |
	+--------------+--------------------------+------+
以下语句用于查找总访问量大于 200 的网站，并且 alexa 排名小于 200：

	mysql> SELECT Websites.name,Websites.alexa,SUM(access_log.count) AS nums FROM access_log
	    -> INNER JOIN Websites
	    -> ON Websites.id=access_log.site_id
	    -> WHERE Websites.alexa < 200
	    -> GROUP BY Websites.name
	    -> HAVING SUM(access_log.count) > 200;
	+----------+-------+------+
	| name     | alexa | nums |
	+----------+-------+------+
	| Facebook |     3 |  750 |
	| Google   |     1 |  275 |
	+----------+-------+------+
具体的使用方法参见[菜鸟教程SQL 函数](http://www.runoob.com/sql/sql-function.html)。
