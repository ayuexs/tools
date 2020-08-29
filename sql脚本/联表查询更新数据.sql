SELECT * FROM army_prototype where army_class in (SELECT b.army_class FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id);

update game.city2army SET army_count = army_count+ IFNULL((SELECT  army_amount FROM troop2officer WHERE officer_id = 1000100000000001),0) where city_id = 1000100000000000 and army_id = 1210;

UPDATE troop2officer SET army_amount = 0 WHERE officer_id in(SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id RIGHT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE  FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total);

UPDATE officer SET army_id = 1210 where id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE  b.army_class = 2 AND FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total
 );

UPDATE officer SET army_id = 1110 where id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE  b.army_class = 1 AND FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total
 );

UPDATE officer SET army_id = 1310 where id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE  b.army_class = 3 AND FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total
);


SELECT a.*,c.army_amount from city2army a LEFT JOIN officer b  ON a.city_id = b.city_id and a.army_id = b.army_id LEFT JOIN troop2officer c on b.id = c.officer_id WHERE b.id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE  FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total);


SELECT a.army_count+c.army_amount from city2army a LEFT JOIN officer b  ON a.city_id = b.city_id and a.army_id = b.army_id LEFT JOIN troop2officer c on b.id = c.officer_id WHERE b.id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total);

update city2army SET army_count = army_count+(SELECT army_amount FROM(SELECT c.* from city2army a LEFT JOIN officer b  ON a.city_id = b.city_id and a.army_id = b.army_id LEFT JOIN troop2officer c on b.id = c.officer_id WHERE b.id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE   FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total))as csum) 
where city_id in (SELECT city_id FROM(SELECT a.* from city2army a LEFT JOIN officer b  ON a.city_id = b.city_id and a.army_id = b.army_id LEFT JOIN troop2officer c on b.id = c.officer_id WHERE b.id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE   FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total))as csum)
AND army_id in (SELECT army_id FROM(SELECT a.* from city2army a LEFT JOIN officer b  ON a.city_id = b.city_id and a.army_id = b.army_id LEFT JOIN troop2officer c on b.id = c.officer_id WHERE b.id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE   FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total))as csum)


SELECT * FROM city2army where city_id in (SELECT city_id FROM(SELECT a.* from city2army a LEFT JOIN officer b  ON a.city_id = b.city_id and a.army_id = b.army_id LEFT JOIN troop2officer c on b.id = c.officer_id WHERE b.id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE  b.army_class = 2 AND FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total))as csum)
AND city_id in (SELECT city_id FROM(SELECT a.* from city2army a LEFT JOIN officer b  ON a.city_id = b.city_id and a.army_id = b.army_id LEFT JOIN troop2officer c on b.id = c.officer_id WHERE b.id in (SELECT id FROM (SELECT a.* FROM officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id LEFT JOIN army_prototype c ON b.army_class = c.army_class AND c.can_be_used = 1 WHERE  b.army_class = 2 AND FLOOR(a.army_id / 100) % 10 != FLOOR(c.id / 100) % 10 GROUP BY a.player_id, a.id ) as total))as csum)


SELECT  ifnull(null,0) army_amount as amount FROM troop2officer WHERE officer_id = 1000100000000003 

-- 性能高
UPDATE troop a LEFT JOIN player2core_unit b ON a.player_id = b.player_id SET a.core_unit_id = b.id where b.pro_id =1 and a.sort =0;

-- 性能低，性能相差近100倍
update troop a ,(SELECT a.player_id,a.core_unit_id,a.sort,b.id,b.pro_id FROM troop a LEFT JOIN player2core_unit b ON a.player_id = b.player_id where b.pro_id =1 and a.sort =0) b 
SET a.core_unit_id = b.id where a.player_id = b.player_id and a.sort = 0;



