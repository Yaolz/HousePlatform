SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_activity`
-- ----------------------------
DROP TABLE IF EXISTS `t_activity`;
CREATE TABLE `t_activity` (
  `id` varchar(36) NOT NULL,
  `title` varchar(50) NOT NULL COMMENT '活动标题',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `address` varchar(100) DEFAULT NULL COMMENT '活动地址',
  `content` text COMMENT '活动内容',
  `logo` varchar(255) DEFAULT NULL,
  `buildings_id` varchar(36) DEFAULT NULL COMMENT '楼盘编号',
  `agency_id` varchar(36) DEFAULT NULL COMMENT '经销商编号',
  `status` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_activity_buildings_id` (`buildings_id`),
  KEY `fk_activity_agency_id` (`agency_id`),
  CONSTRAINT `fk_activity_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_activity_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_activity
-- ----------------------------
INSERT INTO `t_activity` VALUES ('4028808b5e803bd2015e803bd6450000', '大减价', '2017-09-17 00:00:00', '2017-09-14 00:00:00', '江西', '', 'uploads/5D (7).jpg', '402880355e59ad56015e59ad5a820000', '402880355e59ac4d015e59ac51560000', '1');
INSERT INTO `t_activity` VALUES ('4028808b5e80432b015e80432fb10000', '大特价', '2017-09-14 00:00:00', '2017-09-17 00:00:00', '爱爱爱', '', 'uploads/5D (25).jpg', '402880355e59ad56015e59ad5a820000', '402880355e59ac4d015e59ac51560000', '1');
INSERT INTO `t_activity` VALUES ('4028808b5e887185015e88720b160000', '草草草草草', '2017-09-16 00:00:00', '2017-09-16 00:00:00', '大打', '嘟嘟嘟', 'uploads/5D (6).png', '402880355e59ad56015e59ad5a820000', '402880355e59ac4d015e59ac51560000', '1');
INSERT INTO `t_activity` VALUES ('402880ce5eac2663015eac6b875f0000', '6666666', '2017-09-26 00:00:00', '2017-09-26 00:00:00', '66666666666', '6666666666666666666', 'uploads/wallpaper_5221854.jpg', null, null, '1');
INSERT INTO `t_activity` VALUES ('402880ce5eac2663015eac6b916a0001', '1234', '2017-09-26 00:00:00', '2017-09-26 00:00:00', '123e4rtyu', '<p>23456yut43e2w1</p>', 'uploads/wallpaper_5221850.jpg', null, null, '1');
INSERT INTO `t_activity` VALUES ('402880ce5eac9acf015eac9ffb450000', '9898', '2017-09-26 00:00:00', '2017-09-20 00:00:00', '888888', '<p>5678997888888888888888888888888888888</p>', 'uploads/wallpaper_5221854.jpg', null, null, '1');

-- ----------------------------
-- Table structure for `t_admin`
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `name` varchar(50) DEFAULT NULL COMMENT '管理员姓名',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `pwd` varchar(50) NOT NULL COMMENT '密码(md5)',
  `email` varchar(50) DEFAULT NULL,
  `role_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_admin_roleid` (`role_id`),
  CONSTRAINT `FK_admin_roleid` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('7850cc60886411e7a5142c56dc7febbc', '售楼网管理员', '0797-888888', '4QrcOUm6Wau+VuBX8g+IPg==', 'shoulouwang@qq.com', null);

-- ----------------------------
-- Table structure for `t_ads`
-- ----------------------------
DROP TABLE IF EXISTS `t_ads`;
CREATE TABLE `t_ads` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `title` varchar(50) NOT NULL COMMENT '广告标题',
  `content` varchar(50) NOT NULL COMMENT '广告描述',
  `logo` varchar(500) DEFAULT NULL COMMENT '广告图片路径',
  `ad_url` varchar(500) DEFAULT NULL COMMENT '广告URl路径',
  `show_status` tinyint(4) DEFAULT '1' COMMENT '是否显示',
  `show_order` int(11) DEFAULT NULL COMMENT '显示顺序',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_ads
-- ----------------------------
INSERT INTO `t_ads` VALUES ('402880ce5eac9acf015eaca67e690001', 'Ｏ(≧口≦)Ｏ w...w123', '水电费规划规范的撒w123', 'uploads/wallpaper_5221866.jpg', '啊是电饭锅w123', '0', '3', null, '1');

-- ----------------------------
-- Table structure for `t_agency`
-- ----------------------------
DROP TABLE IF EXISTS `t_agency`;
CREATE TABLE `t_agency` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '经销商名称',
  `email` varchar(50) NOT NULL COMMENT '邮箱，作为登录帐号',
  `pwd` varchar(50) NOT NULL COMMENT '密码',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人姓名',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `tel` varchar(15) DEFAULT NULL COMMENT '固定电话',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `logo` varchar(500) DEFAULT NULL,
  `intro` varchar(500) DEFAULT NULL COMMENT '简介',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `checked_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `role_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `name` (`name`),
  KEY `FK_agency_roleid` (`role_id`),
  CONSTRAINT `FK_agency_roleid` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_agency
-- ----------------------------
INSERT INTO `t_agency` VALUES ('402880355e59ac4d015e59ac51560000', '啊啊啊啊啊啊啊啊啊啊', '20000@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '老王', '13802266401', '07558147730', '江西bb', 'public/img/noimage.png', '爱爱爱', '2017-09-07 08:10:19', '1', '1', 'd715a8c987f411e7a5142c56dc7febbc');
INSERT INTO `t_agency` VALUES ('402880355e59ac4d015e59ac51ca0001', '经销商1', '20001@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '老王', '1380226641', '07558147731', '北京', null, null, '2017-09-07 08:10:19', '1', '1', 'd715a8c987f411e7a5142c56dc7febbc');
INSERT INTO `t_agency` VALUES ('402880355e59ac4d015e59ac51cf0002', '经销商2', '20002@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '老王', '1380226642', '07558147732', '北京', null, null, '2017-09-07 08:10:19', '1', '1', 'd715a8c987f411e7a5142c56dc7febbc');
INSERT INTO `t_agency` VALUES ('402880355e70b5b4015e70b77c7c0000', null, '20006@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', null, '13802266407', null, null, null, null, '2017-09-11 19:33:47', '1', '0', 'd715a8c987f411e7a5142c56dc7febbc');
INSERT INTO `t_agency` VALUES ('4028808b5e78f5c1015e7915fea60000', 'Test', 'test@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', 'Test', '13888888888', '', '', 'uploads/5D (5).png', '', '2017-09-13 10:33:58', '1', '1', 'd715a8c987f411e7a5142c56dc7febbc');
INSERT INTO `t_agency` VALUES ('40289fc15e6990d7015e699d7f930018', null, '30005@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', null, '13802266402', null, null, null, null, '2017-09-10 10:28:03', '1', '1', 'd715a8c987f411e7a5142c56dc7febbc');

-- ----------------------------
-- Table structure for `t_appointment`
-- ----------------------------
DROP TABLE IF EXISTS `t_appointment`;
CREATE TABLE `t_appointment` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `app_arrive_time` datetime DEFAULT NULL COMMENT '预约看房时间',
  `arrive_time` datetime DEFAULT NULL COMMENT '真实看房时间',
  `app_status` tinyint(4) DEFAULT NULL COMMENT '预约状态',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态，激活或冻结',
  `emp_id` varchar(36) DEFAULT NULL COMMENT '员工编号',
  `user_id` varchar(36) DEFAULT NULL COMMENT '员工编号',
  `agency_id` varchar(36) DEFAULT NULL,
  `house_id` varchar(36) DEFAULT NULL COMMENT '户型编号',
  PRIMARY KEY (`id`),
  KEY `fk_app_emp_id` (`emp_id`),
  KEY `fk_app_user_id` (`user_id`),
  KEY `fk_app_agency_id` (`agency_id`),
  KEY `fk_app_house_id` (`house_id`),
  CONSTRAINT `fk_app_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_app_emp_id` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`),
  CONSTRAINT `fk_app_house_id` FOREIGN KEY (`house_id`) REFERENCES `t_house` (`id`),
  CONSTRAINT `fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_appointment
-- ----------------------------
INSERT INTO `t_appointment` VALUES ('402880355e740d13015e740d18720000', '2017-09-12 11:06:09', '2017-09-24 00:52:49', '1', '2017-09-12 11:06:09', '1', '402880355e59b2b0015e59b2b4e00000', '402880355e64ac65015e64ad09550000', '402880355e59ac4d015e59ac51560000', '402880355e59ae46015e59ae4b110000');

-- ----------------------------
-- Table structure for `t_article`
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `title` varchar(50) NOT NULL COMMENT '文章标题',
  `abstracts` varchar(100) NOT NULL COMMENT '文章摘要',
  `content` text NOT NULL COMMENT '文章内容',
  `logo` varchar(500) DEFAULT NULL COMMENT '文章图片路径',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `admin_id` varchar(36) DEFAULT NULL COMMENT '管理员id',
  `type_id` varchar(36) DEFAULT NULL COMMENT '类型id',
  PRIMARY KEY (`id`),
  KEY `fk_article_type_id` (`type_id`),
  CONSTRAINT `fk_article_type_id` FOREIGN KEY (`type_id`) REFERENCES `t_article_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_article
-- ----------------------------
INSERT INTO `t_article` VALUES ('402880ce5eb70450015eb7ea46910003', '123', '水电费该用户', '<p>水电费刚回家看喀什市大飞哥</p>', 'uploads/wallpaper_5221854.jpg', '2017-09-25 15:22:18', '1', '7850cc60886411e7a5142c56dc7febbc', '402880ce5eacaac1015eacbeb4550000');
INSERT INTO `t_article` VALUES ('402880ce5eb70450015eb7eaa29d0004', '儿童Yui', '23456Yui维尔体育健康', '<p>是大法官和加快了</p>', 'uploads/wallpaper_5221850.jpg', '2017-09-25 15:22:41', '1', '7850cc60886411e7a5142c56dc7febbc', '402880ce5eacaac1015eacbeb4550000');
INSERT INTO `t_article` VALUES ('402880ce5eb70450015eb7eb17800005', '法国红酒', '是的法规和健康', '<p>阿萨德日发帖勾玉卡</p>', 'uploads/wallpaper_5221882.jpg', '2017-09-25 15:23:11', '1', '7850cc60886411e7a5142c56dc7febbc', '402880ce5eacaac1015eacbeb4550000');
INSERT INTO `t_article` VALUES ('402880ce5eb70450015eb7f469750006', '发过火鸡', '是的法规和健康伶', '<p>玩儿体育记看了</p>', 'uploads/wallpaper_5221868.jpg', '2017-09-25 15:33:22', '1', '7850cc60886411e7a5142c56dc7febbc', '402880ce5eacaac1015eacbeb4550000');
INSERT INTO `t_article` VALUES ('402880ce5eb70450015eb7f4a4710007', '客家话', '是的法规和健康', '<p>玩儿体育</p>', 'uploads/wallpaper_5221866.jpg', '2017-09-25 15:33:37', '1', '7850cc60886411e7a5142c56dc7febbc', '402880ce5eacaac1015eacbeb4550000');
INSERT INTO `t_article` VALUES ('402880ce5eb70450015eb7f4fe110008', '艾薇儿退款', '玩儿推Yui雨天热玩儿体育', '<p>艾薇儿体育课了</p>', 'uploads/wallpaper_5221878.jpg', '2017-09-25 15:34:00', '0', '7850cc60886411e7a5142c56dc7febbc', '402880ce5eacaac1015eacbeb4550000');

-- ----------------------------
-- Table structure for `t_article_type`
-- ----------------------------
DROP TABLE IF EXISTS `t_article_type`;
CREATE TABLE `t_article_type` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `name` varchar(50) NOT NULL COMMENT '类别名称',
  `des` varchar(500) DEFAULT NULL COMMENT '类别描述',
  `status` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_article_type
-- ----------------------------
INSERT INTO `t_article_type` VALUES ('402880ce5eacaac1015eacbeb4550000', '搞笑', '去玩儿回家', '1');

-- ----------------------------
-- Table structure for `t_building`
-- ----------------------------
DROP TABLE IF EXISTS `t_building`;
CREATE TABLE `t_building` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '楼栋名称',
  `total_floor` int(11) NOT NULL COMMENT '总层数',
  `total_lift` int(11) NOT NULL COMMENT '电梯数',
  `floor_rooms` int(11) NOT NULL COMMENT '每层多少户',
  `total_room` int(11) NOT NULL COMMENT '总户数',
  `created_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `buildings_id` varchar(36) DEFAULT NULL COMMENT '楼盘编号',
  PRIMARY KEY (`id`),
  KEY `fk_building` (`buildings_id`),
  CONSTRAINT `fk_building` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_building
-- ----------------------------
INSERT INTO `t_building` VALUES ('402880355e59aebc015e59aec0fd0000', 'A栋', '10', '2', '4', '200', null, '0', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_building` VALUES ('402880355e59af74015e59af78280000', 'A栋', '10', '2', '4', '200', null, '0', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_building` VALUES ('402880355e59b1a4015e59b1a8e40000', 'A栋', '10', '2', '4', '200', null, '0', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_building` VALUES ('4028808b5e78f5c1015e792817280007', '1', '30', '2', '0', '0', null, '0', '4028808b5e78f5c1015e792716670006');
INSERT INTO `t_building` VALUES ('4028808b5e7f3536015e7f35dc810000', 'AAB1', '100', '5', '10', '1000', '2017-09-14 15:06:30', '0', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_building` VALUES ('4028808b5e7f3536015e7f53b95303e9', 'C1a', '100', '10', '8', '800', '2017-09-14 15:39:07', '0', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_building` VALUES ('4028808b5e7f3536015e7f54bb53070a', 'A186', '100', '10', '5', '500', '2017-09-14 15:40:13', '0', '402880355e59ad56015e59ad5a820000');

-- ----------------------------
-- Table structure for `t_buildings`
-- ----------------------------
DROP TABLE IF EXISTS `t_buildings`;
CREATE TABLE `t_buildings` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '楼盘名称',
  `area` varchar(50) DEFAULT NULL COMMENT '所属区域',
  `address` varchar(100) DEFAULT NULL,
  `floor_area` double DEFAULT NULL COMMENT '占地面积',
  `building_area` double DEFAULT NULL COMMENT '建筑面积',
  `house_type` varchar(20) DEFAULT NULL COMMENT '房源类型',
  `building_type` varchar(20) DEFAULT NULL COMMENT '建筑类型',
  `latitude` double NOT NULL COMMENT '纬度',
  `longitude` double NOT NULL COMMENT '纬度',
  `avg_price` double NOT NULL COMMENT '楼盘均价',
  `company` varchar(255) DEFAULT NULL COMMENT '开发公司',
  `open_date` date DEFAULT NULL COMMENT '开盘时间',
  `total_rooms` int(11) DEFAULT NULL COMMENT '总套数',
  `reception_address` varchar(100) NOT NULL COMMENT '接待地址',
  `tel` varchar(15) NOT NULL COMMENT '楼盘售楼电话',
  `green_ratio` double DEFAULT NULL COMMENT '绿化率',
  `plot_ratio` double DEFAULT NULL COMMENT '容积率',
  `property_company` varchar(100) DEFAULT NULL COMMENT '物业公司',
  `property_fee` double DEFAULT NULL COMMENT '物业费',
  `car_station` int(11) DEFAULT NULL COMMENT '车位数',
  `traffic` text COMMENT '交通状况',
  `equipments` text COMMENT '周边配套',
  `logo` varchar(500) DEFAULT NULL,
  `intro` varchar(500) DEFAULT NULL COMMENT '简介',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `agency_id` varchar(36) NOT NULL COMMENT '经销商id',
  `province` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_agency_id` (`agency_id`),
  CONSTRAINT `fk_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_buildings
-- ----------------------------
INSERT INTO `t_buildings` VALUES ('402880355e59ad56015e59ad5a820000', '壹号楼盘', '赣县', '四川', null, '100000000', '普通住宅', '高层', '20.5', '100.5', '4500', '蓝翔建筑公司', '2017-09-20', '1005', '赣州章贡区58号大道', '07978843741', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (10).png', '江西省', '2017-09-07 08:11:27', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('402880355e75169d015e75175d650000', '天上人间', '章贡区', '江西省赣州市', '13335.8', '26665.68', '普通住宅', '板楼', '138.6', '120.5', '12111.5', '江西装修集团', '2021-01-19', '1200', '章贡区58号路', '075581477315', '30.58', '35.58', '暂无', '1000.5', '3000', '流畅', '', 'uploads/5D (1).png', '', '2012-09-13 00:00:00', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('402880355e7519ca015e751a1e830000', '天线宝宝', '章贡区', '江西省赣州市', null, '26665.68', '普通住宅', '板楼', '13.6', '120.5', '12111.5', '江西装修集团', '2021-01-19', '1200', '章贡区58号路', '075581477315', '30.58', '35.58', '暂无', '1000.5', '3000', '流畅', '', 'uploads/5D (1).png', '江西省', '2012-09-13 00:00:00', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('402880355e7519ca015e751ee39f0001', '绝望之城', '南康区', '江西赣州市南康', '123456', '123456.5', '商品房', '板楼', '31.2', '552.5', '11112.56', '娃哈哈', '2019-09-17', '1200', '章贡区23路', '07978842135', '50', '20', '无', '123.5', '1235', '流畅', '', 'uploads/5D (7).png', '', '2015-09-23 00:00:00', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e78f5c1015e792716670006', '番剧', '章贡区', '赣州', '45222.5', '45525.66', '普通住宅', '板楼', '120', '120', '45555', '52542', '2017-09-14', '2000', '5252', '5254', '25', '25', '45252', '525', '54254', '52542', '54254', 'uploads/5D (10).jpg', '', '2017-09-18 10:33:11', '1', '4028808b5e78f5c1015e7915fea60000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e7b29a8015e7b2af3b60000', '花园宝宝', '章贡区', '', null, '4556456', '普通住宅', '板楼', '55.5', '12.02', '456456', '', '2017-09-13', '0', '赣州大道110', '', null, null, '', '0', '0', '', '', 'uploads/5D (7).png', '', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e82f1de015e8309a0db0000', '亚历山大', '章贡区', '', null, '2255456', '普通住宅', '板楼', '89.9999', '123.5555', '124564', '', '2017-09-12', '1122', '赣州', '', null, null, '', '0', '0', '', '', 'uploads/5D (7).png', '', '2017-09-18 10:33:11', '1', '402880355e70b5b4015e70b77c7c0000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e82f1de015e830b70930001', '亚历克斯', '章贡区', '', null, '456465', '普通住宅', '板楼', '22', '111', '2123', '', '2017-09-12', '1122', '江西', '', null, null, '', '0', '0', '', '', 'uploads/5D (7).png', '', '2017-09-18 10:33:11', '1', '402880355e70b5b4015e70b77c7c0000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e887185015e887e84d30001', '天堂之门', '章贡区', '', null, '123123', '普通住宅', '板楼', '12', '11.5', '123123', '', '2017-09-12', '0', '撒打算的', '', null, null, '', '0', '0', '', '', 'uploads/5D (7).png', '', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51cf0002', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513250000', '地下城0', '章贡区0', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843740', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513960001', '地下城1', '章贡区1', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843741', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d5139b0002', '地下城2', '章贡区2', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843742', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513a00003', '地下城3', '章贡区3', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843743', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513a40004', '地下城4', '章贡区4', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843744', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513a80005', '地下城5', '章贡区5', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843745', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513ab0006', '地下城6', '章贡区6', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843746', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513af0007', '地下城7', '章贡区7', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843747', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513b30008', '地下城8', '章贡区8', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843748', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513b80009', '地下城9', '章贡区9', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843749', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513bc000a', '地下城10', '章贡区10', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437410', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'uploads/5D (7).png', '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513c0000b', '地下城11', '章贡区11', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437411', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', null, '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513c4000c', '地下城12', '章贡区12', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437412', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', null, '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513c7000d', '地下城13', '章贡区13', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437413', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', null, '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513cb000e', '地下城14', '章贡区14', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437414', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', null, '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513cf000f', '地下城15', '章贡区15', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437415', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', null, '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513d40010', '地下城16', '章贡区16', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437416', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', null, '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513d70011', '地下城17', '章贡区17', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437417', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', null, '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513db0012', '地下城18', '章贡区18', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437418', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', null, '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92d50e015e92d513df0013', '地下城19', '章贡区19', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437419', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', null, '黑色天堂', '2017-09-18 10:33:11', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2080000', '地下城0', '章贡区0', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843740', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a29a0001', '地下城1', '章贡区1', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843741', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a29f0002', '地下城2', '章贡区2', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843742', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2a30003', '地下城3', '章贡区3', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843743', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2a80004', '地下城4', '章贡区4', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843744', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2ad0005', '地下城5', '章贡区5', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843745', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2b00006', '地下城6', '章贡区6', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843746', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2b30007', '地下城7', '章贡区7', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843747', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2b80008', '地下城8', '章贡区8', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843748', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2bb0009', '地下城9', '章贡区9', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '07978843749', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2be000a', '地下城10', '章贡区10', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437410', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2c2000b', '地下城11', '章贡区11', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '18000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437411', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2c4000c', '地下城12', '章贡区12', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '23000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437412', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2c8000d', '地下城13', '章贡区13', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437413', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2cb000e', '地下城14', '章贡区14', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437414', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2cf000f', '地下城15', '章贡区15', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437415', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2d40010', '地下城16', '章贡区16', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437416', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2d70011', '地下城17', '章贡区17', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437417', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2da0012', '地下城18', '章贡区18', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437418', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');
INSERT INTO `t_buildings` VALUES ('4028808b5e92e09d015e92e0a2de0013', '地下城19', '章贡区19', '江西省', '1000000', '100000000', '普通住宅', '高层', '20.5', '100.5', '13000.5', '蓝翔建筑公司', '2017-09-18', '1005', '赣州章贡区58号大道', '079788437419', '50.5', '30.5', '暂不公开', '0', '1000', '流畅', '无', 'public/img/noimage.png', '黑色天堂', '2017-09-18 10:45:49', '1', '402880355e59ac4d015e59ac51560000', '江西省', '赣州市');

-- ----------------------------
-- Table structure for `t_buildings_avgprice`
-- ----------------------------
DROP TABLE IF EXISTS `t_buildings_avgprice`;
CREATE TABLE `t_buildings_avgprice` (
  `id` varchar(36) NOT NULL,
  `avg_price` double NOT NULL COMMENT '楼盘均价',
  `recording_time` datetime NOT NULL COMMENT '修改均价的时间',
  `buildings_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_avg_buildings_id` (`buildings_id`),
  CONSTRAINT `fk_avg_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_buildings_avgprice
-- ----------------------------
INSERT INTO `t_buildings_avgprice` VALUES ('4028808b5e9efb54015e9f00234b0000', '12000.5', '2017-09-21 19:15:40', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_buildings_avgprice` VALUES ('402880ce5eb70450015eb70c42a30000', '2000000000', '2017-09-25 11:19:48', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_buildings_avgprice` VALUES ('402880ce5eb70450015eb70c93590001', '12345', '2017-09-25 11:20:08', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_buildings_avgprice` VALUES ('402880ce5eb70450015eb70cf0d10002', '4500', '2017-09-25 11:20:32', '402880355e59ad56015e59ad5a820000');

-- ----------------------------
-- Table structure for `t_buildings_img`
-- ----------------------------
DROP TABLE IF EXISTS `t_buildings_img`;
CREATE TABLE `t_buildings_img` (
  `id` varchar(36) NOT NULL,
  `img_path` varchar(500) NOT NULL COMMENT '图片路径',
  `img_des` varchar(50) DEFAULT NULL COMMENT '图片描述',
  `created_time` datetime DEFAULT NULL,
  `buildings_id` varchar(36) DEFAULT NULL COMMENT '楼盘编号',
  PRIMARY KEY (`id`),
  KEY `fk_buildings_id` (`buildings_id`),
  CONSTRAINT `fk_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_buildings_img
-- ----------------------------
INSERT INTO `t_buildings_img` VALUES ('4028808b5e93ba6b015e93bf1f900031', 'uploads/5D (8).jpg', null, '2017-09-18 14:48:50', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e93ba6b015e93bf1fa30032', 'uploads/5D (8).png', null, '2017-09-18 14:48:50', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e93ba6b015e93bf20030033', 'uploads/5D (9).jpg', null, '2017-09-18 14:48:50', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e93ba6b015e93bf20160034', 'uploads/5D (9).png', null, '2017-09-18 14:48:50', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e93ba6b015e93bf204d0035', 'uploads/5D (10).jpg', null, '2017-09-18 14:48:50', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e93ba6b015e93bf20520036', 'uploads/5D (10).png', null, '2017-09-18 14:48:50', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e93ba6b015e93bf20fd0037', 'uploads/5D (11).jpg', null, '2017-09-18 14:48:50', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3df80000', 'uploads/5D (11).png', null, '2017-09-18 16:30:32', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3e380001', 'uploads/5D (12).jpg', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3e400002', 'uploads/5D (12).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3ea50003', 'uploads/5D (13).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3ea60004', 'uploads/5D (13).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3f020005', 'uploads/5D (14).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3f060006', 'uploads/5D (14).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3f320007', 'uploads/5D (15).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3f350008', 'uploads/5D (15).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3fa30009', 'uploads/5D (16).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3fa5000a', 'uploads/5D (16).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3fe6000b', 'uploads/5D (17).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c3fec000c', 'uploads/5D (17).png', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e941992015e941c403b000d', 'uploads/5D (18).jpg', null, '2017-09-18 16:30:33', '4028808b5e92e09d015e92e0a2080000');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dacf190000', 'uploads/5D (69).png', null, '2017-09-18 19:58:41', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dacf540001', 'uploads/5D (69).png', null, '2017-09-18 19:58:41', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dacf540002', 'uploads/5D (69).png', null, '2017-09-18 19:58:41', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dacf540003', 'uploads/5D (69).png', null, '2017-09-18 19:58:41', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dacf540004', 'uploads/5D (69).png', null, '2017-09-18 19:58:41', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad01c0005', 'uploads/5D (70).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad03d0006', 'uploads/5D (70).png', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad0610007', 'uploads/5D (71).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad0890008', 'uploads/5D (72).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad0ed0009', 'uploads/5D (73).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad11e000a', 'uploads/5D (74).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad156000b', 'uploads/5D (75).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad192000c', 'uploads/5D (76).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad1a9000d', 'uploads/5D (77).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad1cf000e', 'uploads/5D (78).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad1f2000f', 'uploads/5D (79).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad2370010', 'uploads/5D (80).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad2810011', 'uploads/5D (81).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad2a30012', 'uploads/5D (82).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad2e50013', 'uploads/5D (83).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad32e0014', 'uploads/5D (84).jpg', null, '2017-09-18 19:58:42', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad3a20015', 'uploads/5D (85).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad3f60016', 'uploads/5D (86).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad4520017', 'uploads/5D (87).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad4c40018', 'uploads/5D (88).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad52b0019', 'uploads/5D (89).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad588001a', 'uploads/5D (90).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad5da001b', 'uploads/5D (91).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad688001c', 'uploads/5D (92).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad6cd001d', 'uploads/5D (93).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad71d001e', 'uploads/5D (94).jpg', null, '2017-09-18 19:58:43', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad745001f', 'uploads/5D (95).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad7a50020', 'uploads/5D (96).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad7f20021', 'uploads/5D (97).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad8360022', 'uploads/5D (98).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad87c0023', 'uploads/5D (99).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad8e00024', 'uploads/5D (100).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad91d0025', 'uploads/5D (101).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad9660026', 'uploads/5D (102).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad99d0027', 'uploads/5D (103).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dad9be0028', 'uploads/5D (104).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dada580029', 'uploads/5D (105).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dada9b002a', 'uploads/5D (106).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadabb002b', 'uploads/5D (107).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadaf1002c', 'uploads/5D (108).jpg', null, '2017-09-18 19:58:44', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadb30002d', 'uploads/5D (109).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadb90002e', 'uploads/5D (110).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadbc8002f', 'uploads/5D (111).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadc280030', 'uploads/5D (112).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadc4a0031', 'uploads/5D (113).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadc700032', 'uploads/5D (114).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadca10033', 'uploads/5D (115).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadcda0034', 'uploads/5D (116).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadcfa0035', 'uploads/5D (117).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadd5f0036', 'uploads/5D (118).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94daddbd0037', 'uploads/5D (119).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94daddf20038', 'uploads/5D (120).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dade390039', 'uploads/5D (121).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dade88003a', 'uploads/5D (122).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadeac003b', 'uploads/5D (123).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadec9003c', 'uploads/5D (124).jpg', null, '2017-09-18 19:58:45', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadf23003d', 'uploads/5D (125).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dadf7b003e', 'uploads/5D (126).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae008003f', 'uploads/5D (127).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae0840040', 'uploads/5D (128).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae0cf0041', 'uploads/5D (129).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae0f70042', 'uploads/5D (130).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae13b0043', 'uploads/5D (131).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae19d0044', 'uploads/5D (132).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae1db0045', 'uploads/5D (133).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae25a0046', 'uploads/5D (134).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae2d00047', 'uploads/5D (135).jpg', null, '2017-09-18 19:58:46', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae33f0048', 'uploads/5D (136).jpg', null, '2017-09-18 19:58:47', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae3c80049', 'uploads/5D (137).jpg', null, '2017-09-18 19:58:47', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae4c6004a', 'uploads/5D (138).jpg', null, '2017-09-18 19:58:47', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae57e004b', 'uploads/5D (139).jpg', null, '2017-09-18 19:58:47', '4028808b5e92e09d015e92e0a29a0001');
INSERT INTO `t_buildings_img` VALUES ('4028808b5e942557015e94dae59c004c', 'uploads/5D (140).jpg', null, '2017-09-18 19:58:47', '4028808b5e92e09d015e92e0a29a0001');

-- ----------------------------
-- Table structure for `t_comment`
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `content` text COMMENT '评价内容',
  `comment_time` datetime DEFAULT NULL COMMENT '评价时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态，激活或冻结',
  `buildings_id` varchar(36) DEFAULT NULL COMMENT '楼盘编号',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户编号',
  PRIMARY KEY (`id`),
  KEY `fk_com_buildings_id` (`buildings_id`),
  KEY `fk_com_user_id` (`user_id`),
  CONSTRAINT `fk_com_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_com_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `t_customer`
-- ----------------------------
DROP TABLE IF EXISTS `t_customer`;
CREATE TABLE `t_customer` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `name` text COMMENT '姓名',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `identity_id` varchar(18) DEFAULT NULL COMMENT '身份证号码',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `address` varchar(100) DEFAULT NULL COMMENT '联系地址',
  `customer_type` varchar(20) DEFAULT NULL COMMENT '客户类型',
  `together` varchar(100) DEFAULT NULL,
  `contract` varchar(500) DEFAULT NULL COMMENT '电子版购房合同路径',
  `archives` varchar(500) DEFAULT NULL COMMENT 'zip版电子档案路径',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态，激活或冻结',
  `emp_id` varchar(36) DEFAULT NULL COMMENT '员工编号',
  `agency_id` varchar(36) DEFAULT NULL COMMENT '经销商编号',
  PRIMARY KEY (`id`),
  KEY `fk_cus_emp_id` (`emp_id`),
  KEY `fk_cus_agency_id` (`agency_id`),
  CONSTRAINT `fk_cus_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_cus_emp_id` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_customer
-- ----------------------------
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37dfc0000', '老王1', '男', '2017-09-07', '36072219961027000', '1234560@qq.com', '1380226640', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '1', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37e670001', '老王2', '男', '2017-09-07', '36072219961027001', '1234561@qq.com', '1380226641', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '1', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37e6b0002', '老王3', '男', '2017-09-07', '36072219961027002', '1234562@qq.com', '1380226642', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '1', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37e6f0003', '老王4', '男', '2017-09-07', '36072219961027003', '1234563@qq.com', '1380226643', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '0', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37e740004', '老王5', '男', '2017-09-07', '36072219961027004', '1234564@qq.com', '1380226644', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '0', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37e790005', '老王6', '男', '2017-09-07', '36072219961027005', '1234565@qq.com', '1380226645', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '0', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37e7b0006', '老王7', '男', '2017-09-07', '36072219961027006', '1234566@qq.com', '1380226646', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '1', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37e7e0007', '老王8', '男', '2017-09-07', '36072219961027007', '1234567@qq.com', '1380226647', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '0', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37e810008', '老王9', '男', '2017-09-07', '36072219961027008', '1234568@qq.com', '1380226648', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '1', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59b379015e59b37e840009', '老王0', '男', '2017-09-07', '36072219961027009', '1234569@qq.com', '1380226649', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:18:09', '0', '402880355e59b2b0015e59b2b4e00000', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_customer` VALUES ('402880355e59bd15015e59bd19f50000', '老王11', '男', '2017-09-07', '36072219961027000', '1234560@qq.com', '1380226640', '北海道', '预约客户', '老王，老李', null, null, '2017-09-07 08:28:39', '0', '402880355e59bca2015e59bca6a10000', '402880355e59ac4d015e59ac51560000');

-- ----------------------------
-- Table structure for `t_employee`
-- ----------------------------
DROP TABLE IF EXISTS `t_employee`;
CREATE TABLE `t_employee` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pwd` varchar(255) NOT NULL DEFAULT '4QrcOUm6Wau+VuBX8g+IPg==' COMMENT '员工初始化默认密码',
  `phone` varchar(11) NOT NULL COMMENT '手机号登录',
  `qq` varchar(20) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `exp` varchar(50) DEFAULT NULL COMMENT '工作经验',
  `des` varchar(100) DEFAULT NULL COMMENT '个人说明',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `basic_salary` double NOT NULL COMMENT '基本工资',
  `headicon` varchar(500) DEFAULT NULL COMMENT '设置一个默认头像',
  `intro` varchar(500) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `agency_id` varchar(36) DEFAULT NULL COMMENT '员工所属经销商',
  `buildings_id` varchar(36) DEFAULT NULL COMMENT '负责楼盘',
  `role_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_employee_agency_id` (`agency_id`),
  KEY `fk_employee_buildings_id` (`buildings_id`),
  KEY `FK_emp_roleid` (`role_id`),
  CONSTRAINT `FK_emp_roleid` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`),
  CONSTRAINT `fk_employee_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_employee_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_employee
-- ----------------------------
INSERT INTO `t_employee` VALUES ('402880355e59b2b0015e59b2b4e00000', '老黄', '120086@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13664077258', '100086', '4564564', '女', '爱爱爱', '啊啊', '啊啊', '1200', 'uploads/5D (4).jpg', '啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊', '2017-09-20 19:02:37', '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('402880355e59bca2015e59bca6a10000', '老黄1', '110086@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13664077259', '123456789', '7878787', '女', '啊啊', '啊啊', '啊啊', '1200', 'uploads/5D (47).jpg', '', '2017-09-21 00:00:00', '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e88294a015e882a6a870000', '小妹妹', '200@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13855224420', '', '', '男', '', '', '', '2850', 'uploads/5D (2).png', '', '2017-09-27 00:00:00', '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882bc9015e882d39250000', '阿三', '111@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13447722241', '', '', '女', '', '', '', '123123', 'uploads/5D (2).png', '', '2017-09-26 00:00:00', '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f186a0000', '老李', '4100@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13447080823', '', '', null, '', '', '', '1200', 'uploads/5D (10).png', '', '2017-11-23 00:00:00', '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f18e00001', '老李1', '4101@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '1376407721', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f18e40002', '老李2', '4102@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '1376407722', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f18e80003', '老李3', '4103@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '1376407723', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f18ec0004', '老李4', '4104@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '1376407724', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f18f10005', '老李5', '4105@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '1376407725', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f18f50006', '老李6', '4106@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '1376407726', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f18f90007', '老李7', '4107@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '1376407727', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f18fd0008', '老李8', '4108@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '1376407728', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f19010009', '老李9', '4109@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '1376407729', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f1905000a', '老李10', '41010@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077210', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f1908000b', '老李11', '41011@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077211', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f190b000c', '老李12', '41012@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077212', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f190e000d', '老李13', '41013@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077213', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f1911000e', '老李14', '41014@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077214', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f1915000f', '老李15', '41015@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077215', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f191a0010', '老李16', '41016@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077216', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f191e0011', '老李17', '41017@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077217', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f19220012', '老李18', '41018@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077218', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f19250013', '老李19', '41019@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077219', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f19280014', '老李20', '41020@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077220', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f192b0015', '老李21', '41021@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077221', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f192f0016', '老李22', '41022@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077222', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f19330017', '老李23', '41023@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077223', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f19360018', '老李24', '41024@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077224', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f19390019', '老李25', '41025@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077225', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f193d001a', '老李26', '41026@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077226', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f1940001b', '老李27', '41027@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077227', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f1944001c', '老李28', '41028@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077228', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');
INSERT INTO `t_employee` VALUES ('4028808b5e882f13015e882f1947001d', '老李29', '41029@qq.com', '4QrcOUm6Wau+VuBX8g+IPg==', '13764077229', null, null, null, null, null, null, '1200', null, null, null, '1', '402880355e59ac4d015e59ac51560000', '402880355e59ad56015e59ad5a820000', 'd7227c6487f411e7a5142c56dc7febbc');

-- ----------------------------
-- Table structure for `t_history`
-- ----------------------------
DROP TABLE IF EXISTS `t_history`;
CREATE TABLE `t_history` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户编号',
  `buildings_id` varchar(36) DEFAULT NULL COMMENT '楼盘编号',
  PRIMARY KEY (`id`),
  KEY `fk_his_user_id` (`user_id`),
  KEY `fk_his_buildings_id` (`buildings_id`),
  CONSTRAINT `fk_his_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_his_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_history
-- ----------------------------
INSERT INTO `t_history` VALUES ('402880ce5eb8b70a015eb8ca6afb0001', '2017-09-25 19:27:07', '402880ce5eb8b70a015eb8c9d98d0000', '4028808b5e92e09d015e92e0a2080000');

-- ----------------------------
-- Table structure for `t_house`
-- ----------------------------
DROP TABLE IF EXISTS `t_house`;
CREATE TABLE `t_house` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '户型名称',
  `logo` varchar(500) DEFAULT NULL,
  `intro` varchar(500) DEFAULT NULL COMMENT '简介',
  `area` double NOT NULL COMMENT '面积',
  `unit_price` double NOT NULL COMMENT '参考单价',
  `created_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `buildings_id` varchar(36) DEFAULT NULL COMMENT '楼盘编号',
  PRIMARY KEY (`id`),
  KEY `fk_buildings_house` (`buildings_id`),
  CONSTRAINT `fk_buildings_house` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_house
-- ----------------------------
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4b110000', 'A0', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4b800001', 'A1', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4b840002', 'A2', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4b880003', 'A3', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4b8c0004', 'A4', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4b920005', 'A5', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4b950006', 'A6', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4b980007', 'A7', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4b9c0008', 'A8', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4ba00009', 'A9', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4ba2000a', 'A10', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4ba6000b', 'A11', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4ba8000c', 'A12', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4baa000d', 'A13', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4bad000e', 'A14', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4baf000f', 'A15', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4bb30010', 'A16', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4bb60011', 'A17', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4bb80012', 'A18', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e59ae46015e59ae4bba0013', 'A19', 'uploads/5D (1).png', '三室两厅', '100.5', '10000', '2017-09-07 08:12:28', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('402880355e75515b015e75535c520000', 'RPK110', 'uploads/5D (1).png', '没有简介', '580', '11000', '2017-09-12 17:02:31', '1', '402880355e7519ca015e751a1e830000');
INSERT INTO `t_house` VALUES ('4028808b5e78f5c1015e7928ea9e0008', 'A', 'uploads/5D (9).png', 'A', '125', '50000', '2017-09-13 10:54:38', '1', '4028808b5e78f5c1015e792716670006');
INSERT INTO `t_house` VALUES ('4028808b5e7dc569015e7dc5b2b30000', 'A180', 'uploads/5D (7).jpg', '两室一厅', '456', '12456', '2017-09-14 08:24:22', '1', '402880355e7519ca015e751ee39f0001');
INSERT INTO `t_house` VALUES ('4028808b5e7dc569015e7e40c4c40001', '86', 'uploads/5D (7).jpg', '啊啊', '112123', '12323', '2017-09-14 10:38:47', '1', '402880355e7519ca015e751ee39f0001');
INSERT INTO `t_house` VALUES ('4028808b5e7dc569015e7e45d7630002', '草泥马', 'uploads/5D (5).png', '啊啊', '111', '111', '2017-09-14 10:44:20', '1', '402880355e7519ca015e751ee39f0001');
INSERT INTO `t_house` VALUES ('4028808b5e7dc569015e7e635d3a0003', '爱爱爱', 'uploads/5D (11).jpg', '爱爱爱', '111', '111', '2017-09-14 11:16:35', '1', '402880355e7519ca015e751ee39f0001');
INSERT INTO `t_house` VALUES ('4028808b5e7dc569015e7e7f16a50006', '花园宝宝', 'uploads/5D (11).jpg', '花园宝宝', '1111', '11', '2017-09-14 11:46:52', '1', '4028808b5e7b29a8015e7b2af3b60000');
INSERT INTO `t_house` VALUES ('4028808b5e80649e015e80670df80000', '天上人间', 'uploads/5D (25).jpg', '啊啊', '123.22', '1223.5', '2017-09-14 20:39:51', '1', '402880355e75169d015e75175d650000');
INSERT INTO `t_house` VALUES ('4028808b5e80649e015e806961e20001', '娃哈哈', 'uploads/5D (19).png', '呜呜呜', '111', '1112.5', '2017-09-14 20:42:24', '1', '402880355e59ad56015e59ad5a820000');
INSERT INTO `t_house` VALUES ('4028808b5e82f1de015e8316f1e80002', '爱爱爱', 'public/img/noimage.png', '爱爱爱', '111', '111', '2017-09-15 09:11:13', '1', '4028808b5e82f1de015e8309a0db0000');
INSERT INTO `t_house` VALUES ('4028808b5e82f1de015e831f02220003', '亚历克斯', 'public/img/noimage.png', '史诗', '1123', '1233', '2017-09-15 09:20:01', '1', '4028808b5e82f1de015e830b70930001');
INSERT INTO `t_house` VALUES ('4028808b5e887185015e887ebd700002', '爱爱爱', 'public/img/noimage.png', '嗖嗖嗖', '111', '122', '2017-09-16 10:22:41', '1', '4028808b5e887185015e887e84d30001');
INSERT INTO `t_house` VALUES ('4028808b5e9efb54015e9f1199760005', 'aa1', 'uploads/5D (98).jpg', '', '112', '1222', '2017-09-20 19:34:44', '1', '4028808b5e92d50e015e92d513250000');
INSERT INTO `t_house` VALUES ('4028808b5e9f182a015e9f38767f0000', 'aaa', 'uploads/5D (11).jpg', '', '111', '1111', '2017-09-20 20:17:11', '1', '4028808b5e92d50e015e92d513ab0006');
INSERT INTO `t_house` VALUES ('4028ab105e78b622015e78b846c10000', 'A180', 'uploads/w650 (1).jpg', '三室两厅', '120.5', '11000.5', '2017-09-13 08:51:36', '1', '402880355e75169d015e75175d650000');

-- ----------------------------
-- Table structure for `t_like`
-- ----------------------------
DROP TABLE IF EXISTS `t_like`;
CREATE TABLE `t_like` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `created_time` datetime DEFAULT NULL COMMENT '点赞创建时间',
  `user_id` varchar(36) DEFAULT NULL COMMENT '客户编号',
  `buildings_id` varchar(36) DEFAULT NULL COMMENT '楼盘编号',
  PRIMARY KEY (`id`),
  KEY `fk_like_user_id` (`user_id`),
  KEY `fk_like_buildings_id` (`buildings_id`),
  CONSTRAINT `fk_like_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_like_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_like
-- ----------------------------
INSERT INTO `t_like` VALUES ('402880ce5eb8b70a015eb8ca9bee0004', '2017-09-25 19:27:20', '402880ce5eb8b70a015eb8c9d98d0000', '4028808b5e92e09d015e92e0a2080000');

-- ----------------------------
-- Table structure for `t_message`
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `content` text COMMENT '留言内容',
  `reply` text COMMENT '回复内容',
  `leave_time` datetime DEFAULT NULL COMMENT '留言时间',
  `reply_time` datetime DEFAULT NULL COMMENT '回复时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态，激活或冻结',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户编号',
  `buildings_id` varchar(36) DEFAULT NULL COMMENT '楼盘编号',
  PRIMARY KEY (`id`),
  KEY `fk_msg_user_id` (`user_id`),
  KEY `fk_msg_buildings_id` (`buildings_id`),
  CONSTRAINT `fk_msg_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_msg_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------

-- ----------------------------
-- Table structure for `t_mission`
-- ----------------------------
DROP TABLE IF EXISTS `t_mission`;
CREATE TABLE `t_mission` (
  `id` varchar(36) NOT NULL,
  `quantity` int(11) DEFAULT NULL COMMENT '员工任务量',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `bonus_percent` double DEFAULT NULL COMMENT '百分比提成',
  `status` tinyint(4) DEFAULT '1',
  `emp_id` varchar(36) DEFAULT NULL COMMENT '员工编号',
  PRIMARY KEY (`id`),
  KEY `fk_mission_emp_id` (`emp_id`),
  CONSTRAINT `fk_mission_emp_id` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_mission
-- ----------------------------
INSERT INTO `t_mission` VALUES ('402880355e59b4d4015e59b4d9260000', '2', '2015-02-07 08:19:38', '2015-11-17 07:12:58', '1', '1', '402880355e59b2b0015e59b2b4e00000');
INSERT INTO `t_mission` VALUES ('402880355e59d407015e59d40b710000', '2', '2017-03-07 08:53:42', '2017-09-28 07:47:02', '2.1', '1', '402880355e59bca2015e59bca6a10000');
INSERT INTO `t_mission` VALUES ('4028808b5e996290015e99647c4e0000', '20', '2017-09-19 00:00:00', '2017-09-30 00:00:00', '2', '1', '4028808b5e882f13015e882f186a0000');
INSERT INTO `t_mission` VALUES ('4028808b5e996290015e9964a4ed0001', '20', '2017-09-19 00:00:00', '2017-09-30 00:00:00', '2', '1', '4028808b5e88294a015e882a6a870000');
INSERT INTO `t_mission` VALUES ('4028808b5e996290015e9964b3b00002', '20', '2014-08-01 00:00:00', '2015-06-30 00:00:00', '2', '1', '4028808b5e882bc9015e882d39250000');
INSERT INTO `t_mission` VALUES ('4028808b5e996290015e9967fba00003', '30', '2017-09-20 00:00:00', '2017-09-30 00:00:00', '2', '1', '4028808b5e882f13015e882f18e40002');
INSERT INTO `t_mission` VALUES ('4028808b5e996290015e9967fcc80004', '30', '2017-09-20 00:00:00', '2017-09-30 00:00:00', '2', '1', '4028808b5e882f13015e882f18e80003');
INSERT INTO `t_mission` VALUES ('4028808b5e996290015e9a362bd00005', '20', '2017-09-19 00:00:00', '2017-09-30 00:00:00', '2', '1', '4028808b5e882f13015e882f18e00001');
INSERT INTO `t_mission` VALUES ('4028808b5e9e255c015e9e27e66e0000', '20', '2017-09-20 00:00:00', '2017-09-30 00:00:00', '3', '1', '4028808b5e882bc9015e882d39250000');
INSERT INTO `t_mission` VALUES ('4028808b5e9e28cd015e9e2935760000', '20', '2017-09-20 00:00:00', '2017-09-30 00:00:00', '2', '1', '4028808b5e882f13015e882f18f10005');
INSERT INTO `t_mission` VALUES ('73fe1045-9378-11e7-9986-80fa5b2e8425', '2', '2017-03-07 08:53:42', '2017-09-17 07:47:02', '1', '1', '402880355e59b2b0015e59b2b4e00000');
INSERT INTO `t_mission` VALUES ('9e31b54a-936d-11e7-9986-80fa5b2e8425', '6', '2016-03-07 08:53:42', '2016-09-17 07:47:02', '6', '1', '402880355e59bca2015e59bca6a10000');

-- ----------------------------
-- Table structure for `t_permission`
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `name` varchar(500) NOT NULL COMMENT '权限名称',
  `des` varchar(50) NOT NULL COMMENT '权限描述',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_permission
-- ----------------------------

-- ----------------------------
-- Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `name` varchar(50) NOT NULL COMMENT '角色名词',
  `des` varchar(50) NOT NULL COMMENT '角色描述',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('d702b59b87f411e7a5142c56dc7febbc', '平台管理员', '平台管理员', '2017-09-07 08:10:09', '1');
INSERT INTO `t_role` VALUES ('d715a8c987f411e7a5142c56dc7febbc', '房产经销商管理员', '房产经销商管理员', '2017-09-07 08:10:09', '1');
INSERT INTO `t_role` VALUES ('d7227c6487f411e7a5142c56dc7febbc', '房产经销商销售员工', '房产经销商销售员工', '2017-09-07 08:10:09', '1');
INSERT INTO `t_role` VALUES ('d737ab4487f411e7a5142c56dc7febbc', '购房用户', '购房用户', '2017-09-07 08:10:09', '1');

-- ----------------------------
-- Table structure for `t_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `role_id` varchar(50) DEFAULT NULL COMMENT '角色编号',
  `permission_id` varchar(50) DEFAULT NULL COMMENT '权限编号',
  PRIMARY KEY (`id`),
  KEY `fk_role_id` (`role_id`),
  KEY `fk_per_id` (`permission_id`),
  CONSTRAINT `fk_per_id` FOREIGN KEY (`permission_id`) REFERENCES `t_permission` (`id`),
  CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------

-- ----------------------------
-- Table structure for `t_room`
-- ----------------------------
DROP TABLE IF EXISTS `t_room`;
CREATE TABLE `t_room` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '房号名称',
  `sale_status` varchar(20) NOT NULL DEFAULT 'saleing' COMMENT '销售状态',
  `house_id` varchar(36) DEFAULT NULL COMMENT '户型编号',
  `building_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_room_house_id` (`house_id`),
  KEY `fk_room_building_id` (`building_id`),
  CONSTRAINT `fk_room_building_id` FOREIGN KEY (`building_id`) REFERENCES `t_building` (`id`),
  CONSTRAINT `fk_room_house_id` FOREIGN KEY (`house_id`) REFERENCES `t_house` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_room
-- ----------------------------
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9540001', '101', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9590002', '102', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a95b0003', '103', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9600004', '104', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9660005', '201', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9690006', '202', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a96c0007', '203', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a96f0008', '204', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9710009', '301', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a974000a', '302', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a976000b', '303', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a978000c', '304', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a97a000d', '401', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a97c000e', '402', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a97f000f', '403', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9830010', '404', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9850011', '501', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9880012', '502', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a98b0013', '503', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a98d0014', '504', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9900015', '601', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9920016', '602', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9940017', '603', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9960018', '604', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9990019', '701', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a99b001a', '702', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a99e001b', '703', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9a0001c', '704', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9a3001d', '801', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9a5001e', '802', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9a7001f', '803', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9a90020', '804', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9ab0021', '901', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9ad0022', '902', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9af0023', '903', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9b00024', '904', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9b20025', '1001', '待售', '402880355e59ae46015e59ae4b110000', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9b40026', '1002', '待售', '402880355e59ae46015e59ae4b800001', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9b70027', '1003', '待售', '402880355e59ae46015e59ae4b840002', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('402880355e59b1a4015e59b1a9b90028', '1004', '待售', '402880355e59ae46015e59ae4b880003', '402880355e59b1a4015e59b1a8e40000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dca30001', '101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dca80002', '102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcb10003', '103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcb40004', '104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcb80005', '105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcbb0006', '106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcbd0007', '107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcc00008', '108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcc30009', '109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcc6000a', '110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcc8000b', '201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dccb000c', '202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dccd000d', '203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcd0000e', '204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcd2000f', '205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcd50010', '206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcd70011', '207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcd90012', '208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcdc0013', '209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcdf0014', '210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dce10015', '301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dce40016', '302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dce70017', '303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcea0018', '304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dced0019', '305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcef001a', '306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcf2001b', '307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcf4001c', '308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcf7001d', '309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcf9001e', '310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcfc001f', '401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dcff0020', '402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd010021', '403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd040022', '404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd060023', '405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd090024', '406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd0b0025', '407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd0e0026', '408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd110027', '409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd150028', '410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd180029', '501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd1b002a', '502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd1d002b', '503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd1f002c', '504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd22002d', '505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd24002e', '506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd27002f', '507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd290030', '508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd2b0031', '509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd2e0032', '510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd300033', '601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd320034', '602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd350035', '603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd380036', '604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd3b0037', '605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd3e0038', '606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd410039', '607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd44003a', '608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd46003b', '609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd49003c', '610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd4c003d', '701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd4f003e', '702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd52003f', '703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd550040', '704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd570041', '705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd5a0042', '706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd5d0043', '707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd600044', '708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd620045', '709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd650046', '710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd680047', '801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd6b0048', '802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd6f0049', '803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd71004a', '804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd74004b', '805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd77004c', '806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd7b004d', '807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd7e004e', '808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd80004f', '809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd820050', '810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd850051', '901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd870052', '902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd890053', '903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd8c0054', '904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd8e0055', '905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd900056', '906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd920057', '907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd950058', '908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd970059', '909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd9b005a', '910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dd9e005b', '1001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dda1005c', '1002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dda3005d', '1003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dda5005e', '1004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dda8005f', '1005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddab0060', '1006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddad0061', '1007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddb00062', '1008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddb20063', '1009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddb50064', '1010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddb80065', '1101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddba0066', '1102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddbe0067', '1103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddc00068', '1104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddc30069', '1105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddc5006a', '1106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddc7006b', '1107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddca006c', '1108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddcc006d', '1109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddce006e', '1110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddd1006f', '1201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddd30070', '1202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddd60071', '1203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddd80072', '1204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dddb0073', '1205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dddd0074', '1206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dde00075', '1207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dde30076', '1208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dde50077', '1209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dde70078', '1210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dde90079', '1301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddec007a', '1302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddee007b', '1303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddf1007c', '1304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddf4007d', '1305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddf6007e', '1306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddf9007f', '1307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddfb0080', '1308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddfd0081', '1309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ddff0082', '1310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de010083', '1401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de030084', '1402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de060085', '1403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de070086', '1404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de090087', '1405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de0b0088', '1406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de0d0089', '1407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de0f008a', '1408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de11008b', '1409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de13008c', '1410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de14008d', '1501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de16008e', '1502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de19008f', '1503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de1b0090', '1504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de1d0091', '1505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de1f0092', '1506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de210093', '1507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de230094', '1508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de250095', '1509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de270096', '1510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de280097', '1601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de2a0098', '1602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de2c0099', '1603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de2e009a', '1604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de30009b', '1605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de32009c', '1606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de35009d', '1607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de37009e', '1608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de39009f', '1609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de3b00a0', '1610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de3d00a1', '1701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de3f00a2', '1702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de4100a3', '1703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de4300a4', '1704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de4500a5', '1705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de5100a6', '1706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de5400a7', '1707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de5600a8', '1708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de5800a9', '1709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de5a00aa', '1710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de5d00ab', '1801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de5f00ac', '1802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de6100ad', '1803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de6300ae', '1804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de6600af', '1805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de6800b0', '1806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de6a00b1', '1807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de6d00b2', '1808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de6f00b3', '1809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de7100b4', '1810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de7400b5', '1901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de7700b6', '1902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de7900b7', '1903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de7c00b8', '1904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de7e00b9', '1905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de8300ba', '1906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de8500bb', '1907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de8800bc', '1908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de8a00bd', '1909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de8c00be', '1910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de8e00bf', '2001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de9000c0', '2002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de9200c1', '2003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de9400c2', '2004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de9600c3', '2005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de9800c4', '2006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de9900c5', '2007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de9b00c6', '2008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de9d00c7', '2009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35de9f00c8', '2010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dea100c9', '2101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dea300ca', '2102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dea500cb', '2103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dea800cc', '2104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deaa00cd', '2105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dead00ce', '2106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deaf00cf', '2107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deb100d0', '2108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deb300d1', '2109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deb500d2', '2110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deb600d3', '2201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deb800d4', '2202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deba00d5', '2203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35debc00d6', '2204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35debe00d7', '2205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35debf00d8', '2206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dec100d9', '2207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dec300da', '2208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dec500db', '2209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dec700dc', '2210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dec900dd', '2301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35decb00de', '2302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35decd00df', '2303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35decf00e0', '2304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ded100e1', '2305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ded300e2', '2306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ded600e3', '2307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35ded800e4', '2308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deda00e5', '2309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dedb00e6', '2310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dedd00e7', '2401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dedf00e8', '2402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dee100e9', '2403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dee300ea', '2404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dee500eb', '2405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dee700ec', '2406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dee900ed', '2407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deec00ee', '2408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35deef00ef', '2409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35def100f0', '2410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35def400f1', '2501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35def700f2', '2502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35defa00f3', '2503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35defd00f4', '2504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df0000f5', '2505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df0200f6', '2506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df0500f7', '2507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df0700f8', '2508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df0a00f9', '2509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df0d00fa', '2510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df0f00fb', '2601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df1100fc', '2602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df1300fd', '2603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df1500fe', '2604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df1700ff', '2605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df190100', '2606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df1b0101', '2607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df1d0102', '2608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df1f0103', '2609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df210104', '2610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df230105', '2701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df250106', '2702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df270107', '2703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df290108', '2704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df2b0109', '2705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df2d010a', '2706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df2f010b', '2707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df31010c', '2708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df33010d', '2709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df35010e', '2710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df37010f', '2801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df3a0110', '2802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df3d0111', '2803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df3f0112', '2804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df410113', '2805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df430114', '2806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df450115', '2807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df470116', '2808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df490117', '2809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df4b0118', '2810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df4d0119', '2901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df4f011a', '2902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df51011b', '2903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df53011c', '2904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df54011d', '2905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df56011e', '2906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df59011f', '2907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df5b0120', '2908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df5d0121', '2909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df5f0122', '2910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df610123', '3001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df630124', '3002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df660125', '3003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df680126', '3004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df6a0127', '3005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df6c0128', '3006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df6e0129', '3007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df71012a', '3008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df73012b', '3009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df75012c', '3010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df77012d', '3101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df79012e', '3102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df7b012f', '3103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df7e0130', '3104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df810131', '3105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df830132', '3106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df850133', '3107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df880134', '3108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df8a0135', '3109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df8c0136', '3110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df8e0137', '3201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df900138', '3202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df920139', '3203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df94013a', '3204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35df9e013b', '3205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfa0013c', '3206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfa2013d', '3207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfa4013e', '3208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfa6013f', '3209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfa80140', '3210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfaa0141', '3301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfad0142', '3302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfaf0143', '3303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfb20144', '3304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfb50145', '3305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfb60146', '3306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfb80147', '3307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfba0148', '3308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfbc0149', '3309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfbe014a', '3310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfc0014b', '3401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfc3014c', '3402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfc6014d', '3403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfc8014e', '3404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfcb014f', '3405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfcd0150', '3406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfcf0151', '3407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfd10152', '3408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfd30153', '3409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfd50154', '3410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfd80155', '3501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfd90156', '3502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfdc0157', '3503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfde0158', '3504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfe00159', '3505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfe2015a', '3506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfe5015b', '3507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfe7015c', '3508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfe9015d', '3509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfeb015e', '3510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfed015f', '3601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dfef0160', '3602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dff10161', '3603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dff30162', '3604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dff50163', '3605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dff70164', '3606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dff80165', '3607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dffa0166', '3608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dffc0167', '3609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35dffe0168', '3610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0000169', '3701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e002016a', '3702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e004016b', '3703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e007016c', '3704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e009016d', '3705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e00b016e', '3706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e00d016f', '3707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e00f0170', '3708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0120171', '3709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0140172', '3710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0170173', '3801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e01a0174', '3802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e01c0175', '3803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e01e0176', '3804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0200177', '3805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0220178', '3806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0240179', '3807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e026017a', '3808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e028017b', '3809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e02b017c', '3810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e02d017d', '3901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e030017e', '3902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e032017f', '3903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0340180', '3904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0360181', '3905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0390182', '3906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e03b0183', '3907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e03d0184', '3908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0400185', '3909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0420186', '3910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0440187', '4001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0470188', '4002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0490189', '4003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e04b018a', '4004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e04d018b', '4005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e050018c', '4006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e052018d', '4007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e055018e', '4008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e057018f', '4009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0590190', '4010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e05b0191', '4101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e05e0192', '4102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0600193', '4103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0620194', '4104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0640195', '4105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0660196', '4106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0680197', '4107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e06a0198', '4108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e06c0199', '4109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e06f019a', '4110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e071019b', '4201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e074019c', '4202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e076019d', '4203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e078019e', '4204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e082019f', '4205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e08401a0', '4206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e08701a1', '4207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e08a01a2', '4208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e08c01a3', '4209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e08e01a4', '4210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e09001a5', '4301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e09301a6', '4302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e09601a7', '4303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e09801a8', '4304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e09b01a9', '4305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e09d01aa', '4306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e09f01ab', '4307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0a201ac', '4308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0a401ad', '4309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0a601ae', '4310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0a801af', '4401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0aa01b0', '4402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0ac01b1', '4403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0ae01b2', '4404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0b001b3', '4405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0b201b4', '4406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0b401b5', '4407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0b601b6', '4408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0b801b7', '4409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0ba01b8', '4410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0bc01b9', '4501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0be01ba', '4502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0c001bb', '4503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0c201bc', '4504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0c401bd', '4505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0c601be', '4506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0c901bf', '4507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0cb01c0', '4508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0cd01c1', '4509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0cf01c2', '4510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0d201c3', '4601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0d401c4', '4602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0d601c5', '4603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0d801c6', '4604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0db01c7', '4605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0dd01c8', '4606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0df01c9', '4607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0e101ca', '4608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0e301cb', '4609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0e601cc', '4610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0e801cd', '4701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0e901ce', '4702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0ec01cf', '4703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0ee01d0', '4704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0f001d1', '4705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0f201d2', '4706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0f401d3', '4707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0f701d4', '4708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0f901d5', '4709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0fc01d6', '4710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e0fe01d7', '4801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e10001d8', '4802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e10301d9', '4803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e10501da', '4804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e10701db', '4805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e10901dc', '4806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e10b01dd', '4807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e10e01de', '4808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e11001df', '4809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e11201e0', '4810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e11401e1', '4901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e11601e2', '4902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e11801e3', '4903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e11a01e4', '4904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e11c01e5', '4905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e11e01e6', '4906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e12101e7', '4907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e12301e8', '4908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e12501e9', '4909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e12701ea', '4910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e12a01eb', '5001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e12c01ec', '5002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e12e01ed', '5003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e13101ee', '5004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e13401ef', '5005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e13601f0', '5006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e13801f1', '5007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e13b01f2', '5008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e13d01f3', '5009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e14001f4', '5010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e14201f5', '5101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e14501f6', '5102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e14701f7', '5103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e14901f8', '5104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e14c01f9', '5105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e14e01fa', '5106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e15101fb', '5107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e15301fc', '5108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e15601fd', '5109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e15901fe', '5110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e15c01ff', '5201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e15f0200', '5202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1610201', '5203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1640202', '5204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1670203', '5205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e16a0204', '5206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1750205', '5207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1780206', '5208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e17a0207', '5209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e17d0208', '5210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e17f0209', '5301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e182020a', '5302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e184020b', '5303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e187020c', '5304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e18a020d', '5305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e18c020e', '5306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e18f020f', '5307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1910210', '5308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1940211', '5309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1970212', '5310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1990213', '5401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e19b0214', '5402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e19f0215', '5403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1a00216', '5404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1a30217', '5405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1a50218', '5406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1a90219', '5407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1ac021a', '5408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1ae021b', '5409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1b1021c', '5410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1b3021d', '5501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1b6021e', '5502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1b9021f', '5503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1bb0220', '5504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1be0221', '5505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1c00222', '5506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1c20223', '5507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1c40224', '5508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1c70225', '5509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1c90226', '5510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1cb0227', '5601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1cd0228', '5602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1cf0229', '5603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1d1022a', '5604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1d3022b', '5605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1d6022c', '5606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1d8022d', '5607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1da022e', '5608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1dc022f', '5609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1df0230', '5610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1e10231', '5701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1e40232', '5702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1e60233', '5703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1e80234', '5704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1ea0235', '5705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1ed0236', '5706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1ef0237', '5707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1f10238', '5708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1f40239', '5709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1f6023a', '5710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1f9023b', '5801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1fb023c', '5802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e1fd023d', '5803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e200023e', '5804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e202023f', '5805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2040240', '5806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2070241', '5807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2090242', '5808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e20c0243', '5809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e20e0244', '5810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2110245', '5901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2140246', '5902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2160247', '5903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2190248', '5904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e21b0249', '5905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e21e024a', '5906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e220024b', '5907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e224024c', '5908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e227024d', '5909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e229024e', '5910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e22c024f', '6001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e22f0250', '6002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2310251', '6003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2330252', '6004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2360253', '6005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2380254', '6006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e23b0255', '6007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e23e0256', '6008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2460257', '6009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2470258', '6010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e24b0259', '6101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e24e025a', '6102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e250025b', '6103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e252025c', '6104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e255025d', '6105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e257025e', '6106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e25a025f', '6107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e25d0260', '6108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e25f0261', '6109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2620262', '6110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2650263', '6201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2680264', '6202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e26b0265', '6203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e26e0266', '6204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2710267', '6205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2740268', '6206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2770269', '6207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e27a026a', '6208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e27d026b', '6209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e280026c', '6210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e283026d', '6301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e286026e', '6302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e288026f', '6303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e28b0270', '6304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e28e0271', '6305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2900272', '6306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2930273', '6307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2960274', '6308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2990275', '6309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e29b0276', '6310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e29e0277', '6401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2a10278', '6402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2a40279', '6403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2a7027a', '6404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2a9027b', '6405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2ac027c', '6406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2ae027d', '6407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2b1027e', '6408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2b4027f', '6409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2b70280', '6410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2ba0281', '6501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2bd0282', '6502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2c00283', '6503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2c30284', '6504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2c70285', '6505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2c90286', '6506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2cc0287', '6507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2cf0288', '6508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2d20289', '6509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2d5028a', '6510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2d7028b', '6601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2da028c', '6602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2dd028d', '6603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2df028e', '6604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2e2028f', '6605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2e50290', '6606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2e80291', '6607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2eb0292', '6608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2ef0293', '6609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2f20294', '6610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2f50295', '6701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2f80296', '6702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2fb0297', '6703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e2fe0298', '6704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3010299', '6705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e304029a', '6706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e307029b', '6707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e30b029c', '6708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e30e029d', '6709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e311029e', '6710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e314029f', '6801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e31702a0', '6802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e31c02a1', '6803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e32002a2', '6804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e32502a3', '6805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e32a02a4', '6806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e32e02a5', '6807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e33102a6', '6808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e33502a7', '6809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e33a02a8', '6810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e33e02a9', '6901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e34302aa', '6902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e34702ab', '6903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e34c02ac', '6904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e35002ad', '6905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e35502ae', '6906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e35902af', '6907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e35d02b0', '6908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e36302b1', '6909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e36802b2', '6910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e36c02b3', '7001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e37102b4', '7002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e37802b5', '7003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e37b02b6', '7004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e37d02b7', '7005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e38002b8', '7006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e38302b9', '7007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e38502ba', '7008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e38802bb', '7009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e38a02bc', '7010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e38d02bd', '7101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e38f02be', '7102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e39202bf', '7103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e39502c0', '7104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e39802c1', '7105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e39b02c2', '7106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e39d02c3', '7107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3a002c4', '7108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3a302c5', '7109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3a602c6', '7110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3a902c7', '7201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3ac02c8', '7202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3af02c9', '7203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3b202ca', '7204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3b502cb', '7205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3b802cc', '7206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3ba02cd', '7207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3bd02ce', '7208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3c002cf', '7209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3c302d0', '7210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3c602d1', '7301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3c802d2', '7302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3cb02d3', '7303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3cd02d4', '7304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3d002d5', '7305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3d202d6', '7306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3d502d7', '7307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3d702d8', '7308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3da02d9', '7309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3dd02da', '7310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3df02db', '7401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3e202dc', '7402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3e402dd', '7403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3e702de', '7404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3ea02df', '7405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3ed02e0', '7406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3f002e1', '7407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3f302e2', '7408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3f602e3', '7409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3f902e4', '7410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3fc02e5', '7501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e3fe02e6', '7502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e40102e7', '7503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e40302e8', '7504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e40602e9', '7505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e40902ea', '7506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e40b02eb', '7507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e40e02ec', '7508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e41102ed', '7509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e41302ee', '7510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e41602ef', '7601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e41802f0', '7602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e41b02f1', '7603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e41e02f2', '7604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e42002f3', '7605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e42302f4', '7606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e42502f5', '7607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e42702f6', '7608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e42a02f7', '7609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e42d02f8', '7610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e43002f9', '7701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e43302fa', '7702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e43602fb', '7703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e43902fc', '7704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e43b02fd', '7705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e43e02fe', '7706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e44102ff', '7707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4440300', '7708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4460301', '7709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4490302', '7710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e44c0303', '7801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e44f0304', '7802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4520305', '7803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4540306', '7804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4580307', '7805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e45c0308', '7806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e45f0309', '7807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e464030a', '7808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e467030b', '7809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e46a030c', '7810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e46d030d', '7901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e470030e', '7902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e472030f', '7903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4750310', '7904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4780311', '7905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e47b0312', '7906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e47e0313', '7907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4800314', '7908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4840315', '7909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4870316', '7910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e48a0317', '8001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e48c0318', '8002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e48f0319', '8003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e492031a', '8004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e495031b', '8005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e498031c', '8006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e49a031d', '8007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e49d031e', '8008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4a0031f', '8009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4a30320', '8010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4a60321', '8101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4a80322', '8102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4ab0323', '8103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4ae0324', '8104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4b10325', '8105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4b40326', '8106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4b60327', '8107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4b90328', '8108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4bc0329', '8109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4be032a', '8110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4c1032b', '8201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4c3032c', '8202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4c6032d', '8203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4c9032e', '8204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4cc032f', '8205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4ce0330', '8206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4d10331', '8207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4d40332', '8208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4d70333', '8209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4da0334', '8210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4dc0335', '8301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4e00336', '8302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4e20337', '8303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4e60338', '8304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4e80339', '8305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4eb033a', '8306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4ee033b', '8307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4f0033c', '8308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4f3033d', '8309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4f6033e', '8310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4f8033f', '8401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4fb0340', '8402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e4fe0341', '8403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5000342', '8404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5030343', '8405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5060344', '8406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5090345', '8407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e50c0346', '8408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e50f0347', '8409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5120348', '8410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5140349', '8501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e517034a', '8502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e51a034b', '8503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e51d034c', '8504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e520034d', '8505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e523034e', '8506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e526034f', '8507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5280350', '8508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e52b0351', '8509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e52e0352', '8510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5310353', '8601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5330354', '8602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5360355', '8603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5390356', '8604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e53c0357', '8605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5400358', '8606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5450359', '8607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e54a035a', '8608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e54e035b', '8609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e553035c', '8610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e558035d', '8701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e55c035e', '8702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e561035f', '8703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5660360', '8704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e56b0361', '8705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5700362', '8706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5740363', '8707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5790364', '8708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e57e0365', '8709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5830366', '8710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5880367', '8801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e58c0368', '8802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5910369', '8803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e596036a', '8804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e59a036b', '8805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e59f036c', '8806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5a4036d', '8807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5ac036e', '8808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5ae036f', '8809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5b10370', '8810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5b40371', '8901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5b70372', '8902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5ba0373', '8903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5bd0374', '8904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5c00375', '8905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5c30376', '8906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5c60377', '8907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5c90378', '8908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5cd0379', '8909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5d0037a', '8910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5d3037b', '9001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5d6037c', '9002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5d9037d', '9003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5dc037e', '9004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5e0037f', '9005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5e30380', '9006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5e70381', '9007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5ea0382', '9008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5ed0383', '9009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5f00384', '9010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5f30385', '9101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5f60386', '9102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5f90387', '9103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5fc0388', '9104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e5ff0389', '9105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e602038a', '9106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e605038b', '9107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e609038c', '9108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e60c038d', '9109', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e610038e', '9110', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e613038f', '9201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6160390', '9202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6190391', '9203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e61c0392', '9204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e61f0393', '9205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6220394', '9206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6260395', '9207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6290396', '9208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e62c0397', '9209', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e62f0398', '9210', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6330399', '9301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e636039a', '9302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e639039b', '9303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e63c039c', '9304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e63f039d', '9305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e642039e', '9306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e645039f', '9307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e64803a0', '9308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e64b03a1', '9309', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e64e03a2', '9310', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e65203a3', '9401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e65603a4', '9402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e65803a5', '9403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e65b03a6', '9404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e65e03a7', '9405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e66103a8', '9406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e66403a9', '9407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e66703aa', '9408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e66a03ab', '9409', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e66e03ac', '9410', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e67103ad', '9501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e67403ae', '9502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e67703af', '9503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e67a03b0', '9504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e67e03b1', '9505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e68003b2', '9506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e68203b3', '9507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e68603b4', '9508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e68903b5', '9509', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e68c03b6', '9510', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e68f03b7', '9601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e69203b8', '9602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e69503b9', '9603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e69803ba', '9604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e69c03bb', '9605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e69f03bc', '9606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6a203bd', '9607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6a503be', '9608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6a803bf', '9609', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6ab03c0', '9610', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6ae03c1', '9701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6b103c2', '9702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6b403c3', '9703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6b703c4', '9704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6ba03c5', '9705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6bd03c6', '9706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6c003c7', '9707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6c303c8', '9708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6c903c9', '9709', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6cd03ca', '9710', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6d003cb', '9801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6d303cc', '9802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6d703cd', '9803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6da03ce', '9804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6dd03cf', '9805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6e003d0', '9806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6e303d1', '9807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6e603d2', '9808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6e903d3', '9809', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6ec03d4', '9810', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6ef03d5', '9901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6f103d6', '9902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6f503d7', '9903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6f803d8', '9904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6fb03d9', '9905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e6fe03da', '9906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e70303db', '9907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e70603dc', '9908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e70a03dd', '9909', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e70d03de', '9910', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e71003df', '10001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e71303e0', '10002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e71603e1', '10003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e71903e2', '10004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e71c03e3', '10005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e72003e4', '10006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e72303e5', '10007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e72603e6', '10008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e72903e7', '10009', '待售中', '402880355e59ae46015e59ae4b9c0008', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f35e72c03e8', '10010', '待售中', '402880355e59ae46015e59ae4ba00009', '4028808b5e7f3536015e7f35dc810000');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b95703ea', '101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b95903eb', '102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b95b03ec', '103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b95d03ed', '104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b95f03ee', '105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96003ef', '106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96203f0', '107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96303f1', '108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96403f2', '201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96503f3', '202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96603f4', '203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96803f5', '204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96903f6', '205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96a03f7', '206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96b03f8', '207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96d03f9', '208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96d03fa', '301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b96e03fb', '302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b97003fc', '303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b97103fd', '304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b97203fe', '305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b97303ff', '306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9740400', '307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9750401', '308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9770402', '401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9790403', '402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b97a0404', '403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b97c0405', '404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b97d0406', '405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b97f0407', '406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9800408', '407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9820409', '408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b983040a', '501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b984040b', '502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b985040c', '503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b986040d', '504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b987040e', '505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b989040f', '506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b98a0410', '507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b98b0411', '508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b98c0412', '601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b98d0413', '602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b98e0414', '603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b98f0415', '604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9910416', '605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9920417', '606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9930418', '607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9950419', '608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b996041a', '701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b997041b', '702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b999041c', '703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b99a041d', '704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b99c041e', '705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b99d041f', '706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b99e0420', '707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9a00421', '708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9a10422', '801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9a20423', '802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9a40424', '803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9a50425', '804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9a60426', '805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9a80427', '806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9a90428', '807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9ab0429', '808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9ac042a', '901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9ae042b', '902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9af042c', '903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9b1042d', '904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9b2042e', '905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9b3042f', '906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9b50430', '907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9b60431', '908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9b80432', '1001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9b90433', '1002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9bb0434', '1003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9bd0435', '1004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9bf0436', '1005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9c10437', '1006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9c30438', '1007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9c40439', '1008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9c6043a', '1101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9c7043b', '1102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9c8043c', '1103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9ca043d', '1104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9cc043e', '1105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9cd043f', '1106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9ce0440', '1107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9d00441', '1108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9d10442', '1201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9d30443', '1202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9d40444', '1203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9d60445', '1204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9d70446', '1205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9d90447', '1206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9db0448', '1207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9dd0449', '1208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9df044a', '1301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9e1044b', '1302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9e3044c', '1303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9e4044d', '1304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9e6044e', '1305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9e7044f', '1306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9e90450', '1307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9ea0451', '1308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9ec0452', '1401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9ee0453', '1402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9ef0454', '1403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9f10455', '1404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9f20456', '1405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9f40457', '1406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9f50458', '1407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9f60459', '1408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9f8045a', '1501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9f9045b', '1502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9fa045c', '1503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9fc045d', '1504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53b9fe045e', '1505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba01045f', '1506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba030460', '1507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba040461', '1508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba060462', '1601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba080463', '1602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba0a0464', '1603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba0c0465', '1604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba0d0466', '1605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba0f0467', '1606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba110468', '1607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba130469', '1608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba15046a', '1701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba16046b', '1702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba18046c', '1703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba19046d', '1704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba1b046e', '1705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba1d046f', '1706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba1f0470', '1707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba210471', '1708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba230472', '1801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba250473', '1802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba270474', '1803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba290475', '1804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba2b0476', '1805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba2d0477', '1806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba2f0478', '1807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba300479', '1808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba32047a', '1901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba33047b', '1902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba34047c', '1903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba36047d', '1904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba37047e', '1905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba39047f', '1906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba3a0480', '1907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba3c0481', '1908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba3e0482', '2001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba3f0483', '2002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba410484', '2003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba420485', '2004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba430486', '2005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba450487', '2006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba470488', '2007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba480489', '2008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba4a048a', '2101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba4b048b', '2102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba4d048c', '2103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba4f048d', '2104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba50048e', '2105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba52048f', '2106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba530490', '2107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba550491', '2108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba560492', '2201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba580493', '2202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba5a0494', '2203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba5b0495', '2204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba5d0496', '2205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba5e0497', '2206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba600498', '2207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba620499', '2208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba63049a', '2301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba65049b', '2302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba66049c', '2303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba68049d', '2304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba69049e', '2305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba6b049f', '2306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba6d04a0', '2307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba6f04a1', '2308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7104a2', '2401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7204a3', '2402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7404a4', '2403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7504a5', '2404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7704a6', '2405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7904a7', '2406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7a04a8', '2407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7c04a9', '2408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7d04aa', '2501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba7f04ab', '2502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba8004ac', '2503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba8304ad', '2504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba8404ae', '2505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba8604af', '2506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba8804b0', '2507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba8a04b1', '2508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba8b04b2', '2601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba8d04b3', '2602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba8e04b4', '2603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9004b5', '2604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9104b6', '2605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9304b7', '2606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9504b8', '2607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9704b9', '2608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9904ba', '2701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9b04bb', '2702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9c04bc', '2703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9e04bd', '2704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53ba9f04be', '2705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baa104bf', '2706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baa304c0', '2707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baa404c1', '2708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baa604c2', '2801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baa804c3', '2802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baaa04c4', '2803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baac04c5', '2804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baad04c6', '2805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baaf04c7', '2806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bab104c8', '2807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bab204c9', '2808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bab404ca', '2901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bab604cb', '2902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bab704cc', '2903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bab904cd', '2904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baba04ce', '2905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53babb04cf', '2906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53babd04d0', '2907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53babf04d1', '2908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bac104d2', '3001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bac304d3', '3002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bac504d4', '3003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bac704d5', '3004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bac804d6', '3005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baca04d7', '3006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bacc04d8', '3007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bace04d9', '3008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bad004da', '3101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bad204db', '3102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bad404dc', '3103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bad604dd', '3104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bad704de', '3105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bad904df', '3106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53badb04e0', '3107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53badd04e1', '3108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53badf04e2', '3201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bae004e3', '3202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bae204e4', '3203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bae404e5', '3204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bae504e6', '3205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bae704e7', '3206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baea04e8', '3207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baec04e9', '3208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baee04ea', '3301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baf004eb', '3302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baf304ec', '3303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baf504ed', '3304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baf704ee', '3305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bafa04ef', '3306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bafd04f0', '3307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53baff04f1', '3308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb0204f2', '3401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb0404f3', '3402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb0704f4', '3403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb0904f5', '3404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb0b04f6', '3405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb0d04f7', '3406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb1004f8', '3407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb1304f9', '3408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb1604fa', '3501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb1804fb', '3502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb1b04fc', '3503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb1d04fd', '3504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb2004fe', '3505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb2204ff', '3506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb240500', '3507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb270501', '3508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb2a0502', '3601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb2c0503', '3602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb2e0504', '3603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb310505', '3604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb330506', '3605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb360507', '3606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb380508', '3607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb3b0509', '3608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb3d050a', '3701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb40050b', '3702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb42050c', '3703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb45050d', '3704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb48050e', '3705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb4b050f', '3706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb4e0510', '3707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb510511', '3708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb550512', '3801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb580513', '3802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb5a0514', '3803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb5d0515', '3804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb5f0516', '3805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb620517', '3806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb640518', '3807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb670519', '3808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb69051a', '3901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb6b051b', '3902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb6e051c', '3903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb70051d', '3904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb73051e', '3905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb76051f', '3906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb790520', '3907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb7b0521', '3908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb7e0522', '4001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb800523', '4002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb830524', '4003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb860525', '4004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb880526', '4005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb8b0527', '4006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb8d0528', '4007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb900529', '4008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb93052a', '4101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb96052b', '4102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb99052c', '4103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bb9c052d', '4104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bba4052e', '4105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bba7052f', '4106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bba90530', '4107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbab0531', '4108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbae0532', '4201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbb00533', '4202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbb20534', '4203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbb50535', '4204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbb70536', '4205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbba0537', '4206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbbd0538', '4207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbbf0539', '4208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbc2053a', '4301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbc4053b', '4302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbc6053c', '4303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbc8053d', '4304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbcb053e', '4305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbcd053f', '4306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbd00540', '4307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbd20541', '4308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbd50542', '4401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbd70543', '4402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbd90544', '4403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbdb0545', '4404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbdd0546', '4405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbdf0547', '4406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbe10548', '4407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbe40549', '4408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbe6054a', '4501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbe8054b', '4502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbeb054c', '4503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbed054d', '4504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbef054e', '4505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbf2054f', '4506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbf50550', '4507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbf70551', '4508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbfa0552', '4601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbfd0553', '4602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bbff0554', '4603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc030555', '4604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc060556', '4605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc080557', '4606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc0a0558', '4607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc0d0559', '4608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc0f055a', '4701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc12055b', '4702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc14055c', '4703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc17055d', '4704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc19055e', '4705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc1b055f', '4706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc1e0560', '4707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc200561', '4708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc230562', '4801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc250563', '4802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc270564', '4803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc2a0565', '4804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc2c0566', '4805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc2e0567', '4806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc310568', '4807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc330569', '4808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc36056a', '4901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc38056b', '4902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc3b056c', '4903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc3d056d', '4904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc40056e', '4905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc42056f', '4906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc450570', '4907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc470571', '4908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc4a0572', '5001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc4c0573', '5002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc4e0574', '5003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc510575', '5004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc530576', '5005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc560577', '5006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc580578', '5007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc5a0579', '5008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc5c057a', '5101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc5f057b', '5102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc62057c', '5103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc64057d', '5104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc67057e', '5105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc69057f', '5106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc6c0580', '5107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc6e0581', '5108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc700582', '5201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc720583', '5202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc740584', '5203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc760585', '5204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc790586', '5205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc7b0587', '5206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc7d0588', '5207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc800589', '5208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc82058a', '5301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc86058b', '5302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc88058c', '5303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc8a058d', '5304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc8d058e', '5305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc8f058f', '5306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc920590', '5307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc940591', '5308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc960592', '5401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc990593', '5402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc9c0594', '5403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bc9e0595', '5404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bca00596', '5405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bca30597', '5406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bca50598', '5407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bca70599', '5408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bca9059a', '5501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcac059b', '5502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcad059c', '5503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcb0059d', '5504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcb2059e', '5505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcb4059f', '5506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcb605a0', '5507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcb805a1', '5508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcba05a2', '5601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcbc05a3', '5602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcbe05a4', '5603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcc005a5', '5604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcc205a6', '5605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcc505a7', '5606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcc605a8', '5607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcc905a9', '5608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bccb05aa', '5701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bccd05ab', '5702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bccf05ac', '5703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcd105ad', '5704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcd205ae', '5705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcd405af', '5706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcd605b0', '5707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcd805b1', '5708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcda05b2', '5801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcdc05b3', '5802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcde05b4', '5803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bce005b5', '5804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bce205b6', '5805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bce405b7', '5806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bce605b8', '5807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bce805b9', '5808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcea05ba', '5901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcec05bb', '5902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcee05bc', '5903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcef05bd', '5904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcf105be', '5905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcf305bf', '5906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcf505c0', '5907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcf705c1', '5908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcf905c2', '6001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcfc05c3', '6002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcfd05c4', '6003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bcff05c5', '6004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd0105c6', '6005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd0305c7', '6006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd0505c8', '6007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd0705c9', '6008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd0905ca', '6101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd0b05cb', '6102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd0d05cc', '6103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd0f05cd', '6104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd1105ce', '6105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd1305cf', '6106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd1505d0', '6107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd1705d1', '6108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd1a05d2', '6201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd1c05d3', '6202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd1e05d4', '6203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd2005d5', '6204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd2205d6', '6205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd2405d7', '6206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd2705d8', '6207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd2905d9', '6208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd2b05da', '6301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd2e05db', '6302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd3005dc', '6303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd3205dd', '6304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd3605de', '6305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd3805df', '6306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd3b05e0', '6307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd3e05e1', '6308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd4005e2', '6401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd4305e3', '6402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd4605e4', '6403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd4805e5', '6404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd4a05e6', '6405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd4c05e7', '6406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd4f05e8', '6407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd5205e9', '6408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd5505ea', '6501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd5805eb', '6502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd5b05ec', '6503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd5d05ed', '6504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd6005ee', '6505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd6205ef', '6506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd6405f0', '6507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd6605f1', '6508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd6805f2', '6601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd6a05f3', '6602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd6d05f4', '6603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd6f05f5', '6604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd7205f6', '6605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd7505f7', '6606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd7705f8', '6607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd7a05f9', '6608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd7c05fa', '6701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd7e05fb', '6702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd8005fc', '6703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd8205fd', '6704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd8405fe', '6705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd8605ff', '6706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd890600', '6707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd8b0601', '6708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd8d0602', '6801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd8f0603', '6802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd910604', '6803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd930605', '6804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd960606', '6805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd980607', '6806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd9a0608', '6807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd9c0609', '6808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bd9e060a', '6901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bda0060b', '6902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bda3060c', '6903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bda6060d', '6904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bda8060e', '6905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdad060f', '6906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdb10610', '6907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdb30611', '6908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdb50612', '7001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdb80613', '7002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdba0614', '7003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdbc0615', '7004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdbe0616', '7005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdc00617', '7006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdc20618', '7007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdc50619', '7008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdc7061a', '7101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdc9061b', '7102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdcb061c', '7103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdcd061d', '7104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdcf061e', '7105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdd1061f', '7106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdd30620', '7107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdd50621', '7108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdd70622', '7201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdd90623', '7202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bddc0624', '7203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdde0625', '7204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bde00626', '7205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bde20627', '7206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bde50628', '7207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bde70629', '7208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdea062a', '7301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdec062b', '7302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdee062c', '7303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdf0062d', '7304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdf1062e', '7305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdf3062f', '7306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdf50630', '7307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdf70631', '7308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdf90632', '7401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdfc0633', '7402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bdfe0634', '7403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be000635', '7404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be030636', '7405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be060637', '7406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be080638', '7407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be0b0639', '7408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be0d063a', '7501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be0f063b', '7502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be12063c', '7503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be14063d', '7504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be16063e', '7505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be19063f', '7506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be1b0640', '7507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be1e0641', '7508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be200642', '7601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be220643', '7602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be250644', '7603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be270645', '7604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be290646', '7605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be2b0647', '7606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be2d0648', '7607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be300649', '7608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be32064a', '7701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be35064b', '7702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be37064c', '7703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be3a064d', '7704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be3d064e', '7705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be3f064f', '7706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be420650', '7707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be450651', '7708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be470652', '7801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be4a0653', '7802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be4c0654', '7803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be4f0655', '7804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be510656', '7805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be540657', '7806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be560658', '7807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be590659', '7808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be5c065a', '7901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be5e065b', '7902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be61065c', '7903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be64065d', '7904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be66065e', '7905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be69065f', '7906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be6c0660', '7907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be6f0661', '7908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be720662', '8001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be740663', '8002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be760664', '8003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be790665', '8004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be7c0666', '8005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be7e0667', '8006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be810668', '8007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be830669', '8008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be85066a', '8101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be87066b', '8102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be89066c', '8103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be8b066d', '8104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be8d066e', '8105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be90066f', '8106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be920670', '8107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be940671', '8108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be960672', '8201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be990673', '8202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be9b0674', '8203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be9d0675', '8204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53be9f0676', '8205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bea20677', '8206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bea40678', '8207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bea60679', '8208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bea8067a', '8301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beaa067b', '8302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bead067c', '8303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beaf067d', '8304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beb1067e', '8305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beb3067f', '8306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beb60680', '8307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beb90681', '8308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bebb0682', '8401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bebe0683', '8402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bec10684', '8403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bec40685', '8404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bec70686', '8405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beca0687', '8406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53becd0688', '8407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bed00689', '8408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bed2068a', '8501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bed5068b', '8502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bed7068c', '8503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beda068d', '8504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bedc068e', '8505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bedf068f', '8506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bee10690', '8507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bee40691', '8508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bee70692', '8601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beeb0693', '8602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53beee0694', '8603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bef10695', '8604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bef30696', '8605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bef50697', '8606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bef70698', '8607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53befa0699', '8608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53befd069a', '8701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf00069b', '8702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf03069c', '8703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf06069d', '8704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf09069e', '8705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf0c069f', '8706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf0f06a0', '8707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf1206a1', '8708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf1506a2', '8801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf1706a3', '8802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf1a06a4', '8803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf1c06a5', '8804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf1e06a6', '8805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf2106a7', '8806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf2406a8', '8807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf2606a9', '8808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf2a06aa', '8901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf2e06ab', '8902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf3206ac', '8903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf3606ad', '8904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf3b06ae', '8905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf4006af', '8906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf4406b0', '8907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf4906b1', '8908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf4d06b2', '9001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf5206b3', '9002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf5606b4', '9003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf5a06b5', '9004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf5f06b6', '9005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf6306b7', '9006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf6806b8', '9007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf6c06b9', '9008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf7006ba', '9101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf7506bb', '9102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf7906bc', '9103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf7e06bd', '9104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf8206be', '9105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf8606bf', '9106', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf8b06c0', '9107', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf8f06c1', '9108', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf9506c2', '9201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf9806c3', '9202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf9a06c4', '9203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf9d06c5', '9204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bf9f06c6', '9205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfa206c7', '9206', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfa406c8', '9207', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfa706c9', '9208', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfa906ca', '9301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfab06cb', '9302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfae06cc', '9303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfb106cd', '9304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfb306ce', '9305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfb606cf', '9306', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfb906d0', '9307', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfbb06d1', '9308', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfbe06d2', '9401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfc006d3', '9402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfc206d4', '9403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfc406d5', '9404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfc706d6', '9405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfca06d7', '9406', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfcc06d8', '9407', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfcf06d9', '9408', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfd206da', '9501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfd406db', '9502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfd706dc', '9503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfd906dd', '9504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfdc06de', '9505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfde06df', '9506', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfe106e0', '9507', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfe306e1', '9508', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfe506e2', '9601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfe706e3', '9602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfeb06e4', '9603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bfef06e5', '9604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bff206e6', '9605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bff506e7', '9606', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bff706e8', '9607', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bffa06e9', '9608', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53bffd06ea', '9701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c00006eb', '9702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c00306ec', '9703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c00506ed', '9704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c00806ee', '9705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c00b06ef', '9706', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c00d06f0', '9707', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c01006f1', '9708', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c01306f2', '9801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c01506f3', '9802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c01806f4', '9803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c01a06f5', '9804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c01d06f6', '9805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c02006f7', '9806', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c02206f8', '9807', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c02506f9', '9808', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c02706fa', '9901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c02a06fb', '9902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c02c06fc', '9903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c02f06fd', '9904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c03106fe', '9905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c03406ff', '9906', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c0370700', '9907', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c03a0701', '9908', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c03d0702', '10001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c03f0703', '10002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c0420704', '10003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c0450705', '10004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c0480706', '10005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c04b0707', '10006', '待售中', '402880355e59ae46015e59ae4b920005', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c04e0708', '10007', '待售中', '402880355e59ae46015e59ae4b950006', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f53c0510709', '10008', '待售中', '402880355e59ae46015e59ae4b980007', '4028808b5e7f3536015e7f53b95303e9');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb5c070b', '101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb5e070c', '102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb5f070d', '103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb60070e', '104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb61070f', '105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb620710', '201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb630711', '202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb640712', '203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb650713', '204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb660714', '205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb670715', '301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb680716', '302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb690717', '303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb690718', '304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb6a0719', '305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb6b071a', '401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb6d071b', '402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb6e071c', '403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb6f071d', '404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb70071e', '405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb71071f', '501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb720720', '502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb730721', '503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb740722', '504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb750723', '505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb760724', '601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb770725', '602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb780726', '603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb790727', '604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb7a0728', '605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb7b0729', '701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb7c072a', '702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb7e072b', '703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb7f072c', '704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb80072d', '705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb81072e', '801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb82072f', '802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb830730', '803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb840731', '804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb850732', '805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb860733', '901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb870734', '902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb880735', '903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb890736', '904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb8b0737', '905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb8b0738', '1001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb8d0739', '1002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb8e073a', '1003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb8f073b', '1004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb90073c', '1005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb91073d', '1101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb92073e', '1102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb93073f', '1103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb940740', '1104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb950741', '1105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb960742', '1201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb960743', '1202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb970744', '1203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb980745', '1204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb9a0746', '1205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb9b0747', '1301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb9c0748', '1302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb9c0749', '1303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bb9e074a', '1304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bba0074b', '1305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bba2074c', '1401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bba3074d', '1402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bba4074e', '1403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bba5074f', '1404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bba70750', '1405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bba80751', '1501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bba90752', '1502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbab0753', '1503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbac0754', '1504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbad0755', '1505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbaf0756', '1601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbb00757', '1602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbb20758', '1603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbb30759', '1604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbb4075a', '1605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbb5075b', '1701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbb7075c', '1702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbb8075d', '1703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbb9075e', '1704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbba075f', '1705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbbb0760', '1801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbbc0761', '1802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbbd0762', '1803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbbe0763', '1804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbc00764', '1805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbc10765', '1901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbc20766', '1902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbc40767', '1903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbc50768', '1904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbc60769', '1905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbc7076a', '2001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbc8076b', '2002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbc9076c', '2003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbca076d', '2004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbcc076e', '2005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbcd076f', '2101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbce0770', '2102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbcf0771', '2103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbd10772', '2104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbd20773', '2105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbd30774', '2201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbd40775', '2202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbd60776', '2203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbd70777', '2204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbd80778', '2205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbda0779', '2301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbdb077a', '2302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbdc077b', '2303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbdd077c', '2304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbdf077d', '2305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbe0077e', '2401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbe1077f', '2402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbe30780', '2403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbe40781', '2404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbe60782', '2405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbe70783', '2501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbe80784', '2502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbe90785', '2503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbea0786', '2504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbeb0787', '2505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbec0788', '2601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbed0789', '2602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbee078a', '2603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbef078b', '2604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbf1078c', '2605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbf2078d', '2701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbf3078e', '2702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbf5078f', '2703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbf60790', '2704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbf70791', '2705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbf80792', '2801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbf90793', '2802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbfa0794', '2803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbfc0795', '2804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbfd0796', '2805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbfe0797', '2901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bbff0798', '2902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc000799', '2903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc03079a', '2904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc04079b', '2905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc05079c', '3001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc06079d', '3002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc08079e', '3003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc09079f', '3004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc0a07a0', '3005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc0b07a1', '3101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc0d07a2', '3102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc0e07a3', '3103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1007a4', '3104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1107a5', '3105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1307a6', '3201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1507a7', '3202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1607a8', '3203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1807a9', '3204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1907aa', '3205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1b07ab', '3301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1d07ac', '3302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc1e07ad', '3303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc2007ae', '3304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc2307af', '3305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc2507b0', '3401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc2707b1', '3402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc2a07b2', '3403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc2c07b3', '3404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc2e07b4', '3405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc3107b5', '3501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc3307b6', '3502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc3507b7', '3503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc3707b8', '3504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc3907b9', '3505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc3a07ba', '3601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc3c07bb', '3602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc3e07bc', '3603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc3f07bd', '3604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4107be', '3605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4307bf', '3701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4407c0', '3702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4607c1', '3703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4707c2', '3704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4907c3', '3705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4a07c4', '3801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4b07c5', '3802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4d07c6', '3803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc4e07c7', '3804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5007c8', '3805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5107c9', '3901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5307ca', '3902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5407cb', '3903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5607cc', '3904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5807cd', '3905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5a07ce', '4001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5b07cf', '4002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5d07d0', '4003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5e07d1', '4004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc5f07d2', '4005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc6107d3', '4101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc6307d4', '4102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc6607d5', '4103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc6807d6', '4104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc6a07d7', '4105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc6c07d8', '4201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc6e07d9', '4202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7007da', '4203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7207db', '4204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7407dc', '4205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7507dd', '4301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7707de', '4302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7907df', '4303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7b07e0', '4304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7c07e1', '4305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7e07e2', '4401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc7f07e3', '4402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8107e4', '4403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8207e5', '4404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8407e6', '4405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8507e7', '4501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8707e8', '4502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8907e9', '4503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8a07ea', '4504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8c07eb', '4505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8e07ec', '4601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc8f07ed', '4602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc9107ee', '4603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc9207ef', '4604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc9407f0', '4605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc9607f1', '4701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc9707f2', '4702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc9907f3', '4703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc9b07f4', '4704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc9d07f5', '4705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bc9f07f6', '4801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bca007f7', '4802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bca207f8', '4803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bca407f9', '4804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bca607fa', '4805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bca707fb', '4901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bca907fc', '4902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcab07fd', '4903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcad07fe', '4904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcaf07ff', '4905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcb00800', '5001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcb20801', '5002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcb40802', '5003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcb60803', '5004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcb70804', '5005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcb90805', '5101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcbb0806', '5102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcbd0807', '5103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcbe0808', '5104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcc00809', '5105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcc2080a', '5201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcc3080b', '5202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcc5080c', '5203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcc7080d', '5204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcc9080e', '5205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bccb080f', '5301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bccd0810', '5302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bccf0811', '5303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcd00812', '5304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcd20813', '5305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcd40814', '5401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcd60815', '5402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcd70816', '5403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcd90817', '5404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcdb0818', '5405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcde0819', '5501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcdf081a', '5502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bce1081b', '5503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bce3081c', '5504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bce5081d', '5505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bce7081e', '5601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bce9081f', '5602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bceb0820', '5603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bced0821', '5604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcef0822', '5605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcf20823', '5701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcf40824', '5702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcf70825', '5703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcf90826', '5704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcfc0827', '5705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bcff0828', '5801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd010829', '5802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd03082a', '5803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd04082b', '5804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd06082c', '5805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd08082d', '5901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd0a082e', '5902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd0c082f', '5903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd0f0830', '5904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd110831', '5905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd130832', '6001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd140833', '6002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd160834', '6003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd180835', '6004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd1a0836', '6005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd1c0837', '6101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd1e0838', '6102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd200839', '6103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd22083a', '6104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd24083b', '6105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd25083c', '6201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd27083d', '6202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd29083e', '6203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd2b083f', '6204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd2e0840', '6205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd300841', '6301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd320842', '6302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd340843', '6303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd360844', '6304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd380845', '6305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd3a0846', '6401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd3c0847', '6402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd3d0848', '6403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd3f0849', '6404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd41084a', '6405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd43084b', '6501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd45084c', '6502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd4a084d', '6503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd4c084e', '6504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd4e084f', '6505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd500850', '6601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd520851', '6602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd530852', '6603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd550853', '6604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd570854', '6605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd590855', '6701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd5b0856', '6702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd5d0857', '6703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd5f0858', '6704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd610859', '6705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd63085a', '6801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd66085b', '6802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd68085c', '6803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd6a085d', '6804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd6b085e', '6805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd6d085f', '6901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd6f0860', '6902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd710861', '6903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd730862', '6904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd750863', '6905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd770864', '7001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd790865', '7002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd7a0866', '7003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd7c0867', '7004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd7e0868', '7005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd800869', '7101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd82086a', '7102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd84086b', '7103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd86086c', '7104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd88086d', '7105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd89086e', '7201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd8b086f', '7202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd8e0870', '7203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd8f0871', '7204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd910872', '7205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd940873', '7301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd950874', '7302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd970875', '7303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd980876', '7304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd9a0877', '7305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd9c0878', '7401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd9d0879', '7402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bd9f087a', '7403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bda0087b', '7404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bda2087c', '7405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bda3087d', '7501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bda5087e', '7502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bda7087f', '7503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bda90880', '7504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdaa0881', '7505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdac0882', '7601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdad0883', '7602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdaf0884', '7603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdb00885', '7604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdb20886', '7605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdb40887', '7701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdb60888', '7702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdb80889', '7703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdba088a', '7704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdbc088b', '7705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdbe088c', '7801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdbf088d', '7802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdc1088e', '7803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdc3088f', '7804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdc50890', '7805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdc70891', '7901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdc90892', '7902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdcc0893', '7903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdce0894', '7904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdd10895', '7905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdd40896', '8001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdd50897', '8002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdd90898', '8003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bddb0899', '8004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdde089a', '8005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bddf089b', '8101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bde2089c', '8102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bde4089d', '8103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bde6089e', '8104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bde8089f', '8105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdea08a0', '8201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdec08a1', '8202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdee08a2', '8203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdf008a3', '8204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdf208a4', '8205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdf408a5', '8301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdf608a6', '8302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdf808a7', '8303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdf908a8', '8304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdfb08a9', '8305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdfd08aa', '8401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bdff08ab', '8402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be0008ac', '8403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be0208ad', '8404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be0408ae', '8405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be0608af', '8501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be0808b0', '8502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be0a08b1', '8503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be0c08b2', '8504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be0e08b3', '8505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be1008b4', '8601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be1208b5', '8602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be1408b6', '8603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be1608b7', '8604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be1808b8', '8605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be1a08b9', '8701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be1b08ba', '8702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be1d08bb', '8703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be2008bc', '8704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be2208bd', '8705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be2408be', '8801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be2608bf', '8802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be2808c0', '8803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be2a08c1', '8804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be2c08c2', '8805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be2d08c3', '8901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be2f08c4', '8902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be3108c5', '8903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be3308c6', '8904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be3508c7', '8905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be3708c8', '9001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be3a08c9', '9002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be3c08ca', '9003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be3e08cb', '9004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be4008cc', '9005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be4108cd', '9101', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be4308ce', '9102', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be4508cf', '9103', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be4708d0', '9104', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be4908d1', '9105', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be4b08d2', '9201', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be4d08d3', '9202', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be4e08d4', '9203', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be5008d5', '9204', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be5208d6', '9205', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be5408d7', '9301', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be5608d8', '9302', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be5808d9', '9303', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be5a08da', '9304', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be5c08db', '9305', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be5e08dc', '9401', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be6008dd', '9402', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be6108de', '9403', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be6308df', '9404', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be6508e0', '9405', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be6708e1', '9501', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be6908e2', '9502', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be6b08e3', '9503', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be6d08e4', '9504', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be6f08e5', '9505', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be7008e6', '9601', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be7208e7', '9602', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be7408e8', '9603', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be7608e9', '9604', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be7808ea', '9605', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be7a08eb', '9701', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be7c08ec', '9702', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be7e08ed', '9703', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be8008ee', '9704', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be8308ef', '9705', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be8508f0', '9801', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be8608f1', '9802', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be8808f2', '9803', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be8a08f3', '9804', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be8d08f4', '9805', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be8e08f5', '9901', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be9008f6', '9902', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be9208f7', '9903', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be9408f8', '9904', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be9608f9', '9905', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be9808fa', '10001', '待售中', '402880355e59ae46015e59ae4b110000', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be9908fb', '10002', '待售中', '402880355e59ae46015e59ae4b800001', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be9c08fc', '10003', '待售中', '402880355e59ae46015e59ae4b840002', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54be9e08fd', '10004', '待售中', '402880355e59ae46015e59ae4b880003', '4028808b5e7f3536015e7f54bb53070a');
INSERT INTO `t_room` VALUES ('4028808b5e7f3536015e7f54bea008fe', '10005', '待售中', '402880355e59ae46015e59ae4b8c0004', '4028808b5e7f3536015e7f54bb53070a');

-- ----------------------------
-- Table structure for `t_sale`
-- ----------------------------
DROP TABLE IF EXISTS `t_sale`;
CREATE TABLE `t_sale` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `sale_time` datetime DEFAULT NULL COMMENT '销售时间',
  `unit_price` double DEFAULT NULL COMMENT '销售单价',
  `discount` double DEFAULT NULL COMMENT '销售折扣',
  `total_cost` double DEFAULT NULL COMMENT '销售总价',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` varchar(2) DEFAULT 'Y' COMMENT '状态',
  `customer_id` varchar(50) DEFAULT NULL COMMENT '客户编号',
  `emp_id` varchar(36) DEFAULT NULL COMMENT '员工编号',
  `room_id` varchar(36) DEFAULT NULL COMMENT '房屋编号',
  `agency_id` varchar(36) DEFAULT NULL COMMENT '经销商编号',
  PRIMARY KEY (`id`),
  KEY `fk_sale_cus_id` (`customer_id`),
  KEY `fk_sale_emp_id` (`emp_id`),
  KEY `fk_sale_room_id` (`room_id`),
  KEY `fk_sale_agency_id` (`agency_id`),
  CONSTRAINT `fk_sale_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_sale_cus_id` FOREIGN KEY (`customer_id`) REFERENCES `t_customer` (`id`),
  CONSTRAINT `fk_sale_emp_id` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`),
  CONSTRAINT `fk_sale_room_id` FOREIGN KEY (`room_id`) REFERENCES `t_room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sale
-- ----------------------------
INSERT INTO `t_sale` VALUES ('402880355e59b624015e59b628f90000', '2015-09-07 08:21:04', '500', '5', '2000000', '2014-09-07 08:21:04', '1', '402880355e59b379015e59b37dfc0000', '402880355e59b2b0015e59b2b4e00000', '402880355e59b1a4015e59b1a95b0003', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('402880355e59b6a7015e59b6abd70000', '2015-10-07 08:21:37', '5000', '5', '2000000', '2014-10-07 08:21:37', '1', '402880355e59b379015e59b37dfc0000', '402880355e59b2b0015e59b2b4e00000', '402880355e59b1a4015e59b1a95b0003', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('402880355e59be92015e59be96780000', '2016-09-07 08:30:16', '5000', '5', '2000000', '2015-02-07 08:30:16', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('402880355e59beab015e59beaf7a0000', '2016-09-07 08:30:23', '5000', '5', '2000000', '2017-09-07 08:30:23', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('6fcd964c-936d-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('71f44d56-936d-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('72c3f9f2-936d-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('73ae0390-936d-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('74a2af65-936d-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('75409273-936d-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('75c50226-936d-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('7643b569-936d-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('95f58728-9378-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59b2b0015e59b2b4e00000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('9cda74e1-936d-11e7-9986-80fa5b2e8425', '2016-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('9da019b7-936d-11e7-9986-80fa5b2e8425', '2016-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('9e2f7cde-936d-11e7-9986-80fa5b2e8425', '2016-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59bca2015e59bca6a10000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('ac305bc8-9378-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59b2b0015e59b2b4e00000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('bed8a8ce-9378-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59b2b0015e59b2b4e00000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');
INSERT INTO `t_sale` VALUES ('bf81caaf-9378-11e7-9986-80fa5b2e8425', '2017-05-07 08:30:28', '5000', '5', '2000000', '2017-09-07 08:30:28', '1', '402880355e59bd15015e59bd19f50000', '402880355e59b2b0015e59b2b4e00000', '402880355e59b1a4015e59b1a9590002', '402880355e59ac4d015e59ac51560000');

-- ----------------------------
-- Table structure for `t_tourist`
-- ----------------------------
DROP TABLE IF EXISTS `t_tourist`;
CREATE TABLE `t_tourist` (
  `id` varchar(36) NOT NULL,
  `phone` varchar(11) NOT NULL COMMENT '游客的手机号',
  `buildings_id` varchar(36) DEFAULT NULL,
  `emp_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tourist_building_id` (`buildings_id`),
  KEY `fk_tourist_emp_id` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_tourist
-- ----------------------------

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` varchar(36) NOT NULL,
  `email` varchar(50) NOT NULL COMMENT '用户邮箱',
  `phone` varchar(11) NOT NULL,
  `pwd` varchar(50) NOT NULL COMMENT '密码',
  `qq` varchar(20) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `headicon` varchar(500) DEFAULT NULL COMMENT '用户头像',
  `role_id` varchar(36) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  KEY `FK_user_roleid` (`role_id`),
  CONSTRAINT `FK_user_roleid` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('402880355e64ac65015e64ad09550000', '3001@qq.com', '13802266100', '4QrcOUm6Wau+VuBX8g+IPg==', null, null, null, null, null, '阿萨德', 'public/img/a1.jpg', 'd737ab4487f411e7a5142c56dc7febbc', '0');
INSERT INTO `t_user` VALUES ('402880355e64b2a0015e64b3de570002', '3002@qq.com', '18302266407', '4QrcOUm6Wau+VuBX8g+IPg==', null, null, null, null, '老李', null, 'public/img/a1.jpg', 'd737ab4487f411e7a5142c56dc7febbc', '1');
INSERT INTO `t_user` VALUES ('402880355e700421015e7004b2180000', '10002@qq.com', '13802266404', '4QrcOUm6Wau+VuBX8g+IPg==', null, null, null, null, '老王', null, 'public/img/a1.jpg', 'd737ab4487f411e7a5142c56dc7febbc', '1');
INSERT INTO `t_user` VALUES ('402880355e700658015e7006f8b70000', '10001@qq.com', '13802266403', '4QrcOUm6Wau+VuBX8g+IPg==', null, null, null, null, null, null, null, 'd737ab4487f411e7a5142c56dc7febbc', '1');
INSERT INTO `t_user` VALUES ('402880ce5eb8b70a015eb8c9d98d0000', '123@qq.com', '15367998789', '4QrcOUm6Wau+VuBX8g+IPg==', null, null, '--', null, null, '123@qq.com', 'public/img/a1.jpg', 'd737ab4487f411e7a5142c56dc7febbc', '1');
INSERT INTO `t_user` VALUES ('40289fc15e6990d7015e69995f0a0009', '20003@qq.com', '13802266421', '4QrcOUm6Wau+VuBX8g+IPg==', null, null, null, null, null, null, 'public/img/a1.jpg', 'd737ab4487f411e7a5142c56dc7febbc', '1');
INSERT INTO `t_user` VALUES ('40289fc15e6990d7015e699aa7e0000a', '20004@qq.com', '13702266401', '4QrcOUm6Wau+VuBX8g+IPg==', null, null, null, null, null, null, 'public/img/a1.jpg', 'd737ab4487f411e7a5142c56dc7febbc', '1');
INSERT INTO `t_user` VALUES ('40289fc15e6990d7015e699ecede0019', '20005@qq.com', '13702266402', '4QrcOUm6Wau+VuBX8g+IPg==', null, null, null, null, null, null, 'public/img/a1.jpg', 'd737ab4487f411e7a5142c56dc7febbc', '1');
