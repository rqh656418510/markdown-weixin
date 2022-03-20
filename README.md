# Markdown 转换微信公众帐号内容

一个在线将`Markdown`内容转换成微信公众帐号内容的工具。

- 线上地址: <https://www.techgrow.cn/markdown-weixin/>

### 效果图
![](https://raw.githubusercontent.com/rqh656418510/markdown-weixin/master/screenshot/demo.png)

### 项目构建

``` sh
# 拉取源代码
$ git clone https://github.com/rqh656418510/markdown-weixin.git

# 进入源代码目录
$ cd markdown-weixin

# 安装依赖
$ npm install

# 构建项目
$ node_modules/webpack/bin/webpack.js

# 查看构建生成的文件（docs目录可直接部署到Web服务器）
$ ls -al docs
```

### Changelog

#### 版本号：V1.2.3
更新日期：2022-03-20

- 升级jQuery版本
- 增加谷歌站点分析

#### 版本号：V1.2.2
更新日期：2020-03-19

- FIX 代码块出现数字编号的 BUG

##### 版本号：V1.2.1
更新日期：2018-07-12

- FIX 复制内容错误的BUG
- 优化页面主题代码

##### 版本号：V1.2.0
更新日期：2018-07-01

- 增加编辑区域和预览区域同步滚动
- 更改页面样式为左右结构，实时预览
- 直接复制内容到粘贴板，不要手动复制
- 替换`google-code-prettify`源为国内`CDN`源
- 支持更换代码样式主题
- 代码长度溢出时横向滚动

### LICENSE

MIT. Thanks for @barretlee.
