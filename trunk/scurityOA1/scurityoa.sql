/*
Navicat MySQL Data Transfer
Source Host     : localhost:3306
Source Database : scurityoa
Target Host     : localhost:3306
Target Database : scurityoa
Date: 2013-09-05 21:13:04
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for biz_account
-- ----------------------------
DROP TABLE IF EXISTS `biz_account`;
CREATE TABLE `biz_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usr_id` varchar(13) DEFAULT NULL,
  `acc_type` varchar(2) DEFAULT NULL,
  `acc_money` double DEFAULT NULL,
  `sheet_id` varchar(13) DEFAULT NULL,
  `acc_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of biz_account
-- ----------------------------

-- ----------------------------
-- Table structure for biz_check_result
-- ----------------------------
DROP TABLE IF EXISTS `biz_check_result`;
CREATE TABLE `biz_check_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `checker_sn` bigint(20) NOT NULL COMMENT '审核人',
  `sheet_type` varchar(20) NOT NULL COMMENT '单据类型',
  `sheet_id` bigint(20) NOT NULL COMMENT '单据编号',
  `check_time` datetime NOT NULL COMMENT '审核时间',
  `stype` varchar(20) NOT NULL COMMENT '审核类型',
  `result` varchar(20) NOT NULL COMMENT '审核结果',
  `comm` varchar(255) DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`id`),
  KEY `FK5E0EAAE03DC2436F` (`checker_sn`),
  CONSTRAINT `FK5E0EAAE03DC2436F` FOREIGN KEY (`checker_sn`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of biz_check_result
-- ----------------------------
INSERT INTO `biz_check_result` VALUES ('1', '31', '报销单', '27', '2013-08-29 16:45:20', 'manger(部门经理)', '审核通过', '同意');
INSERT INTO `biz_check_result` VALUES ('2', '31', '报销单', '28', '2013-08-29 16:55:12', 'manger(部门经理)', '审核通过', '没意见，同意了....');
INSERT INTO `biz_check_result` VALUES ('3', '31', '报销单', '24', '2013-08-29 17:01:00', 'manger(部门经理)', '审核通过', 'ddd');
INSERT INTO `biz_check_result` VALUES ('4', '31', '报销单', '27', '2013-08-29 17:03:29', 'manger(部门经理)', '审核通过', 'dddvvv');
INSERT INTO `biz_check_result` VALUES ('5', '31', '报销单', '25', '2013-08-29 17:18:18', 'manger(部门经理)', '审核通过', 'dddvvvbbbggg');
INSERT INTO `biz_check_result` VALUES ('6', '31', '报销单', '31', '2013-08-29 17:28:49', 'manger(部门经理)', '审核通过', '668899');
INSERT INTO `biz_check_result` VALUES ('7', '31', '报销单', '26', '2013-08-30 08:47:10', 'manger(部门经理)', '审核通过', '同意 下次多花点......');
INSERT INTO `biz_check_result` VALUES ('8', '31', '报销单', '27', '2013-08-30 14:08:38', 'manger(部门经理)', '审核通过', 'ok very');
INSERT INTO `biz_check_result` VALUES ('9', '31', '报销单', '32', '2013-08-30 16:02:33', 'manger(部门经理)', '审核通过', 'ok plass is money');
INSERT INTO `biz_check_result` VALUES ('10', '31', '报销单', '37', '2013-08-30 16:04:12', 'manger(部门经理)', '审核通过', 'ok ddd');
INSERT INTO `biz_check_result` VALUES ('11', '31', '报销单', '34', '2013-08-30 16:04:29', 'manger(部门经理)', '审核通过', 'ok dddff');
INSERT INTO `biz_check_result` VALUES ('12', '30', '报销单', '31', '2013-08-31 10:10:34', 'boss(总经理)', '审核通过', 'ok fffddd');
INSERT INTO `biz_check_result` VALUES ('13', '30', '报销单', '32', '2013-08-31 10:20:39', 'boss(总经理)', '审核通过', 'yyyyy');
INSERT INTO `biz_check_result` VALUES ('14', '30', '报销单', '34', '2013-08-31 10:44:16', 'boss(总经理)', '审核通过', 'hello very good');
INSERT INTO `biz_check_result` VALUES ('15', '30', '报销单', '37', '2013-08-31 10:49:24', 'boss(总经理)', '审核通过', 'ok .....');
INSERT INTO `biz_check_result` VALUES ('16', '32', '报销单', '28', '2013-08-31 13:13:00', 'finance(财务)', '审核通过', 'ggggg');
INSERT INTO `biz_check_result` VALUES ('17', '32', '报销单', '32', '2013-08-31 21:12:26', 'finance(财务)', '审核通过', 'ok');
INSERT INTO `biz_check_result` VALUES ('18', '32', '报销单', '25', '2013-08-31 21:24:37', 'finance(财务)', '审核通过', 'ok 已付款....');
INSERT INTO `biz_check_result` VALUES ('19', '32', '报销单', '26', '2013-08-31 21:29:32', 'finance(财务)', '审核通过', '快没钱了，还多花点....');
INSERT INTO `biz_check_result` VALUES ('20', '32', '报销单', '34', '2013-08-31 21:32:02', 'finance(财务)', '审核通过', 'ok....');
INSERT INTO `biz_check_result` VALUES ('21', '31', '报销单', '30', '2013-09-01 11:32:52', 'manger(部门经理)', '审核通过', 'ok');
INSERT INTO `biz_check_result` VALUES ('22', '31', '报销单', '36', '2013-09-01 11:34:13', 'manger(部门经理)', '审核拒绝', 'ok');
INSERT INTO `biz_check_result` VALUES ('23', '31', '报销单', '39', '2013-09-01 12:10:59', 'manger(部门经理)', '审核通过', '拒绝');
INSERT INTO `biz_check_result` VALUES ('24', '31', '报销单', '35', '2013-09-01 12:11:59', 'manger(部门经理)', '审核拒绝', '拒绝');
INSERT INTO `biz_check_result` VALUES ('25', '31', '报销单', '42', '2013-09-01 12:25:59', 'manger(部门经理)', '审核拒绝', null);
INSERT INTO `biz_check_result` VALUES ('26', '31', '报销单', '43', '2013-09-01 12:31:04', 'manger(部门经理)', '审核拒绝', null);
INSERT INTO `biz_check_result` VALUES ('27', '31', '报销单', '44', '2013-09-01 12:37:04', 'manger(部门经理)', '审核打回', null);
INSERT INTO `biz_check_result` VALUES ('28', '31', '报销单', '45', '2013-09-01 12:39:07', 'manger(部门经理)', '审核打回', null);
INSERT INTO `biz_check_result` VALUES ('29', '31', '报销单', '47', '2013-09-01 12:39:23', 'manger(部门经理)', '审核拒绝', null);
INSERT INTO `biz_check_result` VALUES ('30', '31', '报销单', '48', '2013-09-01 12:39:41', 'manger(部门经理)', '审核通过', 'ok pass');
INSERT INTO `biz_check_result` VALUES ('31', '30', '报销单', '48', '2013-09-01 14:14:43', 'boss(总经理)', 'BOSS拒绝', null);
INSERT INTO `biz_check_result` VALUES ('32', '31', '报销单', '49', '2013-09-01 15:18:56', 'manger(部门经理)', '审核通过', 'jhhh');
INSERT INTO `biz_check_result` VALUES ('33', '31', '报销单', '50', '2013-09-01 15:19:05', 'manger(部门经理)', '审核通过', 'okkkkk');
INSERT INTO `biz_check_result` VALUES ('34', '31', '报销单', '51', '2013-09-01 15:19:11', 'manger(部门经理)', '审核通过', 'okkkkk');
INSERT INTO `biz_check_result` VALUES ('35', '31', '报销单', '52', '2013-09-01 15:19:17', 'manger(部门经理)', '审核通过', 'okkkkk');
INSERT INTO `biz_check_result` VALUES ('36', '30', '报销单', '51', '2013-09-01 15:19:51', 'boss(总经理)', 'BOSS拒绝', null);
INSERT INTO `biz_check_result` VALUES ('37', '30', '报销单', '49', '2013-09-01 15:26:36', 'boss(总经理)', 'BOSS打回', null);
INSERT INTO `biz_check_result` VALUES ('38', '30', '报销单', '50', '2013-09-01 15:27:23', 'boss(总经理)', '审核通过', 'ok......');
INSERT INTO `biz_check_result` VALUES ('39', '31', '报销单', '46', '2013-09-05 18:50:21', 'manger(部门经理)', '审核通过', 'ok,....');

-- ----------------------------
-- Table structure for biz_claim_voucher
-- ----------------------------
DROP TABLE IF EXISTS `biz_claim_voucher`;
CREATE TABLE `biz_claim_voucher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_sn` bigint(20) NOT NULL COMMENT '填报人',
  `next_deal_sn` bigint(20) DEFAULT NULL COMMENT '待处理人',
  `create_time` date NOT NULL COMMENT '填写时间',
  `event` varchar(255) NOT NULL COMMENT '事由',
  `total_account` double NOT NULL COMMENT '总金额',
  `status` varchar(20) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `FKF5F9537F7FFE18C8` (`create_sn`),
  KEY `FKF5F9537F2B4560C` (`next_deal_sn`),
  CONSTRAINT `FKF5F9537F2B4560C` FOREIGN KEY (`next_deal_sn`) REFERENCES `user` (`id`),
  CONSTRAINT `FKF5F9537F7FFE18C8` FOREIGN KEY (`create_sn`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of biz_claim_voucher
-- ----------------------------
INSERT INTO `biz_claim_voucher` VALUES ('24', '28', '32', '2013-08-28', 'fff', '11', 'DM已审核');
INSERT INTO `biz_claim_voucher` VALUES ('25', '28', '1', '2013-08-28', 'ffff', '110', '已付款');
INSERT INTO `biz_claim_voucher` VALUES ('26', '28', '1', '2013-08-28', 'bbbb', '33', '已付款');
INSERT INTO `biz_claim_voucher` VALUES ('27', '33', '32', '2013-08-28', 'gghhjj', '679', 'DM已审核');
INSERT INTO `biz_claim_voucher` VALUES ('28', '33', '1', '2013-08-28', '88uujjll', '88', '已付款');
INSERT INTO `biz_claim_voucher` VALUES ('29', '28', '31', '2013-08-28', 'ppoojj', '99', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('30', '33', '32', '2013-08-28', 'dddd', '11', 'DM已审核');
INSERT INTO `biz_claim_voucher` VALUES ('31', '28', '32', '2013-08-29', 'yyhhjj', '6666', 'BOSS已审核');
INSERT INTO `biz_claim_voucher` VALUES ('32', '28', '1', '2013-08-29', 'uujjkk', '8888', '已付款');
INSERT INTO `biz_claim_voucher` VALUES ('33', '28', '31', '2013-08-30', '777jjj', '165', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('34', '28', '1', '2013-08-30', 'ttttt', '7666', '已付款');
INSERT INTO `biz_claim_voucher` VALUES ('35', '28', null, '2013-08-30', 'yyyy', '112', '审核拒绝');
INSERT INTO `biz_claim_voucher` VALUES ('36', '33', null, '2013-08-30', 'yyyyy', '6677', '审核拒绝');
INSERT INTO `biz_claim_voucher` VALUES ('38', '33', null, '2013-09-01', '6u6uuuu', '6672', '审核拒绝');
INSERT INTO `biz_claim_voucher` VALUES ('39', '33', '32', '2013-09-01', 'jjj', '77', 'DM已审核');
INSERT INTO `biz_claim_voucher` VALUES ('40', '33', '31', '2013-09-01', 'kk', '165', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('41', '28', '31', '2013-09-01', 'ttt', '33', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('42', '28', null, '2013-09-01', 'yyy', '6655', '审核拒绝');
INSERT INTO `biz_claim_voucher` VALUES ('43', '28', null, '2013-09-03', 'jjj', '65', '审核拒绝');
INSERT INTO `biz_claim_voucher` VALUES ('44', '28', '28', '2013-09-01', '56565', '7876', '审核打回');
INSERT INTO `biz_claim_voucher` VALUES ('45', '33', '33', '2013-09-01', 'yyy', '666', '审核打回');
INSERT INTO `biz_claim_voucher` VALUES ('46', '33', '32', '2013-09-01', 'ttt', '555', 'DM已审核');
INSERT INTO `biz_claim_voucher` VALUES ('47', '33', null, '2013-09-01', 'ttt', '4444', '审核拒绝');
INSERT INTO `biz_claim_voucher` VALUES ('48', '33', null, '2013-09-01', 'uyuyu', '7788', '已提交');
INSERT INTO `biz_claim_voucher` VALUES ('49', '28', '28', '2013-09-01', 'jjj', '12345', 'BOSS打回');
INSERT INTO `biz_claim_voucher` VALUES ('50', '28', '32', '2013-09-01', 'yyuu', '88996', 'BOSS已审核');
INSERT INTO `biz_claim_voucher` VALUES ('51', '28', null, '2013-09-01', 'yyy', '55446', 'BOSS拒绝');
INSERT INTO `biz_claim_voucher` VALUES ('52', '28', '30', '2013-09-01', 'hhh', '77665', 'DM已审核');
INSERT INTO `biz_claim_voucher` VALUES ('53', '28', '31', '2013-09-01', 'ggg', '33333', '已提交');
INSERT INTO `biz_claim_voucher` VALUES ('54', '33', '31', '2013-09-02', '公事 打车费', '1221', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('55', '33', '31', '2013-09-02', '玩玩玩 very', '8954', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('56', '33', '31', '2013-09-03', 'jjkk', '7777', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('57', '33', '31', '2013-09-03', 'hjhjhj', '954', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('58', '33', '31', '2013-09-04', 'yyy', '6612', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('60', '28', '31', '2013-09-05', 'kkkkgggg', '10077', '已提交');
INSERT INTO `biz_claim_voucher` VALUES ('61', '28', '31', '2013-09-05', 'llllll', '1443', '已提交');
INSERT INTO `biz_claim_voucher` VALUES ('62', '28', '31', '2013-09-05', 'hhhh', '666', '已提交');
INSERT INTO `biz_claim_voucher` VALUES ('63', '28', '31', '2013-09-05', 'ghgfhf', '555', '已提交');
INSERT INTO `biz_claim_voucher` VALUES ('64', '28', '31', '2013-09-05', 'hhhh', '8877', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('65', '28', '31', '2013-09-05', 'kkjjj', '8879', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('66', '28', '31', '2013-09-05', 'gggg', '621', '已提交');
INSERT INTO `biz_claim_voucher` VALUES ('67', '28', '31', '2013-09-05', 'dfd', '443', '未提交');
INSERT INTO `biz_claim_voucher` VALUES ('68', '28', '31', '2013-09-05', 'fdf', '55', '已提交');
INSERT INTO `biz_claim_voucher` VALUES ('69', '28', '31', '2013-09-05', 'fdfdf', '3333', '已提交');
INSERT INTO `biz_claim_voucher` VALUES ('70', '28', '31', '2013-09-05', 'vvvvv', '7000', '未提交');

-- ----------------------------
-- Table structure for biz_claim_voucher_detail
-- ----------------------------
DROP TABLE IF EXISTS `biz_claim_voucher_detail`;
CREATE TABLE `biz_claim_voucher_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `main_id` bigint(20) DEFAULT NULL COMMENT '报销单(主单)编号',
  `item` varchar(20) NOT NULL COMMENT '项目',
  `account` double NOT NULL COMMENT '金额',
  `des` varchar(200) NOT NULL COMMENT '费用说明',
  PRIMARY KEY (`id`),
  KEY `FKEC02A511D7B13702` (`main_id`),
  CONSTRAINT `FK_details` FOREIGN KEY (`main_id`) REFERENCES `biz_claim_voucher` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of biz_claim_voucher_detail
-- ----------------------------
INSERT INTO `biz_claim_voucher_detail` VALUES ('37', '24', '城际交通费', '11', 'fff');
INSERT INTO `biz_claim_voucher_detail` VALUES ('38', '25', '城际交通费', '55', 'hh');
INSERT INTO `biz_claim_voucher_detail` VALUES ('39', '25', '城际交通费', '55', 'ff');
INSERT INTO `biz_claim_voucher_detail` VALUES ('40', '26', '城际交通费', '33', 'gg');
INSERT INTO `biz_claim_voucher_detail` VALUES ('41', '27', '城际交通费', '123', 'tt');
INSERT INTO `biz_claim_voucher_detail` VALUES ('42', '27', '城际交通费', '556', 'fff');
INSERT INTO `biz_claim_voucher_detail` VALUES ('43', '28', '城际交通费', '88', '88u');
INSERT INTO `biz_claim_voucher_detail` VALUES ('44', '29', '城际交通费', '99', '99p');
INSERT INTO `biz_claim_voucher_detail` VALUES ('45', '30', '城际交通费', '11', 'dd');
INSERT INTO `biz_claim_voucher_detail` VALUES ('46', '31', '城际交通费', '6666', 'yyyy');
INSERT INTO `biz_claim_voucher_detail` VALUES ('47', '32', '城际交通费', '8888', 'uuuu');
INSERT INTO `biz_claim_voucher_detail` VALUES ('48', '33', '城际交通费', '77', 'jjj');
INSERT INTO `biz_claim_voucher_detail` VALUES ('49', '33', '城际交通费', '88', 'kkkk');
INSERT INTO `biz_claim_voucher_detail` VALUES ('50', '34', '城际交通费', '1000', '6677jj');
INSERT INTO `biz_claim_voucher_detail` VALUES ('51', '34', '城际交通费', '6666', 'llll');
INSERT INTO `biz_claim_voucher_detail` VALUES ('52', '35', '城际交通费', '112', 'yyy');
INSERT INTO `biz_claim_voucher_detail` VALUES ('53', '36', '城际交通费', '6677', 'ooooo');
INSERT INTO `biz_claim_voucher_detail` VALUES ('56', '38', '城际交通费', '6666', 'uuuu');
INSERT INTO `biz_claim_voucher_detail` VALUES ('57', '38', '城际交通费', '6', 'u');
INSERT INTO `biz_claim_voucher_detail` VALUES ('58', '39', '城际交通费', '77', 'kk');
INSERT INTO `biz_claim_voucher_detail` VALUES ('59', '40', '城际交通费', '77', 'kk');
INSERT INTO `biz_claim_voucher_detail` VALUES ('60', '40', '城际交通费', '88', 'mm');
INSERT INTO `biz_claim_voucher_detail` VALUES ('61', '41', '城际交通费', '33', 'tt');
INSERT INTO `biz_claim_voucher_detail` VALUES ('62', '42', '城际交通费', '6655', 'yy');
INSERT INTO `biz_claim_voucher_detail` VALUES ('63', '43', '城际交通费', '65', 'jj');
INSERT INTO `biz_claim_voucher_detail` VALUES ('64', '44', '城际交通费', '7876', '666');
INSERT INTO `biz_claim_voucher_detail` VALUES ('65', '45', '城际交通费', '666', 'yy');
INSERT INTO `biz_claim_voucher_detail` VALUES ('66', '46', '城际交通费', '555', 'ttt');
INSERT INTO `biz_claim_voucher_detail` VALUES ('67', '47', '城际交通费', '4444', 'ttt');
INSERT INTO `biz_claim_voucher_detail` VALUES ('68', '48', '城际交通费', '7788', 'uuu');
INSERT INTO `biz_claim_voucher_detail` VALUES ('69', '49', '城际交通费', '12345', 'uuu');
INSERT INTO `biz_claim_voucher_detail` VALUES ('70', '50', '城际交通费', '88996', 'yyy');
INSERT INTO `biz_claim_voucher_detail` VALUES ('71', '51', '城际交通费', '55446', 'yyy');
INSERT INTO `biz_claim_voucher_detail` VALUES ('72', '52', '城际交通费', '77665', '66hh');
INSERT INTO `biz_claim_voucher_detail` VALUES ('73', '53', '城际交通费', '33333', 'rrrrr');
INSERT INTO `biz_claim_voucher_detail` VALUES ('74', '54', '城际交通费', '555', '业务办理');
INSERT INTO `biz_claim_voucher_detail` VALUES ('75', '54', '城际交通费', '666', '止');
INSERT INTO `biz_claim_voucher_detail` VALUES ('76', '55', '城际交通费', '8888', 'hhhh');
INSERT INTO `biz_claim_voucher_detail` VALUES ('77', '55', '城际交通费', '66', 'yy');
INSERT INTO `biz_claim_voucher_detail` VALUES ('78', '56', '城际交通费', '7777', '88uuu');
INSERT INTO `biz_claim_voucher_detail` VALUES ('79', '57', '城际交通费', '66', 'jj');
INSERT INTO `biz_claim_voucher_detail` VALUES ('80', '57', '城际交通费', '888', 'bbb');
INSERT INTO `biz_claim_voucher_detail` VALUES ('81', '58', '城际交通费', '6612', 'tt');
INSERT INTO `biz_claim_voucher_detail` VALUES ('85', '60', '城际交通费', '666', 'jjjj');
INSERT INTO `biz_claim_voucher_detail` VALUES ('86', '60', '城际交通费', '555', 'ggg');
INSERT INTO `biz_claim_voucher_detail` VALUES ('87', '60', '城际交通费', '8856', 'iii');
INSERT INTO `biz_claim_voucher_detail` VALUES ('88', '61', '城际交通费', '888', 'jjj');
INSERT INTO `biz_claim_voucher_detail` VALUES ('89', '61', '城际交通费', '555', 'hhhh');
INSERT INTO `biz_claim_voucher_detail` VALUES ('90', '62', '通讯费', '666', 'uuj');
INSERT INTO `biz_claim_voucher_detail` VALUES ('91', '63', '城际交通费', '555', 'kkjhj');
INSERT INTO `biz_claim_voucher_detail` VALUES ('92', '64', '城际交通费', '8877', 'jjhhg');
INSERT INTO `biz_claim_voucher_detail` VALUES ('93', '65', '城际交通费', '8879', 'kkkk');
INSERT INTO `biz_claim_voucher_detail` VALUES ('94', '66', '城际交通费', '555', '五gg');
INSERT INTO `biz_claim_voucher_detail` VALUES ('95', '66', '城际交通费', '66', '止 ');
INSERT INTO `biz_claim_voucher_detail` VALUES ('96', '67', '办公费', '443', 'fff');
INSERT INTO `biz_claim_voucher_detail` VALUES ('97', '68', '城际交通费', '55', 'dfd');
INSERT INTO `biz_claim_voucher_detail` VALUES ('98', '69', '城际交通费', '3333', 'fdf ');
INSERT INTO `biz_claim_voucher_detail` VALUES ('99', '70', '餐补', '7000', 'vvv');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `manager_sn` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', 'OA', '业务部');
INSERT INTO `department` VALUES ('2', 'FD', '财务部');
INSERT INTO `department` VALUES ('3', 'IT', 'IT部');
INSERT INTO `department` VALUES ('4', 'XS', '销售部');

-- ----------------------------
-- Table structure for persistent_logins
-- ----------------------------
DROP TABLE IF EXISTS `persistent_logins`;
CREATE TABLE `persistent_logins` (
  `username` varchar(64) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of persistent_logins
-- ----------------------------

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name_cn` varchar(50) DEFAULT NULL,
  `name_en` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES ('1', '员工', 'employe');
INSERT INTO `position` VALUES ('2', '部门经理', 'departmentManger');
INSERT INTO `position` VALUES ('3', '总经理', 'generalManager');
INSERT INTO `position` VALUES ('4', '财务', 'finance');
INSERT INTO `position` VALUES ('5', '管理员', 'admin');

-- ----------------------------
-- Table structure for resc
-- ----------------------------
DROP TABLE IF EXISTS `resc`;
CREATE TABLE `resc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `res_type` varchar(50) DEFAULT NULL,
  `res_string` varchar(200) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `descn` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of resc
-- ----------------------------
INSERT INTO `resc` VALUES ('1', '系统管理员', 'URL', '/admin/**', '1', '系统管理员操作页面\r\n\r\n');
INSERT INTO `resc` VALUES ('3', '', 'URL', '/userReg/**', '3', '用户注册页面');
INSERT INTO `resc` VALUES ('4', '', 'URL', '/error/**', '4', 'errorInfo');
INSERT INTO `resc` VALUES ('6', null, 'URL', '/login.jsp*', '5', 'loginPage');
INSERT INTO `resc` VALUES ('7', null, 'URL', '/userPage.jsp*', '6', '普通用户页面');
INSERT INTO `resc` VALUES ('8', '', 'URL', '/manager.jsp*', '7', '经理操做页面');
INSERT INTO `resc` VALUES ('11', '业务部办公区', 'URL', '/oA/OA1/indexs.jsp*', '20', '业务部办公区\r\n\r\n');
INSERT INTO `resc` VALUES ('12', '部门经理', 'URL', '/oA/OA1/departmentManger/**', '22', '部门经理办公区\r\n');
INSERT INTO `resc` VALUES ('13', '总经理', 'URL', '/oA/OA1/generalManager/**', '21', '总经理办公区\r\n');
INSERT INTO `resc` VALUES ('14', '员工业务', 'URL', '/oA/OA1/employee/**', '23', '员工业务办公区');
INSERT INTO `resc` VALUES ('15', '财务部', 'URL', '/oA/OA1/employee/**', '24', '财务操作页面');

-- ----------------------------
-- Table structure for resc_role
-- ----------------------------
DROP TABLE IF EXISTS `resc_role`;
CREATE TABLE `resc_role` (
  `resc_id` bigint(20) NOT NULL DEFAULT '0',
  `role_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resc_id`,`role_id`),
  KEY `fk_resc_role_role` (`role_id`),
  CONSTRAINT `fk_resc_role_resc` FOREIGN KEY (`resc_id`) REFERENCES `resc` (`id`),
  CONSTRAINT `fk_resc_role_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of resc_role
-- ----------------------------
INSERT INTO `resc_role` VALUES ('1', '1');
INSERT INTO `resc_role` VALUES ('7', '1');
INSERT INTO `resc_role` VALUES ('11', '1');
INSERT INTO `resc_role` VALUES ('7', '2');
INSERT INTO `resc_role` VALUES ('3', '3');
INSERT INTO `resc_role` VALUES ('6', '3');
INSERT INTO `resc_role` VALUES ('8', '4');
INSERT INTO `resc_role` VALUES ('11', '10');
INSERT INTO `resc_role` VALUES ('14', '17');
INSERT INTO `resc_role` VALUES ('11', '19');
INSERT INTO `resc_role` VALUES ('13', '19');
INSERT INTO `resc_role` VALUES ('11', '20');
INSERT INTO `resc_role` VALUES ('12', '20');
INSERT INTO `resc_role` VALUES ('11', '21');
INSERT INTO `resc_role` VALUES ('15', '21');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `descn` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'ROLE_ADMIN', '管理员角色\r\n\r\n');
INSERT INTO `role` VALUES ('2', 'ROLE_USER', '用户角色');
INSERT INTO `role` VALUES ('3', 'IS_AUTHENTICATED_ANONYMOUSLY', '没有任何权限限制的页面');
INSERT INTO `role` VALUES ('4', 'ROLE_MANAGER', '经理权限');
INSERT INTO `role` VALUES ('10', 'ROLE_OA', '办公人员角色\r\n\r\n\r\n');
INSERT INTO `role` VALUES ('17', 'ROLE_OA_EMP', '员工\r\n');
INSERT INTO `role` VALUES ('19', 'ROLE_OA_GeneralManager', '总经理\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n');
INSERT INTO `role` VALUES ('20', 'ROLE_OA_DepartmentManger', '部门经理\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n');
INSERT INTO `role` VALUES ('21', 'ROLE_FINANCE', '财务\r\n\r\n\r\n\r\n');

-- ----------------------------
-- Table structure for sys_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionary`;
CREATE TABLE `sys_dictionary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `d_type` varchar(20) NOT NULL,
  `item` varchar(20) NOT NULL,
  `d_value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of sys_dictionary
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `status` int(11) DEFAULT '1',
  `descn` varchar(200) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `position_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK36EBCBE07E36FD` (`department_id`),
  KEY `FK36EBCB5435EA19` (`position_id`),
  CONSTRAINT `FK36EBCB5435EA19` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`),
  CONSTRAINT `FK36EBCBE07E36FD` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'ceb4f32325eda6142bd65215f4c0f371', '1', 'admin', '卢俊义', '3', '5');
INSERT INTO `user` VALUES ('2', 'user', '47a733d60998c719cf3526ae7d106d13', '1', 'user', null, null, null);
INSERT INTO `user` VALUES ('3', 'manager', 'de835dd5333c20c2b0d5c062aa83fb56', '1', 'managerAuthorities', null, null, null);
INSERT INTO `user` VALUES ('14', 'aaaa2', '824cf1db83e5a536e347f1c9ff961d34', '1', 'fsaaaaa', null, null, null);
INSERT INTO `user` VALUES ('17', 'hh', '0c2e02318d809a9572403c5e6d15e7e3', '1', null, null, null, null);
INSERT INTO `user` VALUES ('20', 'fs', 'dc54f039667acdb86a779458e68ec916', '1', 'fs', null, null, null);
INSERT INTO `user` VALUES ('28', 'OA001', '6138217e4b4aced33a7b4b141a40756a', '1', 'OA001 ', '林冲', '1', '1');
INSERT INTO `user` VALUES ('29', 'OA002', '2a241c69db46adffaead5498c2b47eb7', '1', 'OA oo2', '武松', '1', '1');
INSERT INTO `user` VALUES ('30', 'CEO001', 'c82534dbf17ab3bd50a7baaf545f261c', '1', '总经理', '宋江', '1', '3');
INSERT INTO `user` VALUES ('31', 'DM001', 'c15986ee5555129ab28d5235e2c51527', '1', '部门经理 ', '吴用', '1', '2');
INSERT INTO `user` VALUES ('32', 'FD001', 'fbdb93059ed646223eb594320d379bb0', '1', '财务人员', '花荣', '2', '4');
INSERT INTO `user` VALUES ('33', 'OA003', 'bf0fbc5f00c455d093ced3c3b2eb84b2', '1', '浪子艳清', '艳清', '1', '1');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `role_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_user_role_role` (`role_id`),
  CONSTRAINT `fk_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1');
INSERT INTO `user_role` VALUES ('17', '1');
INSERT INTO `user_role` VALUES ('20', '1');
INSERT INTO `user_role` VALUES ('1', '2');
INSERT INTO `user_role` VALUES ('2', '2');
INSERT INTO `user_role` VALUES ('14', '2');
INSERT INTO `user_role` VALUES ('17', '2');
INSERT INTO `user_role` VALUES ('3', '4');
INSERT INTO `user_role` VALUES ('20', '4');
INSERT INTO `user_role` VALUES ('28', '10');
INSERT INTO `user_role` VALUES ('33', '10');
INSERT INTO `user_role` VALUES ('28', '17');
INSERT INTO `user_role` VALUES ('29', '17');
INSERT INTO `user_role` VALUES ('33', '17');
INSERT INTO `user_role` VALUES ('30', '19');
INSERT INTO `user_role` VALUES ('31', '20');
INSERT INTO `user_role` VALUES ('32', '21');
