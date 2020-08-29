SELECT a.* FROM player2item a RIGHT JOIN (SELECT player_id,MAX(item_id)as item_id from player2item GROUP BY player_id) b on a.player_id = b.player_id and a.item_id= b.item_id
