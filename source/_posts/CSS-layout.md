---
title: 关于CSS几种布局方式的学习总结
date: 2018-01-02 14:05:23
tags: [CSS]
categories: CSS
---
学习一段时间了，但对于CSS布局方法的掌握一直比较混乱，于是再来学习总结一遍。文章参考自[CSS 常见布局方式 ](http://www.sohu.com/a/168143624_274163)。
<!--more-->
CSS几种常见的布局方式如下图总结。

![1](/images/CSS-layout/1.jpeg)
## 传统盒模型布局方式 ##
传统布局方式就是通过盒模型，使用 display属性（文档流布局） + position属性（定位布局） + float属性（浮动布局）。
### 文档流布局 ###
最基本的布局方式，就是按照文档的顺序一个一个显示出来，块元素独占一行，行内元素共享一行。
### 定位布局 ###
通过 **position属性**来进行定位。该属性有四种不同类型的定位，分别为static（默认定位）、relative（相对定位）、absolute（绝对定位）和fixed（固定定位）。

**static：**若某元素的position属性的是默认static，那这个元素就在文档流中。

**relative：**设置为相对定位的元素**不脱离文档流**，参考自身的位置通过top、bottom、left和right进行定位，让这个元素以自身原来的位置为基准进行移动，**元素仍然保持其未定位前的形状，它原本所占的空间仍然保留**（因为它没有脱离文档流）。因此，采用相对定位的元素有可能覆盖了其他元素，因为它其实占据了两个位置，一个是移动前的位置，一个是移动后的位置，若移动后的位置和别的元素冲突，就把别的元素覆盖了。

与relative（相对定位）不同，**设置为absolute（绝对定位）和fixed（固定定位）的元素脱离了文档流**，元素原先在正常文档流中所占的空间会关闭，就像该元素不存在一样。

**absolute:** absolute（绝对定位）元素的位置相对于最近的已定位的祖先元素，若该元素没有已定位的祖先元素，那么它的位置相对于最初的包含块。 

**fixed:** fixed（固定定位）是相对于浏览器窗口的，即将设置为fixed（固定位置）的元素固定在浏览器的某个位置上，即使拖动浏览器的滚动条，该元素的位置也不会改变。
### 浮动布局 ###
使用 **float属性**，使元素脱离文档流，浮动起来。

在CSS中使用float属性用于改变块元素对象的默认显示方式。当块元素对象设置了float属性后，它将不再独占一行，而是可以浮动到左侧或右侧，直到浮动的框外缘碰到包含框或另一个浮动框的边框为止。

**注意：**浮动框也不在文档流中，因此对文档流的中块框来说，浮动框就像不存在一样。这一点和absolute（绝对定位）属性类型有类似之处，但float和absolute还有以下**不同：**

(1)absolute元素的位置相对于离它最近的已定位的祖先元素，它可以以父元素框的4个顶点为基准进行定位。而float属性定位时则是根据left或right属性值，以父元素的左上或右上为基准进行定位。

(2)采用absolute属性定位的元素不能被文本所包围，而采用float属性定位的元素可以被文本包围（float最初设计的用意就是这个，用以取代HTML中的align属性）。

(3)float的影响可控，absolute的影响不可控。
设置float和absolute属性的元素都脱离了文档流，因此它们都会影响到其下方的元素。但是，absolute是布局属性，使用它时没有一种有效的方法使之与其下方的元素不重合在一起。相反，若一个元素指定了float属性，当我们向其下方（或后面）的元素的应用了clear属性后（clear:left；clear:right；clear:both），其后的元素就不再受影响了。所以一般在网页布局时，更多的使用float属性。
## flex布局 ##
flex是Flexible Box的缩写，意为"弹性布局"，用来为盒状模型提供最大的灵活性。

flex是一种新型的布局方式，使用该布局方式可以实现几乎所有你想要的效果。但是要注意其浏览器的兼容性，flex 只支持 ie 10+，所以还是要根据项目情况使用。
### 使用flex布局 ###
只需要将其display属性设置为 flex 即可，也可以设置行内的 flex。 Webkit内核的浏览器，必须加上 -webkit 前缀。**注意：**设为flex布局以后，子元素的 float、clear 和 vertical-align 属性将失效。

Flexible Box模型如下：

![2](/images/CSS-layout/2.png)

在flex中，最核心的概念就是**容器和轴**，所有的属性都是围绕容器和轴设置的。其中，容器分为父容器和子容器。轴分为主轴（main axis）和交叉轴（cross axis）（主轴默认为水平方向，方向向右，交叉轴为主轴顺时针旋转 90°）。

在使用 flex 的元素中，默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴开始的位置称为 main start，主轴结束的位置称为 main end。交叉轴开始的位置称为 cross start，交叉轴结束的位置称为 cross end。

在使用 flex 的子元素中，占据的主轴空间叫做 main size，占据的交叉轴空间叫做 cross size。
### 父容器属性 ###
父容器上有六个属性：flex-direction：主轴的方向。 flex-wrap：超出父容器子容器的排列样式。 flex-flow：flex-direction 属性和 flex-wrap 属性的简写形式。 justify-content：子容器在主轴的排列方向。 align-items：子容器在交叉轴的排列方向。 align-content：多根轴线的对齐方式。

**flex-direction** 属性决定主轴的方向（主轴的方向不一定是水平的，这个属性就是设置主轴的方向，主轴默认是水平方向，从左至右，如果主轴方向设置完毕，那么交叉轴就不需要设置，交叉轴永远是主轴顺时针旋转 90°）。

![3](/images/CSS-layout/3.jpeg)

**flex-wrap** 属性决定子容器如果在一条轴线排不下时，如何换行。

![4](/images/CSS-layout/4.jpeg)

**flex-flow** 属性是 flex-direction 属性和 flex-wrap 属性的简写形式，默认值为 row nowrap。

**justify-content** 属性定义了子容器在主轴上的对齐方式。

![5](/images/CSS-layout/5.jpeg)

**align-items** 属性定义子容器在交叉轴上如何对齐,具体的对齐方式与交叉轴的方向有关，下面假设交叉轴从上到下。

![6](/images/CSS-layout/6.jpeg)

**align-content** 属性定义了多根轴线的对齐方式。如果项目只有一根轴线，该属性不起作用。

![7](/images/CSS-layout/7.jpeg)
### 子容器属性 ###
子容器也有 6 个属性：order：子容器的排列顺序。 flex-grow：子容器剩余空间的拉伸比例。 flex-shrink：子容器超出空间的压缩比例。 flex-basis：子容器在不伸缩情况下的原始尺寸。 子元素的 flex 属性是 flex-grow,flex-shrink 和 flex-basis 的简写。 align-self属性。

**order** 属性定义项目的排列顺序。数值越小，排列越靠前，默认为 0。

**flex-grow** 属性定义子容器的伸缩比例。按照该比例给子容器分配空间。

**flex-shrink** 属性定义了子容器弹性收缩的比例。例如，超出的部分按 1:2 的比例从给定子容器中减去。此属性要生效，父容器的 flex-wrap 属性要设置为 nowrap。

**flex-basis** 属性定义了子容器在不伸缩情况下的原始尺寸，主轴为横向时代表宽度，主轴为纵向时代表高度。

**flex** 属性是 flex-grow,flex-shrink 和 flex-basis 的简写，默认值为 0 1auto。后两个属性可选。

**align-self** 属性允许单个项目有与其他项目不一样的对齐方式，可覆盖父容器align-items 属性。默认值为 auto，表示继承父元素的 align-items属性，如果没有父元素，则等同于 stretch。
## grid网格布局 ##
flex 布局虽然强大，但是只能是一维布局，如果要进行二维布局，还需要使用 grid。

grid 布局又称为“网格布局”，可以实现二维布局方式，和之前的 表格table布局差不多，然而，这是使用 CSS 控制的，不是使用 HTML 控制的，同时还可以依赖于媒体查询根据不同的上下文得新定义布局。

网格布局还可以让我们摆脱现在布局中存在的文档流限制，换句话说，你的结构不需要根据设计稿从上往下布置了。这也意味着您可以自由地更改页面元素位置。这最适合你在不同的断点位置实现你最需要的布局，而不再需要为响应你的设计而担心HTML结构的问题。
和 table 布局不同的是，grid 布局不需要在 HTML 中使用特定的标签布局，所有的布局都是在 CSS 中完成的，你可以随意定义你的 grid 网格。

没有 HTML 结构的网格布局有助于使用流体、调整顺序等技术管理或更改布局。通过结合 CSS 的媒体查询属性，可以控制网格布局容器和他们的子元素，使用页面的布局根据不同的设备和可用空间调整元素的显示风格与定位，而不需要去改变文档结构的本质内容。
### grid 网格布局中的基本概念 ###
**网格线(Grid Lines)** 组成了网格，他是网格的水平和垂直的分界线。一个网格线存在行或列的两侧。我们可以引用它的数目或者定义的网格线名称。

![8](/images/CSS-layout/8.jpeg)

**网格轨道(Grid Track)**是就是相邻两条网格线之间的空间，就好比表格中行或列。所在在网格中其分为grid column和grid row。每个网格轨道可以设置一个大小，用来控制宽度或高度。

![9](/images/CSS-layout/9.jpeg)

**网格单元格(Grid Cell)** 是指四条网格线之间的空间。所以它是最小的单位，就像表格中的单元格。


![10](/images/CSS-layout/10.jpeg)

**网格区域(Grid Area)** 是由任意四条网格线组成的空间，所以他可能包含一个或多个单元格。相当于表格中的合并单元格之后的区域。

![11](/images/CSS-layout/11.jpeg)
### 使用grid布局 ###
使用 grid 布局很简单，通过display属性设置属性值为 grid 或 inline-grid 或者是 subgrid（该元素父元素为网格，继承父元素的行和列的大小） 就可以了。

网格容器中的所有子元素就会自动变成网格项目（grid item），然后设置列（grid-template-columns）和 行（grid-template-rows）的大小，设置 grid-template-columns 有多少个参数，生成的 grid 列表就有多少 列。

**注：**当元素设置了网格布局，column、float、clear、vertical-align属性无效。


## reference ##
[CSS定位——position、float小结](http://blog.csdn.net/zhuyunhe/article/details/45790527)