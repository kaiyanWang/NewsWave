# NewsWave
项目简介：SpringBoot+Vue前后端分离项目。前端通过Vue+ElementUI+axios实现，后端通过SpringBoot+MyBatis+WebSocket实现。项目已经部署：http://www.wky-news.top:9091

### 后端项目结构（SpirngBoot+MyBatis）

```
backend/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/demo/
│   │   │       ├── DemoApplication.java       # 主启动类
│   │   │       ├── controller/              # 控制器层（处理HTTP请求）
│   │   │       │   └── NewsController.java
│   │   │       ├── service/                 # 服务层（业务逻辑）
│   │   │       │   ├── NewsService.java	 # 接口
│   │   │       │   └── impl/
│   │   │       │       └── NewsServiceImpl.java
│   │   │       ├── mapper/                  # MyBatis Mapper接口
│   │   │       │   └── NewsMapper.java
│   │   │       ├── entity/                  # 实体类（与数据库表映射）
│   │   │       │   └── News.java
│   │   │       ├── config/                  # 配置类（跨域、安全等）
│   │   │       │   └── CorsConfig.java
│   │   │       └── exception/               # 异常处理
│   │   │           └── GlobalExceptionHandler.java
│   │   ├── resources/                       # 资源文件
│   │   │   ├── application.properties       # 核心配置文件
│   │   │   ├── mapper/                      # MyBatis XML映射文件
│   │   │   │   └── NewsMapper.xml
│   │   │   └── static/                      # 静态资源（如Swagger文档）
│   └── test/                                # 测试代码
│       └── com/example/demo/
│           └── DemoApplicationTests.java
├── pom.xml                                 # Maven依赖配置
└── mvnw                                    # Maven wrapper（Linux/macOS）
```

### 前端项目结构（Vue+Element UI+Axios）

```
frontend/
├── public/                                 # 静态资源（直接打包）
│   └── index.html                          # 入口HTML
├── src/
│   ├── assets/                             # 静态资源（图片、字体等）
│   ├── components/                         # 通用组件
│   │   └── CommonButton.vue
│   ├── views/                              # 页面级组件
│   │   ├── NewsList.vue                    # 新闻列表页
│   │   └── NewsEdit.vue                    # 新闻编辑页
│   ├── router/                             # 路由配置
│   │   └── index.js
│   ├── store/                              # Vuex状态管理
│   │   ├── index.js
│   │   └── modules/
│   │       └── news.js
│   ├── axios.js                            # Axios封装
│   ├── main.js                             # 入口JS（全局配置）
│   └── App.vue                             # 根组件
├── vue.config.js                           # Vue CLI配置（如代理、打包）
├── package.json                            # 依赖配置
└── README.md
```

# 快速启动

### Step1 数据库库表建立

打开[sql文件](https://pan.baidu.com/s/18bJWIKcZ7Ow8FKKPrH0ZIw)，复制到SQL窗口，还原数据

### Step2 导入后端项目

打开news项目，使用开发工具导入

1、win+R输入`services.msc`找到MySQL服务，如果没有启动，将其打开

2、在application.properties中修改数据源用户名和密码

3、将[files](https://pan.baidu.com/s/18bJWIKcZ7Ow8FKKPrH0ZIw)文件放在D:盘根目录下

4、运行启动类

### Step3 导入前端项目

打开news-web项目，使用开发工具导入，并且启动测试

```npm install```

```npm run serve```

**访问地址：`http://localhost:9090/index`**