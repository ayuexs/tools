
update player2item c ,(SELECT player_id,favor FROM (SELECT a.*,favor FROM player2item a LEFT JOIN (SELECT player_id,1014001,sum(favor) as favor FROM hire_officer_favor a 
LEFT JOIN officer_prototype b ON a.officer_pro_id = b.id WHERE b.quality = 4 GROUP BY 1) b ON  a.player_id= b.player_id WHERE a.item_id = 1014001) as d) e 
set c.count = c.count + IFNULL(e.favor,0) WHERE c.item_id = 1014001 and c.player_id= e.player_Id;


update player2item c ,(SELECT player_id,favor FROM (SELECT a.*,favor FROM player2item a LEFT JOIN (SELECT player_id,1013001,sum(favor) as favor FROM hire_officer_favor a 
LEFT JOIN officer_prototype b ON a.officer_pro_id = b.id WHERE b.quality = 3 GROUP BY 1) b ON  a.player_id= b.player_id WHERE a.item_id = 1013001) as d) e 
set c.count = c.count + IFNULL(e.favor,0) WHERE c.item_id = 1013001 and c.player_id= e.player_Id;

-- 旧
update player2item c ,(SELECT player_id,favor FROM (SELECT a.*,favor FROM player2item a LEFT JOIN (SELECT player_id,1015004,sum(favor) as favor FROM hire_officer_favor a 
LEFT JOIN officer_prototype b ON a.officer_pro_id = b.id WHERE b.quality = 5 GROUP BY 1) b ON  a.player_id= b.player_id WHERE a.item_id = 1015004) as d) e 
set c.count = c.count + IFNULL(e.favor,0) WHERE c.item_id = 1015004 and c.player_id= e.player_Id;
-- 新
update player2item c LEFT JOIN (SELECT player_id,1015004,sum(favor) as favor FROM hire_officer_favor a LEFT JOIN officer_prototype b ON a.officer_pro_id = b.id WHERE b.quality = 5 GROUP BY 1) e
on c.player_id= e.player_id set c.count = c.count+IFNULL(e.favor,0) where c.item_id = 1015004 and c.player_id= e.player_Id;

UPDATE officer a ,(SELECT a.id,a.player_id, SUM(b.power_addition) as power_addition FROM officer a LEFT join equipment b ON a.player_id = b.player_id and a.id = b.officer_id GROUP BY 1)as c 
SET a.equipment_power = a.equipment_power + IFNULL(c.power_addition,0) where a.player_id = c.player_id and a.id=c.id;


INSERT IGNORE INTO player2item SELECT player_id,1013001,sum(favor) FROM hire_officer_favor a LEFT JOIN officer_prototype b ON a.officer_pro_id = b.id WHERE b.quality = 3 GROUP BY 1;
INSERT IGNORE INTO player2item SELECT player_id,1014001,sum(favor) FROM hire_officer_favor a LEFT JOIN officer_prototype b ON a.officer_pro_id = b.id WHERE b.quality = 4 GROUP BY 1;
INSERT IGNORE INTO player2item SELECT player_id,1015004,sum(favor) FROM hire_officer_favor a LEFT JOIN officer_prototype b ON a.officer_pro_id = b.id WHERE b.quality = 5 GROUP BY 1;







