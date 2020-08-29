INSERT IGNORE INTO troop 
SELECT 1000100000019201 + 1+ @rowno:=@rowno+1,a.city_id,a.city_id,null,null,null,null,null,null,-1,null,NOW(),NULL,NULL,-1,0,0,0,0,0,0,0,0,4,null,null,null,null,null,null,null,0 FROM (
select city_id FROM city2building WHERE level >=12 and LEVEL <18 and building_pro_id = 5 AND city_id not in (SELECT city_id FROM troop WHERE sort = 4) AND FLOOR(city_id / 100000000000) = 10001) as a, (SELECT @rowno:=0) b;

INSERT IGNORE INTO troop 
SELECT 1000200000016688 + 1+ @rowno:=@rowno+1,a.city_id,a.city_id,null,null,null,null,null,null,-1,null,NOW(),NULL,NULL,-1,0,0,0,0,0,0,0,0,4,null,null,null,null,null,null,null,0 FROM (
select city_id FROM city2building WHERE level >=12 and LEVEL <18 and building_pro_id = 5 AND city_id not in (SELECT city_id FROM troop WHERE sort = 4) AND FLOOR(city_id / 100000000000) = 10002) as a, (SELECT @rowno:=0) b;