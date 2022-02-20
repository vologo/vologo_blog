/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:3306
 Source Schema         : boblog

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 14/07/2021 16:01:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for about
-- ----------------------------
DROP TABLE IF EXISTS `about`;
CREATE TABLE `about`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像地址',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `github` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'github地址',
  `qq` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'QQ号',
  `wechat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '微信号',
  `bilibili` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '哔哩哔哩',
  `netease` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网易云id',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '电子邮箱',
  `reward` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '赞赏码',
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '个人简介',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of about
-- ----------------------------
INSERT INTO `about` VALUES (1, 'http://cdn.vologo.cn/20210402211525_59.jpeg', '我是一个菜鸟小傻瓜', 'https://github.com/1234', '157899541', 'vologo123', 'https://141414', 'https://14141414', 'volo1111go@msn.com', 'http://cdn.vologo.cn/20210404164211_message_bg.png', '我是一个不会写代码的小傻瓜', '2021-04-05 00:26:59', '2021-04-05 11:33:28', NULL);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '管理员昵称',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '管理员邮箱',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '管理员密码',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (2, 'vologo', 'vologo@msn.com', '$2a$10$G3H7aqrFF3TPNJyVFbm6vu5fiMh1j6UPD64DV6lYnspwGJxgWA1Da', '2021-01-13 21:39:02', '2021-01-13 21:39:02', NULL);
INSERT INTO `admin` VALUES (3, 'myvologo', 'imaqing@msn.com', '$2a$10$Pb03EqjhwgpgXsRWpUFuCOJ2NSm5Qtz3qIaF4iODKqZLI73uiQYf2', '2021-03-24 22:15:33', '2021-03-24 22:15:33', NULL);
INSERT INTO `admin` VALUES (4, 'mvologo', 'maqing@msn.com', '$2a$10$icDb8mJmrTethYts68jWUuD/JW/AKzeG/K5mWmiQ9L6JQAH.5cplC', '2021-03-24 22:19:23', '2021-03-24 22:19:23', NULL);

-- ----------------------------
-- Table structure for advertise
-- ----------------------------
DROP TABLE IF EXISTS `advertise`;
CREATE TABLE `advertise`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告标题',
  `link` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告链接',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章标题',
  `author` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '梁凤波' COMMENT '文章作者',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章内容',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章简介',
  `keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '文章关键字',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章封面',
  `browse` int(11) NULL DEFAULT 0 COMMENT '文章浏览次数',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `category_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '这是第一个文章', '马鳖', '这是第一个文章这是第一个文章这是第一个文章这是第一个文章这是第一个文章![Snipaste_20210111_172938.png](1)', '这是第一个文章', '这是第一个文章', 'http://cdn.vologo.cn/Fiew9gmQIl8g-gj0C89nTDoWPu7j', 15, '2021-01-13 23:50:50', '2021-03-23 18:37:41', NULL, 23);
INSERT INTO `article` VALUES (2, 'two article', 'vologo', '我问呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜', '前端', '前端', 'http://cdn.vologo.cn/FkNSf1car5CQ3CkVwxH0FlHqZ9Bf', 12, '2021-01-14 00:05:16', '2021-03-24 18:52:40', NULL, NULL);
INSERT INTO `article` VALUES (3, '测试下', '源来', '测试开始啦', '测试', '测试', 'http://cdn.vologo.cn/Fi3Z4dMz0h6It1hK7QT32YK__XKb', 3, '2021-03-17 09:44:52', '2021-03-20 00:29:57', NULL, NULL);
INSERT INTO `article` VALUES (4, '再来测试', '测试员', '测试员啦啦啦', '再来测试', '再来测试', 'http://cdn.vologo.cn/FlGQMGioAHYRvHpSZgqXBwvXTZ8S', 8, '2021-03-17 10:03:56', '2021-03-20 16:44:58', NULL, NULL);
INSERT INTO `article` VALUES (5, '测试图片', '马鳖', '测试图片', '测试图片', '测试图片', 'http://cdn.vologo.cn/Fm6PEE79BWmIY66R-opPN6vDzhMv', 2, '2021-03-20 21:48:03', '2021-03-21 10:56:25', NULL, NULL);
INSERT INTO `article` VALUES (6, '测试接口', '马鳖', '# Markdown Demo(Ctrl + A 删除即可)  \n\n- - -\n\n## 一、标题\n\n### 1. 使用 `#` 表示标题，其中 `#` 号必须在行首，例如：  \n\n# 一号标题\n## 二号标题\n### 三号标题\n#### 四号标题\n##### 五号标题\n###### 六号标题\n\n### 2. 使用 `===` 或者 `---` 表示，例如：  \n\n一级标题\n===\n\n二级标题\n---\n\n#### **扩展：如何换行？**\n一般使用 **两个空格** 加 **回车** 换行，不过一些 IDE 也可以直接使用回车换行。  \n\n\n## 二、分割线\n\n使用三个或以上的 `-` 或者 `*`  表示，且这一行只有符号，**注意不要被识别为二级标题即可**，例如中间或者前面可以加空格\n\n- - -\n\n* * *\n\n\n## 三、斜体和粗体\n\n使用 `*` 和 `**` 分别表示斜体和粗体，例如  \n\n*斜体* \n**粗体** \n***又斜又粗***\n\n#### **扩展：**删除线使用两个 `~` 表示，例如  \n\n~~我是要删掉的文字~~\n\n- - -\n\n\n## 四、超链接和图片\n\n超链接和图片的写法类似，图片仅在超链接前多了一个 `!` ，一般是 [文字描述] (链接)  \n两种写法，分别是： [第一种写法](https://www.baidu.com/) 和 [第二种写法][1]  \n图片的话就比如这样： ![Image][2]  \n\n[1]: https://www.baidu.com/  \n[2]: https://www.zybuluo.com/static/img/logo.png  \n\n- - -\n\n\n## 五、无序列表\n\n使用 `-`、`+` 和 `*` 表示无序列表，前后留一行空白，可嵌套，例如\n\n+ 一层\n    - 二层\n    - 二层\n        * 三层\n            + 四层\n+ 一层\n\n- - -\n\n\n## 六、有序列表\n\n使用 `1. ` （点号后面有个空格）表示有序列表，可嵌套，例如\n\n1. 一层\n    1. 二层\n    2. 二层\n2. 一层\n\n- - -\n\n\n## 七、文字引用\n\n使用 `&gt;` 表示，可以有多个 `&gt;`，表示层级更深，例如\n\n&gt; 第一层\n&gt;&gt;第二层\n&gt;这样是跳不出去的\n&gt;&gt;&gt; 还可以更深\n\n&gt; 这样就跳出去了  \n\n- - -\n\n\n## 八、行内代码块\n\n其实上面已经用过很多次了，即使用 \\` 表示，例如\n\n`行内代码块`\n\n### 扩展：很多字符是需要转义，使用反斜杠 `\\` 进行转义\n\n- - -\n\n\n## 九、代码块\n\n使用四个空格缩进表示代码块，例如\n\n    public class HelloWorld\n    {\n        public static void main(String[] args)\n        { \n            System.out.println( \"Hello, World!\" );\n        }\n    }\n\n一些 IDE 支持行数提示和着色，一般使用三个 \\` 表示，例如\n\n```\npublic class HelloWorld\n{\n    public static void main(String[] args)\n    { \n        System.out.println( \"Hello, World!\" );\n    }\n}\n```\n\n- - -\n\n\n## 十、表格\n\n直接看例子吧，第二行的 `---:` 表示了对齐方式，默认**左对齐**，还有**右对齐**和**居中**  \n\n|商品|数量|单价|\n|---|---:|:---:|\n|苹果苹果苹果|10|\\$1|\n|电脑|1|\\$1999|\n\n- - -\n\n\n## 十一、数学公式\n\n使用 `$` 表示，其中一个 \\$ 表示在行内，两个 \\$ 表示独占一行。\n例如质量守恒公式：$$E=mc^2$$\n支持 **LaTeX** 编辑显示支持，例如：$\\sum_{i=1}^n a_i=0$， 访问 [MathJax][2] 参考更多使用方法。\n\n推荐一个常用的数学公式在线编译网站： [https://www.codecogs.com/latex/eqneditor.php][3]  \n\n[2]: http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference  \n\n[3]: https://www.codecogs.com/latex/eqneditor.php  \n\n- - -\n\n\n## 十二、支持HTML标签\n\n### 1. 例如想要段落的缩进，可以如下：\n\n&nbsp;&nbsp;不断行的空白格&nbsp;或&#160;  \n&ensp;&ensp;半方大的空白&ensp;或&#8194;  \n&emsp;&emsp;全方大的空白&emsp;或&#8195;  \n\n\n- - -\n\n## 十三、其它\n1. markdown 各个 IDE 的使用可能存在大同小异，一般可以参考各个 IDE 的介绍文档\n2. 本文档介绍的内容基本适用于大部分的 IDE\n3. 其它一些类似 **流程图** 之类的功能，需要看 IDE 是否支持。\n\n\n查看原始数据：[https://gitee.com/afei_/MarkdownDemo/raw/master/README.md](https://gitee.com/afei_/MarkdownDemo/raw/master/README.md)\n\n博客：[https://blog.csdn.net/afei__/article/details/80717153](https://blog.csdn.net/afei__/article/details/80717153)', '测试接口', '测试接口', 'http://cdn.vologo.cn/FvfAHTRpf_lk822ztR8pmBHcYovV', 4, '2021-03-21 11:54:24', '2021-03-21 12:01:46', NULL, NULL);
INSERT INTO `article` VALUES (7, '测试修改图片', '马克', '测试修改图片', '测试修改文章', '测试修改文章', 'http://cdn.vologo.cn/FpGkNpqlkkZ1r64GFR05UH6KvOh9', 337, '2021-03-21 12:44:45', '2021-03-21 20:52:54', NULL, NULL);
INSERT INTO `article` VALUES (8, '测试文章发表', '马鳖', '测试文章发表', '测试文章发表', '测试', 'http://cdn.vologo.cn/FkpVePZeqHNk23QkwWgARy6lDKM_', 458, '2021-03-21 12:49:11', '2021-03-21 16:13:18', NULL, NULL);
INSERT INTO `article` VALUES (9, '测试图片接口', '马鳖', '云编程', '测试图片接口', '测试', 'http://cdn.vologo.cn/Fivs1VSSJObMKCPHkiboaJeZXHhg', 45, '2021-03-21 12:51:14', '2021-03-21 20:57:36', NULL, NULL);
INSERT INTO `article` VALUES (10, '测试图片删除功能', '马鳖', '# 测试图片删除', '测试图片删除功能', '测试', 'http://cdn.vologo.cn/FmGUtTS9tbUEYxdXbS_nj_kYo-7q', 29, '2021-03-21 13:06:50', '2021-03-23 18:49:06', NULL, NULL);
INSERT INTO `article` VALUES (11, '测试分页功能', '马鳖', '# 测试分页', '测试分页功能', '测试', 'http://cdn.vologo.cn/FjWDBmgkAmP9OlgUa59B5U2syLLr', 7, '2021-03-21 13:17:26', '2021-04-04 22:47:55', NULL, NULL);
INSERT INTO `article` VALUES (12, '再次测试发表文章', '马克', '# 是否正常', '再次测试发表文章', '测试发表', 'http://cdn.vologo.cn/Fj9IZJkJIMujxLeHr0NtoVe8vFE-', 161, '2021-03-21 16:39:23', '2021-03-24 20:20:42', NULL, NULL);
INSERT INTO `article` VALUES (13, '测试后台的七牛云token', '马鳖', '看看token是成功', '测试后台的七牛云token', '测试', 'http://cdn.vologo.cn/Fr9vazE_r0mhVe5MtdrdBD6AWCdF', 1000, '2021-03-24 18:52:34', '2021-03-24 18:52:44', NULL, NULL);
INSERT INTO `article` VALUES (14, '测试七牛云接口', '马鳖', '七牛云是否可用', '测试七牛云接口', '测试', 'http://cdn.vologo.cn/FvGMRDTdfwacfyaKIamgx9_bB2Mh', 29, '2021-03-24 20:23:21', '2021-04-04 21:40:47', NULL, 15);
INSERT INTO `article` VALUES (15, '测试性能', '马鳖', '# Markdown Demo(Ctrl + A 删除即可)  \n\n- - -\n\n## 一、标题\n\n### 1. 使用 `#` 表示标题，其中 `#` 号必须在行首，例如：  \n\n# 一号标题\n## 二号标题\n### 三号标题\n#### 四号标题\n##### 五号标题\n###### 六号标题\n\n### 2. 使用 `===` 或者 `---` 表示，例如：  \n\n一级标题\n===\n\n二级标题\n---\n\n#### **扩展：如何换行？**\n一般使用 **两个空格** 加 **回车** 换行，不过一些 IDE 也可以直接使用回车换行。  \n\n\n## 二、分割线\n\n使用三个或以上的 `-` 或者 `*`  表示，且这一行只有符号，**注意不要被识别为二级标题即可**，例如中间或者前面可以加空格\n\n- - -\n\n* * *\n\n\n## 三、斜体和粗体\n\n使用 `*` 和 `**` 分别表示斜体和粗体，例如  \n\n*斜体* \n**粗体** \n***又斜又粗***\n\n#### **扩展：**删除线使用两个 `~` 表示，例如  \n\n~~我是要删掉的文字~~\n\n- - -\n\n\n## 四、超链接和图片\n\n超链接和图片的写法类似，图片仅在超链接前多了一个 `!` ，一般是 [文字描述] (链接)  \n两种写法，分别是： [第一种写法](https://www.baidu.com/) 和 [第二种写法][1]  \n图片的话就比如这样： ![Image][2]  \n\n[1]: https://www.baidu.com/  \n[2]: https://www.zybuluo.com/static/img/logo.png  \n\n- - -\n\n\n## 五、无序列表\n\n使用 `-`、`+` 和 `*` 表示无序列表，前后留一行空白，可嵌套，例如\n\n+ 一层\n    - 二层\n    - 二层\n        * 三层\n            + 四层\n+ 一层\n\n- - -\n\n\n## 六、有序列表\n\n使用 `1. ` （点号后面有个空格）表示有序列表，可嵌套，例如\n\n1. 一层\n    1. 二层\n    2. 二层\n2. 一层\n\n- - -\n\n\n## 七、文字引用\n\n使用 `&gt;` 表示，可以有多个 `&gt;`，表示层级更深，例如\n\n&gt; 第一层\n&gt;&gt;第二层\n&gt;这样是跳不出去的\n&gt;&gt;&gt; 还可以更深\n\n&gt; 这样就跳出去了  \n\n- - -\n\n\n## 八、行内代码块\n\n其实上面已经用过很多次了，即使用 \\` 表示，例如\n\n`行内代码块`\n\n### 扩展：很多字符是需要转义，使用反斜杠 `\\` 进行转义\n\n- - -\n\n\n## 九、代码块\n\n使用四个空格缩进表示代码块，例如\n\n    public class HelloWorld\n    {\n        public static void main(String[] args)\n        { \n            System.out.println( \"Hello, World!\" );\n        }\n    }\n\n一些 IDE 支持行数提示和着色，一般使用三个 \\` 表示，例如\n\n```\npublic class HelloWorld\n{\n    public static void main(String[] args)\n    { \n        System.out.println( \"Hello, World!\" );\n    }\n}\n```\n\n- - -\n\n\n## 十、表格\n\n直接看例子吧，第二行的 `---:` 表示了对齐方式，默认**左对齐**，还有**右对齐**和**居中**  \n\n|商品|数量|单价|\n|---|---:|:---:|\n|苹果苹果苹果|10|\\$1|\n|电脑|1|\\$1999|\n\n- - -\n\n\n## 十一、数学公式\n\n使用 `$` 表示，其中一个 \\$ 表示在行内，两个 \\$ 表示独占一行。\n例如质量守恒公式：$$E=mc^2$$\n支持 **LaTeX** 编辑显示支持，例如：$\\sum_{i=1}^n a_i=0$， 访问 [MathJax][2] 参考更多使用方法。\n\n推荐一个常用的数学公式在线编译网站： [https://www.codecogs.com/latex/eqneditor.php][3]  \n\n[2]: http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference  \n\n[3]: https://www.codecogs.com/latex/eqneditor.php  \n\n- - -\n\n\n## 十二、支持HTML标签\n\n### 1. 例如想要段落的缩进，可以如下：\n\n&nbsp;&nbsp;不断行的空白格&nbsp;或&#160;  \n&ensp;&ensp;半方大的空白&ensp;或&#8194;  \n&emsp;&emsp;全方大的空白&emsp;或&#8195;  \n\n\n- - -\n\n## 十三、其它\n1. markdown 各个 IDE 的使用可能存在大同小异，一般可以参考各个 IDE 的介绍文档\n2. 本文档介绍的内容基本适用于大部分的 IDE\n3. 其它一些类似 **流程图** 之类的功能，需要看 IDE 是否支持。\n\n\n查看原始数据：[https://gitee.com/afei_/MarkdownDemo/raw/master/README.md](https://gitee.com/afei_/MarkdownDemo/raw/master/README.md)\n\n博客：[https://blog.csdn.net/afei__/article/details/80717153](https://blog.csdn.net/afei__/article/details/80717153)', '测试性能', '性能', 'http://cdn.vologo.cn/FhZLM9F_pMi7GYv9aJwbm7IIPw6d', 51, '2021-03-25 11:53:23', '2021-04-02 23:31:53', NULL, 1);
INSERT INTO `article` VALUES (16, '测试发布文章', '马克', '测试发布文章', '测试发布文章', '测试', 'http://cdn.vologo.cn/20210404202840_psc (2).jfif', 444, '2021-04-04 20:29:25', '2021-04-04 20:29:25', NULL, 20);
INSERT INTO `article` VALUES (17, '测试已上传的图片发表文章', '马克', '测试已上传的图片发表文章', '测试已上传的图片发表文章', '测试', 'http://cdn.vologo.cn/20210402211525_59.jpeg', 100, '2021-04-04 20:31:22', '2021-04-04 22:47:53', NULL, 20);
INSERT INTO `article` VALUES (18, '测试mavon-editor上传图片', '马克', '![QQ图片20210112212054.jpg](http://cdn.vologo.cn/20210404224241_QQ图片20210112212054.jpg)\n图片上传了吗', '测试mavon-editor上传图片', '测试', 'http://cdn.vologo.cn/20210404224350_a34901338744ebf8f16cd420def9d72a6059a7be.jpg', 114, '2021-04-04 22:44:01', '2021-04-05 11:45:44', NULL, 22);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类关键字',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '分类父级ID，默认为0',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '前端', 'frontend', 0, '2021-01-13 21:40:50', '2021-03-19 21:53:03', NULL);
INSERT INTO `category` VALUES (12, '后端', 'backend', 0, '2021-03-19 14:36:52', '2021-03-19 14:36:52', NULL);
INSERT INTO `category` VALUES (13, 'Java牛逼哄哄', 'Java', 0, '2021-03-19 14:38:44', '2021-03-19 21:56:43', NULL);
INSERT INTO `category` VALUES (14, 'JavaScript表示不服', 'JavaScript', 0, '2021-03-19 14:40:15', '2021-03-19 22:04:30', NULL);
INSERT INTO `category` VALUES (15, 'PHP天下第一', 'PHP', 0, '2021-03-19 14:41:03', '2021-03-19 21:54:33', NULL);
INSERT INTO `category` VALUES (16, 'Ruby唯快不破', 'Ruby', 0, '2021-03-19 14:43:40', '2021-03-19 21:57:49', NULL);
INSERT INTO `category` VALUES (17, 'Python短平快', 'Python', 0, '2021-03-19 22:05:23', '2021-03-19 22:05:23', NULL);
INSERT INTO `category` VALUES (18, 'Golang够浪', 'Golang', 0, '2021-03-19 22:06:41', '2021-03-19 22:06:41', NULL);
INSERT INTO `category` VALUES (19, '哔哩哔哩', 'bilibliaa', 0, '2021-03-19 22:09:08', '2021-03-19 22:10:04', '2021-03-19 22:10:04');
INSERT INTO `category` VALUES (20, '测试', 'Test', 0, '2021-03-21 12:43:54', '2021-03-21 12:43:54', NULL);
INSERT INTO `category` VALUES (21, 'Vuex', 'vuex', 0, '2021-03-26 15:01:19', '2021-03-26 18:56:27', '2021-03-26 18:56:27');
INSERT INTO `category` VALUES (22, '.NET', '.NET', 0, '2021-04-02 14:31:04', '2021-04-02 14:31:04', NULL);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_id` int(11) NOT NULL COMMENT '评论目标id, 如普通文章，专栏的文章id',
  `target_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论目标类型, 如article, column',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论人的名字',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论人的邮箱',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 1, 'article', 'vologo', 'vologo@163.com', '图片呢 并见了', '2021-01-13 23:55:56', '2021-03-21 23:13:05', NULL);
INSERT INTO `comment` VALUES (2, 2, 'article', 'vologo', 'vologo@msn.com', '乌拉乌拉乌拉乌拉乌拉乌拉乌拉', '2021-01-29 12:36:59', '2021-03-23 19:02:04', '2021-03-23 19:02:04');
INSERT INTO `comment` VALUES (3, 12, 'article', 'image', 'vologo@123.com', '你好，我是马瘪瘪', '2021-03-22 17:06:55', '2021-03-23 19:01:51', '2021-03-23 19:01:51');

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告标题',
  `link` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告链接',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告头像',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '描述',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friend
-- ----------------------------
INSERT INTO `friend` VALUES (1, '我的个人博客', 'https://vologo.cn', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 11:38:26', '2021-03-22 12:02:08', NULL);
INSERT INTO `friend` VALUES (2, '谷歌一下', 'https://www.Google.com', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 12:00:54', '2021-03-26 15:36:46', NULL);
INSERT INTO `friend` VALUES (3, 'Vue框架', 'https://cn.vuejs.org/', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 12:01:23', '2021-03-22 12:01:23', NULL);
INSERT INTO `friend` VALUES (4, 'VUE-ELEMENT-ADMIN', 'https://panjiachen.github.io/vue-element-admin', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 12:01:55', '2021-03-22 12:01:55', NULL);
INSERT INTO `friend` VALUES (5, '搜狐新闻', 'http://souhu.com', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 14:57:48', '2021-03-22 14:57:48', NULL);
INSERT INTO `friend` VALUES (6, 'Elment', 'https://element.eleme.cn/', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 14:59:11', '2021-03-22 14:59:11', NULL);
INSERT INTO `friend` VALUES (7, 'el-admi', 'https://el-admin.xin/', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 15:01:16', '2021-03-22 15:01:16', NULL);
INSERT INTO `friend` VALUES (8, '必应', 'https://cn.bing.com/', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 15:02:14', '2021-03-22 15:02:14', NULL);
INSERT INTO `friend` VALUES (9, '腾讯视频', 'https://v.qq.com/', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 15:10:29', '2021-03-22 15:10:29', NULL);
INSERT INTO `friend` VALUES (10, '京东商城', 'https://www.3.cn', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 15:11:03', '2021-03-22 18:09:15', NULL);
INSERT INTO `friend` VALUES (11, '天猫商城', 'https://www.tmall.com/', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 15:11:40', '2021-03-22 18:07:33', NULL);
INSERT INTO `friend` VALUES (12, '哔哩哔哩', 'https://www.bilibili.com/', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 15:12:13', '2021-03-22 18:07:23', NULL);
INSERT INTO `friend` VALUES (13, '优酷视频', 'http://www.youku.com', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'element', '2021-03-22 18:08:31', '2021-03-22 18:08:31', NULL);

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '素材链接',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `is_collected` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES (1, 'http://cdn.vologo.cn/20210402173033_61e89358ly1gp2t9uioyyg20bz07agmf.gif', '2021-04-02 17:59:16', '2021-04-04 17:26:13', NULL, 1);
INSERT INTO `image` VALUES (2, 'http://cdn.vologo.cn/Fj9IZJkJIMujxLeHr0NtoVe8vFE-', '2021-04-01 18:54:50', '2021-04-04 16:49:58', '2021-04-04 16:49:58', 0);
INSERT INTO `image` VALUES (3, 'http://cdn.vologo.cn/20210402211525_59.jpeg', '2021-04-02 21:15:25', '2021-04-04 16:53:41', NULL, 1);
INSERT INTO `image` VALUES (4, 'http://cdn.vologo.cn/20210402214031_smart-questions-07.fa44bafc.png', '2021-04-02 21:40:32', '2021-04-02 22:26:53', NULL, 1);
INSERT INTO `image` VALUES (5, 'http://cdn.vologo.cn/20210402222825_c8e946de97292e984b81b579ce694436.png', '2021-04-02 22:28:25', '2021-04-04 16:53:43', '2021-04-04 16:53:43', 1);
INSERT INTO `image` VALUES (6, 'http://cdn.vologo.cn/20210402223000_642004.jpg', '2021-04-02 22:30:00', '2021-04-02 23:31:21', NULL, 1);
INSERT INTO `image` VALUES (7, 'http://cdn.vologo.cn/20210402233450_avatar.jpg', '2021-04-02 23:34:51', '2021-04-04 17:00:35', '2021-04-04 17:00:35', 0);
INSERT INTO `image` VALUES (8, 'http://cdn.vologo.cn/20210404103214_smart-questions-03.0f04828b.png', '2021-04-04 10:32:14', '2021-04-04 10:32:22', NULL, 1);
INSERT INTO `image` VALUES (9, 'http://cdn.vologo.cn/20210404103556_c8e946de97292e984b81b579ce694436.png', '2021-04-04 10:35:56', '2021-04-04 10:35:56', NULL, 0);
INSERT INTO `image` VALUES (10, 'http://cdn.vologo.cn/20210404103646_b21c8701a18b87d6a9d96ce85b6211301e30fd25.jpeg', '2021-04-04 10:36:46', '2021-04-04 10:36:56', NULL, 1);
INSERT INTO `image` VALUES (11, 'http://cdn.vologo.cn/20210404103715_smart-questions-07.fa44bafc.png', '2021-04-04 10:37:15', '2021-04-04 16:52:43', '2021-04-04 16:52:43', 0);
INSERT INTO `image` VALUES (12, 'http://cdn.vologo.cn/20210404104058_0eb30f2442a7d933b5e80d29fa21e81b72f0019e.jpeg', '2021-04-04 10:40:58', '2021-04-04 10:40:58', NULL, 0);
INSERT INTO `image` VALUES (13, 'http://cdn.vologo.cn/20210404104105_c8ea15ce36d3d539e81c56ed6dedd058352ab069.jpeg', '2021-04-04 10:41:05', '2021-04-04 17:26:23', NULL, 1);
INSERT INTO `image` VALUES (14, 'http://cdn.vologo.cn/20210404104115_aeffeb4de74e2fde4bd74fc7b4486jpeg.jpeg', '2021-04-04 10:41:16', '2021-04-04 10:41:16', NULL, 0);
INSERT INTO `image` VALUES (15, 'http://cdn.vologo.cn/20210404104126_f01c15bb73e1ef3793e64e6b7bbccjpeg.jpeg', '2021-04-04 10:41:26', '2021-04-04 10:43:24', NULL, 1);
INSERT INTO `image` VALUES (16, 'http://cdn.vologo.cn/20210404104200_f9dcd100baa1cd11e2446d496a11f0f4c2ce2df0.jpeg', '2021-04-04 10:42:00', '2021-04-04 10:43:36', NULL, 0);
INSERT INTO `image` VALUES (17, 'http://cdn.vologo.cn/20210404164202_003.jpg', '2021-04-04 16:42:02', '2021-04-04 16:42:02', NULL, 0);
INSERT INTO `image` VALUES (18, 'http://cdn.vologo.cn/20210404164211_message_bg.png', '2021-04-04 16:42:11', '2021-04-04 16:42:11', NULL, 0);
INSERT INTO `image` VALUES (19, 'http://cdn.vologo.cn/20210404164224_Snipaste_2021-03-28_14-56-28.png', '2021-04-04 16:42:24', '2021-04-04 16:42:24', NULL, 0);
INSERT INTO `image` VALUES (20, 'http://cdn.vologo.cn/20210404164235_BB1eZNlq.jfif', '2021-04-04 16:42:35', '2021-04-04 17:26:27', NULL, 1);
INSERT INTO `image` VALUES (21, 'http://cdn.vologo.cn/20210404164246_background.9b952c4a.jpg', '2021-04-04 16:42:46', '2021-04-04 16:42:46', NULL, 0);
INSERT INTO `image` VALUES (22, 'http://cdn.vologo.cn/20210404165336_v2-ff1ebecf54ddd25dc47c5f62ff7d3be1_720w.jpg', '2021-04-04 16:53:36', '2021-04-04 17:00:28', NULL, 1);
INSERT INTO `image` VALUES (23, 'http://cdn.vologo.cn/20210404170023_Snipaste_2021-03-25_15-52-07.png', '2021-04-04 17:00:23', '2021-04-04 17:00:23', NULL, 0);
INSERT INTO `image` VALUES (24, 'http://cdn.vologo.cn/20210404200056_d349e2039245d688b45db582abc27d1ed31b24e8.jpg', '2021-04-04 20:00:57', '2021-04-04 20:00:57', NULL, 0);
INSERT INTO `image` VALUES (25, 'http://cdn.vologo.cn/20210404202029_QQ图片20210404103052.jpg', '2021-04-04 20:20:29', '2021-04-04 20:20:29', NULL, 0);
INSERT INTO `image` VALUES (26, 'http://cdn.vologo.cn/20210404202105_4ec2d5628535e5dd694b7d807bc6a7efce1b620e.jfif', '2021-04-04 20:21:05', '2021-04-04 20:21:05', NULL, 0);
INSERT INTO `image` VALUES (27, 'http://cdn.vologo.cn/20210404202127_f8d5d697d05f65a4a0fd54ffe5362247.jfif', '2021-04-04 20:21:27', '2021-04-04 20:21:27', NULL, 0);
INSERT INTO `image` VALUES (28, 'http://cdn.vologo.cn/20210404202516_src=http___img.wxcha.com_file_201812_12_c4d05d3c24.jpg&refer=http___img.wxcha.jfif', '2021-04-04 20:25:16', '2021-04-04 20:25:16', NULL, 0);
INSERT INTO `image` VALUES (29, 'http://cdn.vologo.cn/20210404202615_psc (3).jfif', '2021-04-04 20:26:15', '2021-04-04 20:26:15', NULL, 0);
INSERT INTO `image` VALUES (30, 'http://cdn.vologo.cn/20210404202840_psc (2).jfif', '2021-04-04 20:28:41', '2021-04-04 20:28:41', NULL, 0);
INSERT INTO `image` VALUES (31, 'http://cdn.vologo.cn/20210404223339_mna2.jpg', '2021-04-04 22:33:40', '2021-04-04 22:33:40', NULL, 0);
INSERT INTO `image` VALUES (32, 'http://cdn.vologo.cn/20210404223932_Snipaste_2021-03-04_18-18-57.png', '2021-04-04 22:39:32', '2021-04-04 22:39:32', NULL, 0);
INSERT INTO `image` VALUES (33, 'http://cdn.vologo.cn/20210404224241_QQ图片20210112212054.jpg', '2021-04-04 22:42:41', '2021-04-04 22:42:41', NULL, 0);
INSERT INTO `image` VALUES (34, 'http://cdn.vologo.cn/20210404224350_a34901338744ebf8f16cd420def9d72a6059a7be.jpg', '2021-04-04 22:43:50', '2021-04-04 22:43:50', NULL, 0);
INSERT INTO `image` VALUES (35, 'http://cdn.vologo.cn/20210405002354_avatar.jpeg', '2021-04-05 00:23:54', '2021-04-05 00:23:54', NULL, 0);

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回复人的名字',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回复人的邮箱',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回复内容',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `comment_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comment_id`(`comment_id`) USING BTREE,
  CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES (1, 'video', '123@123.com', '哦哦，我知道了', '2021-03-22 17:07:39', '2021-03-23 18:34:52', '2021-03-23 18:34:52', 3);
INSERT INTO `reply` VALUES (2, '你的昵称好看', '1333@321.com', '看看是谁I', '2021-03-22 17:08:10', '2021-03-23 18:37:25', '2021-03-23 18:37:25', 3);
INSERT INTO `reply` VALUES (3, 'xxyy', 'xxyy@msn.com', '扯拐了', '2021-03-23 18:36:20', '2021-03-23 18:36:20', NULL, 1);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类关键字',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签颜色',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (23, 'Redis', 'Redis', 'red', '2021-04-02 14:31:44', '2021-04-02 14:31:44', NULL);
INSERT INTO `tag` VALUES (24, 'Nginx', 'Nginx', 'green', '2021-04-02 14:32:04', '2021-04-02 14:32:04', NULL);
INSERT INTO `tag` VALUES (25, 'Typora', 'Typora', 'black', '2021-04-02 14:32:19', '2021-04-02 14:32:19', NULL);
INSERT INTO `tag` VALUES (26, 'Vuex', 'Vuex', 'coral', '2021-04-04 21:42:21', '2021-04-04 21:42:21', NULL);

SET FOREIGN_KEY_CHECKS = 1;
