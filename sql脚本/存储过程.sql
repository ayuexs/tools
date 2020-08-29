-- 按司令部等级插入载具
CREATE PROCEDURE update_player2coreUnit()
BEGIN
	DECLARE done int DEFAULT 0;
	declare a_city_id bigint default 0;
	declare a_player_id bigint default 0;
	declare a_player_level bigint default 0;
	declare a_core_unit_id bigint default 1000100000000000;

	declare a_faction bigint default 0;
	declare a_reputation_level bigint default -1;
	declare a_is_have_alliancecard bigint default 0;

	declare b_player_id bigint default 0;
	declare b_tech_id bigint default 0;	
	declare player2tech cursor for select player_id,tech_id from player_active_tech where tech_id = 1110 or tech_id = 2110 or tech_id = 3110 or tech_id = 4110; 

	declare city cursor for select id,player_id,level from city where id >0 and level>=3;  
	declare continue HANDLER for not found set done = 1;
-- 按市政厅等级插入载具
set @aaa = (select unix_timestamp(now()));
	open city;
	REPEAT
		FETCH city INTO a_city_id,a_player_id,a_player_level;
 
			IF NOT DONE THEN 
					IF(a_player_level > 18) THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,1,1,400,0,NULL,1,1);
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,2,1,400,0,NULL,0,1);
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,3,1,400,0,NULL,0,1);
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,4,1,400,0,NULL,0,1);
					set a_core_unit_id = a_core_unit_id+5;
					
					ELSEIF(a_player_level > 13) THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,1,1,400,0,NULL,1,1);
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,2,1,400,0,NULL,0,1);
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,3,1,400,0,NULL,0,1);
					set a_core_unit_id = a_core_unit_id+6;

					ELSEIF(a_player_level > 7) THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,1,1,400,0,NULL,1,1);
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,2,1,400,0,NULL,0,1);
					set a_core_unit_id = a_core_unit_id+7;
					
					ELSEIF(a_player_level > 2) THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,1,1,400,0,NULL,1,1) ;
					set a_core_unit_id = a_core_unit_id+8;

					
				END IF;		
			END IF;

	 UNTIL done END REPEAT;
	close city;
 set @bbb = (select unix_timestamp(now()));
select @bbb-@aaa;
-- 按玩家阵营，声望等级，是否有军团卡插入载具
-- 重新开始一个循环
 select '===================================';
	set done = 0;
	set a_core_unit_id = 1000100000000004;
set @ccc = (select unix_timestamp(now()));
	open city;
	REPEAT
		FETCH city INTO a_city_id,a_player_id,a_player_level;
			IF NOT DONE THEN 
			SET a_faction=(SELECT faction FROM player where id = a_player_id);
			set a_reputation_level=(SELECT reputation_level FROM player where id = a_player_id);
			SET a_is_have_alliancecard = (SELECT is_have_alliancecard FROM player where id = a_player_id);
			
				IF(a_reputation_level > 2) THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,11,1,500,0,NULL,0,1) ;
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,12,1,625,0,NULL,0,1) ;
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,13,1,500,0,NULL,0,1) ;
						IF(a_is_have_alliancecard=1) THEN
							set a_core_unit_id = a_core_unit_id+1;
							INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,101,1,550,0,NULL,0,1) ;
							set a_core_unit_id = a_core_unit_id+5;
						ELSE
							set a_core_unit_id = a_core_unit_id+6;
						END IF;
			
				ELSEIF(a_faction =1)THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,11,1,400,0,NULL,0,1);
						IF(a_is_have_alliancecard=1) THEN
							set a_core_unit_id = a_core_unit_id+1;
							INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,101,1,550,0,NULL,0,1);
							set a_core_unit_id = a_core_unit_id+7;
						ELSE
							set a_core_unit_id = a_core_unit_id+8;
						END IF;

				ELSEIF(a_faction =2)THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,12,1,400,0,NULL,0,1) ;
						IF(a_is_have_alliancecard=1) THEN
							set a_core_unit_id = a_core_unit_id+1;
							INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,101,1,550,0,NULL,0,1);
							set a_core_unit_id = a_core_unit_id+7;
						ELSE
							set a_core_unit_id = a_core_unit_id+8;
						END IF;

				ELSEIF(a_faction =3)THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,13,1,400,0,NULL,0,1);
						IF(a_is_have_alliancecard=1) THEN
							set a_core_unit_id = a_core_unit_id+1;
							INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,101,1,550,0,NULL,0,1);
							set a_core_unit_id = a_core_unit_id+7;
						ELSE
							set a_core_unit_id = a_core_unit_id+8;
						END IF;
				ELSE
						IF(a_is_have_alliancecard=1) THEN
							INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,101,1,550,0,NULL,0,1) ;
							set a_core_unit_id = a_core_unit_id+8;
						END IF;
				
				END IF;		
			END IF;
	 UNTIL done END REPEAT;
	close city;
 set @ddd = (select unix_timestamp(now()));
select @ddd-@ccc;
-- 按科技更新载具恢复速度
-- 重新开始一个循环
	set done = 0;
 set @eee = (select unix_timestamp(now()));
	open player2tech;
	REPEAT
		FETCH player2tech INTO b_player_id,b_tech_id;
			IF NOT DONE THEN 
				IF(b_tech_id = 4110) THEN
					UPDATE city_data set core_unit_recovery_speed = 24 WHERE player_id = b_player_id;
				ELSEIF (b_tech_id = 3110) THEN
					UPDATE city_data set core_unit_recovery_speed = 19 WHERE player_id = b_player_id;
				ELSEIF (b_tech_id = 2110) THEN
					UPDATE city_data set core_unit_recovery_speed = 15 WHERE player_id = b_player_id;
				ELSEIF (b_tech_id = 1110) THEN
					UPDATE city_data set core_unit_recovery_speed = 13 WHERE player_id = b_player_id;
				END IF;		
			END IF;
	 UNTIL done END REPEAT;
	close player2tech;
  set @fff = (select unix_timestamp(now()));
select @fff-@eee;
END;
CALL update_player2coreUnit();







-- 按玩家阵营，声望等级，是否有军团卡插入载具

CREATE PROCEDURE update_player2coreUnit_faction()
BEGIN
	DECLARE done int DEFAULT 0;
	declare a_faction bigint default 0;
	declare a_player_id bigint default 0;
	declare a_reputation_level bigint default -1;
	declare a_is_have_alliancecard bigint default 0;
	declare a_core_unit_id bigint default 1000100000000004;

	declare player2CoreUnit cursor for select id,faction,reputation_level,is_have_alliancecard from player where id >0;  
	declare continue HANDLER for not found set done = 1;

	open player2CoreUnit;
	REPEAT
		FETCH player2CoreUnit INTO a_player_id,a_faction,a_reputation_level,a_is_have_alliancecard;
			IF NOT DONE THEN 
				IF(a_reputation_level > 2) THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,11,1,500,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,12,1,625,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
					set a_core_unit_id = a_core_unit_id+1;
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,13,1,500,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
						IF(a_is_have_alliancecard>0) THEN
							set a_core_unit_id = a_core_unit_id+1;
							INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,101,1,550,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
							set a_core_unit_id = a_core_unit_id+5;
						ELSE
							set a_core_unit_id = a_core_unit_id+6;
						END IF;

				ELSEIF(a_faction =1)THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,11,1,400,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
						IF(a_is_have_alliancecard>0) THEN
							set a_core_unit_id = a_core_unit_id+1;
							INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,101,1,550,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
							set a_core_unit_id = a_core_unit_id+7;
						ELSE
							set a_core_unit_id = a_core_unit_id+8;
						END IF;

				ELSEIF(a_faction =2)THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,12,1,400,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
						IF(a_is_have_alliancecard>0) THEN
							set a_core_unit_id = a_core_unit_id+1;
							INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,101,1,550,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
							set a_core_unit_id = a_core_unit_id+7;
						ELSE
							set a_core_unit_id = a_core_unit_id+8;
						END IF;

					ELSEIF(a_faction =3)THEN
					INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,13,1,400,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
						IF(a_is_have_alliancecard>0) THEN
							set a_core_unit_id = a_core_unit_id+1;
							INSERT INTO `player2core_unit` VALUES (a_core_unit_id,a_player_id,101,1,550,0,NULL,0,0) ON DUPLICATE KEY UPDATE id = a_core_unit_id;
							set a_core_unit_id = a_core_unit_id+7;
						ELSE
							set a_core_unit_id = a_core_unit_id+8;
						END IF;
				
				ELSE
					set a_core_unit_id = a_core_unit_id+9;
				END IF;		
			END IF;
	 UNTIL done END REPEAT;
	close player2CoreUnit;
END;
CALL update_player2coreUnit_faction();

-- 按科技更新载具恢复速度

CREATE PROCEDURE update_core_unit_recovery()
BEGIN
	DECLARE done int DEFAULT 0;
	declare a_player_id bigint default 0;
	declare a_tech_id bigint default 0;

	declare player2CoreUnit cursor for select player_id,tech_id from player_active_tech where tech_id = 1110 or tech_id = 2110 or tech_id = 3110 or tech_id = 4110;  
	declare continue HANDLER for not found set done = 1;

	open player2CoreUnit;
	REPEAT
		FETCH player2CoreUnit INTO a_player_id,a_tech_id;
			IF NOT DONE THEN 
				IF(a_tech_id = 4110) THEN
					UPDATE city_data set core_unit_recovery_speed = 24 WHERE player_id = a_player_id;
				ELSEIF (a_tech_id = 3110) THEN
					UPDATE city_data set core_unit_recovery_speed = 19 WHERE player_id = a_player_id;
				ELSEIF (a_tech_id = 2110) THEN
					UPDATE city_data set core_unit_recovery_speed = 15 WHERE player_id = a_player_id;
				ELSEIF (a_tech_id = 1110) THEN
					UPDATE city_data set core_unit_recovery_speed = 13 WHERE player_id = a_player_id;
				END IF;		
			END IF;
	 UNTIL done END REPEAT;
	close player2CoreUnit;
END;
CALL update_core_unit_recovery();


--

CREATE PROCEDURE update_troop_allianceId()
BEGIN 
DECLARE playerId LONG;  
DECLARE done INT DEFAULT FALSE; 
  
DECLARE My_Cursor CURSOR FOR ( SELECT id FROM player WHERE id > -1);  
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;   
  
OPEN My_Cursor;  
  myLoop: LOOP 
    FETCH My_Cursor INTO playerId;  
    IF done THEN 
      LEAVE myLoop; 
    END IF;  
    -- 内层循环，根据每个玩家的id查询是否有军团
		BEGIN
			SET @allianceId = (SELECT alliance_id FROM player2alliance WHERE player_id = playerId);
			IF(@allianceId IS NOT NULL) THEN
				UPDATE troop SET alliance_id = @allianceId WHERE player_id = playerId;
			END IF; 
     END;
    COMMIT; 
  END LOOP myLoop; 
  CLOSE My_Cursor;
END;

CALL update_troop_allianceId();

--


















-- 载具插入
CREATE PROCEDURE update_player2coreUnit()
BEGIN
	DECLARE done int DEFAULT 0;
	declare a_city_id bigint default 0;
	declare a_player_id bigint default 0;
	declare a_player_level bigint default 0;
	declare a_core_unit_id bigint default 1000100000000000;

	declare a_faction bigint default 0;
	declare a_reputation_level bigint default -1;
	declare a_is_have_alliancecard bigint default 0;

	declare b_player_id bigint default 0;
	declare b_tech_id bigint default 0;	
	declare player2tech cursor for select player_id,tech_id from player_active_tech where tech_id = 1110 or tech_id = 2110 or tech_id = 3110 or tech_id = 4110; 

	declare city cursor for select id,player_id,level from city where id >0 and level>=3;  
	declare continue HANDLER for not found set done = 1;
-- 按市政厅等级插入载具
-- 批量插入
	set @aaa = (select unix_timestamp(now()));
	set @exesql = "";
	set @exedata ="(1,1,12,1,400,0,NULL,0,0)";

	set @updateexesql24 = "1";
	set @updateexesql19 = "1";
	set @updateexesql15 = "1";
	set @updateexesql13 = "1";
	set @updateexedata24 ="1";
	set @updateexedata19 ="1";
	set @updateexedata15 ="1";
	set @updateexedata13 ="1";

	open city;
	REPEAT
		FETCH city INTO a_city_id,a_player_id,a_player_level;
 
			IF NOT DONE THEN 
					IF(a_player_level > 18) THEN
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","1,1,400,0,NULL,1,1)");
					set a_core_unit_id = a_core_unit_id+1;
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","2,1,400,0,NULL,0,1)");
					set a_core_unit_id = a_core_unit_id+1;
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","3,1,400,0,NULL,0,1)");
					set a_core_unit_id = a_core_unit_id+1;
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","4,1,400,0,NULL,0,1)");
					set a_core_unit_id = a_core_unit_id+5;
					
					ELSEIF(a_player_level > 13) THEN
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","1,1,400,0,NULL,1,1)");
					set a_core_unit_id = a_core_unit_id+1;
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","2,1,400,0,NULL,0,1)");
					set a_core_unit_id = a_core_unit_id+1;
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","3,1,400,0,NULL,0,1)");
					set a_core_unit_id = a_core_unit_id+6;

					ELSEIF(a_player_level > 7) THEN
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","1,1,400,0,NULL,1,1)");
					set a_core_unit_id = a_core_unit_id+1;
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","2,1,400,0,NULL,0,1)");
					set a_core_unit_id = a_core_unit_id+7;
					
					ELSEIF(a_player_level > 2) THEN
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","1,1,400,0,NULL,1,1)");
					set a_core_unit_id = a_core_unit_id+8;

					
				END IF;		
			END IF;

	 UNTIL done END REPEAT;
	close city;
				SET @exesql =CONCAT("INSERT INTO `player2core_unit` VALUES ",@exedata);
				prepare stmt from @exesql;
				execute stmt;
				DEALLOCATE prepare stmt;
				set @exesql = "";
				set @exedata ="(2,1,12,1,400,0,NULL,0,0)";
 set @bbb = (select unix_timestamp(now()));
select @bbb-@aaa;
-- 按玩家阵营，声望等级，是否有军团卡插入载具
-- 批量插入
-- 重新开始一个循环
 select '===================================';
	set done = 0;
	set a_core_unit_id = 1000100000000004;
set @ccc = (select unix_timestamp(now()));
	open city;
	REPEAT
		FETCH city INTO a_city_id,a_player_id,a_player_level;
			IF NOT DONE THEN 
			SET a_faction=(SELECT faction FROM player where id = a_player_id);
			set a_reputation_level=(SELECT reputation_level FROM player where id = a_player_id);
			SET a_is_have_alliancecard = (SELECT is_have_alliancecard FROM player where id = a_player_id);
			
				IF(a_reputation_level > 2) THEN
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","11,1,500,0,NULL,0,0)");
					set a_core_unit_id = a_core_unit_id+1;
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","12,1,625,0,NULL,0,0)");
					set a_core_unit_id = a_core_unit_id+1;
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","13,1,500,0,NULL,0,0)");
						IF(a_is_have_alliancecard=1) THEN
							set a_core_unit_id = a_core_unit_id+1;
							set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","101,1,550,0,NULL,0,0)");
							set a_core_unit_id = a_core_unit_id+5;
						ELSE
							set a_core_unit_id = a_core_unit_id+6;
						END IF;
			
				ELSEIF(a_faction =1)THEN
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","11,1,500,0,NULL,0,0)");
						IF(a_is_have_alliancecard=1) THEN
							set a_core_unit_id = a_core_unit_id+1;
							set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","101,1,550,0,NULL,0,0)");
							set a_core_unit_id = a_core_unit_id+7;
						ELSE
							set a_core_unit_id = a_core_unit_id+8;
						END IF;

				ELSEIF(a_faction =2)THEN
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","12,1,625,0,NULL,0,0)");
						IF(a_is_have_alliancecard=1) THEN
							set a_core_unit_id = a_core_unit_id+1;
							set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","101,1,550,0,NULL,0,0)");
							set a_core_unit_id = a_core_unit_id+7;
						ELSE
							set a_core_unit_id = a_core_unit_id+8;
						END IF;

				ELSEIF(a_faction =3)THEN
					set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","13,1,500,0,NULL,0,0)");
						IF(a_is_have_alliancecard=1) THEN
							set a_core_unit_id = a_core_unit_id+1;
							set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","101,1,550,0,NULL,0,0)");
							set a_core_unit_id = a_core_unit_id+7;
						ELSE
							set a_core_unit_id = a_core_unit_id+8;
						END IF;
				ELSE
						IF(a_is_have_alliancecard=1) THEN
							set @exedata = CONCAT(@exedata,",(",a_core_unit_id,",",a_player_id,",","101,1,550,0,NULL,0,0)");
							set a_core_unit_id = a_core_unit_id+8;
						END IF;
				
				END IF;		
			END IF;
	 UNTIL done END REPEAT;
	close city;
				SET @exesql =CONCAT("INSERT INTO `player2core_unit` VALUES ",@exedata);
				prepare stmt from @exesql;
				execute stmt;
				DEALLOCATE prepare stmt;
				set @exedata ="";
				set @exesql ="";
 set @ddd = (select unix_timestamp(now()));
select @ddd-@ccc;
-- 按科技更新载具恢复速度
-- 批量插入
-- 重新开始一个循环
	set done = 0;
 set @eee = (select unix_timestamp(now()));
	open player2tech;
	REPEAT
		FETCH player2tech INTO b_player_id,b_tech_id;
			IF NOT DONE THEN 
				IF(b_tech_id = 4110) THEN
					set @updateexedata24 = CONCAT(@updateexedata24,",",b_player_id);	
				ELSEIF (b_tech_id = 3110) THEN
					set @updateexedata19 = CONCAT(@updateexedata19,",",b_player_id);
				ELSEIF (b_tech_id = 2110) THEN
					set @updateexedata15 = CONCAT(@updateexedata15,",",b_player_id);
				ELSEIF (b_tech_id = 1110) THEN
					set @updateexedata13 = CONCAT(@updateexedata13,",",b_player_id);
				END IF;		
			END IF;
	 UNTIL done END REPEAT;
	close player2tech;

				SET @updateexesql13 =CONCAT("UPDATE city_data set core_unit_recovery_speed = 13 WHERE player_id in (",@updateexedata13,")");
				prepare stmt from @updateexesql13;
				execute stmt;
				DEALLOCATE prepare stmt;
				set @updateexedata13 ="";
				set @updateexesql13 ="";

				SET @updateexesql15 =CONCAT("UPDATE city_data set core_unit_recovery_speed = 15 WHERE player_id in (",@updateexedata15,")");
				prepare stmt from @updateexesql15;
				execute stmt;
				DEALLOCATE prepare stmt;
				set @updateexedata15 ="";
				set @updateexesql15 ="";

				SET @updateexesql19 =CONCAT("UPDATE city_data set core_unit_recovery_speed = 19 WHERE player_id in (",@updateexedata19,")");
				prepare stmt from @updateexesql19;
				execute stmt;
				DEALLOCATE prepare stmt;
				set @updateexedata19 ="";
				set @updateexesql19 ="";

				SET @updateexesql24 =CONCAT("UPDATE city_data set core_unit_recovery_speed = 24 WHERE player_id in (",@updateexedata24,")");
				prepare stmt from @updateexesql24;
				execute stmt;
				DEALLOCATE prepare stmt;
				set @updateexedata24 ="";
				set @updateexesql24 ="";

				
  set @fff = (select unix_timestamp(now()));
select @fff-@eee;
END;
CALL update_player2coreUnit();

-- 删除存储过程
drop procedure update_player2coreUnit;

delete from player2core_unit where id<100;

-- 如果一个session的预处理语句过多，可能会达到max_prepared_stmt_count的上限值。10万条超过了，5万六千条没问题；
-- 将第一个载具放到部队上
-- 性能高
UPDATE troop a LEFT JOIN player2core_unit b ON a.player_id = b.player_id SET a.core_unit_id = b.id where b.pro_id =1 and a.sort =0;

-- 性能低
update troop a ,(SELECT a.player_id,a.core_unit_id,a.sort,b.id,b.pro_id FROM troop a LEFT JOIN player2core_unit b ON a.player_id = b.player_id where b.pro_id =1 and a.sort =0) b 
SET a.core_unit_id = b.id where a.player_id = b.player_id and a.sort = 0;


-- 根据司令部等级刷新载具等级
update player2core_unit a LEFT JOIN city b on a.player_id = b.player_id LEFT JOIN city2building c on b.id = c.city_id set a.`level` = c.building_level 
WHERE c.building_id = 5 and c.building_level > 1 and (a.pro_id = 1 or a.pro_id = 2 or a.pro_id = 3 or a.pro_id = 4) ;

-- 根据载具等级更新载具血量
update player2core_unit a LEFT JOIN core_unit_level_prototype b on a.pro_id = b.pro_id set a.hp = b.hp WHERE a.`level` = b.`level`and a.`level` >1;


