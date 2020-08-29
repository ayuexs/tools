

SELECT CONCAT(ROUND((SELECT count(a.id) from equipment a,equipment_prototype b where a.pro_id = b.id  and b.army_class  = 1)/(SELECT count(a.id) from equipment a,equipment_prototype b where a.pro_id = b.id )*100),'%');
SELECT CONCAT(ROUND((SELECT count(a.id) from equipment a,equipment_prototype b where a.pro_id = b.id  and b.army_class  = 2)/(SELECT count(a.id) from equipment a,equipment_prototype b where a.pro_id = b.id )*100),'%');
SELECT CONCAT(ROUND((SELECT count(a.id) from equipment a,equipment_prototype b where a.pro_id = b.id  and b.army_class  = 3)/(SELECT count(a.id) from equipment a,equipment_prototype b where a.pro_id = b.id )*100),'%');
SELECT CONCAT(ROUND((SELECT count(a.id) from equipment a,equipment_prototype b where a.pro_id = b.id  and b.army_class  = 4)/(SELECT count(a.id) from equipment a,equipment_prototype b where a.pro_id = b.id )*100),'%');
