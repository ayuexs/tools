-- 去重计数
SELECT count(distinct player_id),item_id from player2item GROUP BY item_id 