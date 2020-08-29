-- 尽量避免在where子句中对字段进行null值判断，否则将导致引擎放弃使用索引而进行全局扫描
select id from t where num is null;
select id from t where num=0;

-- 尽量避免在 where 子句中使用 or 来连接条件，否则将导致引擎放弃使用索引而进行全表扫描
select id from t where num=10 or num=20;
select id from t where num=10 union all select id from t where num=20;

-- 不能前置百分号;会导致全表扫描
select id from t where name like ‘%c%’;
select id from t where name like ‘c%’;

-- 能用 between 就不要用 in 
select id from t where num in(1,2,3);
select id from t where num between 1 and 3;

-- 尽量避免在 where 子句中对字段进行表达式操作或者函数操作，这将导致引擎放弃使用索引而进行全表扫描
select id from t where num/2=100
elect id from t where num=100*2

-- 在使用索引字段作为条件时,应尽可能的让字段顺序与索引顺序相一致。

-- 很多时候用 exists 代替 in 是一个好的选择，联合查询才是王道
select num from a where num in(select num from b)
select num from a where exists(select 1 from b where num=a.num) -- 适合数据量大的

-- 在新建临时表时，如果一次性插入数据量很大，那么可以使用 select into 代替 create table，避免造成大量 log ，以提高速度；如果数据量不大，为了缓和系统表的资源，应先create table，然后insert。
 