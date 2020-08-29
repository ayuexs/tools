drop procedure if exists update_player2coreUnit;
delimiter %%
-- 载具插入
CREATE PROCEDURE update_player2coreUnit()
BEGIN
	DECLARE done int DEFAULT 0;
	declare a_player_id bigint default 0;
	declare a_core_unit_id bigint default 0;
	declare add_count bigint default 0;
	
	declare player cursor for select id from player where is_have_month_card=1;  
	declare continue HANDLER for not found set done = 1;
-- 批量插入
	set @exesql = "";
	set @exedata ="(1,1,7,0,400,0,NULL,0)";
	set a_core_unit_id=(SELECT MAX(id) from player2core_unit);
	set a_core_unit_id = a_core_unit_id+1;		

	open player;
	REPEAT
		FETCH player INTO a_player_id;
 
			IF NOT DONE THEN 
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","7,0,400,0,NULL,0)");
					set a_core_unit_id = a_core_unit_id+1;		
					set add_count = add_count+1;
			END IF;

	 UNTIL done END REPEAT;
	close player;
				SET @exesql =CONCAT("INSERT INTO `player2core_unit` VALUES ",@exedata);
				prepare stmt from @exesql;
				execute stmt;
				DEALLOCATE prepare stmt;

select add_count;
END
%%
delimiter ;
CALL update_player2coreUnit();


-- 删除存储过程
drop procedure update_player2coreUnit;

delete from player2core_unit where id<100;






