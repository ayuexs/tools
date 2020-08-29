DELETE FROM task_event WHERE event_kind_id  = 101 or event_kind_id  = 102;

drop procedure if exists update_task_event;
delimiter %%
CREATE PROCEDURE update_task_event()
BEGIN
  DECLARE done int DEFAULT 0;
  declare a_city_id bigint default 0;
  declare a_player_id bigint default 0;
  declare a_building_pro_id bigint default 0;
  declare a_level bigint default 0;
  declare a bigint default 1;


  
  declare city cursor for SELECT a.player_id,a.id,b.building_pro_id,b.`level` FROM city a LEFT JOIN city2building b on a.id = b.city_id where a.id>0 and b.`level`>0;  
  

  declare continue HANDLER for not found set done = 1;
  
  set @exesql1 = "";
  set @exedata1 ="(1,101,1,-1,-1,-1,1,'2018-08-01 19:03:52')";
  set @exesql2 = "";
  set @exedata2 ="(2,101,1,-1,-1,-1,1,'2018-08-01 19:03:52')";
  set @exesql3 = "";
  set @exedata3 ="(3,101,1,-1,-1,-1,1,'2018-08-01 19:03:52')";
  set @now=NOW();
  
  open city;
  REPEAT
    FETCH city INTO a_player_id,a_city_id,a_building_pro_id,a_level;
          
      IF NOT DONE THEN 
        set @exedata1 = CONCAT(@exedata1,",(",a_player_id,",","101,",a_building_pro_id,",-1,-1,-1,1,","'",@now,"')");
        set a = 1;  
				IF(a_city_id > 1000100000002650) THEN
          WHILE (a<=a_level) do
            set @exedata2 = CONCAT(@exedata2,",(",a_player_id,",","102,",a_building_pro_id,",",a,",-1,-1,1,","'",@now,"')");
            set a = a+1;        
          end WHILE;
        ELSE      
          WHILE (a<=a_level) do
            set @exedata3 = CONCAT(@exedata3,",(",a_player_id,",","102,",a_building_pro_id,",",a,",-1,-1,1,","'",@now,"')");
            set a = a+1;       
          end WHILE;
        end IF;	
      END IF;     
    UNTIL done END REPEAT;
  CLOSE city;
      SET @exesql1 =CONCAT("REPLACE INTO `task_event` VALUES ",@exedata1);
      prepare stmt1 from @exesql1;
      execute stmt1;
      DEALLOCATE prepare stmt1;

      SET @exesql2 =CONCAT("REPLACE INTO `task_event` VALUES ",@exedata2);
      prepare stmt2 from @exesql2;
      execute stmt2;
      DEALLOCATE prepare stmt2;

      SET @exesql3 =CONCAT("REPLACE INTO `task_event` VALUES ",@exedata3);
       prepare stmt3 from @exesql3;
      execute stmt3;
      DEALLOCATE prepare stmt3;
      
     
END;
%%
delimiter ;
CALL update_task_event();

-- 删除存储过程
drop procedure update_task_event;

DELETE FROM task_event WHERE player_id<100;

