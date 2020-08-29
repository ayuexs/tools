select a.* from player2item a where EXISTS(select b.id from player b where a.player_id = b.id);


SELECT * from player2item where player_id in (SELECT id from player );


SELECT * from player a where a.id in (SELECT player_id from player2item b WHERE b.player_id = a.id)

SELECT * from player where id in (SELECT player_id FROM player2item)

SELECT * from player a where EXISTS (SELECT player_id from player2item b where b.player_id = a.id)



EXPLAIN SELECT * from player a where a.id in (SELECT player_id from player2item b WHERE b.player_id = a.id)

EXPLAIN SELECT * from player where id in (SELECT player_id FROM player2item)

EXPLAIN SELECT * from player a where EXISTS (SELECT player_id from player2item b where b.player_id = a.id)