-- MySQL dump 10.13  Distrib 8.0.35, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: kusha
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `img_url` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` VALUES (1,'/b1.jpg','2024-04-01 00:00:00'),(2,'/b2.jpg','2024-04-02 00:00:00'),(4,'/b3.jpg','2024-04-01 00:00:00'),(5,'/b4.jpg','2024-04-01 00:00:00');
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `level` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'热点',1,0,1),(3,'民生',2,1,1),(4,'锐评',2,1,1),(5,'科技',1,0,2),(6,'数码',2,5,2),(7,'产品发布',2,5,2),(8,'历史',1,0,3),(9,'中国历史',2,8,3),(10,'海圆历',2,8,3);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `content_id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (16,'罗宾酱！！！',26,76,'2025-06-06 09:49:50'),(17,'哇哇哇',3,77,'2025-06-06 12:11:52'),(18,'？？？？？？',7,77,'2025-06-06 12:40:52'),(19,'罗宾酱！！！！！！',12,77,'2025-06-06 12:56:23'),(20,'真好',27,75,'2025-06-06 13:14:24'),(21,'@娜美',3,80,'2025-06-06 13:39:33'),(22,'后端SpirngBoot+MyBatis',3,78,'2025-06-06 13:43:23'),(23,'前端Vue+Element UI+Axios',3,78,'2025-06-06 13:43:35'),(24,'出发了船长@路飞',8,80,'2025-06-06 13:48:33'),(25,'娜美小姐！！！！！！！！',12,80,'2025-06-06 13:49:03'),(26,'真不错呀',12,78,'2025-06-06 13:50:02'),(27,'我愿意出10万贝利',8,78,'2025-06-06 14:05:48'),(28,'新版本已发布',26,75,'2025-06-06 14:12:37'),(29,'111',28,84,'2025-06-06 18:01:30'),(30,'111',28,75,'2025-06-06 18:02:35'),(31,'111',29,77,'2025-06-06 18:06:19'),(32,'111',24,78,'2025-06-06 18:09:22');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `content` text,
  `type` int DEFAULT NULL,
  `view_count` int DEFAULT NULL,
  `comment_count` int DEFAULT NULL,
  `brief` varchar(50) DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `update_by` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (75,'浪潮新闻v1.0发布啦','/2025/06/06/3c2c2a8d-23a0-4242-9951-a02245fe6d47.jpg','/2025/06/06/63035a37-1386-4d8a-87f0-22a6b5e9a10e.mp4','',2,44,3,NULL,7,26,NULL,'2025-06-06 09:26:36','2025-06-06 12:45:07'),(76,'空白的一百年','/2025/06/06/8c3659bd-6d77-46db-86c3-ee22b520b8e5.png',NULL,'<div><font size=\"4\">&nbsp; &nbsp; &nbsp; &nbsp;在空白的一百年前，世界上存在着一个高度发达且繁荣的古代王国。这个王国拥有先进的科技，能够制造出威力巨大的古代兵器，如<b>冥王、海王和天王</b>。</font></div><div><span style=\"font-size: large;\">&nbsp; &nbsp; &nbsp; &nbsp; 但20 位有野心的国王联合起来，发动了对古代王国的战争，最终成功推翻了古代王国，并建立了<b>世界政府</b>。</span></div><div><span style=\"font-size: large;\">&nbsp; &nbsp; &nbsp; &nbsp; 这 20 位国王的后裔便成为了<b>天龙人</b>，他们掌控着世界政府的最高权力，为了维护自己的统治地位，他们将空白的一百年历史从世界上抹去，任何试图探究这段历史的人都将被世界政府视为敌人并遭到追杀。</span></div><p><br/></p><p><font size=\"5\">我会找到真正的历史正文，解开“空白的一百年”的真相<sup>&nbsp;</sup>。</font></p>',3,52,1,'&nbsp; &nbsp; &nbsp; &nbsp;在空白',10,27,NULL,'2025-06-06 09:48:44',NULL),(77,'克洛克工作室Mr.0身份大曝光','/2025/06/06/e3baa905-0660-4728-b6e7-6a18088e9ea8.png','','<h1><b>先说结论：</b></h1><h2><b id=\"l35bf\">Mr.0是克洛克达尔</b></h2><p>沙·克洛克达尔<sup>&nbsp;</sup>，称号“<b>沙漠之王</b>”，悬赏金为19亿6500万贝里。<a href=\"https://baike.baidu.com/item/%E8%87%AA%E7%84%B6%E7%B3%BB/59807463?fromModule=lemma_inlink\" target=\"_blank\">自然系</a>·<a href=\"https://baike.baidu.com/item/%E6%B2%99%E6%B2%99%E6%9E%9C%E5%AE%9E/5052711?fromModule=lemma_inlink\" target=\"_blank\">沙沙果实</a>能力者，能自由的操控沙子，并能将身体沙化<sup>&nbsp;</sup>。<b></b></p>',1,53,4,'先说结论：Mr.0是克洛克达尔沙·克洛克达尔&nbsp;，称',4,27,NULL,'2025-06-06 11:35:47','2025-06-06 14:36:30'),(78,'浪潮新闻v2.0','/2025/06/06/4f4d7ba8-de73-4d44-8264-6359066a8fbf.jpg',NULL,'<h1>浪潮新闻项目2.0</h1><p>简介：本项目为基于 B/S 架构的 Web 应用。前端通过Vue+ElementUI+axios实现，后端通过SpringBoot+MyBatis实现。</p><h3>后端项目结构（SpirngBoot+MyBatis）</h3><pre>backend/<br/>├── src/<br/>│ &nbsp; ├── main/<br/>│ &nbsp; │ &nbsp; ├── java/<br/>│ &nbsp; │ &nbsp; │ &nbsp; └── com/example/demo/<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; ├── DemoApplication.java &nbsp; &nbsp; &nbsp; # 主启动类<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; ├── controller/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 控制器层（处理HTTP请求）<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; │ &nbsp; └── NewsController.java<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; ├── service/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # 服务层（业务逻辑）<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; │ &nbsp; ├── NewsService.java     # 接口<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; │ &nbsp; └── impl/<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; │ &nbsp; &nbsp; &nbsp; └── NewsServiceImpl.java<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; ├── mapper/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # MyBatis Mapper接口<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; │ &nbsp; └── NewsMapper.java<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; ├── entity/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 实体类（与数据库表映射）<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; │ &nbsp; └── News.java<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; ├── config/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 配置类（跨域、安全等）<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; │ &nbsp; └── CorsConfig.java<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; └── exception/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # 异常处理<br/>│ &nbsp; │ &nbsp; │ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; └── GlobalExceptionHandler.java<br/>│ &nbsp; │ &nbsp; ├── resources/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # 资源文件<br/>│ &nbsp; │ &nbsp; │ &nbsp; ├── application.properties &nbsp; &nbsp; &nbsp; # 核心配置文件<br/>│ &nbsp; │ &nbsp; │ &nbsp; ├── mapper/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # MyBatis XML映射文件<br/>│ &nbsp; │ &nbsp; │ &nbsp; │ &nbsp; └── NewsMapper.xml<br/>│ &nbsp; │ &nbsp; │ &nbsp; └── static/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 静态资源（如Swagger文档）<br/>│ &nbsp; └── test/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 测试代码<br/>│ &nbsp; &nbsp; &nbsp; └── com/example/demo/<br/>│ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; └── DemoApplicationTests.java<br/>├── pom.xml &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # Maven依赖配置<br/>└── mvnw &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # Maven wrapper（Linux/macOS）</pre><h3>前端项目结构（Vue+Element UI+Axios）</h3><pre>frontend/<br/>├── public/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # 静态资源（直接打包）<br/>│ &nbsp; └── index.html &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 入口HTML<br/>├── src/<br/>│ &nbsp; ├── assets/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # 静态资源（图片、字体等）<br/>│ &nbsp; ├── components/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # 通用组件<br/>│ &nbsp; │ &nbsp; └── CommonButton.vue<br/>│ &nbsp; ├── views/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 页面级组件<br/>│ &nbsp; │ &nbsp; ├── NewsList.vue &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 新闻列表页<br/>│ &nbsp; │ &nbsp; └── NewsEdit.vue &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 新闻编辑页<br/>│ &nbsp; ├── router/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # 路由配置<br/>│ &nbsp; │ &nbsp; └── index.js<br/>│ &nbsp; ├── store/ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # Vuex状态管理<br/>│ &nbsp; │ &nbsp; ├── index.js<br/>│ &nbsp; │ &nbsp; └── modules/<br/>│ &nbsp; │ &nbsp; &nbsp; &nbsp; └── news.js<br/>│ &nbsp; ├── axios.js &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # Axios封装<br/>│ &nbsp; ├── main.js &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # 入口JS（全局配置）<br/>│ &nbsp; └── App.vue &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # 根组件<br/>├── vue.config.js &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # Vue CLI配置（如代理、打包）<br/>├── package.json &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  # 依赖配置<br/>└── README.md</pre><h3><strong>关键目录说明</strong></h3><h4><strong>后端核心模块</strong></h4><ol><li><p><code>controller/</code>：处理 HTTP 请求，返回 JSON 数据（如<code>NewsController</code>处理新闻列表接口）。</p></li><li><p><code>service/</code>：封装业务逻辑（如数据校验、事务管理），通过依赖注入调用<code>mapper</code>。</p></li><li><p><code>mapper/</code> &amp; <code>resources/mapper/</code>：<code>mapper接口</code>定义数据操作方法，<code>XML文件</code>编写具体 SQL 语句（MyBatis 核心）。</p></li><li><p><code>entity/</code>：与数据库表字段一一映射，使用 JPA 注解（如<code>@Entity</code>、<code>@Table</code>）。</p></li></ol><h4><strong>前端核心模块</strong></h4><ol><li><p><code>views/</code>：存放页面级组件（如新闻列表、编辑页面），包含模板、逻辑和样式。</p></li><li><p><code>router/</code>：配置前端路由，实现页面跳转（支持 Hash 模式或 History 模式）。</p></li><li><p><code>store/</code>：使用 Vuex 管理全局状态（如用户登录信息、新闻列表缓存）。</p></li><li><p><code>axios.js</code>：封装 Axios 请求，设置基地址、请求头和拦截器（处理跨域、错误提示）。</p></li></ol>',1,33,5,'浪潮新闻项目2.0简介：本项目为基于 B/S 架构的 Web',3,26,NULL,'2025-06-06 12:48:50',NULL),(79,'5000年前~海圆历元年','/2025/06/06/b61b0c26-a4c0-455e-b157-1b96a01ffcb2.jpeg','','<h2><b id=\"t6huh\">5000年前</b></h2><p><b>“全知之树”</b>在西海<b>奥哈拉岛</b>萌芽，随后考古学者们开始将世界各地的文献材料，汇聚在这颗树下，海外学者们亦被这座图书馆所吸引，不断加入到奥哈拉的研究中，随着时光推移，奥哈拉逐渐成为举世闻名的“考古学圣地”。</p><h2 id=\"xclkq\">4000年前</h2><p><b>阿拉巴斯坦</b>王国首都阿尔巴拿，完成皇宫的修建。</p><p>\n</p><h2><b id=\"71ixo\">海圆历元年</b></h2><p>“世界之历”海圆历作为通用纪年法，开始成为航海家和冒险者们记录日志的主要方式</p>',3,13,0,'5000年前“全知之树”在西海奥哈拉岛萌芽，随后考古学者们开',10,27,NULL,'2025-06-06 13:09:39','2025-06-06 14:01:42'),(80,'黄金都市——香多拉','/2025/06/06/d24be96a-ee0b-4803-a1db-b3b0e0b5495f.png','','<h2 id=\"zomvt\">海圆历402年</h2><p>伟大航路加亚岛上的古代都市“<b>香多拉</b>”十分繁荣，由于城区建筑大量采用黄金，也获得了“<b>黄金都市</b>”的美誉。</p>',3,12,3,'海圆历402年伟大航路加亚岛上的古代都市“香多拉”十分繁荣，',10,27,NULL,'2025-06-06 13:10:57','2025-06-06 13:38:58'),(81,'海圆历500年，象主被惩罚','/2025/06/06/9d6d84aa-654f-4526-bc69-dd5517ed62fe.jfif','','<h2><b id=\"xa7gs\">海圆历500年</b></h2><p><b>象主</b>因为犯下某种过错，被惩罚只能在海上游荡，<b>毛皮族</b>开始在象背上生活。</p>',3,10,0,'海圆历500年象主因为犯下某种过错，被惩罚只能在海上游荡，毛',10,27,NULL,'2025-06-06 13:12:47','2025-06-06 14:00:23'),(82,'历史正文','/2025/06/06/7c314bf2-0711-4ca3-b6c4-e77955d77218.jfif','','<h2><b id=\"oqjh5\">海圆历620年</b></h2><p><font size=\"4\"><b style=\"\">和之国光月一族</b>用高超技艺，将历史铭刻在无法被摧毁的巨石上，随后送往世界各地，即“<b style=\"\">历史正文</b>”。</font></p><p>格林比特上，勤劳的咚塔塔一族遭到堂吉诃德家族的奴役，德雷斯罗萨因为压榨小人族的劳动成果而变得富足。神秘人物“乔伊·波伊”，以方舟诺亚作为信物，与当时的人鱼公主立下某种约定，但最后没有实现，他在历史正文中刻下谢罪文，并留在了鱼人岛海之森。</p>',3,6,0,'海圆历620年和之国光月一族用高超技艺，将历史铭刻在无法被摧',10,27,NULL,'2025-06-06 13:35:47','2025-06-06 14:02:35'),(83,'世界政府','/2025/06/06/9116dfbd-a8ce-4c4f-bdaa-6d3c0f88c193.jpg','','<h2><b id=\"8i2pc\">海圆历720年</b></h2><p><font size=\"4\">20位国王结盟组成“世界政府”，成为世界权力中枢。</font></p><p><font size=\"4\"><b>天龙人</b>开始成为“世界的主人”，并定居在红土大陆上的<b><u>“圣地”玛丽乔亚</u></b>，唯一的例外是奈菲鲁塔里王族，选择留在阿拉巴斯坦王国。</font></p><p><font size=\"4\">世界政府<i style=\"\"><b>禁止</b>民众解读历史正文</i>，<b style=\"\">“空白100年</b>”就此诞生，三大暴力机器海军、谍报机关“CIPHER-POL”以及海底大监狱逐渐成立，“黄金都市”香多拉为了守护历史正文，奋战不屈终至毁灭。咚塔塔一族因为堂吉诃德家族迁往<font color=\"#c24f4a\">圣地玛丽乔亚</font>，而重获新生，仁善的力库王族与小人族和解，共同建设德雷斯罗萨王国。</font></p>',3,8,0,'海圆历720年20位国王结盟组成“世界政府”，成为世界权力中',10,27,NULL,'2025-06-06 13:37:57','2025-06-06 17:27:23');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `nickname` varchar(100) DEFAULT NULL,
  `is_admin` int DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'路飞','lf','王路飞',0,'2025-06-05 15:10:25','/2025/06/06/74e9c2f8-5da7-445b-8acf-9b13ca662f69.png'),(7,'克洛克达尔','klkde','Mr.0',0,'2025-06-03 10:48:09','/2025/06/06/a0b2c9ba-6bb7-4724-a7d7-0e1c0b1e0f97.png'),(8,'娜美','nm','小贼猫',0,'2025-06-03 10:48:18','/2025/06/06/55f97d70-e025-452d-8c62-b0e921aa6aed.png'),(12,'山治','sz','Mr.prince',0,'2025-06-03 14:08:56','/2025/06/06/3dca4eb9-8e2f-49ad-8d12-94dfbd18100f.png'),(24,'索隆','sl','大剑豪',0,'2025-06-03 15:22:05','/2025/06/06/1d0f260a-76e6-4690-ad92-da69fbe5b954.jpg'),(26,'汪凯艳','wky','Ms.逗号',1,'2025-06-06 09:15:54','/2025/06/06/b1c21f64-35b7-43b9-9d4b-9aacf157a228.jpg'),(27,'罗宾','lb','Ms.all Sunday',1,'2025-06-06 09:33:19','/2025/06/06/d2be69ee-acb9-4056-ae17-1bd07bb91144.jpeg');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-07  8:43:54
