/*
Navicat MySQL Data Transfer

Source Server         : DNCRM
Source Server Version : 50632
Source Host           : localhost:3306
Source Database       : dncrm

Target Server Type    : MYSQL
Target Server Version : 50632
File Encoding         : 65001

Date: 2018-04-28 11:06:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_util
-- ----------------------------
DROP TABLE IF EXISTS `sys_util`;
CREATE TABLE `sys_util` (
  `id` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '编号',
  `content` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '内容'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_util
-- ----------------------------
INSERT INTO `sys_util` VALUES ('1', '1.16');
