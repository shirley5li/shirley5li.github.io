---
title: MongoDB学习from菜鸟教程
date: 2018-03-12 13:12:29
tags: [MongoDB]
categories: DataBase
---
在学习[《一起学 Node.js》](https://github.com/nswbmw/N-blog)中，需要使用 Express + MongoDB 搭建多人博客，因此在[菜鸟MongoDB 教程](http://www.runoob.com/mongodb/mongodb-tutorial.html)上学习总结MongoDB的基本用法。
<!--more-->
MongoDB是一个基于分布式文件存储的开源数据库系统。 在高负载的情况下，添加更多的节点，可以保证服务器性能, 为WEB应用提供可扩展的高性能数据存储解决方案。
MongoDB 将数据存储为一个文档，数据结构由键值(key=>value)对组成。 MongoDB 文档类似于 JSON 对象。 字段值可以包含其他文档，数组及文档数组。
mongodb中基本的概念是文档、集合、数据库。一个mongodb中可以建立多个数据库。MongoDB的默认数据库为"db"，该数据库存储在data目录中。

MongoDB的单个实例可以容纳多个独立的数据库，每一个都有自己的集合和权限，不同的数据库也放置在不同的文件中。

## 基本用法 ##
先cd到bin文件夹下，执行"mongo"启动客户端。
(1)`show dbs` 命令可以显示所有数据的列表。

	> show dbs
	admin   0.000GB
	config  0.000GB
	local   0.000GB
(2)`db` 命令可以显示当前数据库对象或集合。

	> db
	test
(3)`use database_name`命令，可以连接到一个指定的数据库。

	> use local
	switched to db local
	> db
	local
(4)**数据库名命名规则：**可以是满足以下条件的任意UTF-8字符串。

    不能是空字符串（"")。
    不得含有' '（空格)、.、$、/、\和\0 (空字符)。
    应全部小写。
    最多64字节
有一些数据库名是保留的，可以直接访问这些有特殊作用的数据库。

    admin： 从权限的角度来看，这是"root"数据库。要是将一个用户添加到这个数据库，这个用户自动继承所有数据库的权限。一些特定的服务器端命令也只能从这个数据库运行，比如列出所有的数据库或者关闭服务器。
    local: 这个数据永远不会被复制，可以用来存储限于本地单台服务器的任意集合
    config: 当Mongo用于分片设置时，config数据库在内部使用，用于保存分片的相关信息。
**(5)文档**
文档是一组键值(key-value)对(即BSON)。MongoDB 的文档不需要设置相同的字段，并且相同的字段不需要相同的数据类型，这与关系型数据库有很大的区别，也是 MongoDB 非常突出的特点。一个简单的文档如下所示：

	{"site":"www.runoob.com", "name":"菜鸟教程"}

    文档中的键/值对是有序的。
    文档中的值不仅可以是在双引号里面的字符串，还可以是其他几种数据类型（甚至可以是整个嵌入的文档)。
    MongoDB区分类型和大小写。
    MongoDB的文档不能有重复的键。
    文档的键是字符串。除了少数例外情况，键可以使用任意UTF-8字符。
文档键命名规范：

    键不能含有\0 (空字符)。这个字符用来表示键的结尾。
    .和$有特别的意义，只有在特定环境下才能使用。
    以下划线"_"开头的键是保留的(不是严格要求的)。
**(6)集合**
集合就是 MongoDB 文档组，类似于 RDBMS （关系数据库管理系统：Relational Database Management System)中的表格。
集合存在于数据库中，集合没有固定的结构，这意味着你在对集合可以插入不同格式和类型的数据，但通常情况下我们插入集合的数据都会有一定的关联性。
可以将以下不同数据结构的文档插入到集合中：
	
	{"site":"www.baidu.com"}
	{"site":"www.google.com","name":"Google"}
	{"site":"www.runoob.com","name":"菜鸟教程","num":5}
集合名命名规范：

	集合名不能是空字符串""。
	集合名不能含有\0字符（空字符)，这个字符表示集合名的结尾。
	集合名不能以"system."开头，这是为系统集合保留的前缀。
	用户创建的集合名字不能含有保留字符。有些驱动程序的确支持在集合名里面包含，这是因为某些系统生成的集合中包含该字符。除非你要访问这种系统创建的集合，否则千万不要在名字里出现$。
Capped collections 就是固定大小的collection。
**(7)元数据**
数据库的信息是存储在集合中。它们使用了系统的命名空间：`dbname.system.*`

## 创建数据库 ##
`use DATABASE_NAME` 如果数据库不存在，则创建数据库，否则切换到指定数据库。

	> use test
	switched to db test
	> db
	test
	> show dbs
	admin   0.000GB
	config  0.000GB
	local   0.000GB
刚创建的test数据库不在数据库列表中，要显示它，必须插入一些数据。

	> db.test.insert({"name":"hello"})
	WriteResult({ "nInserted" : 1 })
	> show dbs
	admin   0.000GB
	config  0.000GB
	local   0.000GB
	test    0.000GB
MongoDB 中默认的数据库为 test，如果你没有创建新的数据库，集合将存放在 test 数据库中。

## 删除数据库 ##
先切换到要删除的数据库，再执行`db.dropDatabase()`

	> use test
	switched to db test
	> db
	test
	> db.dropDatabase()
	{ "dropped" : "test", "ok" : 1 }
	> show dbs
	admin   0.000GB
	config  0.000GB
	local   0.000GB

关于MongoDB更详细的操作命令见菜鸟教程。
