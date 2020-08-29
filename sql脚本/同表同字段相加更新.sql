-- 附件中 id为 2111 / 2112 / 2113 的道具 以100:1 的比例转化为 id为 3053 / 3063 / 3043 的道具
UPDATE mail_system_attachment SET reward_id = 3053,count= count/100 WHERE reward_type = 2 and reward_id = 2111;
UPDATE mail_system_attachment SET reward_id = 3063,count= count/100 WHERE reward_type = 2 and reward_id = 2112;
UPDATE mail_system_attachment SET reward_id = 3043,count= count/100 WHERE reward_type = 2 and reward_id = 2113;

-- 背包中 id为 2111 / 2112 / 2113 的道具 以100:1 的比例转化为 id为 3053 / 3063 / 3043 的道具
INSERT IGNORE INTO player2item SELECT player_id,3053,0 from player2item;
INSERT IGNORE INTO player2item SELECT player_id,3063,0 from player2item;
INSERT IGNORE INTO player2item SELECT player_id,3043,0 from player2item;

update player2item  as a, player2item as b set b.count = b.count+a.count/100 WHERE a.player_id = b.player_id and b.item_id = 3053 and a.item_id = 2111;
update player2item  as a, player2item as b set b.count = b.count+a.count/100 WHERE a.player_id = b.player_id and b.item_id = 3063 and a.item_id = 2112;
update player2item  as a, player2item as b set b.count = b.count+a.count/100 WHERE a.player_id = b.player_id and b.item_id = 3043 and a.item_id = 2113;

-- 背包中 id为 ( 2311,2312,2313,2321,2322,2323,2331,2332,2333,2341,2342,2343,2351,2352,2353 )的道具中直接删除
DELETE FROM player2item WHERE item_id = 2111 or item_id = 2112 or item_id = 2113 or (item_id = 3053 and count = 0) or (item_id = 3063 and count = 0) OR (item_id = 3073 and count = 0) 
or item_id = 2311 or item_id = 2312 or item_id = 2313 or item_id = 2321 or item_id = 2322 or item_id = 2323 or item_id = 2331 or item_id = 2332 or item_id = 2333 
or item_id = 2341 or item_id = 2342 or item_id = 2343 or item_id = 2351 or item_id = 2352 or item_id = 2353;

-- 背包中 id为 2501 / 2502 / 2503 / 2504 / 2505 的道具以1:1 的比例转化为 id 为 2511 / 2512 / 2515 / 2517 / 2518 的道具
update player2item set item_id = 2511 where item_id = 2501;
update player2item set item_id = 2512 where item_id = 2502;
update player2item set item_id = 2515 where item_id = 2503;
update player2item set item_id = 2517 where item_id = 2504;
update player2item set item_id = 2518 where item_id = 2505;

-- 背包中 id 为 (115101,115111,115401,125201,125211,125401,135301,135311,135401,115121,125221,135321,115122,125222,135322,115123,125223,135323,115424,125424,135424 )的道具数量*2
update player2item set count = count*2 WHERE item_id = 115101 or item_id = 115111 or item_id = 115401 or item_id = 125201 or item_id = 125211 or item_id = 125401
or item_id = 135301 or item_id = 135311 or item_id = 135401 or item_id = 115121 or item_id = 125221 or item_id = 135321 or item_id = 115122 or item_id = 125222 or item_id = 135322
or item_id = 115123 or item_id = 125223 or item_id = 135323 or item_id = 115424 or item_id = 125424 or item_id = 135424;

-- 按背包中 id 为 100000的契约数量 和 市场等级 刷玩家的VIP等级和VIP点 ,同时删除背包中的契约
update player as a,player2item as b set a.vip_point = b.count where a.id = b.player_id and b.item_id = 100000;

UPDATE player set vip_point = vip_point+10 WHERE vip_level >=2;
UPDATE player set vip_point = vip_point+200 WHERE vip_level >=3;
UPDATE player set vip_point = vip_point+550 WHERE vip_level >=4;
UPDATE player set vip_point = vip_point+700 WHERE vip_level >=5;
UPDATE player set vip_point = vip_point+1500 WHERE vip_level >=6;
UPDATE player set vip_point = vip_point+3000 WHERE vip_level >=7;
UPDATE player set vip_point = vip_point+4500 WHERE vip_level >=8;
UPDATE player set vip_point = vip_point+8000 WHERE vip_level >=9;
UPDATE player set vip_point = vip_point+15000 WHERE vip_level >=10;
UPDATE player set vip_point = vip_point+30000 WHERE vip_level >=11;
UPDATE player set vip_point = vip_point+40000 WHERE vip_level >=12;

UPDATE player SET vip_level = 2 WHERE vip_point >=10;
UPDATE player SET vip_level = 3 WHERE vip_point >=210;
UPDATE player SET vip_level = 4 WHERE vip_point >=760;
UPDATE player SET vip_level = 5 WHERE vip_point >=1460;
UPDATE player SET vip_level = 6 WHERE vip_point >=2960;
UPDATE player SET vip_level = 7 WHERE vip_point >=5960;
UPDATE player SET vip_level = 8 WHERE vip_point >=10460;
UPDATE player SET vip_level = 9 WHERE vip_point >=18460;
UPDATE player SET vip_level = 10 WHERE vip_point >=33460;
UPDATE player SET vip_level = 11 WHERE vip_point >=63460;
UPDATE player SET vip_level = 12 WHERE vip_point >=103460;



-- 处理赏金任务
truncate table task_contract;
truncate table task_contract_alliance;
truncate table task_contract_event;
truncate table task_contract_faction;
update task_contract_info set faction_last_refresh_timestamp = 0,accept_faction_task_time=0,faction_task_score=0,is_reward_faction_group=0,accept_alliance_task_time=0,is_reward_alliance_group=0;

-- 玩家出征部队信息（所有玩家部队回城）
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
wounded_cure_timestamp=-1,
win_streak_count=0,
win_npc_streak_count=0,
food=0,
water=0,
wood=0,
energy=0,
population=0,
credit =0,
core_unit_efficiency=0,
total_space=0,
exterior_id=null,
oil_cost=0,
current_item_id=NULL,
is_captured = 0;

DELETE FROM march;
DELETE FROM troop_attack_alert;
DELETE FROM troop_intercept_alert;
DELETE FROM alliance_event where event_type = 0 or event_type = 1;
update city_schedule SET schedule_value = 1;
DELETE FROM alliance_building_schedule;
update alliance_building SET state = 0;
update npc_mine SET gather_player_id = NULL,gather_troop_id = NULL,gather_output = NULL ,gather_amount = NULL,gather_start_timestamp = NULL,gather_update_timestamp = NULL,gather_end_timestamp = NULL;
update npc_greatmine set state = 0 where state = 1;
DELETE FROM troop_scavenge;

-- 玩家地图信息（所有玩家重新落地）
UPDATE city a SET map_id = null, is_fall = 0,state = 0,durability = 
(SELECT c.city_durability_max FROM city2building b LEFT JOIN building_level_prototype c on b.building_pro_id = c.building_pro_id WHERE b.city_id = a.id and b.building_pro_id = 10 and c.level = a.level);

UPDATE player_login_info SET state = 2;

-- 玩家清除军团补偿
insert ignore into player2item SELECT a.player_id ,20181129, FLOOR(0.1567*POW(b.level,3)-2.6271*POW(b.`level`,2)+18.175*b.`level`-23.804) from player2alliance a LEFT JOIN alliance b on a.alliance_id = b.id WHERE a.alliance_id is not NULL and b.`level` >=2;

-- 玩家军团信息
update player2alliance set alliance_id = null,position = null,contribution = 0,bonus_get_time = null;
truncate table alliance;
truncate table alliance_applycation;
truncate table alliance_building;
truncate table alliance_building_schedule;
truncate table alliance_help_ask;
truncate table alliance_help_offer;
truncate table alliance_invitation;
truncate table alliance_relation_tag;
truncate table alliance_truce;
truncate table campaign_alliance_score;
truncate table npc_alliance_monster;
truncate table task_contract_alliance;

-- 主线任务
truncate table task_common;
truncate table task_common_event;

-- 活动
truncate table campaign_alliance_score;
truncate table campaign_npc_info;
truncate table campaign_player_score;
truncate table campaign_score_rewards_record;
truncate table npc_campaign_monster;
truncate table player2campaign;
truncate table task_campaign;
truncate table task_campaign_event;
truncate table campaign_normal_info;
truncate table campaign_score_info;

-- 补足队列

ALTER TABLE `troop`
MODIFY COLUMN `id`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部队id' FIRST ;

INSERT IGNORE INTO troop SELECT NULL,a.city_id,a.city_id,null,null,null,null,null,null,-1,null,NOW(),NULL,NULL,-1,0,0,0,0,0,0,0,0,3,null,null,null,null,null,null,null,0 FROM (select city_id FROM city2building WHERE level >9 and LEVEL <12 and building_pro_id = 5 AND city_id not in (SELECT city_id FROM troop WHERE sort = 3)) as a;
INSERT IGNORE INTO troop SELECT NULL,a.city_id,a.city_id,null,null,null,null,null,null,-1,null,NOW(),NULL,NULL,-1,0,0,0,0,0,0,0,0,4,null,null,null,null,null,null,null,0 FROM (select city_id FROM city2building WHERE level >=12 and LEVEL <15 and building_pro_id = 5 AND city_id not in (SELECT city_id FROM troop WHERE sort = 4)) as a;
INSERT IGNORE INTO troop SELECT NULL,a.city_id,a.city_id,null,null,null,null,null,null,-1,null,NOW(),NULL,NULL,-1,0,0,0,0,0,0,0,0,5,null,null,null,null,null,null,null,0 FROM (select city_id FROM city2building WHERE level >=15 and building_pro_id = 5 AND city_id not in (SELECT city_id FROM troop WHERE sort = 5)) as a;

ALTER TABLE `troop`
MODIFY COLUMN `id`  bigint(20) NOT NULL COMMENT '部队id' FIRST ;


-- 军官俘虏处理
truncate table officer_capture_info;
update officer SET state = 0 WHERE state = 2;

-- 将玩家信物刷到城市属性
update city_data a,player2item b set a.credit = b.count where a.city_id = b.player_id and b.item_id = 2211;

DELETE FROM player2item WHERE item_id = 100000 or item_id = 2211;

-- 核心单元处理
UPDATE player2core_unit a LEFT JOIN core_unit_level_prototype b on a.pro_id = b.pro_id AND a.`level` = b.`level` SET a.durability = b.durability_max WHERE a.`level` != 0;

UPDATE player2core_unit a LEFT JOIN core_unit_level_prototype b on a.pro_id = b.pro_id AND b.`level` = 1 SET a.durability = b.durability_max WHERE a.`level` = 0;










-- vip点更新检测
SELECT a.id,a.vip_point,b.player_id,b.item_id,b.count FROM player a LEFT JOIN player2item b on a.id = b.player_id WHERE  b.item_id = 100000;

-- vip等级更新检测
SELECT a.vip_level,b.level FROM player a LEFT JOIN (SELECT a.player_id,b.level FROM city a LEFT JOIN city2building b on a.id = b.city_id where b.building_pro_id  =9) as b on a.id = b.player_id;
