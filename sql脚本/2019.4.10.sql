-- 玩家的玩家的vipvip	点变为原来的点变为原来的1010倍倍
update player set vip_point = vip_point*10;
--   按照新的按照新的vip_level_prototypevip_level_prototype	  表中的数据重新确定玩家的表中的数据重新确定玩家的	vipvip等级等级
UPDATE player SET vip_level = 2 WHERE vip_point >=100;
UPDATE player SET vip_level = 3 WHERE vip_point >=3100;
UPDATE player SET vip_level = 4 WHERE vip_point >=6900;
UPDATE player SET vip_level = 5 WHERE vip_point >=10600;
UPDATE player SET vip_level = 6 WHERE vip_point >=15100;
UPDATE player SET vip_level = 7 WHERE vip_point >=25000;
UPDATE player SET vip_level = 8 WHERE vip_point >=51100;
UPDATE player SET vip_level = 9 WHERE vip_point >=121100;
UPDATE player SET vip_level = 10 WHERE vip_point >=201100;
UPDATE player SET vip_level = 11 WHERE vip_point >=301100;
UPDATE player SET vip_level = 12 WHERE vip_point >=501100;

-- 买过的vip	限购礼包记录清掉
DELETE from player_pay_item_record where pay_item_id not in(10000011, 10000010);

-- game_plan	 表	plan_type	 为0的, current_level	 改为 8,plan_type	 为4的, current_level	 改为 1
update game_plan set current_level = 8 WHERE plan_type = 0;
update game_plan set current_level = 1 WHERE plan_type = 4;
update game_plan set count = 0;

-- 现有小矿全部删掉	 重新生成
DELETE from npc_mine;

-- 现有NPC全部删掉	,重新生成
DELETE from npc_monster;

-- 现有军团NPC	全部删掉
DELETE FROM npc_alliance_monster;

-- 现有的军团旗子全部删掉
DELETE FROM alliance_building WHERE pro_id = 101011;

-- 现有的军团据点全部置为未占领状态

truncate table map2field;	
insert into map2field select * from init_map2field_prototype;
	

truncate table alliance_building;
insert into alliance_building select * from init_alliance_building_prototype;



CREATE TEMPORARY TABLE complex2prototype select alliance_complex.id as complex_id,alliance_complex.pro_id as complex_pro_id,alliance_complex_prototype.building_reset_level as building_reset_level 
	from alliance_complex,alliance_complex_prototype where alliance_complex.pro_id=alliance_complex_prototype.id;
CREATE TEMPORARY TABLE building2complex  select alliance_building2complex.building_id as building_id,complex2prototype.building_reset_level as building_reset_level 
	from alliance_building2complex,complex2prototype where alliance_building2complex.complex_id=complex2prototype.complex_id;
update alliance_building,building2complex set alliance_building.level =building2complex.building_reset_level where alliance_building.id=building2complex.building_id;
update alliance_building,alliance_building_level_prototype set alliance_building.durability= alliance_building_level_prototype.durability_max 
	where alliance_building.pro_id=alliance_building_level_prototype.building_pro_id and alliance_building.level=alliance_building_level_prototype.level;


update alliance_complex set alliance_id=-1,state=0,state_end_timestamp=null,is_active=0, is_have_reward=1;
update alliance_building2complex set current_alliance_id=-1,is_troop_generated=0;
update npc_greatmine SET level=1, alliance_id=-1,state =0,cooling_end_timestamp=NULL,current_amount=(SELECT total_amount FROM npc_greatmine_reward_prototype where npc_greatmine_pro_id=pro_id AND level=1);


-- 玩家的主线任务进度全部清空
truncate table task_common;
truncate table task_common_event;
truncate table task_common_chapter;

-- 处理赏金任务
truncate table task_contract;
truncate table task_contract_alliance;
truncate table task_contract_event;
truncate table task_contract_faction;
update task_contract_info set faction_last_refresh_timestamp = 0,accept_faction_task_time=0,faction_task_score=0,is_reward_faction_group=0,accept_alliance_task_time=0,is_reward_alliance_group=0;

-- 处理军团赏金任务
truncate table task_contract_alliance;

-- 删掉玩家现有的以下30141000,30141100,30141200,30542000,30542100,30542200,31042000,31042100,31042200,31543000,31543100,31543200,31513000,31513100,31513200,31523000,31523100,31523200,31533000,
-- 31533100,31533200,32044100,32044200,32014200,32014001,32024000,32024100,32024101,32024201,32034200,32034001装备
DELETE FROM equipment where pro_id in(30141000,30141100,30141200,30542000,30542100,30542200,31042000,31042100,31042200,31543000,31543100,31543200,31513000,31513100,31513200,31523000,31523100,
31523200,31533000,31533100,31533200,32044100,32044200,32014200,32014001,32024000,32024100,32024101,32024201,32034200,32034001);

-- 以下 旧ID	的装备换为新ID 
update equipment set  pro_id = 4210 WHERE  pro_id = 2421101; 
update equipment set  pro_id = 4220 WHERE pro_id = 2421102;
update equipment set  pro_id = 4230 WHERE pro_id = 2421103;

update equipment set  pro_id = 5110 WHERE pro_id = 1540101;
update equipment set  pro_id = 5120 WHERE pro_id = 1540102;
update equipment set pro_id = 5130 WHERE pro_id = 1540103;

update equipment set pro_id = 5210 WHERE pro_id = 2540101;
update equipment set  pro_id = 5220 WHERE pro_id = 2540102;
update equipment set  pro_id = 5230 WHERE pro_id = 2540103;

update equipment set  pro_id = 5310 WHERE pro_id = 3540101;
update equipment set  pro_id = 5320 WHERE pro_id = 3540102;
update equipment set  pro_id = 5330 WHERE pro_id = 3540103;

-- 之后所有的装备	,强化等级 +20级
update equipment SET `level` = `level`+20;

-- 玩家 id	 =12 的垃圾 按 1:1的比例	 加给 	ID =11的 	垃圾,同时删掉	 id=12	的垃圾
-- 玩家 id	 =22 的垃圾 按 1:1的比例	 加给 	ID =21的 	垃圾,同时删掉	 id=22	的垃圾

insert ignore into player2junk SELECT a.id,11,0 from (select id from player where id>0)as a;
insert ignore into player2junk SELECT a.id,21,0 from (select id from player where id>0)as a;
insert ignore into player2junk SELECT a.id,31,0 from (select id from player where id>0)as a;
-- 玩家 id	 =32 的垃圾 按 1:1的比例	 加给 	ID =31的 	垃圾,同时删掉	 id=32	的垃圾
update player2junk as a,player2junk as b set a.count = a.count+b.count where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 12;
update player2junk as a,player2junk as b set a.count = a.count+b.count where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 22;
update player2junk as a,player2junk as b set a.count = a.count+b.count where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 32;

-- 把玩家 id =40或41或42或43 的垃圾 按 1:10000的比例 加给 ID =11和21和31的 三种垃圾,同时删掉 id=40或41或42或43的垃圾
update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 40;
update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 40;
update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 40;

update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 41;
update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 41;
update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 41;

update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 42;
update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 42;
update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 42;

update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 43;
update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 43;
update player2junk as a,player2junk as b set a.count = a.count+b.count*10000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 43;

-- 把玩家 id =2001 或 2002 或 2003 或 2004 或 2005 或 2006 或 2007的垃圾 按 1:1000的比例 加给 ID =11和21和31的 三种垃圾,同时删掉 id =2001 或 2002 或 2003 或 2004 或 2005 或 2006 或 2007的垃圾
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 2001;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 2001;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 2001;

update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 2002;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 2002;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 2002;

update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 2003;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 2003;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 2003;

update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 2004;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 2004;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 2004;

update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 2005;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 2005;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 2005;

update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 2006;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 2006;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 2006;

update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 11 and b.junk_id = 2007;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 21 and b.junk_id = 2007;
update player2junk as a,player2junk as b set a.count = a.count+b.count*1000 where a.player_id = b.player_id and a.junk_id = 31 and b.junk_id = 2007;

DELETE from player2junk where junk_id in(12,22,32,40,41,42,43,2001,2002,2003,2004,2005,2006,2007);

-- 7/11/15/18 级玩家分别解锁 2/3/4/5地块
update city set area2_state = 2 where `level` >=7 and `level`<11;
update city set area2_state = 2,area3_state =2 where `level` >=11 and `level`<15;
update city set area2_state = 2,area3_state =2,area4_state=2 where `level` >=15 and `level`<18;
update city set area2_state = 2,area3_state =2,area4_state=2,area5_state=2 where `level` >=18;

-- 删掉以下ID的建筑数据
DELETE from city2building where building_pro_id in(101,102,105,107,108,109,111,112,113,114,115,116,118,119);
-- ID=7 (酒吧) 的建筑 等级改为1
update city2building set `level` =1 where building_pro_id = 7;
-- 现有更新建筑id
set @rowno:=0;
set @id=1000100000000000;
update city2building set id = @id+ @rowno:=@rowno+1;

-- city2building加主键
ALTER TABLE `city2building` ADD PRIMARY KEY (`id`);
-- 更新city2building 的player_id
update city2building a,city b set a.player_id = b.player_id WHERE a.city_id = b.id;
-- 更新city2building 的position和area
UPDATE city2building a,city_building_init_prototype b set a.position = b.position,a.area = b.area where a.building_pro_id = b.building_pro_id;
-- 增加 id=9 (市场) 的建筑数据,等级为1级
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,9,1,9,1,NULL,null FROM (select * from city2building where building_pro_id = 1  )as a;
-- 增加ID=6 (科技所) 的建筑, 等级与当前市政厅等级一致
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,6,a.level,6,1,NULL,null FROM (select * from city2building where building_pro_id = 1 )as a;
-- 增加ID=24 (科技所) 的建筑, 等级与当前市政厅等级一致
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,24,a.level,24,1,NULL,null FROM (select * from city2building where building_pro_id = 1 )as a;
-- 增加ID=19/ 20/21/22/23 的建筑,等级与之前玩家 ID=2(兵营)的建筑一致,随后删除ID=2的建筑
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,19,a.level,19,1,NULL,null FROM (select * from city2building where building_pro_id = 2 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,20,a.level,20,1,NULL,null FROM (select * from city2building where building_pro_id = 2 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,21,a.level,21,1,NULL,null FROM (select * from city2building where building_pro_id = 2 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,22,a.level,22,1,NULL,null FROM (select * from city2building where building_pro_id = 2 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,23,a.level,23,1,NULL,null FROM (select * from city2building where building_pro_id = 2 )as a;
DELETE from city2building where building_pro_id = 2;
-- ID=14建筑处理
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,14,a.level,2012,2,NULL,null FROM (select * from city2building where building_pro_id = 14 and position = 2011)as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,14,a.level,2013,3,NULL,null FROM (select * from city2building where building_pro_id = 14 and position = 2011)as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,14,a.level,2014,3,NULL,null FROM (select * from city2building where building_pro_id = 14 and position = 2011)as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,14,a.level,2015,4,NULL,null FROM (select * from city2building where building_pro_id = 14 and position = 2011)as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,14,a.level,2016,4,NULL,null FROM (select * from city2building where building_pro_id = 14 and position = 2011)as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,14,a.level,2017,5,NULL,null FROM (select * from city2building where building_pro_id = 14 and position = 2011)as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,14,a.level,2018,5,NULL,null FROM (select * from city2building where building_pro_id = 14 and position = 2011)as a;

update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 14 and a.position = 2018 and b.building_pro_id = 1 and b.`level` <18 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 14 and a.position = 2017 and b.building_pro_id = 1 and b.`level` <18 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 14 and a.position = 2016 and b.building_pro_id = 1 and b.`level` <15 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 14 and a.position = 2015 and b.building_pro_id = 1 and b.`level` <15 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 14 and a.position = 2014 and b.building_pro_id = 1 and b.`level` <11 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 14 and a.position = 2013 and b.building_pro_id = 1 and b.`level` <11 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 14 and a.position = 2012 and b.building_pro_id = 1 and b.`level` <7 and a.city_id = b.city_id;
-- ID=15建筑处理
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,15,a.level,2022,2,NULL,null FROM (select * from city2building where building_pro_id = 15 and position = 2021 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,15,a.level,2023,3,NULL,null FROM (select * from city2building where building_pro_id = 15 and position = 2021 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,15,a.level,2024,3,NULL,null FROM (select * from city2building where building_pro_id = 15 and position = 2021 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,15,a.level,2025,4,NULL,null FROM (select * from city2building where building_pro_id = 15 and position = 2021 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,15,a.level,2026,4,NULL,null FROM (select * from city2building where building_pro_id = 15 and position = 2021 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,15,a.level,2027,5,NULL,null FROM (select * from city2building where building_pro_id = 15 and position = 2021 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,15,a.level,2028,5,NULL,null FROM (select * from city2building where building_pro_id = 15 and position = 2021 )as a;

update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 15 and a.position = 2028 and b.building_pro_id = 1 and b.`level` <18 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 15 and a.position = 2027 and b.building_pro_id = 1 and b.`level` <18 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 15 and a.position = 2026 and b.building_pro_id = 1 and b.`level` <15 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 15 and a.position = 2025 and b.building_pro_id = 1 and b.`level` <15 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 15 and a.position = 2024 and b.building_pro_id = 1 and b.`level` <11 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 15 and a.position = 2023 and b.building_pro_id = 1 and b.`level` <11 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 15 and a.position = 2022 and b.building_pro_id = 1 and b.`level` <7 and a.city_id = b.city_id;
-- ID=16建筑处理
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,16,a.level,2032,2,NULL,null FROM (select * from city2building where building_pro_id = 16 and position = 2031 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,16,a.level,2033,3,NULL,null FROM (select * from city2building where building_pro_id = 16 and position = 2031 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,16,a.level,2034,3,NULL,null FROM (select * from city2building where building_pro_id = 16 and position = 2031 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,16,a.level,2035,4,NULL,null FROM (select * from city2building where building_pro_id = 16 and position = 2031 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,16,a.level,2036,4,NULL,null FROM (select * from city2building where building_pro_id = 16 and position = 2031 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,16,a.level,2037,5,NULL,null FROM (select * from city2building where building_pro_id = 16 and position = 2031 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,16,a.level,2038,5,NULL,null FROM (select * from city2building where building_pro_id = 16 and position = 2031 )as a;

update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 16 and a.position = 2038 and b.building_pro_id = 1 and b.`level` <18 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 16 and a.position = 2037 and b.building_pro_id = 1 and b.`level` <18 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 16 and a.position = 2036 and b.building_pro_id = 1 and b.`level` <15 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 16 and a.position = 2035 and b.building_pro_id = 1 and b.`level` <15 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 16 and a.position = 2034 and b.building_pro_id = 1 and b.`level` <11 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 16 and a.position = 2033 and b.building_pro_id = 1 and b.`level` <11 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 16 and a.position = 2032 and b.building_pro_id = 1 and b.`level` <7 and a.city_id = b.city_id;
-- ID=103建筑处理
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,103,a.level,2002,2,NULL,null FROM (select * from city2building where building_pro_id = 103 and position = 2001 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,103,a.level,2003,3,NULL,null FROM (select * from city2building where building_pro_id = 103 and position = 2001 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,103,a.level,2004,4,NULL,null FROM (select * from city2building where building_pro_id = 103 and position = 2001 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,103,a.level,2005,5,NULL,null FROM (select * from city2building where building_pro_id = 103 and position = 2001 )as a;

update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 103 and a.position = 2005 and b.building_pro_id = 1 and b.`level` <18 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 103 and a.position = 2004 and b.building_pro_id = 1 and b.`level` <15 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 103 and a.position = 2003 and b.building_pro_id = 1 and b.`level` <11 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 103 and a.position = 2002 and b.building_pro_id = 1 and b.`level` <7 and a.city_id = b.city_id;
-- ID=104建筑处理
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,104,a.level,2042,2,NULL,null FROM (select * from city2building where building_pro_id = 104 and position = 2041 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,104,a.level,2043,3,NULL,null FROM (select * from city2building where building_pro_id = 104 and position = 2041 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,104,a.level,2044,4,NULL,null FROM (select * from city2building where building_pro_id = 104 and position = 2041 )as a;
INSERT IGNORE INTO city2building 
SELECT @id+1+ @rowno:=@rowno+1,a.city_id,a.player_id,104,a.level,2045,5,NULL,null FROM (select * from city2building where building_pro_id = 104 and position = 2041 )as a;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 104 and a.position = 2045 and b.building_pro_id = 1 and b.`level` <18 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 104 and a.position = 2044 and b.building_pro_id = 1 and b.`level` <15 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 104 and a.position = 2043 and b.building_pro_id = 1 and b.`level` <11 and a.city_id = b.city_id;
update city2building a,city2building b SET a.`level` = 0 where a.building_pro_id = 104 and a.position = 2042 and b.building_pro_id = 1 and b.`level` <7 and a.city_id = b.city_id;
update city2building set construction_action_id = null;
-- 处理建筑的ID目标值
update id_generator_recorder set target_value = CEILING(@rowno/200)*200 where id = 'City2building';

-- 道具处理
insert ignore into player2item SELECT a.id,1111,0 from (select id from player where id>0)as a;
insert ignore into player2item SELECT a.id,1112,0 from (select id from player where id>0)as a;
insert ignore into player2item SELECT a.id,1113,0 from (select id from player where id>0)as a;
insert ignore into player2item SELECT a.id,1211,0 from (select id from player where id>0)as a;
insert ignore into player2item SELECT a.id,1212,0 from (select id from player where id>0)as a;
insert ignore into player2item SELECT a.id,1213,0 from (select id from player where id>0)as a;
insert ignore into player2item SELECT a.id,1311,0 from (select id from player where id>0)as a;
insert ignore into player2item SELECT a.id,1312,0 from (select id from player where id>0)as a;
insert ignore into player2item SELECT a.id,1313,0 from (select id from player where id>0)as a;

update player2item a,player2item b set a.count = a.count+b.count where a.player_id = b.player_id and a.item_id = 1111 and b.item_id = 1121;
update player2item a,player2item b set a.count = a.count+b.count where a.player_id = b.player_id and a.item_id = 1112 and b.item_id = 1122;
update player2item a,player2item b set a.count = a.count+b.count where a.player_id = b.player_id and a.item_id = 1113 and b.item_id = 1123;
update player2item a,player2item b set a.count = a.count+b.count where a.player_id = b.player_id and a.item_id = 1211 and b.item_id = 1221;
update player2item a,player2item b set a.count = a.count+b.count where a.player_id = b.player_id and a.item_id = 1212 and b.item_id = 1222;
update player2item a,player2item b set a.count = a.count+b.count where a.player_id = b.player_id and a.item_id = 1213 and b.item_id = 1223;
update player2item a,player2item b set a.count = a.count+b.count where a.player_id = b.player_id and a.item_id = 1311 and b.item_id = 1321;
update player2item a,player2item b set a.count = a.count+b.count where a.player_id = b.player_id and a.item_id = 1312 and b.item_id = 1322;
update player2item a,player2item b set a.count = a.count+b.count where a.player_id = b.player_id and a.item_id = 1313 and b.item_id = 1323;

update player2item a,player2item b set a.count = a.count+b.count*100 WHERE  a.player_id = b.player_id and a.item_id = 1113 and b.item_id = 1911;
update player2item a,player2item b set a.count = a.count+b.count*100 WHERE  a.player_id = b.player_id and a.item_id = 1113 and b.item_id = 1912;
update player2item a,player2item b set a.count = a.count+b.count*100 WHERE  a.player_id = b.player_id and a.item_id = 1113 and b.item_id = 1913;
update player2item a,player2item b set a.count = a.count+b.count*100 WHERE  a.player_id = b.player_id and a.item_id = 1213 and b.item_id = 1911;
update player2item a,player2item b set a.count = a.count+b.count*100 WHERE  a.player_id = b.player_id and a.item_id = 1213 and b.item_id = 1912;
update player2item a,player2item b set a.count = a.count+b.count*100 WHERE  a.player_id = b.player_id and a.item_id = 1213 and b.item_id = 1913;
update player2item a,player2item b set a.count = a.count+b.count*100 WHERE  a.player_id = b.player_id and a.item_id = 1313 and b.item_id = 1911;
update player2item a,player2item b set a.count = a.count+b.count*100 WHERE  a.player_id = b.player_id and a.item_id = 1313 and b.item_id = 1912;
update player2item a,player2item b set a.count = a.count+b.count*100 WHERE  a.player_id = b.player_id and a.item_id = 1313 and b.item_id = 1913;


update player2item set item_id = 431 where item_id = 3011; 
update player2item set item_id = 432 where item_id = 3012; 
update player2item set item_id = 433 where item_id = 3013; 
update player2item set item_id = 434 where item_id = 3014; 
update player2item set item_id = 435 where item_id = 3015; 
update player2item set item_id = 436 where item_id = 3016; 
update player2item set item_id = 437 where item_id = 3017; 
update player2item set item_id = 438 where item_id = 3018; 
update player2item set item_id = 401 where item_id = 3071; 
update player2item set item_id = 402 where item_id = 3072; 
update player2item set item_id = 403 where item_id = 3073; 
update player2item set item_id = 404 where item_id = 3074; 
update player2item set item_id = 405 where item_id = 3075; 
update player2item set item_id = 406 where item_id = 3076; 
update player2item set item_id = 407 where item_id = 3077; 
update player2item set item_id = 408 where item_id = 3078; 
update player2item set item_id = 409 where item_id = 3079; 

DELETE from player2item where item_id in (1121,1122,1123,1221,1222,1223,1321,1322,1323,1911,1912,1913,3011,3012,3013,3015,3016,3017,3018,3071,3072,3073,3074,3075,3076,3077,3078,3079,
1401,1402,1403,1411,1412,1413,1421,1422,1423,1431,1432,1433,2111,2112,2113,2191,2192,2193,2194,2201,2202,2203,2311,2312,2313,2321,2322,2323,2331,2332,2333,2341,2342,2343,2351,2352,2353,
2400,2501,2502,2503,2504,2505,4113,4114,45,4116,4117,4118,4119,4120,4121,4122,4123,4124,4125,4126,4127,4128,4129,4130,4213,4214,4215,4216,4217,4218,4219,4220,4221,4222,4223,4224,4225,
4226,4227,4228,4229,4230,4313,4314,4315,4316,4317,4318,4319,4320,4321,4322,4323,4324,4325,4326,4327,4328,4329,4330,4401,4402,4403,4404,4405,4406,4411,4412,4413,4414,4415,4416,4421,4422,
4423,4424,4425,4426,4431,4432,4433,4434,4435,4436,4441,4442,4443,4444,4445,4446,4451,4452,4453,4454,4455,4456,4461,4462,4463,4464,4465,4466,4471,4472,4473,4474,4475,4476,4481,4482,4483,
4484,4485,4486,4491,4492,4493,4494,4495,4496,5013,5014,5015,5016,5017,5018,5019,5020,5021,5022,5023,5024,5025,5026,5027,5028,5029,5030,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,
7011,7012,7013,7014,7015,7016,7017,7018,7019,7020,8001,8002,8003,8004,8005,12101,12102,12103,12201,12202,12203,12301,12302,12303,13101,13102,13103,13104,13201,13202,13203,13204,13301,13302,
13303,13304,14101,14102,14103,14104,14201,14202,14203,14204,14301,14302,14303,14304,14305,15101,15102,15103,15201,15202,15203,15301,15302,15303,30001,30002,30003,30004,30005,30006,30007,
30008,30009,30010,90001,90011,90012,90013,90014,90015,100000,100003,1914101,1915101,1924201,1925401,1934401,2001001,2001002,2001003,2001004,2001005,2001006,2001007,2001008,2001009,2001010,
2001011,2001012,2001013,2001014,2001015,2001016,2001017,2001018,2001019,2001020,2001021,2001022,2001023,2001024,2001025,2001026,2001027,2001028,2001029,2001030,2110101,2110102,2110103,2110104,
2110105,2110106,2110107,2110201,2110202,2110203,2110204,2110205,2110206,2110207,2110301,2110302,2110303,2110304,2110305,2110306,2110307,2110401,2110402,2110403,2110404,2110405,2110406,2110407,
2110501,2110502,2110503,2110504,2110505,2110506,2110507,2110601,2110602,2110603,2110604,2110605,2110606,2110607,2110701,2110702,2110703,2110704,2110705,2110706,2110707,2110801,2110802,2110803,
2110804,2110805,2110806,2110807,2110901,2110902,2110903,2110904,2110905,2110906,2110907,2111001,2111002,2111003,2111004,2111005,2111006,2111007,2111101,2111102,2111103,2111104,2111105,2111106,
2111107,2111201,2111202,2111203,2111204,2111205,2111206,2111207,2111301,2111302,2111303,2111304,2111305,2111306,2111307,2111401,2111402,2111403,2111404,2111405,2111406,2111407,2111501,2111502,
2111503,2111504,2111505,2111506,2111507,2111601,2111602,2111603,2111604,2111605,2111606,2111607,2111701,2111702,2111703,2111704,2111705,2111706,2111707,2111801,2111802,2111803,2111804,2111805,
2111806,2111807,2111901,2111902,2111903,2111904,2111905,2111906,2111907,2112001,2112002,2112003,2112004,2112005,2112006,2112007,2112101,2112102,2112103,2112104,2112105,2112106,2112107,2112201,
2112202,2112203,2112204,2112205,2112206,2112207,2112301,2112302,2112303,2112304,2112305,2112306,2112307,2112401,2112402,2112403,2112404,2112405,2112406,2112407,2112501,2112502,2112503,2112504,
2112505,2112506,2112507,2112601,2112602,2112603,2112604,2112605,2112606,2112607,2112701,2112702,2112703,2112704,2112705,2112706,2112707,2112801,2112802,2112803,2112804,2112805,2112806,2112807,
2112901,2112902,2112903,2112904,2112905,2112906,2112907,2113001,2113002,2113003,2113004,2113005,2113006,2113007,2120101,2120102,2120103,2120104,2120105,2120106,2120107,2120201,2120202,2120203,
2120204,2120205,2120206,2120207,2120301,2120302,2120303,2120304,2120305,2120306,2120307,2120401,2120402,2120403,2120404,2120405,2120406,2120407,2120501,2120502,2120503,2120504,2120505,2120506,
2120507,2120601,2120602,2120603,2120604,2120605,2120606,2120607,2120701,2120702,2120703,2120704,2120705,2120706,2120707,2120801,2120802,2120803,2120804,2120805,2120806,2120807,2120901,2120902,
2120903,2120904,2120905,2120906,2120907,2121001,2121002,2121003,2121004,2121005,2121006,2121007,2121101,2121102,2121103,2121104,2121105,2121106,2121107,2121201,2121202,2121203,2121204,2121205,
2121206,2121207,2121301,2121302,2121303,2121304,2121305,2121306,2121307,2121401,2121402,2121403,2121404,2121405,2121406,2121407,2121501,2121502,2121503,2121504,2121505,2121506,2121507,2121601,
2121602,2121603,2121604,2121605,2121606,2121607,2121701,2121702,2121703,2121704,2121705,2121706,2121707,2121801,2121802,2121803,2121804,2121805,2121806,2121807,2121901,2121902,2121903,2121904,
2121905,2121906,2121907,2122001,2122002,2122003,2122004,2122005,2122006,2122007,2122101,2122102,2122103,2122104,2122105,2122106,2122107,2122201,2122202,2122203,2122204,2122205,2122206,2122207,
2122301,2122302,2122303,2122304,2122305,2122306,2122307,2122401,2122402,2122403,2122404,2122405,2122406,2122407,2122501,2122502,2122503,2122504,2122505,2122506,2122507,2122601,2122602,2122603,
2122604,2122605,2122606,2122607,2122701,2122702,2122703,2122704,2122705,2122706,2122707,2122801,2122802,2122803,2122804,2122805,2122806,2122807,2122901,2122902,2122903,2122904,2122905,2122906,
2122907,2123001,2123002,2123003,2123004,2123005,2123006,2123007,2130101,2130102,2130103,2130104,2130105,2130106,2130107,2130201,2130202,2130203,2130204,2130205,2130206,2130207,2130301,2130302,
2130303,2130304,2130305,2130306,2130307,2130401,2130402,2130403,2130404,2130405,2130406,2130407,2130501,2130502,2130503,2130504,2130505,2130506,2130507,2130601,2130602,2130603,2130604,2130605,
2130606,2130607,2130701,2130702,2130703,2130704,2130705,2130706,2130707,2130801,2130802,2130803,2130804,2130805,2130806,2130807,2130901,2130902,2130903,2130904,2130905,2130906,2130907,2131001,
2131002,2131003,2131004,2131005,2131006,2131007,2131101,2131102,2131103,2131104,2131105,2131106,2131107,2131201,2131202,2131203,2131204,2131205,2131206,2131207,2131301,2131302,2131303,2131304,
2131305,2131306,2131307,2131401,2131402,2131403,2131404,2131405,2131406,2131407,2131501,2131502,2131503,2131504,2131505,2131506,2131507,2131601,2131602,2131603,2131604,2131605,2131606,2131607,
2131701,2131702,2131703,2131704,2131705,2131706,2131707,2131801,2131802,2131803,2131804,2131805,2131806,2131807,2131901,2131902,2131903,2131904,2131905,2131906,2131907,2132001,2132002,2132003,
2132004,2132005,2132006,2132007,2132101,2132102,2132103,2132104,2132105,2132106,2132107,2132201,2132202,2132203,2132204,2132205,2132206,2132207,2132301,2132302,2132303,2132304,2132305,2132306,
2132307,2132401,2132402,2132403,2132404,2132405,2132406,2132407,2132501,2132502,2132503,2132504,2132505,2132506,2132507,2132601,2132602,2132603,2132604,2132605,2132606,2132607,2132701,2132702,
2132703,2132704,2132705,2132706,2132707,2132801,2132802,2132803,2132804,2132805,2132806,2132807,2132901,2132902,2132903,2132904,2132905,2132906,2132907,2133001,2133002,2133003,2133004,2133005,
2133006,2133007,20181031,20181126,20181127,20181128,20181129,20181220,20181221,20181222,20181223,20181224,20181225,20181226,20181227,20190213,20190214,20190215);


-- 科技处理
insert into player2technology SELECT c.player_id,c.tech_id,c.level,null from 
(SELECT a.player_id,b.tech_id,max(b.`level`)as `level` from city2building a RIGHT JOIN technology_level_prototype b on a.`level` >= b.need_tech_building_level 
WHERE a.building_pro_id = 6 GROUP BY a.player_id , b.tech_id)as c;

-- 预备役处理
update city_data c,(SELECT a.city_id,b.melee_population_max from city2building a RIGHT JOIN building_level_prototype b on a.`level` = b.`level` where b.building_pro_id = 20 and a.building_pro_id = 20)as d set c.melee_population = d.melee_population_max WHERE c.city_id = d.city_id;
update city_data c,(SELECT a.city_id,b.armored_population_max from city2building a RIGHT JOIN building_level_prototype b on a.`level` = b.`level` where b.building_pro_id = 21 and a.building_pro_id = 21)as d set c.armored_population = d.armored_population_max WHERE c.city_id = d.city_id;
update city_data c,(SELECT a.city_id,b.blitz_population_max from city2building a RIGHT JOIN building_level_prototype b on a.`level` = b.`level` where b.building_pro_id = 22 and a.building_pro_id = 22)as d set c.blitz_population = d.blitz_population_max WHERE c.city_id = d.city_id;
update city_data c,(SELECT a.city_id,b.remote_population_max from city2building a RIGHT JOIN building_level_prototype b on a.`level` = b.`level` where b.building_pro_id = 23 and a.building_pro_id = 23)as d set c.remote_population = d.remote_population_max WHERE c.city_id = d.city_id;

-- 部队处理
update city_data a LEFT JOIN troop b on a.city_id = b.city_id SET a.food = a.food+b.food WHERE b.food >0;
update city_data a LEFT JOIN troop b on a.city_id = b.city_id SET a.wood = a.wood+b.wood where b.wood >0;
update city_data a LEFT JOIN troop b on a.city_id = b.city_id SET a.water = a.water+b.water WHERE b.water>0;
UPDATE troop
SET 
start_map_id=null,
current_map_id=null,
target_type=null,
target_id=null,
target_speed_age=NULL,
state = -1,
action = NULL,
create_time=null,
state_update_timestamp=unix_timestamp(now()),
action_start_timestamp=NULL,
win_streak_count=0,
win_npc_streak_count=0,
food=0,
water=0,
wood=0,
energy=0,
credit =0,
core_unit_efficiency=0,
total_space=0,
exterior_id=null,
oil_cost=0,
current_item_id=NULL,
is_captured = 0,
is_auto_replenish = 1;

DELETE FROM march;
DELETE FROM troop_attack_alert;
DELETE FROM troop_intercept_alert;
DELETE FROM alliance_event where event_type = 0 or event_type = 1;
update city_schedule SET schedule_value = 1;
DELETE FROM alliance_building_schedule;
update npc_greatmine set state = 0 where state = 1;
DELETE FROM troop_scavenge;
update troop2officer set is_expedition = 0;

-- 处理map
delete FROM map2cover where cover_type = 2 and map_id not in(SELECT map_id from alliance_building );
-- 处理刷新次数
UPDATE refresh_counter SET fragment_store_free_refresh_count =0,fragment_store_diamond_refresh_count=0;

-- 附件处理
DELETE FROM mail_system_attachment WHERE reward_type=2 AND reward_id  not in (select id from item_prototype);
DELETE FROM mail_system_attachment WHERE reward_type=-1 AND reward_id not in (select id from reward_group_prototype);
DELETE FROM mail_system_attachment WHERE reward_type=1 AND reward_id not in (select id from junk_prototype);
DELETE FROM mail_system_attachment WHERE reward_type=6 AND reward_id not in (select id from equipment_prototype);
DELETE FROM mail_system_attachment WHERE reward_type=7 AND reward_id not in (select id from fragment_prototype);

UPDATE mail_system SET is_attachment=0 WHER
E id not in  (SELECT DISTINCT mail_system_id from mail_system_attachment);

--  繁荣度刷新
UPDATE player aaa LEFT JOIN 
(SELECT a.player_id, SUM(b.add_power) as total_power FROM city2building a LEFT JOIN building_level_prototype b ON a.building_pro_id = b.building_pro_id WHERE a.`level` >= b.`level` GROUP BY a.player_id) bbb 
ON aaa.id = bbb.player_id SET aaa.building_power = bbb.total_power WHERE bbb.player_id IS NOT NULL;


UPDATE player aaa LEFT JOIN 
(SELECT player_id, SUM(b.add_power) as total_power FROM player2technology a LEFT JOIN technology_level_prototype b ON a.tech_pro_id = b.tech_id WHERE a.`level` >= b.`level` GROUP BY player_id) bbb 
ON aaa.id = bbb.player_id SET aaa.technology_power = bbb.total_power WHERE bbb.player_id IS NOT NULL;

-- 跳过玩家新手步骤
update player set newbie_step = 9999 WHERE id>0;

-- 设置军官人数
update officer SET army_amount = army_amount-1;


INSERT IGNORE INTO task_event SELECT a.player_id,101,-1,2,-1,-1,1,NOW() from(SELECT player_id from city WHERE area2_state = 2)as a;
INSERT IGNORE INTO task_event SELECT a.player_id,101,-1,3,-1,-1,1,NOW() from(SELECT player_id from city WHERE area3_state = 2)as a;
INSERT IGNORE INTO task_event SELECT a.player_id,101,-1,4,-1,-1,1,NOW() from(SELECT player_id from city WHERE area4_state = 2)as a;
INSERT IGNORE INTO task_event SELECT a.player_id,101,-1,5,-1,-1,1,NOW() from(SELECT player_id from city WHERE area5_state = 2)as a;



-- 测试
DELETE from city2building where building_pro_id = 9

SELECT * FROM city2building where building_pro_id = 14 or building_pro_id = 1

SELECT * FROM city2building where building_pro_id = 15 and position =2021 or building_pro_id = 1

ALTER TABLE `city2building` ADD COLUMN `id`  bigint(20) NOT NULL FIRST ;
ALTER TABLE `city2building` ADD COLUMN `position`  int(11) NULL DEFAULT NULL COMMENT '建筑位置' AFTER `level`;
ALTER TABLE `city2building` ADD COLUMN `area`  int(11) NULL DEFAULT NULL COMMENT '建筑区域' AFTER `position`;
ALTER TABLE `city2building` ADD COLUMN `player_id`  bigint(20) NULL DEFAULT NULL COMMENT '角色id' AFTER `city_id`;
ALTER TABLE `city2building` ADD COLUMN `construction_action_id`  bigint(20) NULL DEFAULT 0 COMMENT '暂未使用' AFTER `area`;
ALTER TABLE `city2building` ADD COLUMN `production_actioin_id`  bigint(20) NULL DEFAULT NULL AFTER `construction_action_id`;
ALTER TABLE `city2building` DROP PRIMARY KEY;
ALTER TABLE `city2building` ADD PRIMARY KEY (`id`);
ALTER TABLE `city2building` DROP COLUMN `state`;
CREATE INDEX `idx_city_id` ON `city2building`(`city_id`) USING BTREE ;

SELECT * from technology_level_prototype where need_tech_building_level =7 GROUP BY tech_id

SELECT a.* FROM player2item a RIGHT JOIN (SELECT player_id,MAX(item_id)as item_id from player2item GROUP BY player_id) b on a.player_id = b.player_id and a.item_id= b.item_id


SELECT player_id,MAX(item_id),count from player2item GROUP BY player_id

SELECT * FROM player2item

SELECT * from officer 