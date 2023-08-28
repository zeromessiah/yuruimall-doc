create schema if not exists yurui_wms collate utf8mb4_general_ci;
use yurui_wms;

drop table if exists wms_purchase;
create table wms_purchase
(
   id                   bigint not null auto_increment comment '采购单id',
   assignee_id          bigint comment '采购人id',
   assignee_name        varchar(255) comment '采购人名',
   phone                char(13) comment '联系方式',
   priority             int(4) comment '优先级',
   status               int(4) comment '状态',
   ware_id              bigint comment '仓库id',
   amount               decimal(18,4) comment '总金额',
   create_time          datetime comment '创建日期',
   update_time          datetime comment '更新日期',
   constraint pk primary key (id)
)comment '采购信息';

drop table if exists wms_purchase_detail;
create table wms_purchase_detail
(
   id                   bigint not null auto_increment,
   purchase_id          bigint comment '采购单id',
   sku_id               bigint comment '采购商品id',
   sku_num              int comment '采购数量',
   sku_price            decimal(18,4) comment '采购金额',
   ware_id              bigint comment '仓库id',
   status               int comment '状态[0新建，1已分配，2正在采购，3已完成，4采购失败]',
   constraint pk primary key (id)
)comment ='采购信息详情';

drop table if exists wms_ware_info;
create table wms_ware_info
(
   id                   bigint not null auto_increment comment 'id',
   name                 varchar(255) comment '仓库名',
   address              varchar(255) comment '仓库地址',
   area_code             varchar(20) comment '区域编码',
   constraint pk primary key (id)
)comment '仓库信息';

drop table if exists wms_ware_order_task;
create table wms_ware_order_task
(
   id                   bigint not null auto_increment comment 'id',
   order_id             bigint comment 'order_id',
   order_sn             varchar(255) comment 'order_sn',
   consignee            varchar(100) comment '收货人',
   consignee_tel        char(15) comment '收货人电话',
   delivery_address     varchar(500) comment '配送地址',
   order_comment        varchar(200) comment '订单备注',
   payment_way          tinyint(1) comment '付款方式【 1:在线付款 2:货到付款】',
   task_status          tinyint(2) comment '任务状态',
   order_body           varchar(255) comment '订单描述',
   tracking_no          char(30) comment '物流单号',
   create_time          datetime comment 'create_time',
   ware_id              bigint comment '仓库id',
   task_comment         varchar(500) comment '工作单备注',
   constraint pk primary key (id)
)comment '库存工作单';

drop table if exists wms_ware_order_task_detail ;
create table wms_ware_order_task_detail
(
   id                   bigint not null auto_increment comment 'id',
   sku_id               bigint comment 'sku_id',
   sku_name             varchar(255) comment 'sku_name',
   sku_num              int comment '购买个数',
   task_id              bigint comment '工作单id',
   constraint pk primary key (id)
)comment '库存工作单详情';

drop table if exists wms_ware_sku;
create table wms_ware_sku
(
   id                   bigint not null auto_increment comment 'id',
   sku_id               bigint comment 'sku_id',
   ware_id              bigint comment '仓库id',
   stock                int comment '库存数',
   sku_name             varchar(200) comment 'sku_name',
   stock_locked         int comment '锁定库存',
   constraint pk primary key (id)
)comment '商品库存';