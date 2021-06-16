/*
 Navicat Premium Data Transfer

 Source Server         : huawei-mysql
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : 121.37.156.155:3306
 Source Schema         : swxl

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 14/06/2021 11:49:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for prod_sales
-- ----------------------------
DROP TABLE IF EXISTS `prod_sales`;
CREATE TABLE `prod_sales`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_class` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sales_date` date NULL DEFAULT NULL,
  `prod_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sales_num` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prod_sales
-- ----------------------------
INSERT INTO `prod_sales` VALUES (1, '图书类', '2017-03-01', 'java入门', 200);
INSERT INTO `prod_sales` VALUES (2, '食品类', '2017-03-10', '德芙巧克力', 100);
INSERT INTO `prod_sales` VALUES (3, '图书类', '2017-03-03', 'Java入门', 300);
INSERT INTO `prod_sales` VALUES (4, '图书类', '2017-03-04', 'php入门到放弃', 250);
INSERT INTO `prod_sales` VALUES (5, '食品类', '2017-03-12', '阿旺雪米饼', 120);
INSERT INTO `prod_sales` VALUES (6, '图书类', '2017-03-15', 'Python基础入门', 115);
INSERT INTO `prod_sales` VALUES (7, '食品类', '2017-03-19', '德芙巧克力', 130);
INSERT INTO `prod_sales` VALUES (8, '图书类', '2017-03-22', 'Java入门', 198);
INSERT INTO `prod_sales` VALUES (10, '图书类', '2017-03-21', 'php入门到放弃', 220);
INSERT INTO `prod_sales` VALUES (11, '图书类', '2017-03-22', 'android开发入门', 110);
INSERT INTO `prod_sales` VALUES (12, '食品类', '2017-03-19', '红枣', 90);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_view` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`p_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, '西瓜', '水果类', 21);
INSERT INTO `products` VALUES (2, '瓜子', '干果类', 32);
INSERT INTO `products` VALUES (22, '苹果', '水果类', 32);
INSERT INTO `products` VALUES (28, '桔子', '水果类', 33);
INSERT INTO `products` VALUES (32, '香蕉', '水果类', 21);
INSERT INTO `products` VALUES (35, '花生', '干果类', 3);
INSERT INTO `products` VALUES (37, '猪肉', '生鲜类', 5);
INSERT INTO `products` VALUES (48, '牛肉', '生鲜类', 23);
INSERT INTO `products` VALUES (60, '开心果', '干果类', 56);
INSERT INTO `products` VALUES (61, '鸡翅', '生鲜类', 23);
INSERT INTO `products` VALUES (77, '樱桃', '水果类', 41);
INSERT INTO `products` VALUES (87, '杜蕾斯', '其他类', 123);
INSERT INTO `products` VALUES (102, '开瓶器', '其他类', 88);
INSERT INTO `products` VALUES (114, '五花肉', '生鲜类', 4);

-- ----------------------------
-- Table structure for products_sales
-- ----------------------------
DROP TABLE IF EXISTS `products_sales`;
CREATE TABLE `products_sales`  (
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_sales` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`p_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products_sales
-- ----------------------------
INSERT INTO `products_sales` VALUES (1, '西瓜', 101);
INSERT INTO `products_sales` VALUES (2, '瓜子', 200);
INSERT INTO `products_sales` VALUES (22, '苹果', 90);
INSERT INTO `products_sales` VALUES (28, '桔子', 80);
INSERT INTO `products_sales` VALUES (35, '花生', 55);
INSERT INTO `products_sales` VALUES (87, '杜蕾斯', 500);
INSERT INTO `products_sales` VALUES (102, '开瓶器', 231);
INSERT INTO `products_sales` VALUES (114, '五花肉', 77);

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `r_content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `r_userid` int(11) NOT NULL,
  `news_id` int(11) NOT NULL,
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO `reviews` VALUES (1, '不错啊', 101, 5);
INSERT INTO `reviews` VALUES (2, '很好的文章', 102, 6);
INSERT INTO `reviews` VALUES (3, '作者用心了', 103, 5);
INSERT INTO `reviews` VALUES (4, '顶赞', 102, 7);
INSERT INTO `reviews` VALUES (5, '不错啊', 101, 5);
INSERT INTO `reviews` VALUES (6, '不错啊', 101, 5);
INSERT INTO `reviews` VALUES (7, '写的不错', 105, 7);
INSERT INTO `reviews` VALUES (8, '很好的文章', 102, 6);
INSERT INTO `reviews` VALUES (9, '很好的文章', 102, 6);
INSERT INTO `reviews` VALUES (10, '知道了', 108, 11);

-- ----------------------------
-- Table structure for user_level
-- ----------------------------
DROP TABLE IF EXISTS `user_level`;
CREATE TABLE `user_level`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_total` decimal(10, 2) NULL DEFAULT NULL,
  `user_rank` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '吃瓜',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_level
-- ----------------------------
INSERT INTO `user_level` VALUES (1, '张三', 5.00, '吃瓜');
INSERT INTO `user_level` VALUES (2, '李四', 30.30, '吃瓜');
INSERT INTO `user_level` VALUES (3, '赵龙', 22.00, '吃瓜');
INSERT INTO `user_level` VALUES (4, '王五', 489.00, '黄金用户');
INSERT INTO `user_level` VALUES (5, '刘飞', 175.00, '白金用户');
INSERT INTO `user_level` VALUES (6, '王菲', 123.00, '吃瓜用户');
INSERT INTO `user_level` VALUES (7, '章子怡', 101.00, '吃瓜');
INSERT INTO `user_level` VALUES (8, '陈晨', 20.00, '吃瓜');
INSERT INTO `user_level` VALUES (9, '老蒋', 11.00, '吃瓜');

-- ----------------------------
-- Table structure for user_sign
-- ----------------------------
DROP TABLE IF EXISTS `user_sign`;
CREATE TABLE `user_sign`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sign_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_sign
-- ----------------------------
INSERT INTO `user_sign` VALUES (1, 'feixiang', '2017-04-01');
INSERT INTO `user_sign` VALUES (2, 'feixiang', '2017-04-02');
INSERT INTO `user_sign` VALUES (3, 'zhangsan', '2017-04-01');
INSERT INTO `user_sign` VALUES (4, 'zhangsan', '2017-04-02');
INSERT INTO `user_sign` VALUES (5, 'feixiang', '2017-04-03');
INSERT INTO `user_sign` VALUES (6, 'feixiang', '2017-04-04');
INSERT INTO `user_sign` VALUES (7, 'lisi', '2017-04-01');
INSERT INTO `user_sign` VALUES (8, 'feixiang', '2017-04-04');
INSERT INTO `user_sign` VALUES (9, 'zhangsan', '2017-04-03');
INSERT INTO `user_sign` VALUES (10, 'feixiang', '2017-04-05');
INSERT INTO `user_sign` VALUES (11, 'feixiang', '2017-04-16');
INSERT INTO `user_sign` VALUES (12, 'zhangsan', '2017-04-16');
INSERT INTO `user_sign` VALUES (13, 'lisi', '2017-04-16');
INSERT INTO `user_sign` VALUES (14, 'feixiang', '2017-04-17');
INSERT INTO `user_sign` VALUES (15, 'feixiang', '2017-04-18');
INSERT INTO `user_sign` VALUES (16, 'zhangsan', '2017-04-17');
INSERT INTO `user_sign` VALUES (17, 'zhangsan', '2017-04-18');
INSERT INTO `user_sign` VALUES (18, 'zhangsan', '2017-04-19');

-- ----------------------------
-- Table structure for users_buy
-- ----------------------------
DROP TABLE IF EXISTS `users_buy`;
CREATE TABLE `users_buy`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `paymoney` decimal(5, 2) NULL DEFAULT NULL,
  `paydate` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_buy
-- ----------------------------
INSERT INTO `users_buy` VALUES (1, 'feixiang', 200.00, '2017-05-15');
INSERT INTO `users_buy` VALUES (2, 'feixiang', 150.00, '2017-05-16');
INSERT INTO `users_buy` VALUES (3, 'zhangsan', 100.00, '2017-05-17');
INSERT INTO `users_buy` VALUES (4, 'lisi', 150.00, '2017-05-16');
INSERT INTO `users_buy` VALUES (5, 'zhangsan', 90.00, '2017-05-18');

-- ----------------------------
-- Table structure for users_score
-- ----------------------------
DROP TABLE IF EXISTS `users_score`;
CREATE TABLE `users_score`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_score` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_score
-- ----------------------------
INSERT INTO `users_score` VALUES (1, 'feixiang', 35);
INSERT INTO `users_score` VALUES (2, 'zhangsan', 25);
INSERT INTO `users_score` VALUES (3, 'lisi', 30);
INSERT INTO `users_score` VALUES (4, 'wuxixi', 15);

-- ----------------------------
-- Table structure for webusers
-- ----------------------------
DROP TABLE IF EXISTS `webusers`;
CREATE TABLE `webusers`  (
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `p_id` int(11) NOT NULL,
  PRIMARY KEY (`u_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webusers
-- ----------------------------
INSERT INTO `webusers` VALUES (1, '张三', 0);
INSERT INTO `webusers` VALUES (2, '大胖胖', 0);
INSERT INTO `webusers` VALUES (3, '李四', 2);
INSERT INTO `webusers` VALUES (4, '大长脸', 2);
INSERT INTO `webusers` VALUES (5, '小朱', 1);
INSERT INTO `webusers` VALUES (6, '小狗', 5);
INSERT INTO `webusers` VALUES (7, '刘九', 5);

SET FOREIGN_KEY_CHECKS = 1;
