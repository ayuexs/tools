update player as a, (SELECT a.player_id,b.level FROM city a LEFT JOIN city2building b on a.id = b.city_id where b.building_pro_id  =9)as b set a.vip_level = b.level WHERE a.id = b.player_id;
