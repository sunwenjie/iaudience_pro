
 --iaudience表结构设计

 --iaudience表结构设计
CREATE TABLE `iau_audience_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL COMMENT '客户ID',
  `name` varchar(255) NOT NULL COMMENT '人群包名称',
  `category_id` int(11) NOT NULL COMMENT '行业id',
  `advanced_setting_id` int(11) DEFAULT NULL COMMENT '高级设置id',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` int(11) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` int(11) NOT NULL COMMENT '更新者',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='人群包设置主表';
alter table iau_audience_plan add column analyse_status tinyint(1) default 0;

CREATE TABLE `iau_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '品牌名称',
  `is_competitor` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是竞争品牌',
  `audience_plan_id` int(11) DEFAULT NULL COMMENT 'audience_plan id',
  `key_words` varchar(255) NOT NULL COMMENT '关键词描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='品牌表';

CREATE TABLE `iau_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL DEFAULT '' COMMENT '产品行业',
  `name` varchar(255) NOT NULL COMMENT '产品名称',
  `brand_id` int(11) DEFAULT NULL COMMENT '产品id',
  `key_words` varchar(255) NOT NULL COMMENT '关键词描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='产品表';





CREATE TABLE `iau_advanced_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key_words` varchar(255) NOT NULL COMMENT '关键词描述',
  `city` varchar(255) NOT NULL COMMENT '城市',
  `location` text NOT NULL COMMENT '位置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='高级优化设置表';

CREATE TABLE iau_audience_news (
  id int(11) NOT NULL AUTO_INCREMENT,
  audience_plan_id int(11) NOT NULL,
  type tinyint(1) NOT NULL COMMENT '1-key:market,2-key:brand',
  score decimal(8,6) NOT NULL COMMENT '热度',
  summary text DEFAULT NULL,
  title text DEFAULT NULL,
  topImg varchar(1000) DEFAULT NULL,
  url varchar(1000) NOT NULL,
  meta text DEFAULT NULL,
  date varchar(45) DEFAULT NULL COMMENT '日期',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  index_sort VARCHAR(45) DEFAULT NULL,
  content VARCHAR(255) DEFAULT NULL,
  name VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='热点新闻';

CREATE TABLE `iau_audience_report_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '1-key:market,2-key:互联网人群,3-key:brand，4-key:competitor,5-key:product,6-key:competitors,7-key:潜在人群',
  `ref_id` int(11) DEFAULT  NULL COMMENT 'type为1则是market id， type为2为空，tpye为3则是brand id,type为4则是brand id，type为5则是product id，type为6为空，type为7则为advanceSettingId',
  `ref_name` VARCHAR(255) DEFAULT  NULL,
  `audience_plan_id` int(11) NOT NULL,
  `total` int(11) NOT NULL DEFAULT '0' COMMENT '当天的数量',
  `date` varchar(45) DEFAULT NULL COMMENT '日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报表数据(天粒度)';


CREATE TABLE `iau_audience_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `audience_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `date` varchar(45) DEFAULT '',
  `create_time` date DEFAULT NULL,
  `type` int(11) DEFAULT '0' COMMENT '1:interest,2:custom-key-word,3:retargeting,4:search-retargeting',
  PRIMARY KEY (`id`),
  UNIQUE KEY `audience_id` (`audience_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='人群 主表';

CREATE TABLE `iau_audience_summary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `audience_id` int(11) DEFAULT NULL,
  `audience_size` int(11) DEFAULT NULL,
  `weekly_growth_rate` float DEFAULT NULL,
  `monthly_growth_rate` float DEFAULT NULL,
  `type` int(11) DEFAULT '0' COMMENT '1:interest,2:custom-key-word,3:retargeting,4:search-retargeting',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='人群汇总表';

CREATE TABLE `iau_audience` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `name_en` varchar(100) DEFAULT NULL,
  `d_type` varchar(20) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `key_type` varchar(10) DEFAULT 'opx',
  `keyword_list` text,
  `include_all_searchers` tinyint(1) DEFAULT '0',
  `include_paid_searchers` tinyint(1) DEFAULT '0',
  `include_organic_searchers` tinyint(1) DEFAULT '0',
  `use_manual_input` tinyint(1) DEFAULT '0',
  `gender` varchar(20) DEFAULT NULL,
  `age_group` varchar(20) DEFAULT NULL,
  `income_group` varchar(20) DEFAULT NULL,
  `city_group` varchar(255) DEFAULT NULL,
  `create_by` varchar(45) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(45) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `result_detail` text,
  `parent_audience_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='人群定义表';

CREATE TABLE `iau_event_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) DEFAULT NULL,
  `event_desc` varchar(255) DEFAULT NULL,
  `event_one_name` varchar(255) DEFAULT NULL,
  `event_one_type` varchar(255) DEFAULT NULL,
  `event_two_name` varchar(255) DEFAULT NULL,
  `event_two_type` varchar(255) DEFAULT NULL,
  `event_three_name` varchar(255) DEFAULT NULL,
  `event_three_type` varchar(255) DEFAULT NULL,
  `event_four_name` varchar(255) DEFAULT NULL,
  `event_four_type` varchar(255) DEFAULT NULL,
  `event_five_name` varchar(255) DEFAULT NULL,
  `event_five_type` varchar(255) DEFAULT NULL,
  `event_six_name` varchar(255) DEFAULT NULL,
  `event_six_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `event_one_default` varchar(255) DEFAULT NULL,
  `event_two_default` varchar(255) DEFAULT NULL,
  `event_three_default` varchar(255) DEFAULT NULL,
  `event_four_default` varchar(255) DEFAULT NULL,
  `event_five_default` varchar(255) DEFAULT NULL,
  `event_six_default` varchar(255) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `conversion_field` tinyint(1) DEFAULT '0',
  `deduplication` tinyint(1) DEFAULT '0',
  `client_id` int(11) DEFAULT NULL,
  `unique_session` tinyint(1) DEFAULT '0',
  `product_id` int(11) DEFAULT NULL,
  `deduplication_type` int(11) DEFAULT '0' COMMENT '0 => No de-duplication\n-1 => Remove duplicate visitor within conversion period\n-2 => Remove duplicate session\n>= 1 => event_params to be de-duplicate',
  `event_index` int(11) DEFAULT NULL,
  `retargeting_status` tinyint(1) DEFAULT '0',
  `manual_feed` tinyint(1) DEFAULT '0',
  `javascripts` text,
  `urls` varchar(10000) DEFAULT NULL,
  `last_event_on` datetime DEFAULT NULL,
  `event_type` mediumint(9) DEFAULT '0',
  `url_flag` tinyint(1) DEFAULT '0',
  `gdn_audience_id` int(11) DEFAULT NULL,
  `gdn_javascripts` text,
  `enable_cookie_matching` tinyint(1) DEFAULT NULL,
  `filter_type` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `event_tags` text,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_clilent_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='活动';

CREATE TABLE `iau_analysis_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `result_json_1` text,
  `result_json_2` text,
  `result_json_3` text,
  `result_json_4` text,
  `result_json_5` text,
  `create_by` varchar(45) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(45) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1-key:market,2-key:互联网人群,3-key:brand，4-key:competitor,5-key:product,6-key:competitors,7-key:潜在人群',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='人群分析 结果报表表';