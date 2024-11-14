/*
 Navicat Premium Dump SQL

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 90001 (9.0.1)
 Source Host           : localhost:3306
 Source Schema         : translate-admin

 Target Server Type    : MySQL
 Target Server Version : 90001 (9.0.1)
 File Encoding         : 65001

 Date: 15/11/2024 00:37:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_manage
-- ----------------------------
DROP TABLE IF EXISTS `auth_manage`;
CREATE TABLE `auth_manage` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `auth_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '授权码',
  `machine_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机器码',
  `expiry_date` timestamp NOT NULL COMMENT '失效时间',
  `available_chars` bigint DEFAULT NULL COMMENT '可用字符串',
  `total_chars` bigint NOT NULL COMMENT '总字符数',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `status` varchar(255) DEFAULT '1' COMMENT '状态',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_code` (`auth_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_manage
-- ----------------------------
BEGIN;
INSERT INTO `auth_manage` (`id`, `auth_code`, `machine_code`, `expiry_date`, `available_chars`, `total_chars`, `created_at`, `updated_at`, `status`, `remarks`) VALUES (8, '74769085-4c25-4c6e-818f-fcaa82d5ee4d', 'f0d16988-a9ff-5a04-a9ae-423a3c2ce444', '2024-11-17 17:34:22', 50000, 50000, '2024-11-14 17:34:22', '2024-11-14 17:34:22', '1', NULL);
COMMIT;

-- ----------------------------
-- Table structure for code_column_config
-- ----------------------------
DROP TABLE IF EXISTS `code_column_config`;
CREATE TABLE `code_column_config` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `table_name` varchar(180) DEFAULT NULL,
  `column_name` varchar(255) DEFAULT NULL,
  `column_type` varchar(255) DEFAULT NULL,
  `dict_name` varchar(255) DEFAULT NULL,
  `extra` varchar(255) DEFAULT NULL,
  `form_show` bit(1) DEFAULT NULL,
  `form_type` varchar(255) DEFAULT NULL,
  `key_type` varchar(255) DEFAULT NULL,
  `list_show` bit(1) DEFAULT NULL,
  `not_null` bit(1) DEFAULT NULL,
  `query_type` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`column_id`) USING BTREE,
  KEY `idx_table_name` (`table_name`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='代码生成字段信息存储';

-- ----------------------------
-- Records of code_column_config
-- ----------------------------
BEGIN;
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (191, 'qrtz_triggers', 'sched_name', 'varchar', NULL, '', b'1', NULL, 'PRI', b'1', b'1', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (192, 'qrtz_triggers', 'trigger_name', 'varchar', NULL, '', b'1', NULL, 'PRI', b'1', b'1', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (193, 'qrtz_triggers', 'trigger_group', 'varchar', NULL, '', b'1', NULL, 'PRI', b'1', b'1', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (194, 'qrtz_triggers', 'job_name', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (195, 'qrtz_triggers', 'job_group', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (196, 'qrtz_triggers', 'description', 'varchar', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (197, 'qrtz_triggers', 'next_fire_time', 'bigint', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (198, 'qrtz_triggers', 'prev_fire_time', 'bigint', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (199, 'qrtz_triggers', 'priority', 'int', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (200, 'qrtz_triggers', 'trigger_state', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (201, 'qrtz_triggers', 'trigger_type', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (202, 'qrtz_triggers', 'start_time', 'bigint', NULL, '', b'1', NULL, '', b'1', b'1', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (203, 'qrtz_triggers', 'end_time', 'bigint', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (204, 'qrtz_triggers', 'calendar_name', 'varchar', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (205, 'qrtz_triggers', 'misfire_instr', 'smallint', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (206, 'qrtz_triggers', 'job_data', 'blob', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (207, 'sys_menu', 'menu_id', 'bigint', NULL, 'auto_increment', b'1', NULL, 'PRI', b'1', b'0', NULL, 'ID');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (208, 'sys_menu', 'pid', 'bigint', NULL, '', b'1', NULL, 'MUL', b'1', b'0', NULL, '上级菜单ID');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (209, 'sys_menu', 'sub_count', 'int', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '子菜单数目');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (210, 'sys_menu', 'type', 'int', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '菜单类型');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (211, 'sys_menu', 'title', 'varchar', NULL, '', b'1', NULL, 'UNI', b'1', b'0', NULL, '菜单标题');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (212, 'sys_menu', 'name', 'varchar', NULL, '', b'1', NULL, 'UNI', b'1', b'0', NULL, '组件名称');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (213, 'sys_menu', 'component', 'varchar', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '组件');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (214, 'sys_menu', 'menu_sort', 'int', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '排序');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (215, 'sys_menu', 'icon', 'varchar', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '图标');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (216, 'sys_menu', 'path', 'varchar', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '链接地址');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (217, 'sys_menu', 'i_frame', 'bit', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '是否外链');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (218, 'sys_menu', 'cache', 'bit', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '缓存');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (219, 'sys_menu', 'hidden', 'bit', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '隐藏');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (220, 'sys_menu', 'permission', 'varchar', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '权限');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (221, 'sys_menu', 'create_by', 'varchar', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '创建者');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (222, 'sys_menu', 'update_by', 'varchar', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '更新者');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (223, 'sys_menu', 'create_time', 'datetime', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '创建日期');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (224, 'sys_menu', 'update_time', 'datetime', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '更新时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (225, 'translation_providers', 'id', 'int', NULL, 'auto_increment', b'0', NULL, 'PRI', b'1', b'1', NULL, '主键');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (226, 'translation_providers', 'provider_name', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, '服务提供商');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (227, 'translation_providers', 'api_key', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, 'API Key');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (228, 'translation_providers', 'api_url', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, 'API Url');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (229, 'translation_providers', 'status', 'tinyint', 'provider_status', '', b'1', 'Select', '', b'1', b'1', NULL, '启用状态');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (230, 'translation_providers', 'additional_config', 'json', NULL, '', b'1', 'Textarea', '', b'1', b'0', NULL, '附加配置信息(headers或特定参数)');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (231, 'translation_providers', 'supported_languages', 'json', NULL, '', b'1', 'Textarea', '', b'1', b'0', NULL, '语言列表');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (232, 'translation_providers', 'created_at', 'timestamp', NULL, 'DEFAULT_GENERATED', b'0', NULL, '', b'1', b'0', NULL, '创建时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (233, 'translation_providers', 'updated_at', 'timestamp', NULL, 'DEFAULT_GENERATED on update CURRENT_TIMESTAMP', b'0', NULL, '', b'1', b'0', NULL, '更新时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (234, 'language_code_mapping', 'id', 'int', NULL, 'auto_increment', b'0', '', 'PRI', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (235, 'language_code_mapping', 'system_language_code', 'varchar', NULL, '', b'1', 'Input', '', b'1', b'1', '=', '系统语言编码');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (236, 'language_code_mapping', 'api_name', 'varchar', 'provider_list', '', b'1', 'Select', '', b'1', b'1', '=', '服务商');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (237, 'language_code_mapping', 'api_language_code', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, 'API语言编码');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (238, 'language_code_mapping', 'created_at', 'timestamp', NULL, '', b'0', NULL, '', b'1', b'0', NULL, '创建时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (239, 'language_code_mapping', 'updated_at', 'timestamp', NULL, '', b'0', NULL, '', b'1', b'0', NULL, '修改时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (240, 'language_list', 'id', 'int', NULL, 'auto_increment', b'0', NULL, 'PRI', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (241, 'language_list', 'code', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', '=', '编码');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (242, 'language_list', 'name', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, '语言');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (243, 'language_list', 'display_name', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', '=', '显示名称');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (244, 'language_list', 'created_at', 'timestamp', NULL, '', b'0', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (245, 'language_list', 'updated_at', 'timestamp', NULL, '', b'0', NULL, '', b'1', b'0', NULL, '');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (246, 'message_cache', 'id', 'bigint', NULL, 'auto_increment', b'0', NULL, 'PRI', b'1', b'0', NULL, 'ID');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (247, 'message_cache', 'source_text', 'text', NULL, '', b'1', NULL, 'MUL', b'1', b'1', NULL, '原文');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (248, 'message_cache', 'language', 'varchar', NULL, '', b'1', 'Input', '', b'1', b'1', '=', '语言');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (249, 'message_cache', 'translated_text', 'text', NULL, '', b'1', NULL, '', b'1', b'0', NULL, '译文');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (250, 'message_cache', 'platform', 'varchar', NULL, '', b'1', NULL, '', b'1', b'1', NULL, '翻译平台');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (251, 'message_cache', 'status', 'varchar', 'translate_status', '', b'1', 'Select', '', b'1', b'1', '=', '状态');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (252, 'message_cache', 'created_at', 'timestamp', NULL, 'DEFAULT_GENERATED', b'0', 'Date', '', b'1', b'0', '=', '创建时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (253, 'message_cache', 'updated_at', 'timestamp', NULL, 'DEFAULT_GENERATED on update CURRENT_TIMESTAMP', b'0', NULL, '', b'1', b'0', NULL, '修改时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (254, 'auth_manage', 'id', 'int', NULL, 'auto_increment', b'0', NULL, 'PRI', b'1', b'0', NULL, 'ID');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (255, 'auth_manage', 'auth_code', 'varchar', NULL, '', b'0', 'Input', 'UNI', b'1', b'0', '=', '授权码');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (256, 'auth_manage', 'machine_code', 'varchar', NULL, '', b'0', 'Input', '', b'1', b'0', '=', '机器码');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (257, 'auth_manage', 'expiry_date', 'timestamp', NULL, '', b'1', 'Date', '', b'1', b'1', '=', '失效时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (258, 'auth_manage', 'available_chars', 'bigint', NULL, '', b'0', NULL, '', b'1', b'0', NULL, '可用字符串');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (259, 'auth_manage', 'total_chars', 'bigint', NULL, '', b'1', NULL, '', b'1', b'1', NULL, '总字符数');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (260, 'auth_manage', 'created_at', 'timestamp', NULL, 'DEFAULT_GENERATED', b'0', 'Date', '', b'1', b'0', '=', '创建时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (261, 'auth_manage', 'updated_at', 'timestamp', NULL, 'DEFAULT_GENERATED on update CURRENT_TIMESTAMP', b'0', 'Date', '', b'1', b'0', '', '修改时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (262, 'auth_manage', 'status', 'varchar', 'enable_status', '', b'1', 'Select', '', b'1', b'1', '=', '状态');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (263, 'auth_manage', 'remarks', 'varchar', NULL, '', b'1', 'Textarea', '', b'1', b'0', NULL, '备注');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (264, 'plugin_code_manage', 'id', 'int', NULL, 'auto_increment', b'1', NULL, 'PRI', b'1', b'0', NULL, 'id');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (265, 'plugin_code_manage', 'platform_name', 'varchar', 'plugin_list', '', b'1', 'Select', '', b'1', b'1', '=', '平台名称');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (266, 'plugin_code_manage', 'js_code', 'text', NULL, '', b'1', 'Textarea', '', b'1', b'0', NULL, 'js代码');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (267, 'plugin_code_manage', 'created_at', 'timestamp', NULL, '', b'0', NULL, '', b'1', b'0', NULL, '创建时间');
INSERT INTO `code_column_config` (`column_id`, `table_name`, `column_name`, `column_type`, `dict_name`, `extra`, `form_show`, `form_type`, `key_type`, `list_show`, `not_null`, `query_type`, `remark`) VALUES (268, 'plugin_code_manage', 'updated_at', 'timestamp', NULL, '', b'0', NULL, '', b'1', b'0', NULL, '修改时间');
COMMIT;

-- ----------------------------
-- Table structure for code_gen_config
-- ----------------------------
DROP TABLE IF EXISTS `code_gen_config`;
CREATE TABLE `code_gen_config` (
  `config_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名',
  `author` varchar(255) DEFAULT NULL COMMENT '作者',
  `cover` bit(1) DEFAULT NULL COMMENT '是否覆盖',
  `module_name` varchar(255) DEFAULT NULL COMMENT '模块名称',
  `pack` varchar(255) DEFAULT NULL COMMENT '至于哪个包下',
  `path` varchar(255) DEFAULT NULL COMMENT '前端代码生成的路径',
  `api_path` varchar(255) DEFAULT NULL COMMENT '前端Api文件路径',
  `prefix` varchar(255) DEFAULT NULL COMMENT '表前缀',
  `api_alias` varchar(255) DEFAULT NULL COMMENT '接口名称',
  PRIMARY KEY (`config_id`) USING BTREE,
  KEY `idx_table_name` (`table_name`(100))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='代码生成器配置';

-- ----------------------------
-- Records of code_gen_config
-- ----------------------------
BEGIN;
INSERT INTO `code_gen_config` (`config_id`, `table_name`, `author`, `cover`, `module_name`, `pack`, `path`, `api_path`, `prefix`, `api_alias`) VALUES (7, 'translation_providers', 'whh', b'0', 'eladmin-translate', 'me.zhengjei', 'provider-manage', 'provider-manage/', NULL, '服务提供商');
INSERT INTO `code_gen_config` (`config_id`, `table_name`, `author`, `cover`, `module_name`, `pack`, `path`, `api_path`, `prefix`, `api_alias`) VALUES (8, 'language_code_mapping', 'whh', b'0', 'eladmin-translate', 'me.zhengjie', 'language-code', 'language-code/', NULL, '语言编码');
INSERT INTO `code_gen_config` (`config_id`, `table_name`, `author`, `cover`, `module_name`, `pack`, `path`, `api_path`, `prefix`, `api_alias`) VALUES (9, 'language_list', 'whh', b'0', 'eladmin-translate', 'me.zhengjie', 'language-list', 'language-list/', NULL, '语言列表');
INSERT INTO `code_gen_config` (`config_id`, `table_name`, `author`, `cover`, `module_name`, `pack`, `path`, `api_path`, `prefix`, `api_alias`) VALUES (10, 'message_cache', 'whh', b'0', 'eladmin-translate', 'me.zhengjie', 'message-cache', 'message-cache/', NULL, '消息缓存');
INSERT INTO `code_gen_config` (`config_id`, `table_name`, `author`, `cover`, `module_name`, `pack`, `path`, `api_path`, `prefix`, `api_alias`) VALUES (11, 'auth_manage', 'whh', b'0', 'eladmin-translate', 'me.zhengjie', 'auth-manage', 'auth-manage/', NULL, '设备授权');
INSERT INTO `code_gen_config` (`config_id`, `table_name`, `author`, `cover`, `module_name`, `pack`, `path`, `api_path`, `prefix`, `api_alias`) VALUES (12, 'plugin_code_manage', 'whh', b'0', 'eladmin-translate', 'me.zhengjie', 'plugin-manage', 'plugin-manage/', NULL, '插件代码');
COMMIT;

-- ----------------------------
-- Table structure for language_code_mapping
-- ----------------------------
DROP TABLE IF EXISTS `language_code_mapping`;
CREATE TABLE `language_code_mapping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `system_language_code` varchar(10) NOT NULL,
  `api_name` varchar(50) NOT NULL,
  `api_language_code` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of language_code_mapping
-- ----------------------------
BEGIN;
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (2, 'zh', 'NiuTrans', 'zh', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (3, 'cht', 'NiuTrans', 'cht', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (4, 'en', 'NiuTrans', 'en', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (5, 'de', 'NiuTrans', 'de', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (6, 'fr', 'NiuTrans', 'fr', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (7, 'es', 'NiuTrans', 'es', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (8, 'ru', 'NiuTrans', 'ru', '2024-10-17 02:41:39', '2024-10-19 19:08:21');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (9, 'ja', 'NiuTrans', 'ja', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (10, 'ko', 'NiuTrans', 'ko', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (11, 'vi', 'NiuTrans', 'vi', '2024-10-17 02:41:39', '2024-10-19 19:08:15');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (12, 'th', 'NiuTrans', 'th', '2024-10-17 02:41:39', '2024-10-19 19:08:12');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (13, 'hi', 'NiuTrans', 'hi', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (14, 'ar', 'NiuTrans', 'ar', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (15, 'pt', 'NiuTrans', 'pt', '2024-10-17 02:41:39', '2024-10-19 20:43:28');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (16, 'it', 'NiuTrans', 'it', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (17, 'pl', 'NiuTrans', 'pl', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (18, 'nl', 'NiuTrans', 'nl', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (19, 'tr', 'NiuTrans', 'tr', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (20, 'el', 'NiuTrans', 'el', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (21, 'fil', 'NiuTrans', 'fil', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (22, 'fi', 'NiuTrans', 'fi', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (23, 'hu', 'NiuTrans', 'hu', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (24, 'sv', 'NiuTrans', 'sv', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (25, 'ms', 'NiuTrans', 'ms', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (26, 'id', 'NiuTrans', 'id', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (27, 'no', 'NiuTrans', 'no', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (28, 'da', 'NiuTrans', 'da', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (29, 'uk', 'NiuTrans', 'uk', '2024-10-17 02:41:39', '2024-10-19 19:08:19');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (30, 'ta', 'NiuTrans', 'ta', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (31, 'ur', 'NiuTrans', 'ur', '2024-10-17 02:41:39', '2024-10-17 02:41:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (91, 'vi', 'HuoShan', 'vi', '2024-10-18 02:30:37', '2024-10-19 19:08:15');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (92, 'th', 'HuoShan', 'th', '2024-10-18 02:30:37', '2024-10-19 19:08:12');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (93, 'hi', 'HuoShan', 'hi', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (94, 'ar', 'HuoShan', 'ar', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (95, 'it', 'HuoShan', 'it', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (96, 'pt', 'HuoShan', 'pt', '2024-10-18 02:30:37', '2024-10-19 20:43:28');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (97, 'ru', 'HuoShan', 'ru', '2024-10-18 02:30:37', '2024-10-19 19:08:21');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (98, 'ko', 'HuoShan', 'ko', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (99, 'ja', 'HuoShan', 'ja', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (100, 'de', 'HuoShan', 'de', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (101, 'fr', 'HuoShan', 'fr', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (102, 'es', 'HuoShan', 'es', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (103, 'en', 'HuoShan', 'en', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (104, 'zh', 'HuoShan', 'zh', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (105, 'zh-TW', 'HuoShan', 'zh-TW', '2024-10-18 02:30:37', '2024-10-19 19:24:32');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (106, 'ug', 'HuoShan', 'ug', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (107, 'yue', 'HuoShan', 'yue', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (108, 'nan', 'HuoShan', 'nan', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (109, 'wuu', 'HuoShan', 'wuu', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (110, 'bo', 'HuoShan', 'bo', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (111, 'fa', 'HuoShan', 'fa', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (112, 'pl', 'HuoShan', 'pl', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (113, 'id', 'HuoShan', 'id', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (114, 'ms', 'HuoShan', 'ms', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (115, 'tr', 'HuoShan', 'tr', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (116, 'uk', 'HuoShan', 'uk', '2024-10-18 02:30:37', '2024-10-19 19:08:19');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (117, 'ta', 'HuoShan', 'ta', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (118, 'te', 'HuoShan', 'te', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (119, 'bn', 'HuoShan', 'bn', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (120, 'my', 'HuoShan', 'my', '2024-10-18 02:30:37', '2024-10-18 02:30:37');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (121, 'vi', 'Baidu', 'vi', '2024-10-18 13:37:45', '2024-10-19 19:08:15');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (122, 'th', 'Baidu', 'th', '2024-10-18 13:37:45', '2024-10-19 19:08:12');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (123, 'hi', 'Baidu', 'hi', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (124, 'ar', 'Baidu', 'ara', '2024-10-18 13:37:45', '2024-10-19 15:14:31');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (125, 'it', 'Baidu', 'it', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (126, 'pt', 'Baidu', 'pt', '2024-10-18 13:37:45', '2024-10-19 20:43:28');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (127, 'ru', 'Baidu', 'ru', '2024-10-18 13:37:45', '2024-10-19 19:08:21');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (128, 'ko', 'Baidu', 'kor', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (129, 'ja', 'Baidu', 'jp', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (130, 'de', 'Baidu', 'de', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (131, 'fr', 'Baidu', 'fra', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (132, 'es', 'Baidu', 'spa', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (133, 'en', 'Baidu', 'en', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (134, 'zh-TW', 'Baidu', 'cht', '2024-10-18 13:37:45', '2024-10-19 19:24:32');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (135, 'zh', 'Baidu', 'zh', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (136, 'ms', 'Baidu', 'may', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (137, 'id', 'Baidu', 'id', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (138, 'pl', 'Baidu', 'pl', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (139, 'nl', 'Baidu', 'nl', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (140, 'ro', 'Baidu', 'ro', '2024-10-18 13:37:45', '2024-10-20 17:28:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (141, 'tr', 'Baidu', 'tr', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (142, 'uk', 'Baidu', 'uk', '2024-10-18 13:37:45', '2024-10-19 19:08:19');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (143, 'el', 'Baidu', 'el', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (144, 'hu', 'Baidu', 'hu', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (145, 'sv', 'Baidu', 'swe', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (146, 'fi', 'Baidu', 'fin', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (147, 'da', 'Baidu', 'dan', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (148, 'cs', 'Baidu', 'cs', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (149, 'bg', 'Baidu', 'bul', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (150, 'he', 'Baidu', 'he', '2024-10-18 13:37:45', '2024-10-18 13:37:45');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (151, 'cs', 'HuoShan', 'cs', '2024-10-19 03:31:43', NULL);
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (152, 'zh-TW', 'NiuTrans', 'cht', '2024-10-19 03:37:39', '2024-10-19 19:24:32');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (155, 'vi', 'YouDao', 'vi', '2024-10-19 03:49:29', '2024-10-19 19:08:15');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (156, 'th', 'YouDao', 'th', '2024-10-19 03:49:29', '2024-10-19 19:08:12');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (157, 'hi', 'YouDao', 'hi', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (158, 'ar', 'YouDao', 'ar', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (159, 'it', 'YouDao', 'it', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (160, 'pt', 'YouDao', 'pt', '2024-10-19 03:49:29', '2024-10-19 20:43:28');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (161, 'ru', 'YouDao', 'ru', '2024-10-19 03:49:29', '2024-10-19 19:08:21');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (162, 'ko', 'YouDao', 'ko', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (163, 'ja', 'YouDao', 'ja', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (164, 'de', 'YouDao', 'de', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (165, 'fr', 'YouDao', 'fr', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (166, 'es', 'YouDao', 'es', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (167, 'en', 'YouDao', 'en', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (168, 'zh-TW', 'YouDao', 'zh-CHT', '2024-10-19 03:49:29', '2024-10-19 19:24:32');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (169, 'zh', 'YouDao', 'zh-CHS', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (170, 'ms', 'YouDao', 'ms', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (171, 'id', 'YouDao', 'id', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (172, 'pl', 'YouDao', 'pl', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (173, 'nl', 'YouDao', 'nl', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (174, 'ro', 'YouDao', 'ro', '2024-10-19 03:49:29', '2024-10-20 17:28:39');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (175, 'tr', 'YouDao', 'tr', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (176, 'uk', 'YouDao', 'uk', '2024-10-19 03:49:29', '2024-10-19 19:08:19');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (177, 'el', 'YouDao', 'el', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (178, 'hu', 'YouDao', 'hu', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (179, 'sv', 'YouDao', 'sv', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (180, 'fi', 'YouDao', 'fi', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (181, 'da', 'YouDao', 'da', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (182, 'cs', 'YouDao', 'cs', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (183, 'bg', 'YouDao', 'bg', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (184, 'he', 'YouDao', 'he', '2024-10-19 03:49:29', '2024-10-19 03:49:29');
INSERT INTO `language_code_mapping` (`id`, `system_language_code`, `api_name`, `api_language_code`, `created_at`, `updated_at`) VALUES (185, 'cs', 'NiuTrans', 'cs', '2024-10-19 03:55:52', '2024-10-19 14:53:01');
COMMIT;

-- ----------------------------
-- Table structure for language_list
-- ----------------------------
DROP TABLE IF EXISTS `language_list`;
CREATE TABLE `language_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of language_list
-- ----------------------------
BEGIN;
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (33, 'he', 'Hebrew', '希伯来语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (34, 'bg', 'Bulgarian', '保加利亚语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (35, 'cs', 'Czech', '捷克语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (36, 'da', 'Danish', '丹麦语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (37, 'fi', 'Finnish', '芬兰语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (38, 'sv', 'Swedish', '瑞典语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (39, 'hu', 'Hungarian', '匈牙利语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (40, 'el', 'Greek', '希腊语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (41, 'uk', 'Ukrainian', '乌克兰语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (42, 'tr', 'Turkish', '土耳其语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (43, 'ro', 'Romanian', '罗马尼亚语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (44, 'nl', 'Dutch', '荷兰语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (45, 'pl', 'Polish', '波兰语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (46, 'id', 'Indonesian', '印尼语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (47, 'ms', 'Malay', '马来语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (48, 'zh', 'Chinese (Simplified)', '简体中文', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (49, 'zh-TW', 'Chinese (Traditional)', '繁体中文', '2024-10-18 16:15:05', '2024-10-19 18:47:02');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (50, 'en', 'English', '英语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (51, 'es', 'Spanish', '西班牙语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (52, 'fr', 'French', '法语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (53, 'de', 'German', '德语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (54, 'ja', 'Japanese', '日语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (55, 'ko', 'Korean', '韩语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (56, 'ru', 'Russian', '俄语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (57, 'pt', 'Portuguese', '葡萄牙语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (58, 'it', 'Italian', '意大利语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (59, 'ar', 'Arabic', '阿拉伯语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (60, 'hi', 'Hindi', '印地语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (61, 'th', 'Thai', '泰语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
INSERT INTO `language_list` (`id`, `code`, `name`, `display_name`, `created_at`, `updated_at`) VALUES (62, 'vi', 'Vietnamese', '越南语', '2024-10-18 16:15:05', '2024-10-18 16:15:05');
COMMIT;

-- ----------------------------
-- Table structure for message_cache
-- ----------------------------
DROP TABLE IF EXISTS `message_cache`;
CREATE TABLE `message_cache` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `source_text` text NOT NULL,
  `language` varchar(10) NOT NULL,
  `translated_text` text,
  `platform` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `auth_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_translation` (`source_text`(255),`language`,`platform`)
) ENGINE=InnoDB AUTO_INCREMENT=3404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of message_cache
-- ----------------------------
BEGIN;
INSERT INTO `message_cache` (`id`, `source_text`, `language`, `translated_text`, `platform`, `status`, `created_at`, `updated_at`, `auth_code`) VALUES (3400, '发的', 'en', NULL, NULL, '0', '2024-10-21 00:27:06', '2024-10-21 00:27:05', '6db91259-156c-4212-b326-dbdbfce9341f');
INSERT INTO `message_cache` (`id`, `source_text`, `language`, `translated_text`, `platform`, `status`, `created_at`, `updated_at`, `auth_code`) VALUES (3401, '你好啊', 'en', 'Hello', 'HuoShan', '1', '2024-10-21 00:27:45', '2024-10-21 00:29:05', '6db91259-156c-4212-b326-dbdbfce9341f');
INSERT INTO `message_cache` (`id`, `source_text`, `language`, `translated_text`, `platform`, `status`, `created_at`, `updated_at`, `auth_code`) VALUES (3402, '你好啊的', 'en', 'Hello.', 'HuoShan', '1', '2024-10-21 00:30:59', '2024-10-21 00:31:02', '6db91259-156c-4212-b326-dbdbfce9341f');
INSERT INTO `message_cache` (`id`, `source_text`, `language`, `translated_text`, `platform`, `status`, `created_at`, `updated_at`, `auth_code`) VALUES (3403, '你好', 'en', NULL, NULL, '0', '2024-11-14 21:22:59', '2024-11-14 21:22:58', '74769085-4c25-4c6e-818f-fcaa82d5ee4d');
COMMIT;

-- ----------------------------
-- Table structure for mnt_app
-- ----------------------------
DROP TABLE IF EXISTS `mnt_app`;
CREATE TABLE `mnt_app` (
  `app_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `upload_path` varchar(255) DEFAULT NULL COMMENT '上传目录',
  `deploy_path` varchar(255) DEFAULT NULL COMMENT '部署路径',
  `backup_path` varchar(255) DEFAULT NULL COMMENT '备份路径',
  `port` int DEFAULT NULL COMMENT '应用端口',
  `start_script` varchar(4000) DEFAULT NULL COMMENT '启动脚本',
  `deploy_script` varchar(4000) DEFAULT NULL COMMENT '部署脚本',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='应用管理';

-- ----------------------------
-- Records of mnt_app
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for mnt_database
-- ----------------------------
DROP TABLE IF EXISTS `mnt_database`;
CREATE TABLE `mnt_database` (
  `db_id` varchar(50) NOT NULL COMMENT 'ID',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `jdbc_url` varchar(255) NOT NULL COMMENT 'jdbc连接',
  `user_name` varchar(255) NOT NULL COMMENT '账号',
  `pwd` varchar(255) NOT NULL COMMENT '密码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`db_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='数据库管理';

-- ----------------------------
-- Records of mnt_database
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for mnt_deploy
-- ----------------------------
DROP TABLE IF EXISTS `mnt_deploy`;
CREATE TABLE `mnt_deploy` (
  `deploy_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `app_id` bigint DEFAULT NULL COMMENT '应用编号',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`deploy_id`) USING BTREE,
  KEY `FK6sy157pseoxx4fmcqr1vnvvhy` (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='部署管理';

-- ----------------------------
-- Records of mnt_deploy
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for mnt_deploy_history
-- ----------------------------
DROP TABLE IF EXISTS `mnt_deploy_history`;
CREATE TABLE `mnt_deploy_history` (
  `history_id` varchar(50) NOT NULL COMMENT 'ID',
  `app_name` varchar(255) NOT NULL COMMENT '应用名称',
  `deploy_date` datetime NOT NULL COMMENT '部署日期',
  `deploy_user` varchar(50) NOT NULL COMMENT '部署用户',
  `ip` varchar(20) NOT NULL COMMENT '服务器IP',
  `deploy_id` bigint DEFAULT NULL COMMENT '部署编号',
  PRIMARY KEY (`history_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='部署历史管理';

-- ----------------------------
-- Records of mnt_deploy_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for mnt_deploy_server
-- ----------------------------
DROP TABLE IF EXISTS `mnt_deploy_server`;
CREATE TABLE `mnt_deploy_server` (
  `deploy_id` bigint NOT NULL COMMENT '部署ID',
  `server_id` bigint NOT NULL COMMENT '服务ID',
  PRIMARY KEY (`deploy_id`,`server_id`) USING BTREE,
  KEY `FKeaaha7jew9a02b3bk9ghols53` (`server_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='应用与服务器关联';

-- ----------------------------
-- Records of mnt_deploy_server
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for mnt_server
-- ----------------------------
DROP TABLE IF EXISTS `mnt_server`;
CREATE TABLE `mnt_server` (
  `server_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `account` varchar(50) DEFAULT NULL COMMENT '账号',
  `ip` varchar(20) DEFAULT NULL COMMENT 'IP地址',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `port` int DEFAULT NULL COMMENT '端口',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`server_id`) USING BTREE,
  KEY `idx_ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='服务器管理';

-- ----------------------------
-- Records of mnt_server
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for plugin_code_manage
-- ----------------------------
DROP TABLE IF EXISTS `plugin_code_manage`;
CREATE TABLE `plugin_code_manage` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `platform_name` varchar(255) DEFAULT NULL COMMENT '平台名称',
  `js_code` text COMMENT 'js代码',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `status` varchar(255) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of plugin_code_manage
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(120) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint NOT NULL,
  `sched_time` bigint NOT NULL,
  `priority` int NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_group` varchar(200) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`),
  KEY `idx_qrtz_ft_trig_inst_name` (`sched_name`,`instance_name`),
  KEY `idx_qrtz_ft_inst_job_req_rcvry` (`sched_name`,`instance_name`,`requests_recovery`),
  KEY `idx_qrtz_ft_j_g` (`sched_name`,`job_name`,`job_group`),
  KEY `idx_qrtz_ft_jg` (`sched_name`,`job_group`),
  KEY `idx_qrtz_ft_t_g` (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `idx_qrtz_ft_tg` (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`),
  KEY `idx_qrtz_j_req_recovery` (`sched_name`,`requests_recovery`),
  KEY `idx_qrtz_j_grp` (`sched_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint NOT NULL,
  `checkin_interval` bigint NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint NOT NULL,
  `repeat_interval` bigint NOT NULL,
  `times_triggered` bigint NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int DEFAULT NULL,
  `int_prop_2` int DEFAULT NULL,
  `long_prop_1` bigint DEFAULT NULL,
  `long_prop_2` bigint DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint DEFAULT NULL,
  `prev_fire_time` bigint DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint NOT NULL,
  `end_time` bigint DEFAULT NULL,
  `calendar_name` varchar(200) DEFAULT NULL,
  `misfire_instr` smallint DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `idx_qrtz_t_j` (`sched_name`,`job_name`,`job_group`),
  KEY `idx_qrtz_t_jg` (`sched_name`,`job_group`),
  KEY `idx_qrtz_t_c` (`sched_name`,`calendar_name`),
  KEY `idx_qrtz_t_g` (`sched_name`,`trigger_group`),
  KEY `idx_qrtz_t_state` (`sched_name`,`trigger_state`),
  KEY `idx_qrtz_t_n_state` (`sched_name`,`trigger_name`,`trigger_group`,`trigger_state`),
  KEY `idx_qrtz_t_n_g_state` (`sched_name`,`trigger_group`,`trigger_state`),
  KEY `idx_qrtz_t_next_fire_time` (`sched_name`,`next_fire_time`),
  KEY `idx_qrtz_t_nft_st` (`sched_name`,`trigger_state`,`next_fire_time`),
  KEY `idx_qrtz_t_nft_misfire` (`sched_name`,`misfire_instr`,`next_fire_time`),
  KEY `idx_qrtz_t_nft_st_misfire` (`sched_name`,`misfire_instr`,`next_fire_time`,`trigger_state`),
  KEY `idx_qrtz_t_nft_st_misfire_grp` (`sched_name`,`misfire_instr`,`next_fire_time`,`trigger_group`,`trigger_state`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` bigint DEFAULT NULL COMMENT '上级部门',
  `sub_count` int DEFAULT '0' COMMENT '子部门数目',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `dept_sort` int DEFAULT '999' COMMENT '排序',
  `enabled` bit(1) NOT NULL COMMENT '状态',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE,
  KEY `inx_pid` (`pid`),
  KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='部门';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (2, 7, 1, '研发部', 3, b'1', 'admin', 'admin', '2019-03-25 09:15:32', '2020-08-02 14:48:47');
INSERT INTO `sys_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (5, 7, 0, '运维部', 4, b'1', 'admin', 'admin', '2019-03-25 09:20:44', '2020-05-17 14:27:27');
INSERT INTO `sys_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (6, 8, 0, '测试部', 6, b'1', 'admin', 'admin', '2019-03-25 09:52:18', '2020-06-08 11:59:21');
INSERT INTO `sys_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (7, NULL, 2, '华南分部', 0, b'1', 'admin', 'admin', '2019-03-25 11:04:50', '2020-06-08 12:08:56');
INSERT INTO `sys_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (8, NULL, 2, '华北分部', 1, b'1', 'admin', 'admin', '2019-03-25 11:04:53', '2020-05-14 12:54:00');
INSERT INTO `sys_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (15, 8, 0, 'UI部门', 7, b'1', 'admin', 'admin', '2020-05-13 22:56:53', '2020-05-14 12:54:13');
INSERT INTO `sys_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (17, 2, 0, '研发一组', 999, b'1', 'admin', 'admin', '2020-08-02 14:49:07', '2020-08-02 14:49:07');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL COMMENT '字典名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='数据字典';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (1, 'user_status', '用户状态', NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `sys_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (4, 'dept_status', '部门状态', NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `sys_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (5, 'job_status', '岗位状态', NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `sys_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (6, 'provider_status', '服务提供商启用状态', 'admin', 'admin', '2024-10-16 19:24:30', '2024-10-16 19:24:30');
INSERT INTO `sys_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (7, 'provider_list', '提供商列表', 'admin', 'admin', '2024-10-16 21:16:04', '2024-10-16 21:16:04');
INSERT INTO `sys_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (8, 'translate_status', '翻译状态', 'admin', 'admin', '2024-10-18 14:18:08', '2024-10-18 14:18:08');
INSERT INTO `sys_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (9, 'enable_status', '授权设备启用状态', 'admin', 'admin', '2024-10-19 21:27:30', '2024-10-19 21:27:30');
INSERT INTO `sys_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (10, 'plugin_list', '插件列表js', 'admin', 'admin', '2024-10-21 15:43:55', '2024-10-21 15:43:55');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_detail`;
CREATE TABLE `sys_dict_detail` (
  `detail_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dict_id` bigint DEFAULT NULL COMMENT '字典id',
  `label` varchar(255) NOT NULL COMMENT '字典标签',
  `value` varchar(255) NOT NULL COMMENT '字典值',
  `dict_sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`detail_id`) USING BTREE,
  KEY `FK5tpkputc6d9nboxojdbgnpmyb` (`dict_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='数据字典详情';

-- ----------------------------
-- Records of sys_dict_detail
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (1, 1, '激活', 'true', 1, NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (2, 1, '禁用', 'false', 2, NULL, NULL, NULL, NULL);
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (3, 4, '启用', 'true', 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (4, 4, '停用', 'false', 2, NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (5, 5, '启用', 'true', 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (6, 5, '停用', 'false', 2, NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (7, 6, '启用', '1', 999, 'admin', 'admin', '2024-10-16 19:24:42', '2024-10-16 19:24:42');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (8, 6, '关闭', '0', 999, 'admin', 'admin', '2024-10-16 19:24:52', '2024-10-16 19:24:52');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (10, 7, 'OpenAI', 'OpenAI', 999, 'admin', 'admin', '2024-10-16 21:16:54', '2024-10-16 21:16:54');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (11, 7, '有道翻译', 'YouDao', 999, 'admin', 'admin', '2024-10-16 21:17:09', '2024-10-16 21:17:09');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (12, 7, '火山翻译', 'HuoShan', 999, 'admin', 'admin', '2024-10-16 21:17:21', '2024-10-16 21:17:21');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (13, 7, '小牛翻译', 'NiuTrans', 999, 'admin', 'admin', '2024-10-17 01:44:16', '2024-10-17 01:44:16');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (14, 7, '百度翻译', 'Baidu', 999, 'admin', 'admin', '2024-10-18 13:23:32', '2024-10-18 13:23:32');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (15, 8, '成功', '1', 999, 'admin', 'admin', '2024-10-18 14:18:42', '2024-10-18 14:18:42');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (16, 8, '失败', '0', 999, 'admin', 'admin', '2024-10-18 14:18:55', '2024-10-18 14:18:55');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (17, 9, '禁用', '0', 999, 'admin', 'admin', '2024-10-19 21:27:58', '2024-10-19 21:27:58');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (18, 9, '启用', '1', 999, 'admin', 'admin', '2024-10-19 21:28:11', '2024-10-19 21:28:11');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (19, 10, 'WhatsApp', 'ws', 999, 'admin', 'admin', '2024-10-21 15:52:46', '2024-10-21 15:52:46');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (20, 10, 'Telegram', 'tg', 999, 'admin', 'admin', '2024-10-21 15:52:58', '2024-10-21 15:52:58');
INSERT INTO `sys_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (21, 10, 'background', 'bg', 999, 'admin', 'admin', '2024-10-22 23:08:12', '2024-10-22 23:08:12');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(180) NOT NULL COMMENT '岗位名称',
  `enabled` bit(1) NOT NULL COMMENT '岗位状态',
  `job_sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`job_id`) USING BTREE,
  UNIQUE KEY `uniq_name` (`name`),
  KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='岗位';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` (`job_id`, `name`, `enabled`, `job_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (8, '人事专员', b'1', 3, NULL, NULL, '2019-03-29 14:52:28', NULL);
INSERT INTO `sys_job` (`job_id`, `name`, `enabled`, `job_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (10, '产品经理', b'1', 4, NULL, NULL, '2019-03-29 14:55:51', NULL);
INSERT INTO `sys_job` (`job_id`, `name`, `enabled`, `job_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (11, '全栈开发', b'1', 2, NULL, 'admin', '2019-03-31 13:39:30', '2020-05-05 11:33:43');
INSERT INTO `sys_job` (`job_id`, `name`, `enabled`, `job_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (12, '软件测试', b'1', 5, NULL, 'admin', '2019-03-31 13:39:43', '2020-05-10 19:56:26');
COMMIT;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `description` varchar(255) DEFAULT NULL,
  `log_type` varchar(10) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `params` text,
  `request_ip` varchar(255) DEFAULT NULL,
  `time` bigint DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `exception_detail` text,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE,
  KEY `log_create_time_index` (`create_time`),
  KEY `inx_log_type` (`log_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6591 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` bigint DEFAULT NULL COMMENT '上级菜单ID',
  `sub_count` int DEFAULT '0' COMMENT '子菜单数目',
  `type` int DEFAULT NULL COMMENT '菜单类型',
  `title` varchar(100) DEFAULT NULL COMMENT '菜单标题',
  `name` varchar(100) DEFAULT NULL COMMENT '组件名称',
  `component` varchar(255) DEFAULT NULL COMMENT '组件',
  `menu_sort` int DEFAULT NULL COMMENT '排序',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `path` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `i_frame` bit(1) DEFAULT NULL COMMENT '是否外链',
  `cache` bit(1) DEFAULT b'0' COMMENT '缓存',
  `hidden` bit(1) DEFAULT b'0' COMMENT '隐藏',
  `permission` varchar(255) DEFAULT NULL COMMENT '权限',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`menu_id`) USING BTREE,
  UNIQUE KEY `uniq_title` (`title`),
  UNIQUE KEY `uniq_name` (`name`),
  KEY `inx_pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='系统菜单';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (1, NULL, 7, 0, '系统管理', NULL, NULL, 1, 'system', 'system', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-18 15:11:29', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (2, 1, 3, 1, '用户管理', 'User', 'system/user/index', 2, 'peoples', 'user', b'0', b'0', b'0', 'user:list', NULL, NULL, '2018-12-18 15:14:44', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (3, 1, 3, 1, '角色管理', 'Role', 'system/role/index', 3, 'role', 'role', b'0', b'0', b'0', 'roles:list', NULL, NULL, '2018-12-18 15:16:07', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (5, 1, 3, 1, '菜单管理', 'Menu', 'system/menu/index', 5, 'menu', 'menu', b'0', b'0', b'0', 'menu:list', NULL, NULL, '2018-12-18 15:17:28', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (6, NULL, 5, 0, '系统监控', NULL, NULL, 10, 'monitor', 'monitor', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-18 15:17:48', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (7, 6, 0, 1, '操作日志', 'Log', 'monitor/log/index', 11, 'log', 'logs', b'0', b'1', b'0', NULL, NULL, 'admin', '2018-12-18 15:18:26', '2020-06-06 13:11:57');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (9, 6, 0, 1, 'SQL监控', 'Sql', 'monitor/sql/index', 18, 'sqlMonitor', 'druid', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-18 15:19:34', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (10, NULL, 5, 0, '组件管理', NULL, NULL, 50, 'zujian', 'components', b'0', b'0', b'0', NULL, NULL, 'admin', '2018-12-19 13:38:16', '2024-10-16 19:33:46');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (11, 10, 0, 1, '图标库', 'Icons', 'components/icons/index', 51, 'icon', 'icon', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-19 13:38:49', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (14, 36, 0, 1, '邮件工具', 'Email', 'tools/email/index', 35, 'email', 'email', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-27 10:13:09', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (15, 10, 0, 1, '富文本', 'Editor', 'components/Editor', 52, 'fwb', 'tinymce', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-27 11:58:25', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (18, 36, 3, 1, '存储管理', 'Storage', 'tools/storage/index', 34, 'qiniu', 'storage', b'0', b'0', b'0', 'storage:list', NULL, NULL, '2018-12-31 11:12:15', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (19, 36, 0, 1, '支付宝工具', 'AliPay', 'tools/aliPay/index', 37, 'alipay', 'aliPay', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-31 14:52:38', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (28, 1, 3, 1, '任务调度', 'Timing', 'system/timing/index', 999, 'timing', 'timing', b'0', b'0', b'0', 'timing:list', NULL, NULL, '2019-01-07 20:34:40', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (30, 36, 0, 1, '代码生成', 'GeneratorIndex', 'generator/index', 32, 'dev', 'generator', b'0', b'1', b'0', NULL, NULL, NULL, '2019-01-11 15:45:55', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (32, 6, 0, 1, '异常日志', 'ErrorLog', 'monitor/log/errorLog', 12, 'error', 'errorLog', b'0', b'0', b'0', NULL, NULL, NULL, '2019-01-13 13:49:03', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (33, 10, 0, 1, 'Markdown', 'Markdown', 'components/MarkDown', 53, 'markdown', 'markdown', b'0', b'0', b'0', NULL, NULL, NULL, '2019-03-08 13:46:44', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (34, 10, 0, 1, 'Yaml编辑器', 'YamlEdit', 'components/YamlEdit', 54, 'dev', 'yaml', b'0', b'0', b'0', NULL, NULL, NULL, '2019-03-08 15:49:40', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (35, 1, 3, 1, '部门管理', 'Dept', 'system/dept/index', 6, 'dept', 'dept', b'0', b'0', b'0', 'dept:list', NULL, NULL, '2019-03-25 09:46:00', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (36, NULL, 7, 0, '系统工具', NULL, '', 30, 'sys-tools', 'sys-tools', b'0', b'0', b'0', NULL, NULL, NULL, '2019-03-29 10:57:35', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (37, 1, 3, 1, '岗位管理', 'Job', 'system/job/index', 7, 'Steve-Jobs', 'job', b'0', b'0', b'0', 'job:list', NULL, NULL, '2019-03-29 13:51:18', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (38, 36, 0, 1, '接口文档', 'Swagger', 'tools/swagger/index', 36, 'swagger', 'swagger2', b'0', b'0', b'0', NULL, NULL, NULL, '2019-03-29 19:57:53', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (39, 1, 3, 1, '字典管理', 'Dict', 'system/dict/index', 8, 'dictionary', 'dict', b'0', b'0', b'0', 'dict:list', NULL, NULL, '2019-04-10 11:49:04', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (41, 6, 0, 1, '在线用户', 'OnlineUser', 'monitor/online/index', 10, 'Steve-Jobs', 'online', b'0', b'0', b'0', NULL, NULL, NULL, '2019-10-26 22:08:43', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (44, 2, 0, 2, '用户新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'user:add', NULL, NULL, '2019-10-29 10:59:46', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (45, 2, 0, 2, '用户编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'user:edit', NULL, NULL, '2019-10-29 11:00:08', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (46, 2, 0, 2, '用户删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'user:del', NULL, NULL, '2019-10-29 11:00:23', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (48, 3, 0, 2, '角色创建', NULL, '', 2, '', '', b'0', b'0', b'0', 'roles:add', NULL, NULL, '2019-10-29 12:45:34', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (49, 3, 0, 2, '角色修改', NULL, '', 3, '', '', b'0', b'0', b'0', 'roles:edit', NULL, NULL, '2019-10-29 12:46:16', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (50, 3, 0, 2, '角色删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'roles:del', NULL, NULL, '2019-10-29 12:46:51', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (52, 5, 0, 2, '菜单新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'menu:add', NULL, NULL, '2019-10-29 12:55:07', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (53, 5, 0, 2, '菜单编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'menu:edit', NULL, NULL, '2019-10-29 12:55:40', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (54, 5, 0, 2, '菜单删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'menu:del', NULL, NULL, '2019-10-29 12:56:00', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (56, 35, 0, 2, '部门新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'dept:add', NULL, NULL, '2019-10-29 12:57:09', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (57, 35, 0, 2, '部门编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'dept:edit', NULL, NULL, '2019-10-29 12:57:27', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (58, 35, 0, 2, '部门删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'dept:del', NULL, NULL, '2019-10-29 12:57:41', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (60, 37, 0, 2, '岗位新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'job:add', NULL, NULL, '2019-10-29 12:58:27', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (61, 37, 0, 2, '岗位编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'job:edit', NULL, NULL, '2019-10-29 12:58:45', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (62, 37, 0, 2, '岗位删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'job:del', NULL, NULL, '2019-10-29 12:59:04', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (64, 39, 0, 2, '字典新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'dict:add', NULL, NULL, '2019-10-29 13:00:17', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (65, 39, 0, 2, '字典编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'dict:edit', NULL, NULL, '2019-10-29 13:00:42', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (66, 39, 0, 2, '字典删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'dict:del', NULL, NULL, '2019-10-29 13:00:59', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (73, 28, 0, 2, '任务新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'timing:add', NULL, NULL, '2019-10-29 13:07:28', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (74, 28, 0, 2, '任务编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'timing:edit', NULL, NULL, '2019-10-29 13:07:41', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (75, 28, 0, 2, '任务删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'timing:del', NULL, NULL, '2019-10-29 13:07:54', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (77, 18, 0, 2, '上传文件', NULL, '', 2, '', '', b'0', b'0', b'0', 'storage:add', NULL, NULL, '2019-10-29 13:09:09', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (78, 18, 0, 2, '文件编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'storage:edit', NULL, NULL, '2019-10-29 13:09:22', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (79, 18, 0, 2, '文件删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'storage:del', NULL, NULL, '2019-10-29 13:09:34', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (80, 6, 0, 1, '服务监控', 'ServerMonitor', 'monitor/server/index', 14, 'codeConsole', 'server', b'0', b'0', b'0', 'monitor:list', NULL, 'admin', '2019-11-07 13:06:39', '2020-05-04 18:20:50');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (82, 36, 0, 1, '生成配置', 'GeneratorConfig', 'generator/config', 33, 'dev', 'generator/config/:tableName', b'0', b'1', b'1', '', NULL, NULL, '2019-11-17 20:08:56', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (83, 10, 0, 1, '图表库', 'Echarts', 'components/Echarts', 50, 'chart', 'echarts', b'0', b'1', b'0', '', NULL, NULL, '2019-11-21 09:04:32', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (90, NULL, 5, 1, '运维管理', 'Mnt', '', 20, 'mnt', 'mnt', b'0', b'0', b'0', NULL, NULL, NULL, '2019-11-09 10:31:08', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (92, 90, 3, 1, '服务器', 'ServerDeploy', 'mnt/server/index', 22, 'server', 'mnt/serverDeploy', b'0', b'0', b'0', 'serverDeploy:list', NULL, NULL, '2019-11-10 10:29:25', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (93, 90, 3, 1, '应用管理', 'App', 'mnt/app/index', 23, 'app', 'mnt/app', b'0', b'0', b'0', 'app:list', NULL, NULL, '2019-11-10 11:05:16', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (94, 90, 3, 1, '部署管理', 'Deploy', 'mnt/deploy/index', 24, 'deploy', 'mnt/deploy', b'0', b'0', b'0', 'deploy:list', NULL, NULL, '2019-11-10 15:56:55', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (97, 90, 1, 1, '部署备份', 'DeployHistory', 'mnt/deployHistory/index', 25, 'backup', 'mnt/deployHistory', b'0', b'0', b'0', 'deployHistory:list', NULL, NULL, '2019-11-10 16:49:44', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (98, 90, 3, 1, '数据库管理', 'Database', 'mnt/database/index', 26, 'database', 'mnt/database', b'0', b'0', b'0', 'database:list', NULL, NULL, '2019-11-10 20:40:04', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (102, 97, 0, 2, '删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'deployHistory:del', NULL, NULL, '2019-11-17 09:32:48', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (103, 92, 0, 2, '服务器新增', NULL, '', 999, '', '', b'0', b'0', b'0', 'serverDeploy:add', NULL, NULL, '2019-11-17 11:08:33', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (104, 92, 0, 2, '服务器编辑', NULL, '', 999, '', '', b'0', b'0', b'0', 'serverDeploy:edit', NULL, NULL, '2019-11-17 11:08:57', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (105, 92, 0, 2, '服务器删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'serverDeploy:del', NULL, NULL, '2019-11-17 11:09:15', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (106, 93, 0, 2, '应用新增', NULL, '', 999, '', '', b'0', b'0', b'0', 'app:add', NULL, NULL, '2019-11-17 11:10:03', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (107, 93, 0, 2, '应用编辑', NULL, '', 999, '', '', b'0', b'0', b'0', 'app:edit', NULL, NULL, '2019-11-17 11:10:28', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (108, 93, 0, 2, '应用删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'app:del', NULL, NULL, '2019-11-17 11:10:55', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (109, 94, 0, 2, '部署新增', NULL, '', 999, '', '', b'0', b'0', b'0', 'deploy:add', NULL, NULL, '2019-11-17 11:11:22', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (110, 94, 0, 2, '部署编辑', NULL, '', 999, '', '', b'0', b'0', b'0', 'deploy:edit', NULL, NULL, '2019-11-17 11:11:41', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (111, 94, 0, 2, '部署删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'deploy:del', NULL, NULL, '2019-11-17 11:12:01', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (112, 98, 0, 2, '数据库新增', NULL, '', 999, '', '', b'0', b'0', b'0', 'database:add', NULL, NULL, '2019-11-17 11:12:43', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (113, 98, 0, 2, '数据库编辑', NULL, '', 999, '', '', b'0', b'0', b'0', 'database:edit', NULL, NULL, '2019-11-17 11:12:58', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (114, 98, 0, 2, '数据库删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'database:del', NULL, NULL, '2019-11-17 11:13:14', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (116, 36, 0, 1, '生成预览', 'Preview', 'generator/preview', 999, 'java', 'generator/preview/:tableName', b'0', b'1', b'1', NULL, NULL, NULL, '2019-11-26 14:54:36', NULL);
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (118, NULL, 3, 0, '翻译配置', NULL, NULL, 999, 'anq', 'translate', b'0', b'0', b'0', NULL, 'admin', 'admin', '2024-10-16 19:34:41', '2024-10-16 19:34:41');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (119, 118, 5, 1, '平台管理', NULL, 'provider-manage/index', 999, 'Steve-Jobs', 'provider-manage', b'0', b'0', b'0', NULL, 'admin', 'admin', '2024-10-16 19:44:50', '2024-10-16 19:44:50');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (120, 118, 1, 1, '编码管理', NULL, 'language-code/index', 999, 'chain', 'language-code-manage', b'0', b'0', b'0', 'languageCodeMapping:list', 'admin', 'admin', '2024-10-16 22:37:53', '2024-10-16 22:37:53');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (121, 118, 2, 1, '语言管理', NULL, 'language-list', 999, 'menu', 'language-list', b'0', b'0', b'0', 'languageList:list', 'admin', 'admin', '2024-10-16 23:16:08', '2024-10-16 23:16:08');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (122, NULL, 1, 0, '翻译管理', NULL, NULL, 997, 'message', 'message', b'0', b'0', b'0', NULL, 'admin', 'admin', '2024-10-18 14:37:44', '2024-10-18 14:37:44');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (123, 122, 0, 1, '翻译记录', NULL, 'message-cache/index', 999, 'codeConsole', 'record', b'0', b'0', b'0', NULL, 'admin', 'admin', '2024-10-18 14:39:17', '2024-10-18 14:39:17');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (124, 120, 0, 2, '查询指定编码数据', NULL, NULL, 999, NULL, NULL, b'0', b'0', b'0', 'getLanguageMappingByCode:query', 'admin', 'admin', '2024-10-19 17:49:28', '2024-10-19 17:49:28');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (125, NULL, 1, 0, '授权管理', NULL, NULL, 995, 'blog', 'auth', b'0', b'0', b'0', NULL, 'admin', 'admin', '2024-10-19 20:49:57', '2024-10-19 20:49:57');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (126, 125, 0, 1, '设备列表', NULL, 'auth-manage/index', 999, 'tree-table', 'equipment-list', b'0', b'0', b'0', 'authManage:list', 'admin', 'admin', '2024-10-19 20:59:00', '2024-10-19 20:59:00');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (127, NULL, 1, 0, '插件管理', NULL, NULL, 993, 'dev', 'plugin', b'0', b'0', b'0', NULL, 'admin', 'admin', '2024-10-21 15:40:39', '2024-10-21 15:40:39');
INSERT INTO `sys_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (128, 127, 0, 1, '代码管理', NULL, 'plugin-manage', 999, 'tools', 'code-manage', b'0', b'0', b'0', 'pluginCodeManage:list', 'admin', 'admin', '2024-10-21 16:07:41', '2024-10-21 16:07:41');
COMMIT;

-- ----------------------------
-- Table structure for sys_quartz_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_quartz_job`;
CREATE TABLE `sys_quartz_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bean_name` varchar(255) DEFAULT NULL COMMENT 'Spring Bean名称',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron 表达式',
  `is_pause` bit(1) DEFAULT NULL COMMENT '状态：1暂停、0启用',
  `job_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `method_name` varchar(255) DEFAULT NULL COMMENT '方法名称',
  `params` varchar(255) DEFAULT NULL COMMENT '参数',
  `description` varchar(255) DEFAULT NULL COMMENT '备注',
  `person_in_charge` varchar(100) DEFAULT NULL COMMENT '负责人',
  `email` varchar(100) DEFAULT NULL COMMENT '报警邮箱',
  `sub_task` varchar(100) DEFAULT NULL COMMENT '子任务ID',
  `pause_after_failure` bit(1) DEFAULT NULL COMMENT '任务失败后是否暂停',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`job_id`) USING BTREE,
  KEY `inx_is_pause` (`is_pause`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='定时任务';

-- ----------------------------
-- Records of sys_quartz_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_quartz_job` (`job_id`, `bean_name`, `cron_expression`, `is_pause`, `job_name`, `method_name`, `params`, `description`, `person_in_charge`, `email`, `sub_task`, `pause_after_failure`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (2, 'testTask', '0/5 * * * * ?', b'1', '测试1', 'run1', 'test', '带参测试，多参使用json', '测试', NULL, NULL, NULL, NULL, 'admin', '2019-08-22 14:08:29', '2020-05-24 13:58:33');
INSERT INTO `sys_quartz_job` (`job_id`, `bean_name`, `cron_expression`, `is_pause`, `job_name`, `method_name`, `params`, `description`, `person_in_charge`, `email`, `sub_task`, `pause_after_failure`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (3, 'testTask', '0/5 * * * * ?', b'1', '测试', 'run', '', '不带参测试', 'Zheng Jie', '', '5,6', b'1', NULL, 'admin', '2019-09-26 16:44:39', '2020-05-24 14:48:12');
INSERT INTO `sys_quartz_job` (`job_id`, `bean_name`, `cron_expression`, `is_pause`, `job_name`, `method_name`, `params`, `description`, `person_in_charge`, `email`, `sub_task`, `pause_after_failure`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (5, 'Test', '0/5 * * * * ?', b'1', '任务告警测试', 'run', NULL, '测试', 'test', '', NULL, b'1', 'admin', 'admin', '2020-05-05 20:32:41', '2020-05-05 20:36:13');
INSERT INTO `sys_quartz_job` (`job_id`, `bean_name`, `cron_expression`, `is_pause`, `job_name`, `method_name`, `params`, `description`, `person_in_charge`, `email`, `sub_task`, `pause_after_failure`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (6, 'testTask', '0/5 * * * * ?', b'1', '测试3', 'run2', NULL, '测试3', 'Zheng Jie', '', NULL, b'1', 'admin', 'admin', '2020-05-05 20:35:41', '2020-05-05 20:36:07');
COMMIT;

-- ----------------------------
-- Table structure for sys_quartz_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_quartz_log`;
CREATE TABLE `sys_quartz_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bean_name` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  `exception_detail` text,
  `is_success` bit(1) DEFAULT NULL,
  `job_name` varchar(255) DEFAULT NULL,
  `method_name` varchar(255) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  `time` bigint DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='定时任务日志';

-- ----------------------------
-- Records of sys_quartz_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `level` int DEFAULT NULL COMMENT '角色级别',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `data_scope` varchar(255) DEFAULT NULL COMMENT '数据权限',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE KEY `uniq_name` (`name`),
  KEY `role_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`role_id`, `name`, `level`, `description`, `data_scope`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (1, '超级管理员', 1, '-', '全部', NULL, 'admin', '2018-11-23 11:04:37', '2020-08-06 16:10:24');
INSERT INTO `sys_role` (`role_id`, `name`, `level`, `description`, `data_scope`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (2, '普通用户', 2, '-', '本级', NULL, 'admin', '2018-11-23 13:09:06', '2020-09-05 10:45:12');
COMMIT;

-- ----------------------------
-- Table structure for sys_roles_depts
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles_depts`;
CREATE TABLE `sys_roles_depts` (
  `role_id` bigint NOT NULL,
  `dept_id` bigint NOT NULL,
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE,
  KEY `FK7qg6itn5ajdoa9h9o78v9ksur` (`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='角色部门关联';

-- ----------------------------
-- Records of sys_roles_depts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_roles_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles_menus`;
CREATE TABLE `sys_roles_menus` (
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`menu_id`,`role_id`) USING BTREE,
  KEY `FKcngg2qadojhi3a651a5adkvbq` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='角色菜单关联';

-- ----------------------------
-- Records of sys_roles_menus
-- ----------------------------
BEGIN;
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (1, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (2, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (3, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (5, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (6, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (7, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (9, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (10, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (11, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (14, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (15, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (18, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (19, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (28, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (30, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (32, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (33, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (34, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (35, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (36, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (37, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (38, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (39, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (41, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (44, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (45, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (46, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (48, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (49, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (50, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (52, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (53, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (54, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (56, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (57, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (58, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (60, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (61, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (62, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (64, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (65, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (66, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (73, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (74, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (75, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (77, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (78, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (79, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (80, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (82, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (83, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (90, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (92, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (93, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (94, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (97, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (98, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (102, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (103, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (104, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (105, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (106, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (107, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (108, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (109, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (110, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (111, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (112, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (113, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (114, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (116, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (118, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (119, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (120, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (121, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (122, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (123, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (124, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (125, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (126, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (127, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (128, 1);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (1, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (2, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (6, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (7, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (9, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (10, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (11, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (14, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (15, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (19, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (30, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (32, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (33, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (34, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (36, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (80, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (82, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (83, 2);
INSERT INTO `sys_roles_menus` (`menu_id`, `role_id`) VALUES (116, 2);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门名称',
  `username` varchar(180) DEFAULT NULL COMMENT '用户名',
  `nick_name` varchar(255) DEFAULT NULL COMMENT '昵称',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(180) DEFAULT NULL COMMENT '邮箱',
  `avatar_name` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `avatar_path` varchar(255) DEFAULT NULL COMMENT '头像真实路径',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `is_admin` bit(1) DEFAULT b'0' COMMENT '是否为admin账号',
  `enabled` bit(1) DEFAULT NULL COMMENT '状态：1启用、0禁用',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `pwd_reset_time` datetime DEFAULT NULL COMMENT '修改密码的时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `UK_kpubos9gc2cvtkb0thktkbkes` (`email`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `uniq_username` (`username`),
  UNIQUE KEY `uniq_email` (`email`),
  KEY `FK5rwmryny6jthaaxkogownknqp` (`dept_id`) USING BTREE,
  KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='系统用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`user_id`, `dept_id`, `username`, `nick_name`, `gender`, `phone`, `email`, `avatar_name`, `avatar_path`, `password`, `is_admin`, `enabled`, `create_by`, `update_by`, `pwd_reset_time`, `create_time`, `update_time`) VALUES (1, 2, 'admin', '管理员', '男', '18888888888', '201507802@qq.com', 'avatar-20241016022046708.png', '/Users/mr/IdeaProjects/eladmin-mp/classpath:avatar/avatar-20241016022046708.png', '$2a$10$Egp1/gvFlt7zhlXVfEFw4OfWQCGPw0ClmMcc6FjTnvXNRVf9zdMRa', b'1', b'1', NULL, 'admin', '2020-05-03 16:38:31', '2018-08-23 09:11:56', '2020-09-05 10:43:31');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `username`, `nick_name`, `gender`, `phone`, `email`, `avatar_name`, `avatar_path`, `password`, `is_admin`, `enabled`, `create_by`, `update_by`, `pwd_reset_time`, `create_time`, `update_time`) VALUES (2, 2, 'test', '测试', '男', '19999999999', '231@qq.com', NULL, NULL, '$2a$10$4XcyudOYTSz6fue6KFNMHeUQnCX5jbBQypLEnGk1PmekXt5c95JcK', b'0', b'1', 'admin', 'admin', NULL, '2020-05-05 11:15:49', '2020-09-05 10:43:38');
COMMIT;

-- ----------------------------
-- Table structure for sys_users_jobs
-- ----------------------------
DROP TABLE IF EXISTS `sys_users_jobs`;
CREATE TABLE `sys_users_jobs` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `job_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of sys_users_jobs
-- ----------------------------
BEGIN;
INSERT INTO `sys_users_jobs` (`user_id`, `job_id`) VALUES (1, 11);
INSERT INTO `sys_users_jobs` (`user_id`, `job_id`) VALUES (2, 12);
COMMIT;

-- ----------------------------
-- Table structure for sys_users_roles
-- ----------------------------
DROP TABLE IF EXISTS `sys_users_roles`;
CREATE TABLE `sys_users_roles` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `FKq4eq273l04bpu4efj0jd0jb98` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='用户角色关联';

-- ----------------------------
-- Records of sys_users_roles
-- ----------------------------
BEGIN;
INSERT INTO `sys_users_roles` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `sys_users_roles` (`user_id`, `role_id`) VALUES (2, 2);
COMMIT;

-- ----------------------------
-- Table structure for tool_alipay_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_alipay_config`;
CREATE TABLE `tool_alipay_config` (
  `config_id` bigint NOT NULL COMMENT 'ID',
  `app_id` varchar(255) DEFAULT NULL COMMENT '应用ID',
  `charset` varchar(255) DEFAULT NULL COMMENT '编码',
  `format` varchar(255) DEFAULT NULL COMMENT '类型 固定格式json',
  `gateway_url` varchar(255) DEFAULT NULL COMMENT '网关地址',
  `notify_url` varchar(255) DEFAULT NULL COMMENT '异步回调',
  `private_key` text COMMENT '私钥',
  `public_key` text COMMENT '公钥',
  `return_url` varchar(255) DEFAULT NULL COMMENT '回调地址',
  `sign_type` varchar(255) DEFAULT NULL COMMENT '签名方式',
  `sys_service_provider_id` varchar(255) DEFAULT NULL COMMENT '商户号',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='支付宝配置类';

-- ----------------------------
-- Records of tool_alipay_config
-- ----------------------------
BEGIN;
INSERT INTO `tool_alipay_config` (`config_id`, `app_id`, `charset`, `format`, `gateway_url`, `notify_url`, `private_key`, `public_key`, `return_url`, `sign_type`, `sys_service_provider_id`) VALUES (1, '2016091700532697', 'utf-8', 'JSON', 'https://openapi.alipaydev.com/gateway.do', 'http://api.auauz.net/api/aliPay/notify', 'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC5js8sInU10AJ0cAQ8UMMyXrQ+oHZEkVt5lBwsStmTJ7YikVYgbskx1YYEXTojRsWCb+SH/kDmDU4pK/u91SJ4KFCRMF2411piYuXU/jF96zKrADznYh/zAraqT6hvAIVtQAlMHN53nx16rLzZ/8jDEkaSwT7+HvHiS+7sxSojnu/3oV7BtgISoUNstmSe8WpWHOaWv19xyS+Mce9MY4BfseFhzTICUymUQdd/8hXA28/H6osUfAgsnxAKv7Wil3aJSgaJczWuflYOve0dJ3InZkhw5Cvr0atwpk8YKBQjy5CdkoHqvkOcIB+cYHXJKzOE5tqU7inSwVbHzOLQ3XbnAgMBAAECggEAVJp5eT0Ixg1eYSqFs9568WdetUNCSUchNxDBu6wxAbhUgfRUGZuJnnAll63OCTGGck+EGkFh48JjRcBpGoeoHLL88QXlZZbC/iLrea6gcDIhuvfzzOffe1RcZtDFEj9hlotg8dQj1tS0gy9pN9g4+EBH7zeu+fyv+qb2e/v1l6FkISXUjpkD7RLQr3ykjiiEw9BpeKb7j5s7Kdx1NNIzhkcQKNqlk8JrTGDNInbDM6inZfwwIO2R1DHinwdfKWkvOTODTYa2MoAvVMFT9Bec9FbLpoWp7ogv1JMV9svgrcF9XLzANZ/OQvkbe9TV9GWYvIbxN6qwQioKCWO4GPnCAQKBgQDgW5MgfhX8yjXqoaUy/d1VjI8dHeIyw8d+OBAYwaxRSlCfyQ+tieWcR2HdTzPca0T0GkWcKZm0ei5xRURgxt4DUDLXNh26HG0qObbtLJdu/AuBUuCqgOiLqJ2f1uIbrz6OZUHns+bT/jGW2Ws8+C13zTCZkZt9CaQsrp3QOGDx5wKBgQDTul39hp3ZPwGNFeZdkGoUoViOSd5Lhowd5wYMGAEXWRLlU8z+smT5v0POz9JnIbCRchIY2FAPKRdVTICzmPk2EPJFxYTcwaNbVqL6lN7J2IlXXMiit5QbiLauo55w7plwV6LQmKm9KV7JsZs5XwqF7CEovI7GevFzyD3w+uizAQKBgC3LY1eRhOlpWOIAhpjG6qOoohmeXOphvdmMlfSHq6WYFqbWwmV4rS5d/6LNpNdL6fItXqIGd8I34jzql49taCmi+A2nlR/E559j0mvM20gjGDIYeZUz5MOE8k+K6/IcrhcgofgqZ2ZED1ksHdB/E8DNWCswZl16V1FrfvjeWSNnAoGAMrBplCrIW5xz+J0Hm9rZKrs+AkK5D4fUv8vxbK/KgxZ2KaUYbNm0xv39c+PZUYuFRCz1HDGdaSPDTE6WeWjkMQd5mS6ikl9hhpqFRkyh0d0fdGToO9yLftQKOGE/q3XUEktI1XvXF0xyPwNgUCnq0QkpHyGVZPtGFxwXiDvpvgECgYA5PoB+nY8iDiRaJNko9w0hL4AeKogwf+4TbCw+KWVEn6jhuJa4LFTdSqp89PktQaoVpwv92el/AhYjWOl/jVCm122f9b7GyoelbjMNolToDwe5pF5RnSpEuDdLy9MfE8LnE3PlbE7E5BipQ3UjSebkgNboLHH/lNZA5qvEtvbfvQ==', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAut9evKRuHJ/2QNfDlLwvN/S8l9hRAgPbb0u61bm4AtzaTGsLeMtScetxTWJnVvAVpMS9luhEJjt+Sbk5TNLArsgzzwARgaTKOLMT1TvWAK5EbHyI+eSrc3s7Awe1VYGwcubRFWDm16eQLv0k7iqiw+4mweHSz/wWyvBJVgwLoQ02btVtAQErCfSJCOmt0Q/oJQjj08YNRV4EKzB19+f5A+HQVAKy72dSybTzAK+3FPtTtNen/+b5wGeat7c32dhYHnGorPkPeXLtsqqUTp1su5fMfd4lElNdZaoCI7osZxWWUo17vBCZnyeXc9fk0qwD9mK6yRAxNbrY72Xx5VqIqwIDAQAB', 'http://api.auauz.net/api/aliPay/return', 'RSA2', '2088102176044281');
COMMIT;

-- ----------------------------
-- Table structure for tool_email_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_email_config`;
CREATE TABLE `tool_email_config` (
  `config_id` bigint NOT NULL COMMENT 'ID',
  `from_user` varchar(255) DEFAULT NULL COMMENT '收件人',
  `host` varchar(255) DEFAULT NULL COMMENT '邮件服务器SMTP地址',
  `pass` varchar(255) DEFAULT NULL COMMENT '密码',
  `port` varchar(255) DEFAULT NULL COMMENT '端口',
  `user` varchar(255) DEFAULT NULL COMMENT '发件者用户名',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='邮箱配置';

-- ----------------------------
-- Records of tool_email_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tool_local_storage
-- ----------------------------
DROP TABLE IF EXISTS `tool_local_storage`;
CREATE TABLE `tool_local_storage` (
  `storage_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `real_name` varchar(255) DEFAULT NULL COMMENT '文件真实的名称',
  `name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `suffix` varchar(255) DEFAULT NULL COMMENT '后缀',
  `path` varchar(255) DEFAULT NULL COMMENT '路径',
  `type` varchar(255) DEFAULT NULL COMMENT '类型',
  `size` varchar(100) DEFAULT NULL COMMENT '大小',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`storage_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='本地存储';

-- ----------------------------
-- Records of tool_local_storage
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tool_qiniu_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_qiniu_config`;
CREATE TABLE `tool_qiniu_config` (
  `config_id` bigint NOT NULL COMMENT 'ID',
  `access_key` text COMMENT 'accessKey',
  `bucket` varchar(255) DEFAULT NULL COMMENT 'Bucket 识别符',
  `host` varchar(255) NOT NULL COMMENT '外链域名',
  `secret_key` text COMMENT 'secretKey',
  `type` varchar(255) DEFAULT NULL COMMENT '空间类型',
  `zone` varchar(255) DEFAULT NULL COMMENT '机房',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='七牛云配置';

-- ----------------------------
-- Records of tool_qiniu_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tool_qiniu_content
-- ----------------------------
DROP TABLE IF EXISTS `tool_qiniu_content`;
CREATE TABLE `tool_qiniu_content` (
  `content_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bucket` varchar(255) DEFAULT NULL COMMENT 'Bucket 识别符',
  `name` varchar(180) DEFAULT NULL COMMENT '文件名称',
  `size` varchar(255) DEFAULT NULL COMMENT '文件大小',
  `type` varchar(255) DEFAULT NULL COMMENT '文件类型：私有或公开',
  `url` varchar(255) DEFAULT NULL COMMENT '文件url',
  `suffix` varchar(255) DEFAULT NULL COMMENT '文件后缀',
  `update_time` datetime DEFAULT NULL COMMENT '上传或同步的时间',
  PRIMARY KEY (`content_id`) USING BTREE,
  UNIQUE KEY `uniq_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='七牛云文件存储';

-- ----------------------------
-- Records of tool_qiniu_content
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for translation_providers
-- ----------------------------
DROP TABLE IF EXISTS `translation_providers`;
CREATE TABLE `translation_providers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_name` varchar(100) NOT NULL,
  `api_key` varchar(255) NOT NULL,
  `api_url` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT '1',
  `additional_config` varchar(255) DEFAULT NULL,
  `supported_languages` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of translation_providers
-- ----------------------------
BEGIN;
INSERT INTO `translation_providers` (`id`, `provider_name`, `api_key`, `api_url`, `status`, `additional_config`, `supported_languages`, `created_at`, `updated_at`) VALUES (2, 'OpenAI', 'sk-e-eee', 'https://api.openai.com/v1/chat/completions', '0', NULL, NULL, '2024-10-16 20:22:06', '2024-11-14 16:53:52');
INSERT INTO `translation_providers` (`id`, `provider_name`, `api_key`, `api_url`, `status`, `additional_config`, `supported_languages`, `created_at`, `updated_at`) VALUES (3, 'YouDao', 'dd', 'https://openapi.youdao.com/api', '0', '{\n\"appKey\":\"dd\"\n}', NULL, '2024-10-17 01:16:39', '2024-11-14 16:53:42');
INSERT INTO `translation_providers` (`id`, `provider_name`, `api_key`, `api_url`, `status`, `additional_config`, `supported_languages`, `created_at`, `updated_at`) VALUES (5, 'NiuTrans', 'ccc', 'https://api.niutrans.com/NiuTransServer/translation', '0', NULL, NULL, '2024-10-17 01:56:29', '2024-11-14 16:53:33');
INSERT INTO `translation_providers` (`id`, `provider_name`, `api_key`, `api_url`, `status`, `additional_config`, `supported_languages`, `created_at`, `updated_at`) VALUES (6, 'HuoShan', 'bb', 'https://translate.volcengineapi.com', '0', '{\"sk\":\"bb==\"}', NULL, '2024-10-17 20:18:43', '2024-11-14 20:48:20');
INSERT INTO `translation_providers` (`id`, `provider_name`, `api_key`, `api_url`, `status`, `additional_config`, `supported_languages`, `created_at`, `updated_at`) VALUES (7, 'Baidu', 'aa', 'https://fanyi-api.baidu.com/api/trans/vip/translate', '0', '{\"appId\":\"fdfd\"}', NULL, '2024-10-18 13:25:08', '2024-11-14 20:48:17');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
