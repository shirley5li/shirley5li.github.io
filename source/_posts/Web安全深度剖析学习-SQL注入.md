---
title: （三）Web安全深度剖析学习【SQL注入】
date: 2018-05-22 11:00:14
tags: [Web Security, SQL注入, SQL]
categories: Web Security
---
《Web安全深度剖析》学习总结, 本部分主要总结SQL注入原理。
<!--more-->
SQL注入漏洞是Web层面最高危的漏洞之一。
# SQL注入原理 #
SQL注入指web应用程序对用户输入数据的合法性没有判断，攻击者可以在web应用程序事先定义好的查询语句的结尾上添加额外的SQL语句，以此来实现欺骗数据库服务器执行非授权的任意SQL查询，从而进一步得到相应的数据信息。

即SQL注入通过把额外的SQL命令插入到Web表单提交或输入域名或页面请求的查询字符串后，最终达到欺骗服务器执行恶意的SQL命令。

**万能密码案例**（JSP + SQL Server）
假设数据库中只有admin用户，密码为password。

一般登录某个网站需要输入用户名和密码，现在构造一个特殊用户名 `'or 1=1--`，其中`--`是SQL Server的单行注释符号。现在使用该特殊用户名登录，密码可随意填写或不填，都可正常登录。

下面分析处理用户登录的程序：
```jsp
public boolean findAdmin(Admin admin) {
    String sql = "select count(*) from admin where username='"+admin.getUsername()+"' 
    and password='"+admin.getPassword()+"'";   //SQL查询语句
    try {
        ResultSet res = this.conn.createStatement().executeQuery(sql);  //执行SQL语句

        if(res.next()) {
            int i = res.getInt(1);   //获取第一列的值
            if(i>0) {
                return true;  //如果结果大于0，返回true
            }
        }
    } catch(Exception e) {
        e.printStackTrace();  //打印异常信息
    }
    return false;
}
```
上述SQL语句的本意是，在数据库中查询username=xxx&&password=xxx的结果，若查询结果大于0，则表示用户存在，返回true，表示登录成功，否则返回false，登录失败。

现在假设用户名为admin,密码为password，执行SQL语句如下：
```jsp
select count(*) from admin where username='admin' and password='password'
```
此时数据库中存在admin用户，并且密码为password，查询结果大于0，返回true，用户登录成功。

接下来使用构造的特殊用户登录，执行SQL语句如下：
```jsp
select count(*) from admin where username=''or 1=1--' and password=''
```
此时password字段被注释掉了，所以输不输入密码都无所谓，并且`username=''or 1=1`语句永远为真，所以最终执行的SQL语句相当于：
```jsp
select count(*) from admin  //查询admin表所有数据条数
```
显然以上查询语句返回条数大于0，返回true，可以成功登录。至此一次简单的SQL注入过程完成。

SQL注入危害很大，假设构造用户名如下： `'or 1=1;drop table admin--`，由于SQL Server支持多语句执行，这里可以直接删除admin表。危害很大滴！

SQL注入漏洞的成因：用户输入的数据被SQL解释器执行。

# 注入漏洞分类 #
常见的SQL注入类型包括：数字型和字符型。
不管分类如何，攻击者的目的都是绕过程序限制，使用户输入的数据带入数据库执行，利用数据库的特殊性获取更多的信息或者更大的权限。
## 数字型注入 ##
当输入的参数为整型时，如ID、年龄、页码等，若存在注入漏洞，则可以认为是数字型注入。数字型注入是最简单的一种。
假设URL为`http://www.xxser.com/test.php?id=8`，可以猜测SQL语句为：
```php
select * from table where id=8
```
**测试步骤如下：**
(1) `http://www.xxser.com/test.php?id=8`
SQL语句为`select * from table where id=8`，该语句会出错，导致脚本程序无法正常从数据库中获取数据，从而使原来的页面出现异常。
(2)`http://www.xxser.com/test.php?id=8 and 1=1`
SQL语句为`select * from table where id=8 and 1=1`，此时语句执行正常，返回数据与原始请求无异。
(3)`http://www.xxser.com/test.php?id=8 and 1=2`
SQL语句为`select * from table where id=8 and 1=2`，语句执行正常，但无法查询出数据，因为`and 1=2`始终为假，返回数据与原始请求有差异。

若以上三个步骤都满足，则程序可能存在SQL注入漏洞。

数字型注入多出现在ASP、PHP等弱类型语言中，弱类型语言会自动推导变量类型，如参数`id=8`，PHP会自动推导变量id的数据类型为int类型，`id=8 and 1=1`会推到为string 类型。而JAVA、C++等强类型语言，若试图把一个string类型转换为int类型会抛出异常。所以强类型语言很少存在数字型注入漏洞。

## 字符型注入 ##
当输入参数为字符串时，称为字符型注入。数字类型不需要单引号闭合，而字符串类型一般需要使用单引号来闭合。
字符型注入关键：如何闭合SQL语句以及注释多余的代码。只要是字符串类型注入，都必须闭合单引号以及注释多余的代码。
例如，update语句：
```php
update Person set username='username',set password='password' where id=1
```
现在对上述SQL语句进行注入，需要闭合单引号，可以在username或password处插入语句`'+(select@@version)+'`，最终执行的SQL语句为：
```php
update Person set username='username',set password=''+(select@@version)+'' where id=1
```
**补充：** 不同的数据库，字符串连接符不同，SQL Server字符串连接符号为`+`，Oracle字符串连接符号为`||`，MySQL字符串连接符号为`+`。
## SQL注入分类 ##
Cookie注入、POST注入、盲注、延时注入都是数字型注入和字符型注入在不同位置的展现形式，都可归纳为数字型注入和字符型注入。
- POST注入(注入字段在POST数据中)
- Cookie注入(注入字段在Cookie数据中)
- 延时注入(使用数据库延时特性注入)
- 搜索注入(注入处为搜索的地点)
- base64注入(注入字符串需要经过base64加密)

# 防止SQL注入 #
关键在于后端程序对用户输入进行过滤。防御主要分为两种：数据类型判断和特殊字符转义。
## 严格的数据类型 ## 
数据类型处理正确后，足以抵挡数字型注入。对于强类型语言，几乎不存在数字类型的注入。对于弱类型语言，需要在程序中严格判断数据类型。如使用`is_numeric()`、`ctype_digit()`等函数判断数据类型。
## 特殊字符转义 ##
此方法针对字符型注入。由于攻击者在字符型注入中会使用单引号等特殊字符，可以将这些特殊字符转义，即可防御字符型SQL注入。
## 使用预编译语句 ##
Java提供了三个接口与数据库交互，`Statement`、`PrepareStatement`、`CallableStatement`。
`Statement`用于执行静态SQL语句，并返回它所生成结果的对象。
`PrepareStatement`为`Statement`的字类，表示预编译SQL语句的对象。
`CallableStatement`为`PrepareStatement`的子类，用于执行SQL存储过程。
## 框架技术 ##
在众多的框架中，有一类框架专门与数据库打交道，称为持久层框架，比较有代表性的有Hibernate、MyBatis、JORM等。
# DVWA之SQL注入 #
参考博客[新手指南：DVWA-1.9全级别教程之SQL Injection ](www.freebuf.com/articles/web/120747.html)

SQL注入，是指攻击者通过注入恶意的SQL命令，破坏SQL查询语句的结构，从而达到执行恶意SQL语句的目的。SQL注入漏洞的危害是巨大的，常常会导致整个数据库被“脱裤”，尽管如此，SQL注入仍是现在最常见的Web漏洞之一。

(1)基于报错的检测方法：
各种符号以及组合： `'` `"` `(`  `%` 

(2)基于布尔的检测：
`1' and '1'='1` 和 `1' and '1'='2` , 相当于`1' and '1` 和 `1' and '0`
当返回的结果不同时即有漏洞。

(3)几个常用的函数：

`user()`返回当前数据库连接使用的用户；
`database()`返回当前数据库连接使用的数据库；
`version()`返回当前数据库的版本；
concat或者concat-ws函数可以将这些函数进行组合使用并显示出来。concat函数中，将其中的参数直接连接起来产生新的字符串。而concat_ws函数，第一个参数作为分隔符将后面各个参数的内容分隔开来再进行相应的连接产生新的字符串。以其常用的例子为例：
```php
concat_ws(char(32,58,32),user(),database(),version())
```
其中char()函数为将里面的参数转化为相应的字符，32为空格，58为冒号`:`，通过这样的方式可以绕过一些简单的过滤机制。

(4)几个全局函数：
`@@datadir` :查询数据库的文件位置
`@@hostname`:查询主机名
`@@version_compile_os`:查询操作系统版本

## 手工注入思路 ##
自动化的注入神器sqlmap。手工注入（非盲注）的步骤如下：
	    1.判断是否存在注入，注入是字符型还是数字型
	    2.猜解SQL查询语句中的字段数
	    3.确定显示的字段顺序
	    4.获取当前数据库
	    5.获取数据库中的表
	    6.获取表中的字段名
	    7.下载数据
## LOW ##
SOURCE
```php
<?php
if( isset( $_REQUEST[ 'Submit' ] ) ) {
    // Get input
    $id = $_REQUEST[ 'id' ];

    // Check database
    $query  = "SELECT first_name, last_name FROM users WHERE user_id = '$id';";
    $result = mysql_query( $query ) or die( '<pre>' . mysql_error() . '</pre>' );

    // Get results
    $num = mysql_numrows( $result );
    $i   = 0;
    while( $i < $num ) {
        // Get values
        $first = mysql_result( $result, $i, "first_name" );
        $last  = mysql_result( $result, $i, "last_name" );

        // Feedback for end user
        echo "<pre>ID: {$id}<br />First name: {$first}<br />Surname: {$last}</pre>";

        // Increase loop count
        $i++;
    }

    mysql_close();
}
?> 
```

Low级别的代码对来自客户端的参数id没有进行任何的检查与过滤，存在明显的SQL注入。
现实攻击场景下，攻击者是无法看到后端代码的，所以下面的手工注入步骤是建立在无法看到源码的基础上。
**1.判断是否存在注入，注入是字符型还是数字型**
(1)输入1，查询成功：
![1-1](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-1.png)

(2)输入`1' and '1'='2`，查询失败，返回结果为空：
![1-2](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-2.png)

(3)输入`1' and '1'='1`，查询成功：
![1-3](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-3.png)

(4)输入`1' or '1'='1`，查询成功:
![1-4](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-4.png)
返回了多个结果，说明存在字符型注入。

**2.猜解SQL查询语句中的字段数**
(1)输入`1' or 1=1 order by 1 #`，查询成功(`#`或`--`表示注释)：
![1-5](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-5.png)

SQL **ORDER BY** 子句: 用于对结果集进行排序。根据指定的列对结果集进行排序，默认按照升序对记录进行排序。若希望按照降序对记录进行排序，可以使用 DESC 关键字。`ORDER BY 1` 表示所select的字段按第一个字段排序。

**补充 SQL语句中$与#区别**：
`select * from user where id=${id} and username=#{username}`
在经过编译后，得到如下语句:`select * from user where id=2 and username=?`
经过编译后,如果是#{}的形式是编译成?，而如果${}是编译成直接的数据。
区别：
`#{}`: 是以预编译的形式，将参数设置到SQL语句中;`PreparedStatement`:防止SQL注入
`${}`: 取出的值直接拼装在SQL语句中;会有安全问题。$方式一般用于传入数据库对象，例如传入表名。

(2)输入`1' or 1=1 order by 2 #`，查询成功:
![1-6](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-6.png)

(3)输入`1′ or 1=1 order by 3 #`，查询失败:
```
Unknown column '3' in 'order clause'
```
说明执行的SQL查询语句中只有两个字段，即这里的`First name`、`Surname`。

**3.确定显示的字段顺序**
输入`1' union select 1,2 #`，查询成功：
![1-7](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-7.png)
说明执行的SQL语句为`select First name,Surname from 表 where ID='id'`。
`select 1,2`中的1和2只是为了凑够union关键字前面的那个表的字段数，在sql注入时，在相应位置替换成想要的数据即可。

**补充`UNION`操作符:**
UNION 操作符用于合并两个或多个 SELECT 语句的结果集。注意，UNION 内部的 SELECT 语句必须拥有相同数量的列。列也必须拥有相似的数据类型。同时，每条 SELECT 语句中的列的顺序必须相同。
默认地，UNION 操作符选取不同的值。如果允许重复的值，请使用 UNION ALL。SQL UNION 语法如下:
```sql
SELECT column_name(s) FROM table_name1
UNION
SELECT column_name(s) FROM table_name2
```
**4.获取当前数据库**
输入`1′ union select 1,database() #`，查询成功：
![1-8](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-8.png)
说明当前的数据库为`dvwa`。

**5.获取数据库中的表**
输入`1' union select 1,group_concat(table_name) from information_schema.tables where table_schema=database() #`，查询成功:
![1-9](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-9.png)
说明数据库dvwa中一共有两个表，`guestbook`与`users`。

**补充：**
MySQL中的`information_schema` 数据库保存了MySQL服务器所有数据库的信息，如数据库名，数据库的表，表栏的数据类型与访问权限等，提供了访问数据库元数据的方式。例如：
```
SCHEMATA表：提供了关于数据库名的信息。
TABLES表：给出了关于数据库中的表的信息。
COLUMNS表：给出了表中的列信息。
```
参考博客[mysql中information_schema.tables字段说明 ](https://blog.csdn.net/boshuzhang/article/details/65632708)。
`information_schema.tables`表用来保存数据库中所有表的信息。
`table_schema=数据库名`表示数据表所属的数据库。
`table_name`表名称。
`group_concat()`会计算哪些行属于同一组，将属于同一组的列显示出来(同一组的显示在一行)，要返回哪些列，由函数参数(就是字段名)决定。分组必须有个标准，就是根据`group by`指定的列进行分组。

**6.获取表中的字段名**
输入`1' union select 1,group_concat(column_name) from information_schema.columns where table_name='users' #`，查询成功：
![1-10](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-10.png)
说明`users`表中有8个字段，分别是user_id,first_name,last_name,user,password,avatar,last_login,failed_login。

**7.下载数据**
输入`1' or 1=1 union select group_concat(user_id,first_name,last_name),group_concat(password) from users #`，查询成功：
![1-11](http://ou3oh86t1.bkt.clouddn.com/SQL%E6%B3%A8%E5%85%A5/1-11.png)
这样就得到了users表中所有用户的user_id,first_name,last_name,password的数据。