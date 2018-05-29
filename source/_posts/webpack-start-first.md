---
title: (一)Webpack入门总结
date: 2018-05-14 09:06:21
tags: [Webpack]
categories: Webpack
---
关于webpck基本使用的入门总结。
<!--more-->
**webpack版本【webpack@4.8.3】**

**补充：**
(1)git bash新建文件的命令：`touch index.html`（再别忘记了！！！）

# 入门 #
## 下载安装及配置(Basic Setup) ##
例如在桌面新建一个目录，使用npm初始化，然后利用npm命令本地安装`webpack`，再安装`webpack-cli`(用于在命令行上运行webpack的工具)：

``` bash
	mkdir webpack-demo && cd webpack-demo
	npm init -y
	npm install webpack webpack-cli --save-dev
```

其中`npm init -y`表示在初始化创建package.json的过程中跳过提问阶段，直接生成一个新的package.json文件,类似的`npm init -f`也会跳过提问阶段。 

npm初始化语法：`npm init [--force|-f|--yes|-y|--scope]`

在项目的根目录下，及webpack-demo下创建以下目录结构，具体目录结构及相应文件内容如下：

**项目目录结构**

![目录结构](http://ou3oh86t1.bkt.clouddn.com/webpack-demo/%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84.png)

**src/index.js**

```js
	function component() {
	    var element = document.createElement('div');
	
	    // 借助了Lodash(一个js工具库，作用是降低array、number、object等使用难度)，
	    // _ 是假定存在的一个Lodash全局对象，将js方法挂载在 _ 这个全局对象变量上。
	    element.innerHTML = _.join(['Hello','webpack'],' ');
	
	    return element;
	
	}
	
	document.body.appendChild(component());
```
**index.html**

``` html
	<!DOCTYPE html>
	<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	    <title>Getting Started</title>
	</head>
	<body>
	    <script src="https://unpkg.com/lodash@4.16.6"></script>
	    <script src="./src/index.js"></script>
	</body>
	</html>
```
修改package.json文件，增加`private`字段使我们的包私有化，同时删除`main`字段。这是为了防止意外发布我们的代码。**[更多关于package.json的内部机制见npm文档](https://docs.npmjs.com/files/package.json)** , package.json修改如下：

**package.json**

```json
	{
	  "name": "webpack-demo",
	  "version": "1.0.0",
	  "description": "",
	  "private": true,
	  "scripts": {
	    "test": "echo \"Error: no test specified\" && exit 1"
	  },
	  "keywords": [],
	  "author": "",
	  "license": "ISC",
	  "devDependencies": {
	    "webpack": "4.8.3",
	    "webpack-cli": "2.1.3"
	  }
	}
```
index.html中的`<script>`标签之间存在隐式依赖关系，index.js的运行依赖于`lodash`。虽然index.js没有显式声明与`lodash`的关系，但它假设全局变量 `_` 存在。

上述方式管理javascript项目存在的问题：

- 脚本对于外部库的依赖并不是显而易见的。(index.js没有显式声明与`lodash`的关系，假设全局变量 `_` 存在，表明index.js调用了lodash库)
- 如果依赖缺失或引入顺序有误，应用程序将无法运行。
- 如果引入的依赖并未使用，浏览器将下载不必要的代码。

接下来使用webpack来管理脚本。

## 创建一个捆绑(Creating a Bundle) ##
首先调整目录结构，将“源”代码（`/src`）与“分发”代码（`/dist`）分开。“源代码”是需要编写和编辑的代码，“分发”代码是构建过程的最小化和最优输出，并且最终将在浏览器中加载。修改后的目录结构如下：

**目录结构**
![修改后的目录结构](http://ou3oh86t1.bkt.clouddn.com/webpack-demo/%E4%BF%AE%E6%94%B9%E5%90%8E%E7%9A%84%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84.png)

为了捆绑`lodash`与index.js之间的依赖关系，需要在本地安装lodash库，命令如下：`npm install --save lodash`。

**注意：** 安装生产环境中用到的包时，需要使用`npm install --save`，开发环境时，使用`npm install --save-dev`。

接下来就可以在脚本中引入`lodash`，如下：

**src/index.js**
``` js
	import _ from 'lodash';
	
	function component() {
	    var element = document.createElement('div');
	
	    // lodash,通过此脚本引入
	    element.innerHTML = _.join(['Hello','webpack'],' ');
	
	    return element;
	
	}
	
	document.body.appendChild(component());
```

接下来需要更新index.html文件，首先去掉包含lodash的`<script>`标签，因为在index.js文件中通过`import`引入过了，然后修改另一个`<script>`标签来加载捆绑代替原来的`/src`文件：

**dist/index.html**
``` html
	<!DOCTYPE html>
	<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	    <title>Getting Started</title>
	</head>
	<body>
	    <!-- <script src="https://unpkg.com/lodash@4.16.6"></script> -->
	    <!-- <script src="./src/index.js"></script> -->
	    <script src="bundle.js"></script>
	</body>
	</html>
```
设置中，index.js明确要求lodash存在，并以 `_` （没有全局范围污染）绑定依赖关系。通过说明模块需要什么依赖关系，webpack可以使用这些信息来构建依赖关系图，然后使用该图生成一个优化的包，其中脚本将按正确的顺序执行。

运行`npx webpack`，以`src/index.js`脚本作为入口点，以`bundle.js`作为输出。
`npx`命令：需要Node 8.2或更高版本，会运行webpack的二进制文件（`./node_modules/.bin/webpack`）。结果如下：

```bash
$ npx webpack
npx: 1 安装成功，用时 3.16 秒
Path must be a string. Received undefined
C:\Users\Shirley\Desktop\webpack-demo\node_modules\webpack\bin\webpack.js
Hash: ac9a5fb5c51baf1f8804
Version: webpack 4.8.3
Time: 3225ms
Built at: 2018-05-13 21:35:31
  Asset    Size  Chunks             Chunk Names
main.js  70 KiB       0  [emitted]  main
Entrypoint main = main.js
[1] (webpack)/buildin/module.js 519 bytes {0} [built]
[2] (webpack)/buildin/global.js 509 bytes {0} [built]
[3] ./src/index.js 253 bytes {0} [built]
    + 1 hidden module

WARNING in configuration
The 'mode' option has not been set, webpack will fallback to 'production' for this value. Set 'mode' option to 'development' or 'production' to enable defaults for each environment.
You can also set it to 'none' to disable any default behavior. Learn more: https://webpack.js.org/concepts/mode/

```

接下来在浏览器中打开index.html，如果打包成功会显示文本 'Hello webpack'。

**注意踩坑！！！** 这里照着文档一步步来，发现浏览器没有文本内容，检查后发现，在index.html文件中引入打包后的脚本文件时示例代码给的打包脚本名字为`bundle.js`，但使用`npx webpack`生成的打包脚本名称为`main.js`,所以导致index.html文件没有正确的引入打包脚本文件。`dist/index.html`修改如下：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Getting Started</title>
</head>
<body>
    <script src="main.js"></script>
</body>
</html>
```
上面的坑在英文文档中，后来看了中文文档发现中文的改过来了。。

打包后的目录结构如下：
![打包后的目录结构](http://ou3oh86t1.bkt.clouddn.com/webpack-demo/%E6%89%93%E5%8C%85%E5%90%8E%E7%9A%84%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84.png)

## 模块(Modules) ##
在ES2015中`import`和`export`声明已经标准化，尽管大部分浏览器还不支持，但webpack支持。

webpack实际上对ES2015语法进行了转码，通过查看node_modules目录可以看到webpack通过引入babel-preset-es2015来进行ES2015语法的转码。除了`import`和`export`，的webpackk支持各种其他模块语法。
 
**注意：**  除了`import`和`export`声明，webpack不会改变其他代码，如果要使用ES2015的其他特性，请确保通过webpack loader系统使用了像babel这样的转码器。

## 使用一个配置文件(Using a Configuration) ##
在 webpack 4 中，可以无须任何配置使用，然而大多数项目会需要很复杂的设置，这就是为什么 webpack 仍然要支持 配置文件。这比在终端(terminal)中手动输入大量命令要高效的多，创建一个取代以上使用 CLI 选项方式的配置文件。

在项目根目录下创建webpack.config.js，用来配置webpack,内容如下：

``` js
const path = require('path');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist')
  }
};
```
通过新配置文件再次执行构建:`npx webpack --config webpack.config.js`。

**注意：** 如果 webpack.config.js 存在，则 webpack 命令将默认选择使用它。在这里使用 `--config` 选项只是表明，可以传递任何名称的配置文件，这对于需要拆分成多个文件的复杂配置是非常有用。

比起 CLI 这种简单直接的使用方式，配置文件具有更多的灵活性。可以通过配置方式指定 loader 规则、插件、解析选项，以及许多其他增强功能。

## NPM 脚本(NPM Scripts) ##
考虑到用 CLI 这种方式来运行本地的 webpack 不是特别方便，可以设置一个快捷方式，在 package.json 添加一个 npm 脚本(npm script)：
``` json
{
  "name": "webpack-demo",
  "version": "1.0.0",
  "description": "",
  "private": true,
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "build": "webpack"  //此处为添加的npm脚本
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "webpack": "4.8.3",
    "webpack-cli": "2.1.3"
  },
  "dependencies": {
    "lodash": "4.17.10"
  }
}
```
现在，可以使用 `npm run build` 命令，来替代之前使用的 `npx webpack` 命令生成打包脚本。

**注意：** 使用 npm 的 `scripts`，可以像使用 `npx` 那样通过模块名引用本地安装的 npm 包。这是大多数基于 npm 的项目遵循的标准，因为它允许所有贡献者使用同一组通用脚本（如果必要，每个 flag 都带有 `--config` 标志）。

**注意：** 通过向 `npm run build` 命令和你的参数之间添加两个中横线，可以将自定义参数传递给 webpack，例如：`npm run build -- --colors`。
