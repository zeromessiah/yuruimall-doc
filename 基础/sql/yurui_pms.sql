create schema if not exists yurui_pms collate utf8mb4_general_ci;
use yurui_pms;
drop table if exists pms_attr;
create table pms_attr
(
    attr_id        bigint not null auto_increment comment '属性id',
    attr_name      char(30) comment '属性名',
    search_type    tinyint comment '是否需要检索[0-不需要，1-需要]',
    `value_type`   tinyint(4)   DEFAULT NULL COMMENT '值类型[0-为单个值，1-可以选择多个值]',
    `icon`         varchar(255) DEFAULT NULL COMMENT '属性图标',
    `value_select` char(255)    DEFAULT NULL COMMENT '可选值列表[用逗号分隔]',
    `attr_type`    tinyint(4)   DEFAULT NULL COMMENT '属性类型[0-销售属性，1-基本属性，2-既是销售属性又是基本属性]',
    enable         bigint comment '启用状态[0 - 禁用，1 - 启用]',
    category_id     bigint comment '所属分类',
    show_desc      tinyint comment '快速展示【是否展示在介绍上；0-否 1-是】，在sku中仍然可以调整',
    constraint pk primary key (attr_id)
) comment '商品属性';

drop table if exists pms_attr_group_relation;
create table pms_attr_group_relation
(
    id            bigint not null auto_increment comment 'id',
    attr_id       bigint comment '属性id',
    attr_group_id bigint comment '属性分组id',
    attr_sort     int comment '属性组内排序',
    constraint pk primary key (id)
) comment '属性&属性分组关联';

drop table if exists pms_attr_group;
create table pms_attr_group
(
   attr_group_id        bigint not null auto_increment comment '分组id',
   attr_group_name      char(20) comment '组名',
   sort                 int comment '排序',
   description             varchar(255) comment '描述',
   icon                 varchar(255) comment '组图标',
   category_id           bigint comment '所属分类id',
   constraint pk primary key (attr_group_id)
)comment '属性分组';

drop table if exists pms_brand;
create table pms_brand
(
   brand_id             bigint not null auto_increment comment '品牌id',
   name                 char(50) comment '品牌名',
   logo                 varchar(2000) comment '品牌logo地址',
   description             longtext comment '介绍',
   show_status          tinyint comment '显示状态[0-不显示；1-显示]',
   first_letter         char(1) comment '检索首字母',
   sort                 int comment '排序',
   constraint pk primary key (brand_id)
)comment '品牌';

drop table if exists pms_category;
create table pms_category
(
   cat_id               bigint not null auto_increment comment '分类id',
   name                 char(50) comment '分类名称',
   parent_cid           bigint comment '父分类id',
   cat_level            int comment '层级',
   show_status          tinyint comment '是否显示[0-不显示，1显示]',
   sort                 int comment '排序',
   icon                 char(255) comment '图标地址',
   product_unit         char(50) comment '计量单位',
   product_count        int comment '商品数量',
   constraint pk primary key (cat_id)
)comment '商品三级分类';

drop table if exists pms_category_brand_relation;
create table pms_category_brand_relation
(
   id                   bigint not null auto_increment,
   brand_id             bigint comment '品牌id',
   category_id           bigint comment '分类id',
   brand_name           varchar(255),
   category_name         varchar(255),
   constraint pk primary key (id)
)comment '品牌分类关联';

drop table if exists pms_comment_replay;
create table pms_comment_replay
(
   id                   bigint not null auto_increment comment 'id',
   comment_id           bigint comment '评论id',
   reply_id             bigint comment '回复id',
   constraint pk primary key (id)
)comment '商品评价回复关系';

drop table if exists pms_product_attr_value;
create table pms_product_attr_value
(
   id                   bigint not null auto_increment comment 'id',
   spu_id               bigint comment '商品id',
   attr_id              bigint comment '属性id',
   attr_name            varchar(200) comment '属性名',
   attr_value           varchar(200) comment '属性值',
   attr_sort            int comment '顺序',
   quick_show           tinyint comment '快速展示【是否展示在介绍上；0-否 1-是】',
   constraint pk primary key (id)
)comment 'spu属性值';

drop table if exists pms_sku_images;
create table pms_sku_images
(
   id                   bigint not null auto_increment comment 'id',
   sku_id               bigint comment 'sku_id',
   img_url              varchar(255) comment '图片地址',
   img_sort             int comment '排序',
   default_img          int comment '默认图[0 - 不是默认图，1 - 是默认图]',
   constraint pk primary key (id)
)comment 'sku图片';

drop table if exists pms_sku_info;
create table pms_sku_info
(
   sku_id               bigint not null auto_increment comment 'skuId',
   spu_id               bigint comment 'spuId',
   sku_name             varchar(255) comment 'sku名称',
   sku_desc             varchar(2000) comment 'sku介绍描述',
   catalog_id           bigint comment '所属分类id',
   brand_id             bigint comment '品牌id',
   sku_default_img      varchar(255) comment '默认图片',
   sku_title            varchar(255) comment '标题',
   sku_subtitle         varchar(2000) comment '副标题',
   price                decimal(18,4) comment '价格',
   sale_count           bigint comment '销量',
   constraint pk primary key (sku_id)
)comment 'sku信息';

drop table if exists pms_sku_sale_attr_value;
create table pms_sku_sale_attr_value
(
   id                   bigint not null auto_increment comment 'id',
   sku_id               bigint comment 'sku_id',
   attr_id              bigint comment 'attr_id',
   attr_name            varchar(200) comment '销售属性名',
   attr_value           varchar(200) comment '销售属性值',
   attr_sort            int comment '顺序',
   constraint pk primary key (id)
)comment 'sku销售属性&值';

drop table if exists pms_spu_comment;
create table pms_spu_comment
(
   id                   bigint not null auto_increment comment 'id',
   sku_id               bigint comment 'sku_id',
   spu_id               bigint comment 'spu_id',
   spu_name             varchar(255) comment '商品名字',
   member_nick_name     varchar(255) comment '会员昵称',
   star                 tinyint(1) comment '星级',
   member_ip            varchar(64) comment '会员ip',
   create_time          datetime comment '创建时间',
   show_status          tinyint(1) comment '显示状态[0-不显示，1-显示]',
   spu_attributes       varchar(255) comment '购买时属性组合',
   likes_count          int comment '点赞数',
   reply_count          int comment '回复数',
   resources            varchar(1000) comment '评论图片/视频[json数据；[{type:文件类型,url:资源路径}]]',
   content              text comment '内容',
   member_icon          varchar(255) comment '用户头像',
   comment_type         tinyint comment '评论类型[0 - 对商品的直接评论，1 - 对评论的回复]',
   constraint pk primary key (id)
)comment '商品评价';

drop table if exists pms_spu_images;
create table pms_spu_images
(
   id                   bigint not null auto_increment comment 'id',
   spu_id               bigint comment 'spu_id',
   img_name             varchar(200) comment '图片名',
   img_url              varchar(255) comment '图片地址',
   img_sort             int comment '顺序',
   default_img          tinyint comment '是否默认图',
   constraint pk primary key (id)
)comment 'spu图片';

drop table if exists pms_spu_info;
create table pms_spu_info
(
   id                   bigint not null auto_increment comment '商品id',
   spu_name             varchar(200) comment '商品名称',
   spu_description      varchar(1000) comment '商品描述',
   catalog_id           bigint comment '所属分类id',
   brand_id             bigint comment '品牌id',
   weight               decimal(18,4),
   publish_status       tinyint comment '上架状态[0 - 下架，1 - 上架]',
   create_time          datetime,
   update_time          datetime,
   constraint pk primary key (id)
)comment 'spu信息';

drop table if exists pms_spu_info_desc;
create table pms_spu_info_desc
(
   spu_id               bigint not null comment '商品id',
   description              longtext comment '商品介绍',
   constraint pk primary key (spu_id)
)comment 'spu信息介绍';
