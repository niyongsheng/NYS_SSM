/*
 Navicat Premium Data Transfer

 Source Server         : local_mysql
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : localhost:3306
 Source Schema         : daocaodui

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 09/12/2019 17:40:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dcd_article
-- ----------------------------
DROP TABLE IF EXISTS `dcd_article`;
CREATE TABLE `dcd_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID主键',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `subtitle` varchar(255) DEFAULT NULL COMMENT '副标题',
  `author` varchar(100) DEFAULT NULL COMMENT '作者',
  `account` varchar(50) NOT NULL COMMENT '发布者账号',
  `icon` varchar(255) DEFAULT NULL COMMENT '主图',
  `content` text COMMENT '文章内容',
  `articleUrl` varchar(255) DEFAULT NULL COMMENT '文章URL',
  `status` bit(1) DEFAULT b'1' COMMENT '文章状态 0不可用 1可用',
  `isTop` bit(1) DEFAULT b'0' COMMENT '是否置顶',
  `articleType` int(1) DEFAULT '1' COMMENT '文章类型 ：1普通 2转载',
  `fellowship` int(11) NOT NULL COMMENT '所属团契',
  `expireTime` datetime DEFAULT NULL COMMENT '过期时间',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`,`account`,`fellowship`) USING BTREE,
  KEY `账号_关联_用户表_account` (`account`),
  KEY `团契_关联_团契表_id` (`fellowship`),
  CONSTRAINT `团契_关联_团契表_id` FOREIGN KEY (`fellowship`) REFERENCES `dcd_fellowship` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `账号_关联_用户表_account` FOREIGN KEY (`account`) REFERENCES `dcd_user` (`account`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dcd_article
-- ----------------------------
BEGIN;
INSERT INTO `dcd_article` VALUES (1, '展翅上腾', '拦阻生命成长、展翅上腾的原因是什么?', '生命季刊', '7793477', 'https://mmbiz.qpic.cn/mmbiz_jpg/O2LJYlPIv9L4XtI9swKzMbFcr6CuPnmnX7uTsy9jZYibqlMPpOFLPjtKkHO0pLrofRLibJm96YX1xJBdBMMdL4PQ/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1', '每当我看见天上一群群的飞鸟，从我头顶掠过时，都会被这群快乐的天路客所吸引。我总喜欢停下来观看它们展翅上腾、在天空中自由快乐飞翔的景象。能够如此无拘无束地翱翔天际，岂不是一件快乐的事吗？\n \n其实我们也是一群群的天路客。我们伟大的救主耶稣基督道成肉身来到世界上，亲自将我们从罪恶势力中救赎出来，赐给我们属天的新生命。这是一个充满喜乐、平安的新生命，为什么呢？因为属天的人活在地上，他内心能够超越今生的物质世界，活出属于永恒的丰盛生命。\n \n基督徒在地上的生活常常充满许多障碍，如果我们可以突破那些拦阻我们活出属天生命的一切障碍，我们就可以在属灵的领域中自由翱翔，饱尝属天的福乐！那今天拦阻着我们、使我们失去属天的喜乐、甚至不能超越这个世界的，都是些什么障碍呢？\n \n我们所在的处境、生活中遇到的种种难处、身边的人和事等等，这些都有可能成为外在的阻碍。但是真正最深的根源，还是我们内在的生命的问题，就是我们老亚当的生命还在掌权作王。\n \n加拉太书5:16-17 “我说，你们当顺着圣灵而行，就不放纵肉体的情欲了。因为情欲和圣灵相争，圣灵和情欲相争，这两个是彼此相敌，使你们不能做所愿意做的。”\n \n什么是情欲的事呢？\n \n加拉太书5:19-21 “情欲的事都是显而易见的，就如奸淫、污秽、邪荡、拜偶像、邪术、仇恨、争竞、忌恨、恼怒、结党、纷争、异端、嫉妒、醉酒、荒宴等类。我从前告诉你们，现在又告诉你们，行这样事的人必不能承受神的国。”\n \n许多基督徒虽然已经承认主名，但我们的旧生命却仍然占上风，老亚当的生命仍然作王，这些就是影响我们属灵的生命不能成长的根本原因所在。\n \n除了上面加拉太书5:19至21所提到的那些情欲的事，我们还有许多其它败坏之处，比如有些人行事为人见风使舵、处事不公平、不公义、凭外表待人、喜富厌贫、与世俗为友等等。每一样不好的心思意念都像一线蛛丝，罪恶的意念越多，蛛丝织得越密，最后织出一张千丝万缕、牢固细密的蛛网，将我们牢牢地罩住。这蛛网不除，猎物又怎能得着释放呢！不要说翱翔了，就是起飞都不能实现，最后就只能沦为撒但攻击和欺负的对象了。这样的基督徒在外表上可能还是很热心服事，在教会做很多事工，但这些其实只是肉体上的事奉，没有圣灵的同在，只不过是草木禾秸的工程罢了。\n \n希伯来书12:1 “我们既有这许多的见证人，如同云彩围着我们，就当放下各样的重担，脱去容易缠累我们的罪，存心忍耐，奔那摆在我们前头的路程。”\n \n就是这些缠累我们的罪，在我们的生命中成为重担，这些都是不蒙神喜悦的部分，就是老亚当仍在我们生命中作王的那部分。\n \n 一个外表光鲜亮丽的杯子很吸引人，但当人拿起来想装水喝的时候，才发现里面很肮脏，没有人会用这个杯。同样，神看人是看其内心，神要看的是人里面有没有基督的生命。\n \n马太福音5:8 “淸心的人有福了，因为他们必得见神”。清心的人指的是那些内心没有诡诈与虚假的人，他们对人处事力求公平、公正、公义，对神则以心灵诚实来敬拜，这样的人必得见神。神出于自己圣洁的属性而喜悦人内心的圣洁，彼得前书1:16“你们要圣洁，因为我是圣洁的”。清心的人是最享受与神同在的人，这种人在世上活得最喜乐，因为他们已经脱去那容易缠累他们的罪，放下了罪的重担，他们就能够成为在属灵的领域中自由翱翔的天路客！\n \n然而若是靠着我们自己的努力，我们断然无法做到。人不可能留在老亚当的生命中，却想要成为清心的人、活出圣洁的生命。活出新生命必须要靠着从圣灵而来的能力，将我们老亚当的生命与基督同钉死在十架上，将一切的邪情私欲治死，让旧人里面的性情一一被对付被治死，新人就活出来了！我们自己毫无能力，然而我们凭着一颗真诚悔改，饥渴慕义的心，不断地依靠圣灵的力量，我们属天的生命，也必一天天地成长壮大！\n \n希伯来书12:2“仰望为我们信心创始成终的耶稣。祂因那摆在祂前面的喜乐，就轻看羞辱，忍受了十字架的苦难，便坐在神宝座的右边。”\n \n同样，今天我们这些蒙主耶稣十字架所拯救的儿女们，让我们一起仰望我们亲爱的救主耶稣基督，轻看世上一切的苦难与羞辱，因为一切苦难都是神对我们的造就；一切羞辱都是主耶稣曾经亲尝过的滋味。主耶稣要赐给我们的生命，是与祂亲密无间、与祂自己完全合一的生命！\n \n求主的灵来光照我们，赐给我们敏锐的属灵触觉，当我们面对任何事情的时候，使我们能分辨哪些是出自肉体的意念，哪些是出自圣灵的提醒。也求主赐给我们属灵的智慧和能力，使我们胜过肉体的邪情私欲。再赐我们谦卑温柔的心去领受一切真理的教导，让主真正坐在我们生命的宝座上，让主在我们的生命中掌权作王。只有这样，圣灵的能力才能在我们生命中顺畅无阻地运行；我们才能活出属神儿女应有的自由、喜乐、丰盛的属灵生命；才能为主做盐与发光，在这弯曲悖谬、黑暗败坏的世代，成为主的美好见证！哈利路亚！', NULL, b'0', NULL, 7793477, 1, NULL, '2019-12-06 11:40:59', '2019-12-06 11:40:55');
COMMIT;

-- ----------------------------
-- Table structure for dcd_banner
-- ----------------------------
DROP TABLE IF EXISTS `dcd_banner`;
CREATE TABLE `dcd_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `bannerUrl` varchar(255) DEFAULT NULL COMMENT '轮播图URL',
  `targetUrl` varchar(255) DEFAULT NULL COMMENT '轮播图跳转目标URL',
  `account` varchar(50) NOT NULL COMMENT '发布者账号',
  `fellowship` int(11) NOT NULL COMMENT '所属团契',
  `isTop` bit(1) DEFAULT NULL COMMENT '是否置顶',
  `status` bit(1) DEFAULT b'1' COMMENT '1有效0失效',
  `expireTime` datetime DEFAULT NULL COMMENT '过期时间',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`,`account`,`fellowship`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dcd_banner
-- ----------------------------
BEGIN;
INSERT INTO `dcd_banner` VALUES (1, 'test0', 'http://image.daocaodui.top/config/icon/cj0.jpg', 'http://www.baidu.com', '7793477', 1, b'1', b'1', '2019-12-09 10:00:46', '2019-12-09 10:00:50', '2019-12-09 10:00:54');
INSERT INTO `dcd_banner` VALUES (3, 'test1', 'http://image.daocaodui.top/config/icon/cj1.jpg', 'http://www.baidu.com', '7793477', 1, b'1', b'1', '2019-12-09 10:00:46', '2019-12-09 10:00:50', '2019-12-09 10:00:54');
INSERT INTO `dcd_banner` VALUES (4, 'test2', 'http://image.daocaodui.top/config/icon/cj2.jpg', 'http://www.baidu.com', '7793477', 1, b'1', b'1', '2019-12-09 10:00:46', '2019-12-09 10:00:50', '2019-12-09 10:00:54');
INSERT INTO `dcd_banner` VALUES (5, 'test3', 'http://image.daocaodui.top/config/icon/cj3.jpg', 'http://www.baidu.com', '7793477', 1, b'1', b'1', '2019-12-09 10:00:46', '2019-12-09 10:00:50', '2019-12-09 10:00:54');
COMMIT;

-- ----------------------------
-- Table structure for dcd_face
-- ----------------------------
DROP TABLE IF EXISTS `dcd_face`;
CREATE TABLE `dcd_face` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `account` varchar(255) NOT NULL COMMENT '人脸所属用户账号',
  `fellowship` int(11) DEFAULT NULL COMMENT '所属团契',
  `nickname` varchar(125) DEFAULT NULL COMMENT '昵称',
  `liveness` bit(1) DEFAULT b'1' COMMENT '1活体0非活体',
  `faceRect` varchar(32) DEFAULT NULL COMMENT '脸部位置(x,y,w,h)',
  `faceOrient` int(1) DEFAULT NULL COMMENT '脸部方向',
  `face3D` varchar(255) DEFAULT NULL COMMENT '3D角度信息(x,z,y)',
  `faceCode` text COMMENT '脸部特征码',
  `faceUrl` varchar(255) DEFAULT NULL COMMENT '网络位置',
  `faceBase64` longtext COMMENT '脸部图像base64',
  `facePhoto` varchar(255) DEFAULT NULL COMMENT '脸部图像',
  `age` int(3) DEFAULT '0' COMMENT '年龄',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别性别:male/female',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `人脸_关联_用户账号` (`account`),
  KEY `人脸表_团契_关联_团契id` (`fellowship`),
  CONSTRAINT `人脸_关联_用户账号` FOREIGN KEY (`account`) REFERENCES `dcd_user` (`account`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `人脸表_团契_关联_团契id` FOREIGN KEY (`fellowship`) REFERENCES `dcd_fellowship` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dcd_face
-- ----------------------------
BEGIN;
INSERT INTO `dcd_face` VALUES (1, '7793477', 1, NULL, b'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for dcd_fellowship
-- ----------------------------
DROP TABLE IF EXISTS `dcd_fellowship`;
CREATE TABLE `dcd_fellowship` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `fellowshipName` varchar(255) DEFAULT NULL COMMENT '团契名称',
  `fellowshipLogo` varchar(255) DEFAULT NULL COMMENT '团契logo',
  `userIcon` varchar(255) DEFAULT NULL COMMENT '用户默认头像',
  `grade` int(2) DEFAULT '0' COMMENT '团契等级',
  `introduction` varchar(255) DEFAULT NULL COMMENT '简介',
  `gps` varchar(70) DEFAULT NULL COMMENT '定位',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `status` bit(1) DEFAULT b'1' COMMENT '1有效0失效',
  `CommemorationDay` date DEFAULT NULL COMMENT '纪念日',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dcd_fellowship
-- ----------------------------
BEGIN;
INSERT INTO `dcd_fellowship` VALUES (1, '稻草堆', 'http://pyd6p69m3.bkt.clouddn.com/config/icon/logo_dcd.png', 'http://pyd6p69m3.bkt.clouddn.com/config/icon/me_dcd.png', 0, '塑造生命 成就使命', NULL, '中国#山东省#临沂市#兰山区#兰山街道', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for dcd_filelog
-- ----------------------------
DROP TABLE IF EXISTS `dcd_filelog`;
CREATE TABLE `dcd_filelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `fileUrl` varchar(255) DEFAULT NULL COMMENT '文件URL',
  `type` bit(1) NOT NULL COMMENT '1上传 0删除',
  `account` varchar(50) NOT NULL COMMENT '发布者账号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`,`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dcd_group
-- ----------------------------
DROP TABLE IF EXISTS `dcd_group`;
CREATE TABLE `dcd_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(20) NOT NULL COMMENT '群组ID',
  `groupIcon` varchar(255) DEFAULT NULL COMMENT '组群头像',
  `groupName` varchar(125) DEFAULT NULL COMMENT '群组名称',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `memberCount` int(5) DEFAULT NULL COMMENT '群成员数',
  `isBan` bit(1) DEFAULT b'0' COMMENT '是否禁言',
  `isVerify` bit(1) DEFAULT b'0' COMMENT '是否需要验证',
  `status` bit(1) DEFAULT b'1' COMMENT '群组状态 0不可用 1可用',
  `groupType` int(1) DEFAULT '1' COMMENT '群组类型  1官方群  2私人群',
  `fellowship` int(11) DEFAULT NULL COMMENT '所属团契',
  `expireTime` datetime DEFAULT NULL COMMENT '过期时间',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `群主_关联_用户账号` (`creator`),
  KEY `群表_团契_关联_团契id` (`fellowship`),
  CONSTRAINT `群主_关联_用户账号` FOREIGN KEY (`creator`) REFERENCES `dcd_user` (`account`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `群表_团契_关联_团契id` FOREIGN KEY (`fellowship`) REFERENCES `dcd_fellowship` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dcd_group
-- ----------------------------
BEGIN;
INSERT INTO `dcd_group` VALUES (1, 1001, 'http://pyd6p69m3.bkt.clouddn.com/config/icon/logo_dcd.png', '测试群', '7793477', NULL, b'1', b'0', b'1', 1, 1, NULL, '2019-10-26 10:15:11', '2019-10-10 10:13:03');
COMMIT;

-- ----------------------------
-- Table structure for dcd_music
-- ----------------------------
DROP TABLE IF EXISTS `dcd_music`;
CREATE TABLE `dcd_music` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID主键',
  `name` varchar(255) DEFAULT NULL COMMENT '歌名',
  `singer` varchar(255) DEFAULT NULL COMMENT '歌手',
  `wordAuthor` varchar(255) DEFAULT NULL COMMENT '词作者',
  `anAuthor` varchar(255) DEFAULT NULL COMMENT '曲作者',
  `icon` varchar(255) DEFAULT NULL COMMENT '封面',
  `lyric` text COMMENT '歌词',
  `musicUrl` varchar(255) DEFAULT NULL COMMENT '歌曲URL',
  `account` varchar(50) NOT NULL COMMENT '发布者账号',
  `status` bit(1) DEFAULT b'0' COMMENT '歌曲状态 0不可用 1可用',
  `isTop` bit(1) DEFAULT NULL COMMENT '是否置顶',
  `musicType` int(1) DEFAULT NULL COMMENT '歌曲类型 ',
  `fellowship` int(11) NOT NULL COMMENT '所属团契',
  `expireTime` datetime DEFAULT NULL COMMENT '过期时间',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`,`account`,`fellowship`) USING BTREE,
  KEY `账号_关联_用户表_account` (`account`),
  KEY `团契_关联_团契表_id` (`fellowship`),
  CONSTRAINT `dcd_music_ibfk_1` FOREIGN KEY (`fellowship`) REFERENCES `dcd_fellowship` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `dcd_music_ibfk_2` FOREIGN KEY (`account`) REFERENCES `dcd_user` (`account`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dcd_music_songMenu
-- ----------------------------
DROP TABLE IF EXISTS `dcd_music_songMenu`;
CREATE TABLE `dcd_music_songMenu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) DEFAULT NULL COMMENT '歌单名称',
  `icon` varchar(255) DEFAULT NULL COMMENT '歌单封面URL',
  `introduction` varchar(255) DEFAULT NULL COMMENT '歌单简介',
  `account` varchar(50) NOT NULL COMMENT '发布者账号',
  `fellowship` int(11) NOT NULL COMMENT '所属团契',
  `isTop` bit(1) DEFAULT NULL COMMENT '是否置顶',
  `status` bit(1) DEFAULT b'1' COMMENT '1有效0失效',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`,`account`,`fellowship`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dcd_pray
-- ----------------------------
DROP TABLE IF EXISTS `dcd_pray`;
CREATE TABLE `dcd_pray` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID主键',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `subtitle` varchar(255) DEFAULT NULL COMMENT '副标题',
  `account` varchar(50) NOT NULL COMMENT '发布者账号',
  `icon` varchar(255) DEFAULT NULL COMMENT '主图',
  `content` text COMMENT '代祷内容',
  `prayUrl` varchar(255) DEFAULT NULL COMMENT '代祷URL',
  `status` bit(1) DEFAULT b'0' COMMENT '代祷状态 0不可用 1可用',
  `isTop` bit(1) DEFAULT NULL COMMENT '是否置顶',
  `prayType` int(1) DEFAULT NULL COMMENT '代祷类型 ',
  `fellowship` int(11) DEFAULT NULL COMMENT '所属团契',
  `expireTime` datetime DEFAULT NULL COMMENT '过期时间',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`,`account`) USING BTREE,
  KEY `账号_关联_用户表_account` (`account`),
  KEY `团契_关联_团契表_id` (`fellowship`),
  CONSTRAINT `dcd_pray_ibfk_1` FOREIGN KEY (`fellowship`) REFERENCES `dcd_fellowship` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `dcd_pray_ibfk_2` FOREIGN KEY (`account`) REFERENCES `dcd_user` (`account`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dcd_publicnotice
-- ----------------------------
DROP TABLE IF EXISTS `dcd_publicnotice`;
CREATE TABLE `dcd_publicnotice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `publicnotice` text COMMENT '公告内容',
  `publicnoticeUrl` varchar(255) DEFAULT NULL COMMENT '公告跳转URL',
  `account` varchar(50) NOT NULL COMMENT '发布者账号',
  `fellowship` int(11) NOT NULL COMMENT '所属团契',
  `isTop` bit(1) DEFAULT NULL COMMENT '是否置顶',
  `status` bit(1) DEFAULT b'1' COMMENT '1有效0失效',
  `expireTime` datetime DEFAULT NULL COMMENT '过期时间',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`,`account`,`fellowship`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dcd_scorelog
-- ----------------------------
DROP TABLE IF EXISTS `dcd_scorelog`;
CREATE TABLE `dcd_scorelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `orderID` varchar(50) DEFAULT NULL COMMENT '单号',
  `amount` float NOT NULL COMMENT '数额',
  `inout` bit(1) NOT NULL DEFAULT b'0' COMMENT '1收入 0支出',
  `account` varchar(50) NOT NULL COMMENT '积分账号',
  `type` int(2) DEFAULT NULL COMMENT '类型：1签到 2奖励 3交易',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`,`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dcd_user
-- ----------------------------
DROP TABLE IF EXISTS `dcd_user`;
CREATE TABLE `dcd_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `account` varchar(255) DEFAULT NULL COMMENT '账号',
  `truename` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `icon` varchar(255) DEFAULT NULL COMMENT '头像',
  `grade` int(2) DEFAULT '0' COMMENT '等级',
  `score` float(7,0) DEFAULT '0' COMMENT '积分',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别',
  `phone` varchar(15) DEFAULT NULL COMMENT '手机号',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `token` varchar(255) DEFAULT NULL COMMENT '登录令牌',
  `imToken` varchar(255) DEFAULT NULL COMMENT 'IM令牌',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `introduction` varchar(255) DEFAULT NULL COMMENT '简介',
  `email` varchar(70) DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `fellowship` int(4) DEFAULT NULL COMMENT '团契',
  `profession` int(4) DEFAULT '1' COMMENT '身份类型',
  `qqOpenid` varchar(100) DEFAULT NULL COMMENT 'QQ',
  `wcOpenid` varchar(100) DEFAULT NULL COMMENT '微信',
  `status` bit(1) DEFAULT b'1' COMMENT '1有效0失效',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `gmtModify` datetime DEFAULT NULL COMMENT '修改时间',
  `gmtCreate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `account` (`account`),
  KEY `emp_fellowship__dept_id` (`fellowship`),
  KEY `id` (`id`),
  CONSTRAINT `emp_fellowship__dept_id` FOREIGN KEY (`fellowship`) REFERENCES `dcd_fellowship` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dcd_user
-- ----------------------------
BEGIN;
INSERT INTO `dcd_user` VALUES (0, '17693111', '倪正则', 'https://dn-portal-files.qbox.me/sample1.jpg?watermark/2/text/56i76I2J5aCG/font/5b6u6L2v6ZuF6buR/fontsize/400/fill/I0VGRUZFRg==/dissolve/70/gravity/SouthEast/dx/10/dy/10', 3, 300, 'male', '18853936111', 'e10adc3949ba59abbe56e057f20f883e', NULL, 'ghi-3333', '貳', '(*^__^*) 嘻嘻……', '3333@dcd.com', '北京', 1, 1, NULL, NULL, b'0', NULL, NULL, '2019-10-10 16:20:04');
INSERT INTO `dcd_user` VALUES (1, '7793477', '倪刚', 'http://image.daocaodui.top/1575438242063_jpeg', 1, 100, 'male', '18853936112', 'dc483e80a7a0bd9ef71d8cf973673924', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1Nzg0NjEzMDAxMjgsInBheWxvYWQiOiJ7XCJwcm9mZXNzaW9uXCI6MCxcImlkXCI6MSxcImZlbGxvd3NoaXBcIjoxLFwiYWNjb3VudFwiOlwiNzc5MzQ3N1wiLFwic3RhdHVzXCI6dHJ1ZX0ifQ.AeEdK_XqadRT1zpHLMcYTEfeJ3wwP7kiLn763YYxxYs', 'wuRqDTBXmdHhsfnl8Ge12pJzCV5BmpBbI/XSo5Diiwl+O/jFOpbcFgRF7ABrGXZqQYkrpZHMvilgRaHgut3AVA==', '倪永胜', '吾生有崖,而知无崖.', '1111@dcd.com', '山东省青岛市市南区人民法院', 1, 0, NULL, NULL, b'1', '2028-12-04', '2019-12-09 13:28:20', '2019-10-15 16:20:04');
INSERT INTO `dcd_user` VALUES (2, '9524786', '倪永辉', 'http://zhaijidi.qmook.com/morentouxiang@3x.png', 0, 0, 'unknown', '15376070939', 'e10adc3949ba59abbe56e057f20f883e', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NzQyOTg4MTM2ODUsInBheWxvYWQiOiJ7XCJwcm9mZXNzaW9uXCI6MSxcImlkXCI6MixcImZlbGxvd3NoaXBcIjoxLFwiYWNjb3VudFwiOlwiOTUyNDc4NlwiLFwic3RhdHVzXCI6dHJ1ZX0ifQ.p3c_qzn4-IH37ILgqvHlaI5QFIZYny2sAbnPHfJ1S1I', 'RjW7YN/LI0oMajQWhqi0QuBzBX0FW6Fb/NiaIGe1S2US6Oba2Oc3/XH4GQArMrKt/y0tZNOWbQLAQbXn6Ltni7w7+ZYszXM+', '哈巴谷书', '哈哈啊', NULL, '上海', 1, 1, NULL, NULL, b'1', NULL, '2019-10-22 09:13:33', '2019-10-17 16:20:04');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
