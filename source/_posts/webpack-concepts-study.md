---
title: (二)Webpack相关概念总结
date: 2018-05-14 09:19:45
tags: [Webpack]
categories: FrontEndFrame
---
关于webapck相关概念的学习总结。
<!--more-->

# 概念 #

webpack 是一个现代 JavaScript 应用程序的静态模块打包器(module bundler)。当 webpack 处理应用程序时，它会递归地构建一个依赖关系图(dependency graph)，其中包含应用程序需要的每个模块，然后将所有这些模块打包成一个或多个 bundle。

从 webpack v4.0.0 开始，可以不用引入配置文件，而webpack 仍然还是高度可配置的，通过在项目根目录下创建一个`webpack.config.js`文件用来配置webpack，在[(一)webpack入门总结](http://shirley5li.me/2018/05/14/webpack-start-first/)中已描述。

## 入口(entry) ##

**入口起点(entry point)** 指示 webpack 应该使用哪个模块，来作为构建其内部依赖图的开始。进入入口起点后，webpack 会找出有哪些模块和库是入口起点（直接和间接）依赖的。
eg: [(一)webpack入门总结](http://shirley5li.me/2018/05/14/webpack-start-first/)中`src/index.js`即为入口起点，如下：

**webpack.config.js**
```js
const path = require('path');

module.exports = {
  entry: './src/index.js',   //入口
  output: {   //出口
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist')
  }
};
```
**注意：** `path`模块为node.js的核心模块，用来操作文件路径。

## 出口(output) ##
`output` 属性指示 webpack 在哪里输出它所创建的 bundles，以及如何命名这些文件，默认输出在 `./dist`文件夹下。
如上的`webpack.config.js`配置中的`output`字段即为配置出口，通过 `output.filename` 和 `output.path` 属性，指示生成的 bundle 名称，以及 bundle 生成(emit)到哪个目录下，示例中生成的bundle名称为`mian.js`，生成到根目录下的`dist`文件夹下。

## loader ##
loader 让 webpack 能够去处理那些非 JavaScript 文件（webpack 自身只理解 JavaScript）。loader 可以将所有类型的文件转换为 webpack 能够处理的有效模块，然后就可以利用 webpack 的打包能力，对它们进行处理。

webpack loader 将所有类型的文件，转换为应用程序的依赖图（和最终的 bundle）可以直接引用的模块，loader 能够 `import` 导入任何类型的模块（例如 `.css` 文件）。

webpack 的配置中 loader 的两个目标：
- `test` 属性，用于标识出应该被对应的 loader 进行转换的某个或某些文件。
- `use` 属性，表示进行转换时，应该使用哪个 loader。

**webpack.config.js**
```js
const path = require('path');

const config = {
  output: {
    filename: 'my-first-webpack.bundle.js'
  },
  module: {
    rules: [   //定义loader
      { test: /\.txt$/, use: 'raw-loader' }
    ]
  }
};

module.exports = config;
```
以上配置中，对一个单独的 module 对象定义了 rules 属性，里面包含两个必须属性：`test` 和 `use`，相当于告诉webpack编译器在进行`require()`或`import`时如果遇到`.txt`文件路径，先使用`raw-loader`处理后再进行打包。

**注意：** 在 webpack 配置中定义 loader 时，要定义在 `module.rules` 中，而不是 `rules`。

## 插件(plugins) ##
loader 被用于转换某些类型的模块，而插件则可以用于执行范围更广的任务。插件的范围包括，从打包优化和压缩，一直到重新定义环境中的变量。

如何使用一个插件：在`webpack.config.js`配置文件中先`require()`该插件，然后将其添加到`plugins`数组中。以在一个配置文件中因为不同目的而多次使用同一个插件，这时需要通过使用 new 操作符来创建它的一个实例。

**webpack.config.js**
```js
const HtmlWebpackPlugin = require('html-webpack-plugin'); // 通过 npm 安装
const webpack = require('webpack'); // 用于访问内置插件

const config = {
  module: {
    rules: [
      { test: /\.txt$/, use: 'raw-loader' }
    ]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin(),
    new HtmlWebpackPlugin({template: './src/index.html'})
  ]
};

module.exports = config;
```

## 模式(mode) ##
通过选择 `development`(开发环境) 或 `production`(生产环境) 之中的一个，来设置 `mode` 参数，启用相应模式下的 webpack 内置的优化。

**webpack.config.js**
```js
module.exports = {
  mode: 'production'
};
```
# 入口起点(Entry Points) #
下面介绍如何配置`entry`属性。
## 单个入口（简写）语法 ##
方法：`entry: string|Array<string>`

**webpack.config.js**
```js
const config = {
  entry: './src/index.js'
};

module.exports = config;
```
entry 属性的单个入口语法，是下面形式的简写：
```js
const config = {
  entry: {
    main: './src/index.js'
  }
};
```
向 `entry` 属性传入「文件路径(file path)数组」将创建“多个主入口(multi-main entry)”。在想要多个依赖文件一起注入，并且将它们的依赖导向(graph)到一个“chunk”时，传入数组的方式就很有用。 

## 对象语法 ##
用法：`entry: {[entryChunkName: string]: string|Array<string>}`

**webpack.config.js**
```js
const config = {
  entry: {
    app: './src/app.js',
    vendors: './src/vendors.js'
  }
};
```
对象语法比较繁琐，但这是应用程序中定义入口的最可扩展的方式。

**“可扩展的 webpack 配置”：** 是指可重用并且可以与其他配置组合使用。这是一种流行的技术，用于将关注点(concern)从环境(environment)、构建目标(build target)、运行时(runtime)中分离，然后使用专门的工具（如 webpack-merge）将它们合并。

以上`webpack.config.js`配置中，`entry`属性作为分离应用程序(app) 和 第三方库(vendor)入口， webpack 从 `app.js` 和 `vendors.js` 开始创建依赖图，这些依赖图是彼此完全分离、互相独立的(每个 bundle 中都有一个 webpack 引导)，该种方式比较常见于，只有一个入口起点（不包括 vendor）的 **单页应用程序** 中。

**why？** 此设置允许使用 `CommonsChunkPlugin` 从「应用程序 bundle」中提取 vendor 引用到 vendor bundle，并把引用 vendor 的部分替换为 `__webpack_require__()` 调用，如果应用程序 bundle 中没有 vendor 代码，那么可以在 webpack 中实现被称为长效缓存的通用模式。（**不是很懂这个地方？？？**）

## 多页面应用程序 ##
**webpack.config.js**
```js
const config = {
  entry: {
    pageOne: './src/pageOne/index.js',
    pageTwo: './src/pageTwo/index.js',
    pageThree: './src/pageThree/index.js'
  }
};
```
改配置指示webpack 需要 3 个独立分离的依赖图。

在多页应用中，每当页面跳转时服务器将为获取一个新的 HTML 文档，页面重新加载新文档，并且资源被重新下载。然而，这给了我们特殊的机会去做很多事：
- 使用 `CommonsChunkPlugin` 为每个页面间的应用程序共享代码创建 bundle。由于入口起点增多，多页应用能够复用入口起点之间的大量代码/模块，从而可以极大地从这些技术中受益。

**注意：** 每个 HTML 文档只使用一个入口起点。

# 输出(Output) # 
配置 `output` 属性可以控制 webpack 如何向硬盘写入编译文件。
**注意：** 即使可以存在多个入口起点，但只指定一个输出配置。

## 用法 ##
配置 `output` 属性的最低要求是，将它的值设置为一个对象，包括以下两点：
- `filename` 用于输出文件的文件名。
- 目标输出目录 `path` 的 **绝对路径** 。

**webpack.config.js**
```js
const config = {
  output: {
    filename: 'bundle.js',
    path: '/home/proj/public/assets'
  }
};

module.exports = config;
```
## 多个入口起点 ##
如果配置创建了多个单独的 "chunk"（例如，使用多个入口起点或使用 `CommonsChunkPlugin` 这样的插件），则应该使用占位符来确保每个文件具有唯一的名称。

```js
{
  entry: {
    app: './src/app.js',
    search: './src/search.js'
  },
  output: {
    filename: '[name].js',
    path: __dirname + '/dist'
  }
}

// 写入到硬盘：./dist/app.js, ./dist/search.js
```
## 高级功能 ##
以下是使用 CDN 和资源 hash 的复杂示例：


**webpack.config.js**
```js
output: {
  path: "/home/proj/cdn/assets/[hash]",
  publicPath: "http://cdn.example.com/assets/[hash]/"
}
```
在编译时不知道最终输出文件的 `publicPath` 的情况下，`publicPath` 可以留空，并且在入口起点文件运行时动态设置,在入口起点设置 `__webpack_public_path__`，如下：

```js
__webpack_public_path__ = myRuntimePublicPath

// 剩余的应用程序入口
```
# 模式(Mode) #
`mode` 配置选项，指示 webpack 使用相应模式的内置优化。
## 用法 ##
(1) 在配置文件中提供`mode`属性：

```js
module.exports = {
  mode: 'production'
};
```
(2) 从 CLI 参数中传递: `webpack --mode=production`

支持以下字符串值：
![mode](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/webpack-demo/mode.png)
**注意：** 只设置 `NODE_ENV`，则不会自动设置 `mode`。

**mode:development**
```js
// webpack.development.config.js
module.exports = {
+ mode: 'development'
- plugins: [
-   new webpack.NamedModulesPlugin(),
-   new webpack.DefinePlugin({ "process.env.NODE_ENV": JSON.stringify("development") }),
- ]
}
```
**mode:production**
```js
// webpack.production.config.js
module.exports = {
+  mode: 'production',
-  plugins: [
-    new UglifyJsPlugin(/* ... */),
-    new webpack.DefinePlugin({ "process.env.NODE_ENV": JSON.stringify("production") }),
-    new webpack.optimize.ModuleConcatenationPlugin(),
-    new webpack.NoEmitOnErrorsPlugin()
-  ]
}
```
# loader #
loader 用于对模块的源代码进行转换。loader 可以使你在 import 或"加载"模块时预处理文件。
loader 可以将文件从不同的语言（如 TypeScript）转换为 JavaScript，或将内联图像转换为 data URL。loader 甚至允许你直接在 JavaScript 模块中 `import` CSS文件。
## 示例 ##
可以使用 loader 告诉 webpack 加载 CSS 文件，或者将 TypeScript 转为 JavaScript。为此，首先安装相对应的 loader：
```shell
npm install --save-dev css-loader
npm install --save-dev ts-loader
```
然后指示 webpack 对每个 `.css` 使用 `css-loader`，对每个 `.ts` 文件使用 `ts-loader`。

**webpack.config.js**
```js
module.exports = {
  module: {
    rules: [
      { test: /\.css$/, use: 'css-loader' },
      { test: /\.ts$/, use: 'ts-loader' }
    ]
  }
};
```
## 使用 loader ##
有三种使用 loader 的方式：
- 配置（推荐）：在 `webpack.config.js` 文件中指定 loader。
- 内联：在每个 `import` 语句中显式指定 loader。
- CLI：在 shell 命令中指定它们。
- 
### 配置 ###
在`webpack.config.js`配置文件中，通过`module.rules`指定多个 loader。

```js
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          { loader: 'style-loader' },
          {
            loader: 'css-loader',
            options: {
              modules: true
            }
          }
        ]
      }
    ]
  }
```
### 内联 ###
可以在 `import` 语句或任何等效于 "import" 的方式中指定 loader。使用 `!` 将资源中的 loader 分开。分开的每个部分都相对于当前目录解析。
``` js
import Styles from 'style-loader!css-loader?modules!./styles.css';
```
选项可以传递查询参数，例如 `?key=value&foo=bar`，或者一个 JSON 对象，例如 `?{"key":"value","foo":"bar"}`。

**注意：** 尽可能使用 `module.rules`，因为这样可以减少源码中的代码量，并且可以在出错时，更快地调试和定位 loader 中的问题。 
### CLI ###
可以通过 CLI 使用 loader:
```shell
webpack --module-bind jade-loader --module-bind 'css=style-loader!css-loader'
```
以上命令对 `.jade` 文件使用 `jade-loader`，对 `.css` 文件使用 `style-loader` 和 `css-loader`。
## loader特性 ##
- loader 支持链式传递。能够对资源使用流水线(pipeline)，一组链式的 loader 将按照相反的顺序执行。loader 链中的第一个 loader 返回值给下一个 loader，在最后一个 loader，返回 webpack 所预期的 JavaScript。
- loader 可以是同步的，也可以是异步的。
- loader 运行在 Node.js 中，并且能够执行任何可能的操作。
- loader 接收查询参数。用于对 loader 传递配置。
- loader 也能够使用 `options` 对象进行配置。
- 除了使用 `package.json` 常见的 `main` 属性，还可以将普通的 npm 模块导出为 loader，做法是在 `package.json` 里定义一个 `loader` 字段。
- 插件(plugin)可以为 loader 带来更多特性。
- loader 能够产生额外的任意文件。

# 插件(Plugins) #
插件是 wepback 的支柱功能，插件目的在于解决 loader 无法实现的其他事。

webpack 插件是一个具有 `apply` 属性的 JavaScript 对象。apply 属性会被 webpack compiler 调用，并且 compiler 对象可在整个编译生命周期访问。

**ConsoleLogOnBuildWebpackPlugin.js**
```js
const pluginName = 'ConsoleLogOnBuildWebpackPlugin';

class ConsoleLogOnBuildWebpackPlugin {
    apply(compiler) {
        compiler.hooks.run.tap(pluginName, compilation => {
            console.log("webpack 构建过程开始！");
        });
    }
}
```
compiler hook 的 tap 方法的第一个参数，应该是驼峰式命名的插件名称。建议为此使用一个常量，以便它可以在所有 hook 中复用。
## 配置 ##
由于插件可以携带参数/选项，必须在 webpack 配置中，向 `plugins` 属性传入 `new` 实例。

**webpack.config.js**
```js
const HtmlWebpackPlugin = require('html-webpack-plugin'); //通过 npm 安装
const webpack = require('webpack'); //访问内置的插件
const path = require('path');

const config = {
  entry: './path/to/my/entry/file.js',
  output: {
    filename: 'my-first-webpack.bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        use: 'babel-loader'
      }
    ]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin(),
    new HtmlWebpackPlugin({template: './src/index.html'})
  ]
};

module.exports = config;
```
## Node API ##
注意：即便使用 Node API，用户也应该在配置中传入 `plugins` 属性。`compiler.apply` 并不是推荐的使用方式。

**some-node-script.js**
```js
  const webpack = require('webpack'); //访问 webpack 运行时(runtime)
  const configuration = require('./webpack.config.js');

  let compiler = webpack(configuration);
  compiler.apply(new webpack.ProgressPlugin());

  compiler.run(function(err, stats) {
    // ...
  });
```
# 配置(Configuration) #
webpack 的配置文件，是导出一个对象的 JavaScript 文件,该导出对象由 webpack 根据对象定义的属性进行解析。

webpack 配置是标准的 Node.js CommonJS 模块：
- 通过 `require(...)` 导入其他文件
- 通过 `require(...)` 使用 npm 的工具函数
- 使用 JavaScript 控制流表达式，例如 `?:` 操作符
- 对常用值使用常量或变量
- 编写并执行函数来生成部分配置

**应避免以下做法:**
- 在使用 webpack 命令行接口(CLI)（应该编写自己的命令行接口，或使用 `--env`）时，访问命令行接口(CLI)参数
- 导出不确定的值（调用 webpack 两次应该产生同样的输出文件）
- 编写很长的配置（应该将配置拆分为多个文件）

## 基本配置 ##
**webpack.config.js**
```js
var path = require('path');

module.exports = {
  mode: 'development',
  entry: './foo.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'foo.bundle.js'
  }
};
```
## 多个 Target ##
导出多个配置，当运行 webpack 时，所有的配置对象都会构建。
```js
module.exports = [{
  output: {
    filename: './dist-amd.js',
    libraryTarget: 'amd'
  },
  entry: './app.js',
  mode: 'production',
}, {
  output: {
    filename: './dist-commonjs.js',
    libraryTarget: 'commonjs'
  },
  entry: './app.js',
  mode: 'production',
}]
```
## 使用其他配置语言 ##
webpack 接受以多种编程和数据语言编写的配置文件。使用 [node-interpret](https://github.com/js-cli/js-interpret)，webpack 可以处理许多不同类型的配置文件。

# 模块(Modules) #
在模块化编程中，开发者将程序分解成离散功能块(discrete chunks of functionality)，并称之为_模块_。
Node.js 从最一开始就支持模块化编程。然而，在 web，模块化的支持正缓慢到来。在 web 存在多种支持 JavaScript 模块化的工具。
## webpack 模块 ##
对比 Node.js 模块，webpack _模块_能够以各种方式表达它们的依赖关系：
- ES2015 `import` 语句
- CommonJS `require()` 语句
- AMD `define` 和 `require` 语句
- css/sass/less 文件中的 `@import` 语句
- 样式(`url(...)`)或 HTML 文件(`<img src=...>`)中的图片链接(image url)

**注意：** webpack 1 需要特定的 loader 来转换 ES 2015 `import`，然而通过 webpack 2 可以开箱即用。 
## 支持的模块类型 ##
CoffeeScript、TypeScript、ESNext (Babel)、Sass、Less、Stylus。

webpack 通过 loader 可以支持各种语言和预处理器编写模块。loader 描述了 webpack 如何处理 非 JavaScript(non-JavaScript) _模块_，并且在bundle中引入这些_依赖_。
 
# 模块解析(Module Resolution) #
resolver 是一个库(library)，用于帮助找到引入模块的绝对路径。当打包模块时，webpack 使用 `enhanced-resolve` 来解析文件路径。

## webpack 中的解析规则 ##
使用 `enhanced-resolve`，webpack 能够解析三种文件路径：

**绝对路径**
```js
import "/home/me/file";

import "C:\\Users\\me\\file";
```
**相对路径**
```js
import "../src/file1";
import "./file2";
```
此时，使用 `import` 或 `require` 的资源文件(resource file)所在的目录被认为是上下文目录(context directory)。在 `import/require` 中给定的相对路径，会添加此上下文路径(context path)，以产生模块的绝对路径(absolute path)。

**模块路径**
```js
import "module";
import "module/lib/file";
```
模块将在 `resolve.modules` 中指定的所有目录内搜索。 可以替换初始模块路径，此替换路径通过使用 `resolve.alias` 配置选项来创建一个别名。

接下来，解析器(resolver)将检查路径是否指向文件或目录。如果路径指向一个文件：
- 如果路径具有文件扩展名，则被直接将文件打包。
- 否则，将使用 [`resolve.extensions`] 选项作为文件扩展名来解析，此选项告诉解析器在解析中能够接受哪些扩展名（例如 .js, .jsx）

如果路径指向一个文件夹，则采取以下步骤找到具有正确扩展名的正确文件：
- 如果文件夹中包含 `package.json` 文件，则按照顺序查找 `resolve.mainFields` 配置选项中指定的字段，并且 `package.json` 中的第一个这样的字段确定文件路径
- 如果 `package.json` 文件不存在或者 `package.json` 文件中的 main 字段没有返回一个有效路径，则按照顺序查找 `resolve.mainFiles` 配置选项中指定的文件名，看是否能在 import/require 目录下匹配到一个存在的文件名。
- 文件扩展名通过 `resolve.extensions` 选项采用类似的方法进行解析。

## 解析 Loader(Resolving Loaders) ##
Loader 解析遵循与文件解析器指定的规则相同的规则。但是 `resolveLoader` 配置选项可以用来为 Loader 提供独立的解析规则。

## 缓存 ##
每个文件系统访问都被缓存，以便更快触发对同一文件的多个并行或串行请求。在观察模式下，只有修改过的文件会从缓存中摘出。如果关闭观察模式，在每次编译前清理缓存。

# 依赖图(Dependency Graph) #
一个文件依赖于另一个文件，webpack 就把此视为文件之间有依赖关系。这使得 webpack 可以接收非代码资源(non-code asset)（例如图像或 web 字体），并且可以把它们作为_依赖_提供给你的应用程序。

webpack 从命令行或配置文件中定义的一个模块列表开始，处理你的应用程序。 从这些入口起点开始，webpack 递归地构建一个依赖图，这个依赖图包含着应用程序所需的每个模块，然后将所有这些模块打包为少量的 bundle (通常只有一个)可由浏览器加载。

**补充：**
对于 HTTP/1.1 客户端，由 webpack 打包你的应用程序会尤其强大，因为在浏览器发起一个新请求时，它能够减少应用程序必须等待的时间。
对于 HTTP/2，你还可以使用代码拆分(Code Splitting)以及通过 webpack 打包来实现最佳优化。

# Manifest #
在使用 webpack 构建的典型应用程序或站点中，有三种主要的代码类型：
- 你或你的团队编写的源码。
- 你的源码会依赖的任何第三方的 library 或 "vendor" 代码。
- webpack 的 runtime 和 manifest，管理所有模块的交互。

## Runtime ##
runtime，以及伴随的 manifest 数据，主要是指：在浏览器运行时，webpack 用来连接模块化的应用程序的所有代码。

runtime 包含：在模块交互时，连接模块所需的加载和解析逻辑。包括浏览器中的已加载模块的连接，以及懒加载模块的执行逻辑。
## Manifest ##
当编译器(compiler)开始执行、解析和映射应用程序时，Manifest会保留所有模块的详细要点，这个数据集合称为 "Manifest"，当完成打包并发送到浏览器时，会在运行时通过 Manifest 来解析和加载模块。

无论你选择哪种模块语法，那些 `import` 或 `require` 语句现在都已经转换为 `__webpack_require__` 方法，此方法指向模块标识符(module identifier)。通过使用 manifest 中的数据，runtime 将能够查询模块标识符，检索出背后对应的模块。

## 缓存优化 ##
通过manifest，使用浏览器缓存来改善项目的性能。

通过使用 bundle 计算出内容散列(content hash)作为文件名称，这样在内容或文件修改时，浏览器中将通过新的内容散列指向新的文件，从而使缓存无效。

# 构建目标(Targets) #
因为服务器和浏览器代码都可以用 JavaScript 编写，所以 webpack 提供了多种构建目标(target)。

## 用法 ##
**webpack.config.js**
```js
module.exports = {
  target: 'node'
};
```
使用 `node` webpack 会编译为用于「类 Node.js」环境（使用 Node.js 的 `require` ，而不是使用任意内置模块（如 `fs` 或 `path`）来加载 chunk）。
## 多个 Target ##
webpack 不支持向 `target` 传入多个字符串，可以通过打包两份分离的配置来创建同构的库:
```js
var path = require('path');
var serverConfig = {
  target: 'node',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'lib.node.js'
  }
  //…
};

var clientConfig = {
  target: 'web', // <=== 默认是 'web'，可省略
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'lib.js'
  }
  //…
};

module.exports = [ serverConfig, clientConfig ];
```
# 模块热替换(Hot Module Replacement) #
模块热替换(HMR - Hot Module Replacement)功能会在应用程序运行过程中替换、添加或删除模块，而无需重新加载整个页面。主要是通过以下几种方式，来显著加快开发速度：
- 保留在完全重新加载页面时丢失的应用程序状态。
- 只更新变更内容，以节省宝贵的开发时间。
- 调整样式更加快速 - 几乎相当于在浏览器调试器中更改样式。

## 在应用程序中 ##
通过以下步骤，可以做到在应用程序中置换(swap in and out)模块：

    1.应用程序代码要求 HMR runtime 检查更新。
    2.HMR runtime（异步）下载更新，然后通知应用程序代码。
    3.应用程序代码要求 HMR runtime 应用更新。
    4.HMR runtime（异步）应用更新。
可以设置 HMR，以使此进程自动触发更新，或者你可以选择要求在用户交互时进行更新。

## 在编译器中 ##
除了普通资源，编译器(compiler)需要发出 "update"，以允许更新之前的版本到新的版本。"update" 由两部分组成：

    1.更新后的 manifest(JSON)
    2.一个或多个更新后的 chunk (JavaScript)
manifest 包括新的编译 hash 和所有的待更新 chunk 目录。每个更新 chunk 都含有对应于此 chunk 的全部更新模块（或一个 flag 用于表明此模块要被移除）的代码。

编译器确保模块 ID 和 chunk ID 在这些构建之间保持一致。通常将这些 ID 存储在内存中（例如，使用 webpack-dev-server 时），但是也可能将它们存储在一个 JSON 文件中。
## 在模块中 ##
HMR 是可选功能，只会影响包含 HMR 代码的模块。举个例子，通过 `style-loader` 为 style 样式追加补丁。 为了运行追加补丁，`style-loader` 实现了 HMR 接口；当它通过 HMR 接收到更新，它会使用新的样式替换旧的样式。

类似的，当在一个模块中实现了 HMR 接口，你可以描述出当模块被更新后发生了什么。然而在多数情况下，不需要强制在每个模块中写入 HMR 代码。如果一个模块没有 HMR 处理函数，更新就会冒泡。这意味着一个简单的处理函数能够对整个模块树(complete module tree)进行更新。如果在这个模块树中，一个单独的模块被更新，那么整组依赖模块都会被重新加载。
## 在 HMR Runtime 中 ##
对于模块系统的 runtime，附加的代码被发送到 `parents` 和 `children` 跟踪模块。在管理方面，runtime 支持两个方法 `check` 和 `apply`。

`check` 发送 HTTP 请求来更新 manifest。如果请求失败，说明没有可用更新。如果请求成功，待更新 chunk 会和当前加载过的 chunk 进行比较。对每个加载过的 chunk，会下载相对应的待更新 chunk。当所有待更新 chunk 完成下载，就会准备切换到 `ready` 状态。

`apply` 方法将所有被更新模块标记为无效。对于每个无效模块，都需要在模块中有一个更新处理函数，或者在它的父级模块们中有更新处理函数。否则，无效标记冒泡，并也使父级无效。每个冒泡继续直到到达应用程序入口起点，或者到达带有更新处理函数的模块（以最先到达为准）。如果它从入口起点开始冒泡，则此过程失败。

之后，所有无效模块都被（通过 `dispose` 处理函数）处理和解除加载。然后更新当前 `hash`，并且调用所有 "accept" 处理函数。runtime 切换回闲置状态，一切照常继续。

在开发过程中，可以将 HMR 作为 LiveReload 的替代。webpack-dev-server 支持 `hot` 模式，在试图重新加载整个页面之前，热模式会尝试使用 HMR 来更新。