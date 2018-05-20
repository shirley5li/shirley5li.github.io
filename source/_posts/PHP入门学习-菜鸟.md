---
title: PHP入门学习
date: 2018-05-20 17:06:32
tags: [PHP]
categories: PHP
---
来自菜鸟PHP基础语法学习总结。
<!--more-->
# 语法 #
PHP 脚本在服务器上执行，然后将纯 HTML 结果发送回浏览器。
- PHP 脚本以 `<?php` 开始，以 `?>` 结束。
- PHP 中的每个代码行都必须以分号结束。
- 两种在浏览器输出文本的基础指令：`echo` 和 `print`。
- PHP 文件通常包含 HTML 标签和一些 PHP 脚本代码,PHP 脚本可以放在文档中的任何位置。
- 单行注释：`//`，多行注释：`/**/`
## 变量 ##
变量以 $ 符号开始，变量名是区分大小写。
```php
<?php
$txt="Hello world!";
$x=5;
$y=10.5;
?>
```
PHP 是一门弱类型语言。
### PHP 变量作用域 ###
PHP 有四种不同的变量作用域：local、global、static、parameter。

在所有函数外部定义的变量，拥有全局作用域。除了函数外，全局变量可以被脚本中的任何部分访问，要在一个函数中访问一个全局变量，需要使用 global 关键字。 

函数内部声明的变量是局部变量，仅能在函数内部访问。

**注意：** global 关键字用于函数内访问全局变量。
```php
<?php
$x=5;
$y=10;
 
function myTest()
{
    global $x,$y;
    $y=$x+$y;
}
 
myTest();
echo $y; // 输出 15
?>
```
PHP 将所有全局变量存储在一个名为 $GLOBALS[index] 的数组中。 index 保存变量的名称。这个数组可以在函数内部访问，也可以直接用来更新全局变量。

**Static 作用域** 当一个函数完成时，它的所有局部变量通常都会被删除。然而有时候希望某个局部变量不要被删除,第一次声明变量时使用 static 关键字。

## 超级全局变量 ##
超级全局变量在一个脚本的全部作用域中都可用。 不需要特别说明，也可以在函数及类中使用。
```
    $GLOBALS
    $_SERVER
    $_REQUEST
    $_POST
    $_GET
    $_FILES
    $_ENV
    $_COOKIE
    $_SESSION
```
### $GLOBALS ###
`$GLOBALS` 是一个包含了全部变量的全局组合数组。变量的名字就是数组的键。
```php
<?php 
$x = 75; 
$y = 25;
function addition() 
{ 
    $GLOBALS['z'] = $GLOBALS['x'] + $GLOBALS['y']; 
}
addition(); 
echo $z; 
?>
```
### $_SERVER ###
`$_SERVER` 是一个包含了诸如头信息(header)、路径(path)、以及脚本位置(script locations)等等信息的数组。这个数组中的项目由 Web 服务器创建。不能保证每个服务器都提供全部项目；服务器可能会忽略一些，或者提供一些没有在这里列举出来的项目。 
```php
<?php 
echo $_SERVER['PHP_SELF'];
echo "<br>";
echo $_SERVER['SERVER_NAME'];
echo "<br>";
echo $_SERVER['HTTP_HOST'];
echo "<br>";
echo $_SERVER['HTTP_REFERER'];
echo "<br>";
echo $_SERVER['HTTP_USER_AGENT'];
echo "<br>";
echo $_SERVER['SCRIPT_NAME'];
?>
```
### $_REQUEST ###
`$_REQUEST` 用于收集HTML表单提交的数据。
```html
<!DOCTYPE html>
<html>
<body>

<form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
Name: <input type="text" name="fname">
<input type="submit">
</form>

<?php 
$name = $_REQUEST['fname']; 
echo $name; 
?>

</body>
</html>
```
### $_POST ###
`$_POST` 被广泛应用于收集表单数据，在HTML form标签的指定该属性："method="post"。
```html
<html>
<body>

<form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
Name: <input type="text" name="fname">
<input type="submit">
</form>

<?php
$name = $_POST['fname'];
echo $name;
?>

</body>
</html>
```
###  $_GET ###
`$_GET` 同样被广泛应用于收集表单数据，在HTML form标签的指定该属性："method="get"。`$_GET`也可以收集URL中发送的数据。
```html
<html>
<body>
<a href="test_get.php?subject=PHP&web=runoob.com">Test $GET</a>
</body>
</html> 
```
test_get.php
```php
<html>
<body>

<?php
echo "Study " . $_GET['subject'] . " at " . $_GET['web'];
?>

</body>
</html>
```
## 魔术变量 ##
PHP 向它运行的任何脚本提供了大量的预定义常量。不过很多常量都是由不同的扩展库定义的，只有在加载了这些扩展库时才会出现，或者动态加载后，或者在编译时已经包括进去了。

这些特殊的常量不区分大小写,随着它们在代码中的位置改变而改变。
- `__LINE__`: 文件中的当前行号。
- `__FILE__`: 文件的完整路径和文件名。如果用在被包含文件中，则返回被包含的文件名。
- `__DIR__`: 文件所在的目录。如果用在被包括文件中，则返回被包括的文件所在的目录。等价于 dirname(__FILE__)。除非是根目录，否则目录中名不包括末尾的斜杠。
- `__FUNCTION__`: 返回该函数被定义时的名字。（PHP 5 起区分大小写）
- `__CLASS__`: 返回该类被定义时的名字（PHP 5 起区分大小写）
- `__TRAIT__`: Trait 的名字
- `__METHOD__`: 类的方法名，返回该方法被定义时的名字（区分大小写）
- `__NAMESPACE__`: 当前命名空间的名称（区分大小写）

## echo/print  ##
- echo - 可以输出一个或多个字符串。字符串可以包含 HTML 标签。
- print - 只允许输出一个字符串，返回值总为 1。字符串可以包含 HTML 标签。

两者在使用时都可以加括号或不加，`echo`/`echo()`，`print`/`print()`。
## 定界符EOF(heredoc) ##
PHP 定界符 EOF 的作用就是按照原样，包括换行格式什么的，输出在其内部的字符串；定界符 EOF 中的任何特殊字符都不需要转义。

规则：
1. 必须后接分号，否则编译通不过。
2. EOF 可以用任意其它字符代替，只需保证结束标识`EOF`与开始标识`<<<EOF`一致。
3. 结束标识必须顶格独自占一行(即必须从行首开始，前后不能衔接任何空白和字符)。
4. 开始标识可以不带引号或带单双引号，不带引号与带双引号效果一致，解释内嵌的变量和转义符号，带单引号则不解释内嵌的变量和转义符号。
5. 当内容需要内嵌引号（单引号或双引号）时，不需要加转义符，本身对单双引号转义。
6. 位于开始标记和结束标记之间的变量可以被正常解析，但是函数则不可以。

```php
<?php
$name="runoob";
$a= <<<EOF
    "abc"$name
    "123"
EOF;
// 结束需要独立一行且前后不能空格
echo $a;
?>
```
## 数据类型 ##
String（字符串）, Integer（整型）, Float（浮点型）, Boolean（布尔型）, Array（数组）, Object（对象）, NULL（空值）。

以下实例中创建了一个**数组**， 然后使用 PHP var_dump() 函数返回数组的数据类型和值：
```php
<?php 
$cars=array("Volvo","BMW","Toyota");
var_dump($cars);
?>

//输出 array(3) { [0]=> string(5) "Volvo" [1]=> string(3) "BMW" [2]=> string(6) "Toyota" } 
```

**对象**
在 PHP 中，对象必须声明。用`class`关键字声明类对象，类是包含属性和方法的数据结构。在类中定义数据类型，然后在实例化的对象中使用数据类型：
```php
<?php
class Car
{
  var $color;
  function __construct($color="green") {
    $this->color = $color;
  }
  function what_color() {
    return $this->color;
  }
}
?>
```
`$this` 代表实例化的对象，`PHP_EOL` 为换行符。
## 常量 ##
常量在定义后，默认是全局变量,可以在整个运行的脚本的任何地方使用（包括函数内部）。

使用`define()`函数设置常量：`bool define ( string $name , mixed $value [, bool $case_insensitive = false ] )`

    name：必选参数，常量名称，即标志符。
    value：必选参数，常量的值。
    case_insensitive ：可选参数，如果设置为 TRUE，该常量则大小写不敏感。默认是大小写敏感的。
eg:
```php
<?php
// 不区分大小写的常量名
define("GREETING", "欢迎访问 Runoob.com", true);
echo greeting;  // 输出 "欢迎访问 Runoob.com"
?>
```
## 字符串 ##
- 并置运算符 `.` 用于把两个字符串值连接起来。
```php
 <?php
$txt1="Hello world!";
$txt2="What a nice day!";
echo $txt1 . " " . $txt2;
?> 
```
- `strlen()` 函数返回字符串的长度（字符数)。
- `strpos()` 函数用于在字符串内查找一个字符或一段指定的文本。如果在字符串中找到匹配，该函数会返回第一个匹配的字符位置。如果未找到匹配，则返回 FALSE。
```php
<?php 
echo strpos("Hello world!","world"); 
?>
//输出 6
```
## 数组 ##
### 创建数组 ###
array() 函数用于创建数组：`array();`
有三种类型的数组：
- 数值数组 - 带有数字 ID 键的数组。`$cars=array("Volvo","BMW","Toyota");`
- 关联数组 - 带有指定的键的数组，每个键关联一个值。 使用分配给数组的指定键创建的数组。`$age=array("Peter"=>"35","Ben"=>"37","Joe"=>"43");`
- 多维数组 - 包含一个或多个数组的数组

### 操作数组的方法 ###
- `count()` 函数用于返回数组的长度
- 访问数组元素，使用中括号 `[]`，即`$cars[0]`
- 使用 foreach 循环遍历关联数组
```php
<?php
$age=array("Peter"=>"35","Ben"=>"37","Joe"=>"43");
foreach($age as $x=>$x_value)
{
    echo "Key=" . $x . ", Value=" . $x_value;
    echo "<br>";
}
?> 
//输出
//Key=Peter, Value=35
//Key=Ben, Value=37
//Key=Joe, Value=43
```
### 数组排序 ###
```
    sort() - 对数组进行升序排列
    rsort() - 对数组进行降序排列
    asort() - 根据关联数组的值，对数组进行升序排列
    ksort() - 根据关联数组的键，对数组进行升序排列
    arsort() - 根据关联数组的值，对数组进行降序排列
    krsort() - 根据关联数组的键，对数组进行降序排列
```
## 命名空间 ##
默认情况下，所有常量、类和函数名都放在全局空间下。
如果一个文件中包含命名空间，它必须在其它所有代码之前声明命名空间，命名空间通过关键字namespace 来声明。

```php
<?php  
// 定义代码在 'MyProject' 命名空间中  
namespace MyProject;  
 
// ... 代码 ...  
```
**注意：** 在声明命名空间之前唯一合法的代码是用于定义源文件编码方式的 declare 语句。所有非 PHP 代码包括空白符都不能出现在命名空间的声明之前。

将全局的非命名空间中的代码与命名空间中的代码组合在一起，只能使用大括号形式的语法。全局代码必须用一个不带名称的 namespace 语句加上大括号括起来，例如：
```php
<?php
namespace MyProject {

const CONNECT_OK = 1;
class Connection { /* ... */ }
function connect() { /* ... */  }
}

namespace { // 全局代码
session_start();
$a = MyProject\connect();
echo MyProject\Connection::start();
}
?>
```
## 面向对象 ##
[PHP 面向对象](http://www.runoob.com/php/php-oop.html)

# 表单验证 #
##  表单 ##
###  下拉菜单多选 ###
下拉菜单是多选的（ multiple="multiple"），可以通过将设置 select `name="q[]"` 以数组的方式获取。
```php
<?php
$q = isset($_POST['q'])? $_POST['q'] : '';
if(is_array($q)) {
    $sites = array(
            'RUNOOB' => '菜鸟教程: http://www.runoob.com',
            'GOOGLE' => 'Google 搜索: http://www.google.com',
            'TAOBAO' => '淘宝: http://www.taobao.com',
    );
    foreach($q as $val) {
        // PHP_EOL 为常量，用于换行
        echo $sites[$val] . PHP_EOL;
    }
      
} else {
?>
<form action="" method="post"> 
    <select multiple="multiple" name="q[]">
    <option value="">选择一个站点:</option>
    <option value="RUNOOB">Runoob</option>
    <option value="GOOGLE">Google</option>
    <option value="TAOBAO">Taobao</option>
    </select>
    <input type="submit" value="提交">
    </form>
<?php
}
?>
```
### 单选按钮 ###
单选按钮表单中 `name` 属性的值是一致的，`value` 值是不同的。
```php
<?php
$q = isset($_GET['q'])? htmlspecialchars($_GET['q']) : '';
if($q) {
        if($q =='RUNOOB') {
                echo '菜鸟教程<br>http://www.runoob.com';
        } else if($q =='GOOGLE') {
                echo 'Google 搜索<br>http://www.google.com';
        } else if($q =='TAOBAO') {
                echo '淘宝<br>http://www.taobao.com';
        }
} else {
?><form action="" method="get"> 
    <input type="radio" name="q" value="RUNOOB" />Runoob
    <input type="radio" name="q" value="GOOGLE" />Google
    <input type="radio" name="q" value="TAOBAO" />Taobao
    <input type="submit" value="提交">
</form>
<?php
}
?>
```
### 复选框 ###
```php
<?php
$q = isset($_POST['q'])? $_POST['q'] : '';
if(is_array($q)) {
    $sites = array(
            'RUNOOB' => '菜鸟教程: http://www.runoob.com',
            'GOOGLE' => 'Google 搜索: http://www.google.com',
            'TAOBAO' => '淘宝: http://www.taobao.com',
    );
    foreach($q as $val) {
        // PHP_EOL 为常量，用于换行
        echo $sites[$val] . PHP_EOL;
    }
      
} else {
?><form action="" method="post"> 
    <input type="checkbox" name="q[]" value="RUNOOB"> Runoob<br> 
    <input type="checkbox" name="q[]" value="GOOGLE"> Google<br> 
    <input type="checkbox" name="q[]" value="TAOBAO"> Taobao<br>
    <input type="submit" value="提交">
</form>
<?php
}
?>
```
### 表单验证 ###
应该尽可能的对用户的输入进行验证（通过客户端脚本），该验证仅用于对输入信息作合法性判断。浏览器验证速度更快，并且可以减轻服务器的压力。

如果用户输入需要插入数据库，应该考虑使用服务器验证，需要作安全性验证。

在服务器验证表单的一种好的方式是，把表单的数据传给当前页面（异步提交的方式更好），而不是跳转到不同的页面。这样用户就可以在同一张表单页面得到错误信息。用户也就更容易发现错误了。

## 表单验证 ##
一段html表单代码如下：
```html
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
“名字”: <input type="text" name="name">
E-mail: <input type="text" name="email">
网址: <input type="text" name="website">
备注: <textarea name="comment" rows="5" cols="40"></textarea>
性别:
<input type="radio" name="gender" value="female">女
<input type="radio" name="gender" value="male">男
</form>
```
该表单使用 method="post" 方法来提交数据。

`$_SERVER["PHP_SELF"]`是超级全局变量，返回当前正在执行脚本的文件名，与document root相关。 所以 `$_SERVER["PHP_SELF"]` 会发送表单数据到当前页面，而不是跳转到不同的页面。

`htmlspecialchars()`方法：把一些预定义的字符转换为 HTML 实体。 
```
    & （和号） 成为 &amp;
    " （双引号） 成为 &quot;
    ' （单引号） 成为 &#039;
    < （小于） 成为 &lt;
    > （大于） 成为 &gt;
```
### $_SERVER["PHP_SELF"]被用作XSS攻击 ###
当黑客使用跨网站脚本的HTTP链接来攻击时，`$_SERVER["PHP_SELF"]`服务器变量也会被植入脚本。原因就是跨网站脚本是附在执行文件的路径后面的，因此`$_SERVER["PHP_SELF"]`的字符串就会包含HTTP链接后面的JavaScript程序代码。

指定以下表单文件名为 "test_form.php":
```html
<form method="post" action="<?php echo $_SERVER["PHP_SELF"];?>">
```
现在，使用URL来指定提交地址 "test_form.php",以上代码修改为如下所示:
```html
<form method="post" action="test_form.php">
```
但是，当用户在浏览器输入以下地址：`http://www.runoob.com/test_form.php/%22%3E%3Cscript%3Ealert('hacked')%3C/script%3E`
以上的 URL 中，将被解析为如下代码并执行:
```html
<form method="post" action="test_form.php/"><script>alert('hacked')</script>
```
代码中添加了 script 标签，并添加了alert命令。 当页面载入时会执行该Javascript代码（用户会看到弹出框）。
### 如何避免 $_SERVER["PHP_SELF"] 被利用 ###
可以通过 `htmlspecialchars()` 函数来避免被利用，如下：
```html
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
```
htmlspecialchars() 把一些预定义的字符转换为 HTML 实体。现在如果用户想利用 `PHP_SELF` 变量, 结果将输出如下所示：
```html
<form method="post" action="test_form.php/&quot;&gt;&lt;script&gt;alert('hacked')&lt;/script&gt;">
```