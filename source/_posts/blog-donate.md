---
title: Next主题配置---打赏功能+文章结束标志
date: 2017-08-10 20:44:56
tags: [next, hexo]
categories: 搭建博客
---
这次介绍一下next主题下添加打赏功能，以及在每篇文章末尾统一添加“文章结束”标志 \~\~\~吼吼吼
<!--more-->

# 打赏功能 #
首先在主题配置文件即hexo/themes/next/_config.yml找到version字段，查看自己的next主题的版本，如下图所示，我用的next主题的版本为5.1.2

![1](/images/blog_donate/1.png)

在网上查了一些添加打赏功能的方法，参照来做的时候，发现了一些问题，可能是由于next主题升级到version5后自身增加了些隐藏的新功能，所以在网上找到的别人的一些方法不太适用，下面的添加文章结束功能也是如此。因此自己尝试设置好后特来分享一哈~

在主题配置文件找到Reward字段部分，如下图所示，其中reward_comment字段设置你的打赏介绍，wechatpay和alipay分别为你保存微信以及支付宝收款二维码的路径，可以是本地路径，也可以是用图床生成的链接地址。我是把图片放在本地的，即将两个二维码图片放在了next/source/images文件夹下。

![2](/images/blog_donate/2.png)

此时默认的打赏按钮如下，略丑。。。然后作了小小改动，把打赏按钮变好看一点点 \~\~\~


![3](/images/blog_donate/3.png)

改动方法如下：在hexo\themes\next\layout\_macro下找到reward.swig文件，这个文件是关于打赏功能样式设置的。用下面代码覆盖原文件中的代码即可。由于保存的自动生成的微信及支付宝二维码图片的大小不一，且原图略大，所以可以通过设置包裹两幅图片的div元素的宽度和高度（代码两处注解处）来限制图片的大小，使其更加美观。宽度和高度可以依据自己喜欢更改大小。当然也可以自己使用图片处理工具将

```
<div style="padding: 10px 0; margin: 20px auto; width: 90%; text-align: center;">
  <div>{{ theme.reward_comment }}</div>
  <button id="rewardButton" disable="enable" style="width: 80px;line-height: 38px;text-align: center;font-weight: bold;color: #fff;border-radius: 5px;
margin:0 20px 20px 0;position: relative;overflow: hidden;color: #8c96a0;text-shadow:1px 1px 1px #fff;border:1px solid #dce1e6;box-shadow: 0 1px 2px #fff inset,0 -1px 0 #a8abae inset;background: -webkit-linear-gradient(top,#f2f3f7,#e4e8ec);background: -moz-linear-gradient(top,#f2f3f7,#e4e8ec);background: linear-gradient(top,#f2f3f7,#e4e8ec);" onclick="var qr = document.getElementById('QR'); if (qr.style.display === 'none') {qr.style.display='block';} else {qr.style.display='none'}">
    打赏
  </button>
  <div id="QR" style="display: none;">

    {% if theme.wechatpay %}
      <div id="wechat" style="display: inline-block;width:150px;height:150px">
        <img id="wechat_qr" src="{{ theme.wechatpay }}" alt="{{ theme.author }} WeChat Pay"/>
        <p>WeChat Pay</p>
      </div>
    {% endif %}

    {% if theme.alipay %}
      <div id="alipay" style="display: inline-block;width:150px;height:150px">
        <img id="alipay_qr" src="{{ theme.alipay }}" alt="{{ theme.author }} Alipay"/>
        <p>Alipay</p>
      </div>
    {% endif %}

    {% if theme.bitcoin %}
      <div id="bitcoin" style="display: inline-block">
        <img id="bitcoin_qr" src="{{ theme.bitcoin }}" alt="{{ theme.author }} Bitcoin"/>
        <p>Bitcoin</p>
      </div>
    {% endif %}

  </div>
</div>
```

调整后的效果见下图，是不是稍微不那么丑了一点点呢，红红火火恍恍惚惚\~\~\~\~

![4](/images/blog_donate/4.png)
# 文章结束标志 #
本以为这是一个非常简单的小功能，其实的确是一个很简单的功能，但由于参考的人家的做法可能不适于我使用的版本，导致这个小小的问题又折腾了好久T T

在hexo\themes\next\layout\_macro文件夹下新建passage-end-tag.swig文件，并添加代码如下：

```
<div> {% if not is_index %} <div style="text-align:center;color: #ccc;font-size:14px;">-------------本文结束<i class="fa fa-smile-o"></i>感谢您的阅读-------------</div> {% endif %} </div>
```

其中的 `<i class="fa fa-smile-o"></i>`为[FontAwesome图标](http://www.yeahzan.com/fa/facss.html),可以在其中挑选自己喜欢的图标，我选了一个笑脸，嘻嘻(●'◡'●)

然后打开hexo\themes\next\layout\_macro文件夹下的post.swig文件，在 `END POST BODY`这段注解后添加如下图框框中的代码：

![5](/images/blog_donate/5.png)

具体代码如下：

```
 {% if theme.passage_end_tag.enabled and not is_index %}
    <div>
       {% include 'passage-end-tag.swig' %}
    </div>
 {% endif %}

```

再然后，打开主题配置文件hexo/themes/next/_config.yml，在末尾添加如下代码：
	
	# 文章末尾添加“本文结束”标记
	passage_end_tag:
	  enabled: true

效果如下图所示：

![6](/images/blog_donate/6.png)

最后，运行下hexo g -d 看下部署到github后的效果吧！

**PS:**比较坑的一点，我使用的markdownpad，使用Tab缩进打代码块时，在右侧预览区可以正常显示代码块文本，但是 `hexo s` 在本地浏览器预览后，代码块文本却没有正确完整的显示，有些html标签被解释掉了。好像是Tab缩进可以被markdownpad的解释器正确解释，但是hexo的解释器却没有将其正确解析。后面换了一种打代码块的方式，就可以在浏览器正确显示了，但在markdownpad的预览区却没得到正常显示。即在代码块的最前面和最后面单独一行使用三个反引号	```。如下图所示。

![7](/images/blog_donate/7.png)

效果显示如下：

![8](/images/blog_donate/8.png)
