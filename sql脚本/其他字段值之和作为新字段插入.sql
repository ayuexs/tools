-- workshop(建筑ID 13) 不足1级的改为1级
update city2building set `level` = 1 WHERE building_pro_id = 13 and `level` <1;
-- 所有玩家增加监狱(建筑ID 18) 等级为1级
INSERT IGNORE INTO city2building SELECT city_id,18,1,0 FROM city2building;
-- 按照1瓶酒换30代币的比例 将背包中的酒( 2201,2202,2203 ) 换成信物 (ID 2211)
INSERT IGNORE INTO player2item SELECT player_id,2211,SUM(count)*30 FROM player2item where item_id = 2201 or item_id = 2202 or item_id = 2203 GROUP BY player_id;
-- 重置阵营赏金任务刷新时间
update task_contract_info SET faction_last_refresh_timestamp = 1537325086428;
-- 清空军团赏金任务
truncate table task_contract_alliance;






--

SELECT a.*,b.* from (SELECT player_id,SUM(count) as count from player2item where item_id = 2201 or item_id = 2202 or item_id = 2203  GROUP BY player_id)as a LEFT JOIN player2item b on a.player_id = b.player_id WHERE b.item_id  =2211;

update (SELECT player_id,SUM(count) as count  from player2item where item_id = 2201 or item_id = 2202 or item_id = 2203  GROUP BY player_id)as a LEFT JOIN player2item b on a.player_id = b.player_id set b.count = a.count* 30 where b.item_id  =2211;

