-- 删除主线为24的
DELETE a from task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id WHERE b.main_line_id = 24;

-- 删除主线为1.2，5的符合条件得task_common
drop procedure if exists update_task_common;
delimiter %%
CREATE PROCEDURE update_task_common()
BEGIN
  DECLARE done int DEFAULT 0;
  declare a_player_id bigint default 0;
	declare b_player_id bigint default 0;
	declare c_player_id bigint default 0;

  declare task_common1 cursor for SELECT a.player_id FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id 
																	WHERE (b.main_line_id = 1 and b.priority >24) or (b.main_line_id = 1 and b.priority =24 and a.task_status = 1);
	declare task_common2 cursor for SELECT a.player_id FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id 
																	WHERE b.main_line_id = 2 and b.priority >26;
	declare task_common3 cursor for SELECT a.player_id FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id 
																	WHERE (b.main_line_id = 5 and b.priority >5) or (b.main_line_id = 5 and b.priority =5 and a.task_status = 1);

  declare continue HANDLER for not found set done = 1;
  
	set @exedata1 = "(1";
	set @exesql1 = "";
	set @exedata2 = "(1";
	set @exesql2 = "";
	set @exedata3 = "(1";
	set @exesql3 = "";
  
open task_common1;
  REPEAT
    FETCH task_common1 INTO a_player_id;
          
      IF NOT DONE THEN 
					 set @exedata1 = CONCAT(@exedata1,",",a_player_id);
      END IF;     
    UNTIL done END REPEAT;
  CLOSE task_common1;
			SET @exesql1 =CONCAT("DELETE a from task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id WHERE a.player_id not in",@exedata1,") and b.main_line_id = 1");
      prepare stmt from @exesql1;
      execute stmt;
      DEALLOCATE prepare stmt;					     


set done = 0;
open task_common2;
  REPEAT
    FETCH task_common2 INTO b_player_id;
          
      IF NOT DONE THEN 
					 set @exedata2 = CONCAT(@exedata2,",",b_player_id);
      END IF;     
    UNTIL done END REPEAT;
  CLOSE task_common2;
			SET @exesql2 =CONCAT("DELETE a from task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id WHERE a.player_id not in",@exedata2,") and b.main_line_id = 2");
      prepare stmt from @exesql2;
      execute stmt;
      DEALLOCATE prepare stmt;					     


set done = 0;
open task_common3;
  REPEAT
    FETCH task_common3 INTO c_player_id;
          
      IF NOT DONE THEN 
					 set @exedata3 = CONCAT(@exedata3,",",c_player_id);
      END IF;     
    UNTIL done END REPEAT;
  CLOSE task_common3;
			SET @exesql3 =CONCAT("DELETE a from task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id WHERE a.player_id not in",@exedata3,") and b.main_line_id = 5");
      prepare stmt from @exesql3;
      execute stmt;
      DEALLOCATE prepare stmt;					     


END
%%
delimiter ;
CALL update_task_common();

-- 删除存储过程
drop procedure update_task_common;


-- 删除task_common_event
DELETE b.* FROM task_common a RIGHT JOIN task_common_event b on a.task_id = b.task_id and a.player_id = b.player_id WHERE a.task_id is null;




-- 验证数据
SELECT a.*,b.* FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id WHERE b.main_line_id =1;
SELECT a.*,b.* FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id WHERE b.main_line_id =2;
SELECT a.*,b.* FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id WHERE b.main_line_id =5;


SELECT a.player_id FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id 
																	WHERE (b.main_line_id = 1 and b.priority >24) or (b.main_line_id = 1 and b.priority =24 and a.task_status = 1);
SELECT a.player_id FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id 
																	WHERE (b.main_line_id = 1 and b.priority <24) or (b.main_line_id = 1 and b.priority =24 and a.task_status = 0);


SELECT a.player_id FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id 
																	WHERE b.main_line_id = 2 and b.priority >26;
SELECT a.player_id FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id 
																	WHERE b.main_line_id = 2 and b.priority <=26;

SELECT a.player_id FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id 
																	WHERE (b.main_line_id = 5 and b.priority >5) or (b.main_line_id = 5 and b.priority =5 and a.task_status = 1);
SELECT a.player_id FROM task_common a LEFT JOIN task_common_mainline_prototype b on a.task_id = b.task_common_id 
																	WHERE (b.main_line_id = 5 and b.priority <5) or (b.main_line_id = 5 and b.priority =5 and a.task_status = 0);


