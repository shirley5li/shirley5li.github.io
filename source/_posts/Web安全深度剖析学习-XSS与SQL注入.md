---
title: （二）Web安全深度剖析学习【XSS与SQL注入】
date: 2018-05-17 16:56:51
tags: [web security, XSS, CSRF, SQL注入]
categories: web security
---
《Web安全深度剖析》学习总结, 本部分主要包括XSS、SQL注入、CSRF。
<!--more-->
# XSS跨站脚本漏洞 #
XSS(Cross Site Scripting)，即跨站脚本攻击。指攻击者在网页中嵌入客户端脚本，通常是JS编写的恶意代码，当用户使用浏览器浏览被嵌入恶意代码的网页时，恶意代码将会在用户浏览器上执行。XSS属于客户端攻击。

## XSS原理 ##
XSS攻击在网页中嵌入客户端恶意脚本代码，这些恶意脚本代码一般使用JavaScript编写，所以JS能做到什么效果，XSS的威力就有多大。
JavaScript可以用来获取用户cookie，改变页面内容、url跳转，所以存在XSS漏洞的网站就可以盗取用户cookie、黑掉页面、导航到恶意网站。