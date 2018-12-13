---
title: Ant Design 入门学习总结
date: 2018-05-28 16:15:46
tags: [antd, dva]
categories: antd
---
Ant Design of React 提供开箱即用的高质量 React 组件，具体的UI组件参见[Ant Design 文档](https://ant.design/docs/react/introduce-cn)。
<!--more-->
# Ant Design简介 #
[Ant Design of React](https://ant.design/docs/react/introduce-cn) 是 Ant Design 的 React 实现。
npm安装：`npm install antd --save`

**按需加载：** 使用 [babel-plugin-import](https://github.com/ant-design/babel-plugin-import)，babel-plugin-import 会帮助你加载 JS 和 CSS，只需从 antd 引入模块即可，无需单独引入样式。
```json
// .babelrc or babel-loader option
{
  "plugins": [
    ["import", { "libraryName": "antd", "libraryDirectory": "es", "style": "css" }] // `style: true` 会加载 less 文件
  ]
}
```
**使用示例：**
```jsx
import { DatePicker } from 'antd';
ReactDOM.render(<DatePicker />, mountNode); 
```

**快速上手：**
利用[antd-init](https://ant.design/docs/react/getting-started-cn)脚手架生成应用实例。(**注意：** antd-init只用于学习和体验antd如何使用，实际业务项目建议使用 dva-cli 和 create-react-app 进行搭建)
`$ npm install antd-init -g` -> `$ mkdir antd-demo && cd antd-demo` -> `$ antd-init`
index.js
```jsx
import React from 'react';
import ReactDOM from 'react-dom';
import { LocaleProvider, DatePicker, message } from 'antd';
// 由于 antd 组件的默认文案是英文，所以需要修改为中文
import zhCN from 'antd/lib/locale-provider/zh_CN';
import moment from 'moment';
import 'moment/locale/zh-cn';

moment.locale('zh-cn');

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      date: '',
    };
  }
  handleChange(date) {
    message.info('您选择的日期是: ' + (date ? date.toString() : ''));
    this.setState({ date });
  }
  render() {
    return (
      <LocaleProvider locale={zhCN}>
        <div style={{ width: 400, margin: '100px auto' }}>
          <DatePicker onChange={value => this.handleChange(value)} />
          <div style={{ marginTop: 20 }}>当前日期：{this.state.date && this.state.date.toString()}</div>
        </div>
      </LocaleProvider>
    );
  }
}

ReactDOM.render(<App />, document.getElementById('root'));
```
`$ npm start`, 访问`http://127.0.0.1:8000`UI样式如下：
![1](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/antd-init-demo/1.png)
![2](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/antd-init-demo/2.png)
![3](https://githubblogbucket1-1258277786.cos.ap-shanghai.myqcloud.com/antd-init-demo/3.png)

`$ npm run build`，入口文件会构建到 dist 目录中，可以自由部署到不同环境中进行引用。

# 项目实战 dva#
[dva](https://github.com/dvajs/dva) 是一个基于 React 和 Redux (Redux 或者 MobX 为数据应用框架) 的轻量应用框架，概念来自 elm，支持 side effects、热替换、动态加载、react-native、SSR 等，已在生产环境广泛应用。
Ant Design React 作为一个 UI 库，搭配 React 生态圈内的Redux，构建了轻量应用框架dva。
(1)**安装dva-cli**
```bash
$ npm install dva-cli -g
$ dva -v
dva-cli version 0.9.1
```
(2)**创建新应用**
```bash
$ dva new dva-quickstart
```
以上命令用于创建 `dva-quickstart` 目录，包含项目初始化目录和文件，并提供开发服务器、构建脚本、数据 mock 服务、代理服务器等功能。
接下来启动开发服务器：
```bash
$ cd dva-quickstart
$ npm start
```
在浏览器访问`http://localhost:8000` ，会看到 dva 的欢迎界面。
(3)**使用antd**
通过 npm 安装 `antd` 和 `babel-plugin-import`(用来按需加载 antd 的脚本和样式，而不是把整个库都引入，从而提高性能) 。
```bash
$ cnpm install antd babel-plugin-import --save
```
**注意：** 一定要用cnpm，npm真的慢出天际。。。。
接下来编辑 `.webpackrc`，使 `babel-plugin-import` 插件生效:
```json
{
+  "extraBabelPlugins": [
+    ["import", { "libraryName": "antd", "libraryDirectory": "es", "style": "css" }]
+  ]
}
```
(4)**定义路由**
写个应用来显示产品列表。首先第一步是创建路由，路由可以想象成是组成应用的不同页面,`src/routes`下是存放页面的。
新建 route component  `src/routes/Products.js`，内容如下:
```jsx
import React from 'react';

const Products = (props) => (
  <h2>List of Products</h2>
);

export default Products;
```
添加路由信息到路由表，编辑 `router.js`(处理页面路由):
```jsx
+ import Products from './routes/Products';
...
+ <Route path="/products" exact component={Products} />
```
在浏览器里打开 `http://localhost:8000/#/products` ，能看到前面定义的 `<h2>` 标签。
(5)**编写 UI Component**
编写一个 `ProductList` component。新建 `components/ProductList.js` 文件:
```jsx
import React from 'react';
import PropTypes from 'prop-types';
import { Table, Popconfirm, Button } from 'antd';

const ProductList = ({ onDelete, products }) => {
  const columns = [{
    title: 'Name',
    dataIndex: 'name',
  }, {
    title: 'Actions',
    render: (text, record) => {
      return (
        <Popconfirm title="Delete?" onConfirm={() => onDelete(record.id)}>
          <Button>Delete</Button>
        </Popconfirm>
      );
    },
  }];
  return (
    <Table
      dataSource={products}
      columns={columns}
    />
  );
};

ProductList.propTypes = {
  onDelete: PropTypes.func.isRequired,
  products: PropTypes.array.isRequired,
};

export default ProductList;
```
其中`<Table />`的`columns`用于表格列的配置描述，类型`ColumnProps[]`。[见文档](https://ant.design/components/table-cn/)
(6)**定义 Model**
完成 UI 后，现在开始处理数据和逻辑。
dva 通过 model 的概念把一个领域的模型管理起来，包含同步更新 state 的 reducers，处理异步逻辑的 effects，订阅数据源的 subscriptions 。
新建 model `models/products.js`:
```js
export default {
  namespace: 'products',
  state: [],
  reducers: {
    'delete'(state, { payload: id }) {
      return state.filter(item => item.id !== id);
    },
  },
};
```
上述 model 里：
- `namespace` 表示在全局 state 上的 key
- `state` 是初始值，在这里是空数组
- `reducers` 等同于 redux 里的 reducer，接收 action，同步更新 state

然后在`index.js`中载入：
```js
// 3. Model
+ app.model(require('./models/products').default);
```
(7)**connect 起来**
将 model 和 component 串联起来。dva 提供了 connect 方法，类似于 react-redux 的 connect，用于将 model 和 component 串联起来。
编辑 `src/routes/Products.js`(页面展示组件)，替换为以下内容:
```jsx
import React from 'react';
import { connect } from 'dva';
import ProductList from '../components/ProductList';

const Products = ({ dispatch, products }) => {
  function handleDelete(id) {
    dispatch({
      type: 'products/delete',
      payload: id,
    });
  }
  return (
    <div>
      <h2>List of Products</h2>
      <ProductList onDelete={handleDelete} products={products} />
    </div>
  );
};

// export default Products;
export default connect(({ products }) => ({
  products,
}))(Products);
```
最后mock一些初始数据让此应用运行起来，编辑`index.js`:
```js
- const app = dva();
+ const app = dva({
+   initialState: {
+     products: [
+       { name: 'dva', id: 1 },
+       { name: 'antd', id: 2 },
+     ],
+   },
+ });
```
(8)**构建应用**
完成开发并且在开发环境验证之后，接下来部署到生产环境：
```bash
$ npm run build
```
几秒后控制台输出如下：
```bash
$ npm run build

> @ build C:\Users\Shirley\Desktop\dva-quickstart
> roadhog build

Compiled successfully.

File sizes after gzip:

  145.28 KB  dist\index.js
  17.84 KB   dist\index.css
```
`build` 命令会打包所有的资源，包含 JavaScript, CSS, web fonts, images, html 等，可以在 `dist/` 目录下找到这些文件。

# 在 create-react-app 中使用 antd #
（1）**安装和初始化**
在命令行中安装 create-react-app 工具:
```bash
$ npm install -g create-react-app
```
新建一个项目:
```bash
$ create-react-app antd-demo
```
工具会自动初始化一个脚手架并安装 React 项目的各种必要依赖。接下来进入项目并启动，浏览器会访问 `http://localhost:3000/`：
```bash
$ cd antd-demo
$ npm start
```
(2)**引入 antd**
npm 安装并引入 antd:
```
$ npm add antd
```
修改 `src/App.js`，引入 antd 的按钮组件:
```jsx
import React, { Component } from 'react';
import Button from 'antd/lib/button';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <Button type="primary">Button</Button>
      </div>
    );
  }
}

export default App;
```
修改 `src/App.css`，在文件顶部引入 `antd/dist/antd.css`:
```css
@import '~antd/dist/antd.css';

.App {
  text-align: center;
}
```
现在可以看到页面上已经有了 antd 的蓝色按钮组件。
(3)**高级配置**
步骤(2)已经把组件成功运行起来了，但是在实际开发过程中还有很多问题，例如上面的例子实际上加载了全部的 antd 组件的样式（对前端性能是个隐患）。
需要对 create-react-app 的默认配置进行自定义，这里使用 `react-app-rewired` （一个对 create-react-app 进行自定义配置的社区解决方案）。

引入 `react-app-rewired` 并修改 package.json 里的启动配置:
```bash
$ npm add react-app-rewired --dev
```
```json
/* package.json */
"scripts": {
-   "start": "react-scripts start",
+   "start": "react-app-rewired start",
-   "build": "react-scripts build",
+   "build": "react-app-rewired build",
-   "test": "react-scripts test --env=jsdom",
+   "test": "react-app-rewired test --env=jsdom",
}
```
然后在项目根目录创建一个 `config-overrides.js` 用于修改默认配置:
```js
module.exports = function override(config, env) {
  // do stuff with the webpack config...
  return config;
};
```
使用 `babel-plugin-import`(用于 **按需加载** 组件代码和样式的 babel 插件)，安装它并修改 `config-overrides.js` 文件:
```bash
$ npm add babel-plugin-import --dev
```
```js
+ const { injectBabelPlugin } = require('react-app-rewired');

  module.exports = function override(config, env) {
+   config = injectBabelPlugin(['import', { libraryName: 'antd', libraryDirectory: 'es', style: 'css' }], config);
    return config;
  };
```
然后移除前面在 `src/App.css` 里全量添加的 `@import '~antd/dist/antd.css';` 样式代码，并且按下面的格式引入模块:
```jsx
 // src/App.js
  import React, { Component } from 'react';
- import Button from 'antd/lib/button';
+ import { Button } from 'antd';
  import './App.css';

  class App extends Component {
    render() {
      return (
        <div className="App">
          <Button type="primary">Button</Button>
        </div>
      );
    }
  }

  export default App;
```
需要重启`npm start`访问页面，否则看不到效果。antd 组件的 js 和 css 代码都会按需加载。

**自定义主题**：自定义主题需要用到 less 变量覆盖功能，可以引入 react-app-rewire 的 less 插件 `react-app-rewire-less` 来帮助加载 less 样式，同时修改 `config-overrides.js` 文件:
```bash
$ npm add react-app-rewire-less --dev
```
```js
  const { injectBabelPlugin } = require('react-app-rewired');
+ const rewireLess = require('react-app-rewire-less');

  module.exports = function override(config, env) {
-   config = injectBabelPlugin(['import', { libraryName: 'antd', style: 'css' }], config);
+   config = injectBabelPlugin(['import', { libraryName: 'antd', style: true }], config);
+   config = rewireLess.withLoaderOptions({
+     modifyVars: { "@primary-color": "#1DA57A" },
+   })(config, env);
    return config;
  };
```
这里利用了 less-loader 的 `modifyVars` 来进行主题配置，修改配置后需要重启 `npm start`才能看到效果。
