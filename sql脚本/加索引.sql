-- 创建索引
//普通索引
alter table table_name add index index_name (column_list) ;
//唯一索引
alter table table_name add unique (column_list) ;
//主键索引
alter table table_name add primary key (column_list) ;

CREATE INDEX index_name ON table_name (column_list)
CREATE UNIQUE INDEX index_name ON table_name (column_list)

-- 删除索引
drop index index_name on table_name ;

alter table table_name drop index index_name ;

alter table table_name drop primary key ;