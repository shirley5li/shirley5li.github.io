---
title: React实战项目news基础知识总结
date: 2018-05-28 22:59:38
tags: [React, antd]
categories: React
---
React实战项目news基础知识学习总结部分。
<!--more-->
# React安装及开发环境配置(v16.2.0) #

使用npm包的形式下载及管理，不推荐使用cdn的形式直接引用和独立安装的形式。

**项目初始化：**

新建一个空文件夹，然后使用`npm init`初始化该项目，会生成一个package.json文件，之后的包管理会在该文件中配置。

**create-react-app的安装** ：

`create-react-app` 是一个全局的命令行工具用来创建一个新的项目。

**（更新补充）：** 如果使用了`create-react-app`命令来创建一个单页应用，就不需要`npm init`了，该命令已经自动化配置好了相关的开发环境，包括babel和webpack。

看了一些视频教程和博客，可能他们搭建环境时的react版本比较早，所以他们的npm包安装过程涉及react(react核心库)、react-dom(与DOM相关的功能)、babel(将 ES6 代码转为 ES5 代码,对 JSX 的支持)，我查看了下最新的官方文档，可以使用如下命令安装react及开启一个新应用，应该是最新版本的`Create React App`已经设置好了会一起下载包括babel等在内的开发环境需要的npm包，需要先全局安装`create-react-app`这个全局命令，如下：

```
npm install -g create-react-app
```
然后利用`create-react-app`命令创建一个名为react_newsapp的react应用(**注意：**react应用的名字中不能包含大写字母)并启动，命令如下：


	create-react-app react_newsapp
	
	cd react_newsapp
	npm start

在使用`create-react-app react_newsapp`命令创建应用时，由以下安装提示可以发现，`create-react-app`会帮你自动下载所需要的多个react应用的基本依赖包,例如react,react-dom等。

![create-react-app创建应用](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/create-react-app%E5%AE%89%E8%A3%85.png)

**阿西吧的事情又发生了。。。于是又卡在了下载资源这一步**，由于`create-react-app`命令默认使用的npm源，真的是下载起来慢的无以表达，几度安装失败，挂了vpn也不行，最终放弃，换到 **淘宝的镜像源** 。由于`create-react-app`指令默认调用npm，于是直接把npm的register给永久设置过来就好了，这样使用cnpm或者npm就没差别了。参考博客[create-react-app慢的解决方法](https://blog.csdn.net/eagyne/article/details/53780653)，方法操作如下：

	npm config set registry https://registry.npm.taobao.org

	-- 配置后可通过下面方式来验证是否成功
	npm config get registry
	-- 或npm info express

设置成功后，再执行`create-react-app react_newsapp`，安装成功后提示如下，使用了淘宝镜像源都下了一会儿，不然真要下到地老天荒。

![create-react-app创建应用2](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/create-react-app%E5%AE%89%E8%A3%852.png)
安装成功后可以在项目的根目录下的package.json中查看引入的依赖，可以看到包括react、react-dom、react-scripts，如下：

	{
	  "name": "react_newsapp",
	  "version": "0.1.0",
	  "private": true,
	  "dependencies": {
	    "react": "^16.3.1",
	    "react-dom": "^16.3.1",
	    "react-scripts": "1.1.4"
	  },
	  "scripts": {
	    "start": "react-scripts start",
	    "build": "react-scripts build",
	    "test": "react-scripts test --env=jsdom",
	    "eject": "react-scripts eject"
	  }
	}
然后使用以下命令开启你创建的应用：

	cd react_newsapp
	npm start

**参考博客(环境搭建)** ：[使用 create-react-app 构建 react应用程序 （react-scripts） ](https://blog.csdn.net/github_squad/article/details/57452333)

**！！！注意** ：

(1)教程是手动安装的react的依赖包，我查看了下，使用命令`create-react-app react_newsapp`后，在node_modules目录下，没有自动安装babelify依赖包，但有babel-preset-react，不知道到时候操作用不用得到，先记录下。手动安装babelify、babel-preset-react、babel-preset-es2015依赖包命令：`npm install --save babelify babel-preset-react babel-preset-es2015`

**更正补充：**  试了下安装`babel-preset-es2015`，但babel提示说最新的版本叫`babel-preset-env`，然后查看了下`create-react-app`自动安装的依赖包里已经有这个包了，所以不必再装老版本的`babel-preset-es2015`。（感叹。。。包包们变得如此之快。。。。）

**npm删除包** 命令：`npm uninstall <package name>`

(2)`create-react-app`使用像 Babel 和 webpack 这样的构建工具，但是已经为你配置好了，可以零配置使用。

## React环境配置与调试技巧 ##
虽然 React 可以在没有构建管道的情况下使用，但是建议配置它，以便提高效率。一个现代构建管道通常包括：

- 一个 包管理器(package manager) ，如 `Yarn` 或 `npm` 。它可以让您利用大量的第三方软件包生态系统，并轻松安装或更新它们。
    
- 一个 打包工具(bundler) ，如`webpack` 或 `Browserify`。它允许您编写模块化代码并将他们在一起，成为一个小包，以实现加载性能的优化，节省加载时间。

- 一个 编译器(compiler) ，如`Babel`。 它可以让你在编写现代 JavaScript 代码的同时兼容旧版本浏览器.

### 手动安装webpack时 ###
全局安装：`npm install -g webpack` -> `npm install -g webpack-dev-server`
当前项目安装： `npm install webpack --save` -> `npm install webpack-dev-server --save` 
## create-react-app的目录结构 ##
使用` create-react-app`命令创建的项目目录结构默认如下所示：

![目录结构](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/create-react-app%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84.png)

node_modules文件夹内是安装的所有依赖模块；

package.json文件定义了项目的基本信息，如项目名称、版本号、在该项目下可执行的命令及项目的依赖模块等，如下：

``` json

	{
	  "name": "react_newsapp",
	  "version": "0.1.0",
	  "private": true,
	  "dependencies": {
	    "react": "^16.3.1",
	    "react-dom": "^16.3.1",
	    "react-scripts": "1.1.4"
	  },
	  "scripts": {
	    "start": "react-scripts start",
	    "build": "react-scripts build",
	    "test": "react-scripts test --env=jsdom",
	    "eject": "react-scripts eject"
	  }
	}
```
public文件夹下的index.html是应用的入口页面；src文件夹下是项目源代码，其中index.js是代码入口，可以在index.js中引入其他的模块(在这些模块中定义不同组建，将组件模块化)。
`public/index.html` 是页面模板;`src/index.js` 是JavaScript的入口点，这两项不要修改名称或删除，其他的文件任意。（若要修改入口点，需要自己修改webpack的配置文件）
**注意：** 把自己的js与css都放到src文件夹内，否则webpack无法打包；把index.html里用到的所有文件都放在Public文件夹下，否则无法使用。
### 脚手架自定义webpack配置 ###
(1) react默认配置文件都是隐藏的，如果要自定义，运行`npm run eject`，提示eject为不可恢复操作，输入y或者y开头的单词，即可进行eject。[Create-React-App的Webpack配置](https://blog.csdn.net/sunhaobo1996/article/details/80264554)
(2) 点开package.json文件，可看到配置的命令是以 `"react-scripts *"` 来执行，所以打开node_modules文件夹，找到react-scripts文件夹进去， config目录即是你需要找的webpack的配置文件，然后就自己去修改配置就好。
webpack.config有两个，一个是dev（开发）环境下的配置文件，一个为prod（生产环境下，即npm run build的配置文件）环境下的配置文件。paths为各种路径，我们可以在这个文件中添加我们自己的路径。
需要修改的内容其实没多少，主要集中在entry入口跟output出口。

这里暂且不修改webpack的配置，就用create-react-app默认的脚手架，后面需要再修改(其实是看了看脚手架的配置文件太复杂了...)。接下来将`src`目录下的js文件们或者css文件们单独放到js目录或css目录下，整理一下不那么乱，然后再修改下对应文件的引入路径，让`hello world`跑起来。
整理src目录结构如下：
![整理后的目录结构](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/%E4%BF%AE%E6%94%B9%E5%90%8E%E7%9A%84%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84.png)

### webpack热加载配置 ###
(1) `Create React App` 不会处理后端逻辑或数据库，它只是创建一个前端构建管道（build pipeline），所以可以使用它来配合任何想使用的后端。它使用 `Babel` 和 `webpack` 这样的构建工具，但是在使用`create-react-app`命令创建项目时已经配置好了，可以零配置使用，自带热加载效果。

(2)不使用脚手架时配置热加载。
不使用`create-react-app`脚手架时，每次改动文件，都需要重新执行`webpack`命令才能重新打包文件，手动刷新浏览器体现改动效果。可以使用`webpack --watch`实现每次修改文件后不用手动执行`webpack`即可在刷新浏览器后看到改动效果，即webpack会自己打包编译改动过的文件。即使使用了`webpack --watch`命令可以自动打包编译改动过的文件，但还需要手动刷新浏览器才能看到效果，热加载配置就是在改动文件后，在浏览器中自动体现更改后的效果。

运行`webpack-dev-server`命令，然后将生成的app本地运行地址`localhost:8080/webpack-dev-server`贴到浏览器，即可实现自动刷新。如果还想去掉上面运行地址的尾巴`webpack-dev-server`，即使用类似`localhost:8080`地址即可观察应用的热加载。使用如下配置：
```shell
webpack-dev-server --contentbase src --inline --hot
```
其中`contentbase src `表示应用的默认运行目录。运行完上述命令，就会生成应用的本地运行地址`localhost:8080`。

# React组件 #
## JSX内置表达式 ##
(1)三元表达式
使用方式如下：
```jsx
class Body extends Component {
    render() {
        var userName = 'Shirley';
        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{userName === '' ? '用户未登录' : '用户名' + userName}</p>
            </div>
        );
    }
}
```
(2)元素属性变量值的使用
```jsx
class Body extends Component {
    render() {
        var userName = 'Shirley';
        var boolInput = true;
        
        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{userName === '' ? '用户未登录' : '用户名' + userName}</p>
                <p>
                    <input type="button" value={userName} disabled={boolInput}/>
                </p>
            </div>
        );
    }
}
```
(3)jsx注释
```jsx
class Body extends Component {
    render() {
        var userName = 'Shirley';
        var boolInput = true;

        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{userName === '' ? '用户未登录' : '用户名' + userName}</p>
                <p>
                    <input type="button" value={userName} disabled={boolInput}/>
                </p>
                {/* 注释 */}
            </div>
        );
    }
}
```
(4)jsx解析html
将html中的空格字符使用unicode转码，jsx解析后会在页面显示空格。若html变量中使用`&nbsp;`这样的html实体，jsx不会将其解析为空格，还是输出字符串。
```jsx
class Body extends Component {
    render() {
        var userName = 'Shirley';
        var boolInput = true;
        var htmlStr1 = 'Hello\u0020Stranger1';
        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{userName === '' ? '用户未登录' : '用户名' + userName}</p>
                <p>
                    <input type="button" value={userName} disabled={boolInput}/>
                </p>
                {/* 注释 */}
				<p>{htmlStr1}</p>
            </div>
        );
    }
}
```
但该种方式还需要在后台设置unicode转码，比较麻烦。(注意：即使在htmlStr的`Hello`和`Stranger`之间添加多个`\u0020`，页面还是显示一个空格)

第二种方式是使用标签的`dangerouslySetInnerHTML`属性，但该属性可能造成XSS漏洞，也不建议使用，将要显示的html字符串挂载到`__html`这样一个变量上。
```jsx
class Body extends Component {
    render() {
        var userName = 'Shirley';
        var boolInput = true;
        var htmlStr1 = 'Hello\u0020Stranger1';
        var htmlStr2 = 'Hello&nbsp;Stranger2';
        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{userName === '' ? '用户未登录' : '用户名' + userName}</p>
                <p>
                    <input type="button" value={userName} disabled={boolInput}/>
                </p>               
                {/* 注释 */}
                <p>{htmlStr1}</p>
                <p dangerouslySetInnerHTML= {{__html : htmlStr2}}></p>
                {htmlStr2}
            </div>
        );
    }
}
```
显示效果对比如下：
![jsx解析html](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/jsx%E8%A7%A3%E6%9E%90html.png)
## 生命周期 ##
![生命周期](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F.png)

src/components/body.js
```jsx
class Body extends Component {
    componentWillMount() {
        console.log("Body-componentWillMount");
    }

    componentDidMount() {
        console.log("Body-componentDidMount");
    }
}
```
src/components/App.js
```jsx
import React, { Component } from 'react';

import ComponentHeader from './header';
import ComponentFooter from './footer';
import Body from './body';

class App extends Component { 
  componentWillMount() {
    console.log("App-componentWillMount");
  }

  componentDidMount() {
    console.log("App-componentDidMount");
  }
  render() {
    return (
      <div className="App">
        <ComponentHeader />
        <Body />
        <ComponentFooter />
      </div>
    );
  }
}
export default App;
```
不同组件的加载顺序如下：
![不同组件的加载顺序](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/%E4%B8%8D%E5%90%8C%E7%BB%84%E4%BB%B6%E7%9A%84%E5%8A%A0%E8%BD%BD%E9%A1%BA%E5%BA%8F.png)
## 状态state ##
`state` -> 虚拟DOM -> DOM
`state`是组件自身内部的属性，只会影响所在的组件，不会污染外部组件。
```jsx
class Body extends Component {
    constructor() {
        super(); //调用基类的所有初始化方法
        this.state = {userName: "Shirley"}; //初始化赋值
    }

    render() {

        setTimeout(() => {
            this.setState({userName: "Hello"}); //2s后改变 state 的值
        }, 2000);
        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{this.state.userName}</p>              
            </div>
        );
    }
}
```
React中页面的刷新，只会作Diff有差异部分的刷新，比如一秒后对`<p>`标签内容的刷新，不会对整个页面进行刷新。
初始化可以放在constructor构造函数里。
**调试技巧：** Google控制台- > console -> show console drawer -> Rendering -> Paint flashing，会高亮当前改变的区域。

## 属性props（父组件->子组件） ##
`state`和`props`会影响组件`component`，进一步影响UI。`props`是组件与外部沟通的桥梁，父组件通过`props`将自身的数据传递给子组件。而`state`是组件内部的属性，不会影响其他组件。
```jsx
class App extends Component { 

  render() {
    return (
      <div className="App">
        <ComponentHeader />
        <Body userId={123} />
        <ComponentFooter />
      </div>
    );
  }
}

class Body extends Component {
    constructor() {
        super(); //调用基类的所有初始化方法
        this.state = {userName: "Shirley"}; //初始化赋值
    }

    render() {

        setTimeout(() => {
            this.setState({userName: "Hello"}); //2s后改变 state 的值
        }, 2000);
        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{this.state.userName}</p>
                <p>{this.props.userId}</p>              
            </div>
        );
    }
}
```
## 子组件向父组件传递参数 ##
事件绑定如下：
```jsx
class Body extends Component {
    constructor() {
        super(); //调用基类的所有初始化方法
        this.state = {userName: "Shirley"}; //初始化赋值
    }

    changeUserInfo() {
        this.setState({userName: "Your name has changed!"});
    }

    render() {
        // setTimeout(() => {
        //     this.setState({userName: "Hello"}); //2s后改变 state 的值
        // }, 2000);

        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{this.state.userName}</p>
                <p>{this.props.userId}</p> 
                <input type="button" value="提交" onClick={this.changeUserInfo.bind(this)} />             
            </div>
        );
    }
}
```
其中`onClick={this.changeUserInfo.bind(this)}`是在调用时绑定this,可以使用ES6语法，如`onClick={() => this.changeUserInfo()}`。也可以直接在构造函数constructor里绑定this，`this.changeUserInfo = this.changeUserInfo.bind(this);`。

**子组件向父组件传递数据：** 只能通过事件的形式，从子组件向父组件传递数据。通过在父组件中事先定义好处理子组件事件的函数，并且以props属性的形式，将该事件处理函数传递给子组件，从而实现子组件向父组件传递数据。

例如在`<Body/>`组件中添加子组件`<BodyChild/>`，并且事先定义好了子组件在输入值改变时的事件处理函数`handleChildValueChange(event)`，以子组件属性的形式(`<BodyChild handleChildValueChange={this.handleChildValueChange.bind(this)}/> `)将该事件处理函数传递给子组件，从而实现从子组件`<BodyChild/>`向父组件`<Body/>`传递数据。

父组件`<Body/>`:
```jsx
class Body extends Component {
    constructor() {
        super(); //调用基类的所有初始化方法
        this.state = {userName: "Shirley"}; //初始化赋值
    }

    changeUserInfo() {
        this.setState({userName: "Your name has changed!"});
    }

    handleChildValueChange(event) { //通过事件形式，获取子组件的数据
        this.setState({userName: event.target.value});
    }
    render() {

        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{this.state.userName}</p>
                <p>{this.props.userId}</p> 
                <input type="button" value="提交" onClick={() => this.changeUserInfo()} />
                {/* BodyChild 子组件 */}
                <BodyChild handleChildValueChange={this.handleChildValueChange.bind(this)}/>             
            </div>
        );
    }
}
```
子组件`<BodyChild/>`:
```jsx
class BodyChild extends Component {
    render() {
        return (
            <div>
                <p>子页面输入:<input type="text" onChange={this.props.handleChildValueChange}/></p>
            </div>
        );
    }
}
```
这样当子组件文本输入框内的值改变时，会实时反映到父组件的`<p>{this.state.userName}</p>`区域。

## props属性校验 ##
props是一个组件对外暴露的接口，React提供了PropTypes对象，用于校验组件属性的类型。
以Body组件为例，当类定义完之后，可以通过`Body.propTypes`形式，限定Body组件属性值的类型。如下：
```
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import BodyChild from './bodyChild';


class Body extends Component {
    constructor() {
        super(); //调用基类的所有初始化方法
        this.state = {userName: "Shirley"}; //初始化赋值
    }

    changeUserInfo() {
        this.setState({userName: "Your name has changed!"});
    }

    handleChildValueChange(event) { //通过事件形式，获取子组件的数据
        this.setState({userName: event.target.value});
    }
    render() {

        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{this.state.userName}</p>
                {/* 通过 PropTypes 对象校验uesrId的类型 */}
                <p>{this.props.userId}</p> 
                <input type="button" value="提交" onClick={() => this.changeUserInfo()} />
                {/* BodyChild 子组件 */}
                <BodyChild handleChildValueChange={this.handleChildValueChange.bind(this)}/>             
            </div>
        );
    }
}

// Body组件props属性校验
Body.propTypes = {
    userId: PropTypes.number
};

export default Body;
```
当在Body父组件App中，通过props传递一个字符串给Body组件的userId属性，会报错：
```jsx
import React, { Component } from 'react';

import ComponentHeader from './header';
import ComponentFooter from './footer';
import Body from './body';

class App extends Component { 

  render() {
    return (
      <div className="App">
        <ComponentHeader />
        {/* Body组件通过 PropTypes对象校验uesrId的类型必须为Number类型 */}
        <Body userId={"hello"} />
        <ComponentFooter />
      </div>
    );
  }
}
export default App;
```
![props类型校验](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/%E5%B1%9E%E6%80%A7%E7%B1%BB%E5%9E%8B%E6%A0%A1%E9%AA%8C.png)

**为组件属性指定默认值：** 当组件属性未被赋值时，组件会使用defaultProps定义的默认属性。
```jsx
Body.defaultProps = {
    userId: 123
};
//或在组件头部定义
const defaultProps = {
    userId: 123
};
```
**传递当前组件的所有props参数的快捷方式：** 利用`...`展开运算符。
```jsx
<Body {...this.props} more="values" />
```
## 组件的Refs ##
Refs主要用来获取纯 HTML DOM节点，例如对`<input>`标签作focus处理，文本的选择等需要操作真实DOM的地方。绝大多数场景下，应该避免使用ref，因为它破坏了React中以props为数据传递介质的典型数据流。

第一种在React中操作真实DOM的方法如下，就像在原生js中操作DOM元素一样：
```jsx
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import ReactDOM from 'react-dom';
import BodyChild from './bodyChild';


class Body extends Component {
    constructor() {
        super(); //调用基类的所有初始化方法
        this.state = {userName: "Shirley"}; //初始化赋值
    }

    changeUserInfo() {
        this.setState({userName: "Your name has changed!"});
        // 第一种方式操作DOM
        var submitBtn = document.getElementById("submitBtn");
        ReactDOM.findDOMNode(submitBtn).style.color = 'red';
    }

    handleChildValueChange(event) { //通过事件形式，获取子组件的数据
        this.setState({userName: event.target.value});
    }
    render() {

        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{this.state.userName}</p>
                {/* 通过 PropTypes 对象校验uesrId的类型 */}
                <p>{this.props.userId}</p> 
                {/* 操作真实DOM */}
                <input id="submitBtn" type="button" value="提交" onClick={() => this.changeUserInfo()} />
                {/* BodyChild 子组件 */}
                <BodyChild handleChildValueChange={this.handleChildValueChange.bind(this)}/>             
            </div>
        );
    }
}
```
第二种通过ref属性操作真实DOM，该方式更接近React的思维，推荐使用此方式进行必要的DOM操作：
```jsx
import React, { Component } from 'react';
import PropTypes from 'prop-types';
// import ReactDOM from 'react-dom';
import BodyChild from './bodyChild';


class Body extends Component {
    constructor() {
        super(); //调用基类的所有初始化方法
        this.state = {userName: "Shirley"}; //初始化赋值
    }

    changeUserInfo() {
        this.setState({userName: "Your name has changed!"});
        // 第一种方式操作真实DOM
        // var submitBtn = document.getElementById("submitBtn");
        // ReactDOM.findDOMNode(submitBtn).style.color = 'red';

        // 第二种方式操作真实DOM
        console.log(this.refs.submitBtn);
        this.refs.submitBtn.style.color = 'red';
    }

    handleChildValueChange(event) { //通过事件形式，获取子组件的数据
        this.setState({userName: event.target.value});
    }
    render() {

        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{this.state.userName}</p>
                {/* 通过 PropTypes 对象校验uesrId的类型 */}
                <p>{this.props.userId}</p> 
                {/* 操作真实DOM */}
                <input id="submitBtn" ref="submitBtn" type="button" value="提交" onClick={() => this.changeUserInfo()} />
                {/* BodyChild 子组件 */}
                <BodyChild handleChildValueChange={this.handleChildValueChange.bind(this)}/>             
            </div>
        );
    }
}
```
`console.log(this.refs.submitBtn)`结果：
![ref操作DOM](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/ref%E6%93%8D%E4%BD%9CDOM.png)
**Refs特点：**
Refs是访问到组件内部DOM节点唯一可靠的方法。
Refs会自动销毁对子组件的引用，即如果子组件被销毁，它的引用也会被销毁，从而不必担心内存问题。
不要在render或render之前对ref进行引用，因为此时组件未渲染，组件内的DOM元素未加载，访问不到。
只能为类组件定义ref属性，不能为函数组件定义ref属性。
不要滥用Refs，尽量使用state和props维护UI。
## 独立组件间共享Mixin ##
在ES6中使用mixin需要使用插件`react-mixin`。
通过Mixins共享组件间的一些方法。例如新建一个src\components\mixins.js文件，里面定义组件间共享的一些方法，如下：
```js
const MixinLog = {
    log() {
        console.log("You are using Mixin.");
    }
};

export default MixinLog;
```
首先安装一下react-mixin: `npm install --save react-mixin@2`。在需要使用mixin共享方法的文件中，导入`react-mixin`安装包，以及引入共享方法所在的文件mixins.js：
```js
import ReactMixin from 'react-mixin';
import MixinLog from './mixins';
```
然后将引入的共享文件导出对象赋值给组件的prototype对象，如下：
```js
// 组件间共享 Mixin
ReactMixin(Body.prototype, MixinLog);
```
接下来，就可以在需要使用共享方法的地方使用引入的共享对象中的方法：
```jsx
import React, { Component } from 'react';
import PropTypes from 'prop-types';
// import ReactDOM from 'react-dom';
import BodyChild from './bodyChild';

import ReactMixin from 'react-mixin';
import MixinLog from './mixins';


class Body extends Component {
    constructor() {
        super(); //调用基类的所有初始化方法
        this.state = {userName: "Shirley"}; //初始化赋值
    }

    changeUserInfo() {
        this.setState({userName: "Your name has changed!"});
        // 第一种方式操作真实DOM
        // var submitBtn = document.getElementById("submitBtn");
        // ReactDOM.findDOMNode(submitBtn).style.color = 'red';

        // 第二种方式操作真实DOM
        console.log(this.refs.submitBtn);
        this.refs.submitBtn.style.color = 'red';

        // 使用Mixin共享方法log()
        MixinLog.log();
    }

    handleChildValueChange(event) { //通过事件形式，获取子组件的数据
        this.setState({userName: event.target.value});
    }
    render() {

        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{this.state.userName}</p>
                {/* 通过 PropTypes 对象校验uesrId的类型 */}
                <p>{this.props.userId}</p> 
                {/* 操作真实DOM */}
                <input id="submitBtn" ref="submitBtn" type="button" value="提交" onClick={() => this.changeUserInfo()} />
                {/* BodyChild 子组件 */}
                <BodyChild handleChildValueChange={this.handleChildValueChange.bind(this)}/>             
            </div>
        );
    }
}

// Body组件props属性校验
Body.propTypes = {
    userId: PropTypes.number
};

// 组件间共享 Mixin
ReactMixin(Body.prototype, MixinLog);

export default Body;
```
可以在mixin共享文件中使用生命周期函数，在生命周期函数中定义一些公用方法：
```js
const MixinLog = {
    componentDidMount() {
        console.log("Mixinlog componentDidMount");
    },
    log() {
        console.log("You are using Mixin.");
    }
};

export default MixinLog;
```
# React样式 #
以header.js为例，添加样式。
(1)第一种方式可以在render()函数中，以json格式定义样式，然后将该样式以 **内联** 形式应用在返回的html标签的`style`属性上，如下：
```jsx
import React, { Component } from 'react';

class ComponentHeader extends Component {
    render() {
        const styleComponentHeader = {
            header: {
                backgroundColor: "#333",
                color: "yellow",
                paddingTop: "15px",
                paddingBottom: "15px"
            },
            //还可以定义其他样式
        };
        return (
            <header style={styleComponentHeader.header}>
                <h1>头部</h1>
            </header>
        );
    }
}

export default ComponentHeader;
```
注意原生的CSS的样式名称在JSX中的写法，例如`background-color`在JSX中写为`backgroundColor`。
(2)第二种方式，css **样式表** 文件的引入。样式表的引入方式有两种，一种是在使用组件的HTML页面中通过`link`标签引入：
```html
<link rel="stylesheet" type="text/css" href="header.css">
```
header.css
```css
.smallFontSize h1 {
    font-size: 10px;
}
```
另一种是把样式表文件当作一个模块，在使用该样式表的组件中，像使用其他组件一样`import`导入样式表文件。如下：
```jsx
import React, { Component } from 'react';
import '../css/header.css'; //导入样式表文件

class ComponentHeader extends Component {
    render() {
        const styleComponentHeader = {
            header: {
                backgroundColor: "#333",
                color: "yellow",
                paddingTop: "15px",
                paddingBottom: "15px"
            },
            //还可以定义其他样式
        };
        return (
            <header style={styleComponentHeader.header} className="smallFontSize">
                <h1>头部</h1>
            </header>
        );
    }
}

export default ComponentHeader;
```
header.css
```css
.smallFontSize h1 {
    font-size: 10px;

}
```
第一种引入样式表的方式常用于该样式表作用于整个应用的所有组件(一般是基础样式表)，第二种引入样式表的方式常用于该样式表作用于某个组件(相当于组件的私有样式)。全局的基础样式表也可以使用第二种方式引入，一般在应用的入口JS文件中引入，例如示例程序中的index.js。

## 内联样式中的表达式 ##
实现的效果：当点击header时，header高度变化。
实现思路：通过点击改变state的值，来影响控制样式，在内联样式中可以使用表达式控制样式。
```jsx
import React, { Component } from 'react';
import '../css/header.css'; //导入样式表文件

class ComponentHeader extends Component {
    constructor() {
        super();
        this.state = {miniHeader: false}; //默认加载时header头部是高的
        this.switchHeader = this.switchHeader.bind(this);
    }

    switchHeader() {
        this.setState({miniHeader: !this.state.miniHeader}); //当点击header头部时，高度切换
    }
    render() {
        const styleComponentHeader = {
            header: {
                backgroundColor: "#333",
                color: "yellow",
                paddingTop: (this.state.miniHeader) ? "3px" : "15px", //内联样式中的表达式
                paddingBottom: (this.state.miniHeader) ? "3px" : "15px"
            },
            //还可以定义其他样式
        };
        return (
            <header style={styleComponentHeader.header} className="smallFontSize" onClick={this.switchHeader}>
                <h1>头部</h1>
            </header>
        );
    }
}

export default ComponentHeader;
```
## CSS的模块化(样式表) ##
CSS模块化解决的问题:全局污染、命名混乱、依赖管理不彻底、无法共享变量、代码压缩不彻底。以footer.js为例，添加CSS模块化样式。
CSS模块化的优点：所有样式都是局部的，解决了命名冲突和全局污染问题；样式类名生成规则配置灵活，可以此来压缩类名；只需引用组件的JS就可搞定组件的所有JS和CSS。
用到的三个有关的插件(`create-react-app`脚手架已经配置好了)：babel-plugin-react-html-attrs、style-loader、css-loader。
footer.css
```css
.miniFooter {
    background-color: #333;
    color: #fff;
    padding-left: 20px;
    padding-top: 3px;
    padding-bottom: 3px;
}

.miniFooter h1 {
    font-size: 5px;
}
```
将CSS样式表导入并应用到footer.js：
```jsx
import React, { Component } from 'react';
var footerCss = require("../css/footer.css");  // 或直接使用 import '../css/footer.css'; 导入
class ComponentFooter extends Component {
    render() {
        console.log(footerCss);
        return (
            <footer className="miniFooter">
                <h1>这里是页面底部</h1>
            </footer>
        );
    }
}

export default ComponentFooter;
```
**补充：** 可以利用`:local(.normal){color:green;}`定义局部样式，导入CSS样式表默认就是添加局部样式；`:global(.btn){color:red;}`可以将样式应用到全局，即使用`:global`定义的样式，即使不使用import导入到组件，也可以在组件中直接使用，相当于全局的样式。footer.css现在如下设置：
```css
:global(.miniFooter h1) {
    font-size: 5px;
}
```
在header.js中并未通过import导入footer.css模块，但可以直接使用footer.css中的全局样式`.miniFooter`：
```jsx
import React, { Component } from 'react';
import '../css/header.css'; //导入样式表文件

class ComponentHeader extends Component {
    constructor() {
        super();
        this.state = {miniHeader: false}; //默认加载时header头部是高的
        this.switchHeader = this.switchHeader.bind(this);
    }

    switchHeader() {
        this.setState({miniHeader: !this.state.miniHeader}); //当点击header头部时，高度切换
    }
    render() {
        const styleComponentHeader = {
            header: {
                backgroundColor: "#333",
                color: "yellow",
                paddingTop: (this.state.miniHeader) ? "3px" : "15px", //内联样式中的表达式
                paddingBottom: (this.state.miniHeader) ? "3px" : "15px"
            },
            //还可以定义其他样式
        };
        return (
            <header style={styleComponentHeader.header} className="smallFontSize miniFooter" onClick={this.switchHeader}>
                <h1>头部</h1>
            </header>
        );
    }
}

export default ComponentHeader;
```
## JSX样式与CSS的互转 ##
### 将CSS样式表中的样式转化为JSX中的样式 ###
在线的转化工具: [translate plain CSS into the React in-line style specific JSON representation](https://staxmanade.com/CssToReact/)
利用上述在线工具将CSS样式表中的样式转化为JSX中的JSON形式后，应用如下，以footer.js为例：
```jsx
import React, { Component } from 'react';
// var footerCss = require("../css/footer.css");  // 或直接使用 import '../css/footer.css'; 导入
class ComponentFooter extends Component {
    render() {
        // console.log(footerCss);
        var footerConvertStyle = {
            "miniFooter": {
                "backgroundColor": "#333",
                "color": "#fff",
                "paddingLeft": "20px",
                "paddingTop": "3px",
                "paddingBottom": "3px"
              },
              "miniFooter_h1": {
                "fontSize": "5px"
              }
        };

        return (
            <footer style={footerConvertStyle.miniFooter}>
                <h1 style={footerConvertStyle.miniFooter_h1}>这里是页面底部</h1>
            </footer>
        );
    }
}

export default ComponentFooter;
```
footer.css
```css
.miniFooter {
    background-color: #333;
    color: #fff;
    padding-left: 20px;
    padding-top: 3px;
    padding-bottom: 3px;
}

.miniFooter h1 {
    font-size: 5px;
}
```
## Ant Design样式框架 ##
样式框架们：比如之前使用较多的Bootstrap，Google的Material-UI(主要用来做一些React的样式管理，扁平式的UI样式)，
蚂蚁金服的[Ant Design](https://ant.design/docs/react/introduce-cn)。
在该demo中引入antd:
```bash
npm install antd --save
```
以Input输入框组件为例，在`src\components\body.js`中引入并使用antd Input组件，如下:
```jsx
import React, { Component } from 'react';
import PropTypes from 'prop-types';
// import ReactDOM from 'react-dom';
import BodyChild from './bodyChild';

import ReactMixin from 'react-mixin';
import MixinLog from './mixins';

import { Input } from 'antd'; //引入antd Input组件


class Body extends Component {
    constructor() {
        super(); //调用基类的所有初始化方法
        this.state = {userName: "Shirley"}; //初始化赋值
    }

    changeUserInfo() {
        this.setState({userName: "Your name has changed!"});
        // 第一种方式操作真实DOM
        // var submitBtn = document.getElementById("submitBtn");
        // ReactDOM.findDOMNode(submitBtn).style.color = 'red';

        // 第二种方式操作真实DOM
        console.log(this.refs.submitBtn);
        this.refs.submitBtn.style.color = 'red';

        // 使用Mixin共享方法log()
        MixinLog.log();
    }

    handleChildValueChange(event) { //通过事件形式，获取子组件的数据
        this.setState({userName: event.target.value});
    }
    render() {

        return (
            <div>
                <h2>这是是页面主体</h2>
                <p>{this.state.userName}</p>
                {/* 通过 PropTypes 对象校验uesrId的类型 */}
                <p>{this.props.userId}</p> 
                {/* antd Input组件使用 */}
                <Input placeholder="Basic usage of antd" />

                {/* 操作真实DOM */}
                <input id="submitBtn" ref="submitBtn" type="button" value="提交" onClick={() => this.changeUserInfo()} />
                {/* BodyChild 子组件 */}
                <BodyChild handleChildValueChange={this.handleChildValueChange.bind(this)}/>             
            </div>
        );
    }
}

// Body组件props属性校验
Body.propTypes = {
    userId: PropTypes.number
};

// 组件间共享 Mixin
ReactMixin(Body.prototype, MixinLog);

export default Body;
```
在body.js的Body组件的父组件App.js中，引入antd的css样式如下，即可完全显示Ant Design 的Input输入框的样子：
``` jsx
import React, { Component } from 'react';

import ComponentHeader from './header';
import ComponentFooter from './footer';
import Body from './body';
import 'antd/dist/antd.css'; //引入antd的css样式

class App extends Component { 

  render() {
    return (
      <div className="App">
        <ComponentHeader />
        {/* Body组件通过 PropTypes对象校验uesrId的类型必须为Number类型 */}
        <Body userId={123} />
        <ComponentFooter />
      </div>
    );
  }
}
export default App;
```
![antd Input](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/antd%20Input.png)
# React Router #
`react-router`用来控制页面间的路由，安装`react-router`:
```bash
$ npm install react-router --save
```
**注意踩坑！！！** 我安装的react-router版本@4.2.0，由于V4版本变化很大，所以遇到很多跟教程用法不一致的地方。React Router包含3个库，`react-router`、`react-router-dom`和`react-router-native`。`react-router-dom`和`react-router-native`都依赖于`react-router`(提供最基本的路由功能)，所以安装时`react-router`也会自动安装。建议安装`react-router-dom`(在浏览器中使用):
```bash
$ npm install react-router-dom --save
```
**卸载第三方依赖包：**
把之前下载的`react-router`卸载掉，好用以上命令重新安装`react-router-dom`，参考博客[React-Native填坑之删除第三方开源组件的依赖包](https://blog.csdn.net/liu__520/article/details/52801139)：
```bash
$ npm uninstall react-router --save
```
然后修改`src/index.js`，内容如下：
```jsx
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import App from './components/App';
import ComponentList from './components/list';
import { HashRouter, Route, Switch } from 'react-router-dom';

class RouterApp extends Component {
    render() {
        return (
            // 这里替换了之前的index.js，变成了程序的入口
            <HashRouter>
                {/* Router 中只能有唯一的一个子元素 */}
                <Switch>
                    {/* App主页 */}
                    <Route exact path="/" component={App}></Route> 
                    {/* ComponentList 列表页 */}
                    <Route exact path="/list" component={ComponentList}></Route>
                </Switch>
            </HashRouter>
        );
    }
}

ReactDOM.render(<RouterApp />, document.getElementById('root'));
```
上述代码在`<RouterApp />`组件中进行路由的绑定，取代了之前的`index.js`变成了程序的入口。

```jsx
// src/components/list.js 中的 <ComponentList /> 组件如下
import React, { Component } from 'react';

class ComponentList extends Component {
    render() {
        return (
            <div>
                <h2>这里是列表页</h2>
            </div>
        );
    }
}

export default ComponentList;
```
## Router相关概念 ##
React Router通过 Router 和 Route 两个组件完成路由功能，一个应用只需要一个Router实例，所有路由配置组件 Route 都定义为 Router 的子组件。
在WEB应用中，一般使用对 Router 进行包装的 `<BrowserRouter />`或 `<HashRouter />`两个组件。`<BrowserRouter />`使用HTML5的 history API(pushState、replaceState等)实现应用的 UI 和 URL 同步。`<HashRouter />`使用 URL 的 hash 实现 UI 和 URL 同步。

`<BrowserRouter />`创建的URL形如：`http://example.com/some/path`
`<HashRouter />`创建的URL形如：`http://example.com/#/some/path`
使用`<BrowserRouter />`时，一般还需要对服务器进行配置，让服务器能正确地处理所有可能的 URL(尤其对单页面应用，要求服务器总是返回唯一的HTML页面)；而使用`<HashRouter />`则不存在这个问题，因为hash部分地内容会被服务器自动忽略，真正有效地部分是hash之前的部分，而对单页应用这部分是固定的。

Router会创建一个history对象，history 用来跟踪 URL，当 URL 发生变化时，Router的后代组件会重新渲染。React Router中提供的其他组件可以通过 context 获取 history 对象，隐含说明了 React Router 中的其他组件必须作为 Router 组件的后代组件使用。**Router 中只能有唯一的一个子元素。**

`<Route />`是React Router用于配置路由信息的组件，每当有一个组件需要根据URL决定是否渲染时，就需要创建一个`<Route />`。上述路由管理两个页面，分别是`/`下的`<App />`主页，和`/list/`下的`<ComponentList />`列表页。 

## Router参数传递 ##
当URL和Route匹配时，Route会创建一个match对象作为props中的一个属性传递给被渲染的组件。利用match对象的`params`属性给Route的path传递参数。例如：`<Route exact path="/list/:id" component={ComponentList}></Route>`包含一个参数id，`params`就是用于从匹配的URL中解析出path中的参数，例如当访问`http://example.com/list/1`时，`params={id:1}`。
index.js
```jsx
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import App from './components/App';
import ComponentList from './components/list';
import { HashRouter, Route, Switch } from 'react-router-dom';

class RouterApp extends Component {
    render() {
        return (
            // 这里替换了之前的index.js，变成了程序的入口
            <HashRouter>
                {/* Router 中只能有唯一的一个子元素 */}
                <Switch>
                    {/* App主页 */}
                    <Route exact path="/" component={App}></Route> 
                    {/* ComponentList 列表页 */}
                    <Route exact path="/list/:id" component={ComponentList}></Route>
                </Switch>
            </HashRouter>
        );
    }
}
ReactDOM.render(<RouterApp />, document.getElementById('root'));
```
list.js
```jsx
import React, { Component } from 'react';

class ComponentList extends Component {
    render() {
        return (
            <div>
                <h2>这里是列表页 {this.props.match.params.id}</h2>
            </div>
        );
    }
}

export default ComponentList;
```
![Route传参](	https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/react_newsapp/readme/images/Route%E4%BC%A0%E5%8F%82.png)




