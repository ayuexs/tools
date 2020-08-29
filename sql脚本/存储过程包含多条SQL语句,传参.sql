CREATE PROCEDURE clear(IN playerId long)
BEGIN
	declare a_player_id bigint default 0;
	set a_player_id = playerId;
-- accusation_player_info
	delete from accusation_player_info where accusation_player_id = a_player_id;
	delete from accusation_player_info where informer_player_id = a_player_id;
-- alert
	delete from alert where target_player_id = a_player_id;
	delete a from alert a LEFT JOIN march b on a.march_id = b.id where b.player_id = a_player_id;
-- alliance_applycation
	delete from alliance_applycation where player_id = a_player_id;
-- alliance_invitation
	delete from alliance_invitation where player_id = a_player_id;
-- army_recruit_action
	delete from army_recruit_action where player_id = a_player_id;
-- battle_info
	delete a from battle_info a LEFT JOIN mail_report_detail_battle b on a.id = b.battle_info_id LEFT JOIN mail_report c on b.report_id = c.id where c.player_id=a_player_id;
-- campaign_player_score
	delete from campaign_player_score where player_id = a_player_id;
-- campaign_score_rewards_record
	delete from campaign_score_rewards_record where player_id = a_player_id; 
-- city
   delete from city where player_id  =a_player_id;
-- city_data
	delete from city_data where player_id = a_player_id;
-- colonization
	delete from colonization where player_id = a_player_id;
-- feedback_session
	delete from feedback_session where player_id = a_player_id;
-- fort
	update map2cover a , fort b set a.cover_type = 0,a.owner_id=-1,a.peace_time=0 where b.player_id = a_player_id and a.map_id=b.map_id;
	delete from fort where player_id = a_player_id;
-- hire_officer_pool_player_record
	delete from hire_officer_pool_player_record where player_id = a_player_id;
-- mail_favorite
	delete from mail_favorite where player_id =a_player_id;
-- mail_report_detail_battle
	delete a from mail_report_detail_battle a LEFT JOIN mail_report b on a.report_id = b.id where b.player_id = a_player_id;
-- mail_report_detail_event
	delete a from mail_report_detail_event a LEFT JOIN mail_report b on a.report_id = b.id where b.player_id = a_player_id;
-- mail_report_detail_officer
	delete a from mail_report_detail_officer a LEFT JOIN mail_report b on a.report_id = b.id where b.player_id = a_player_id;
-- mail_report_detail_resource
	delete a from mail_report_detail_resource a LEFT JOIN mail_report b on a.report_id = b.id where b.player_id = a_player_id;
-- mail_report4alliance_share
	delete a from mail_report4alliance_share a LEFT JOIN mail_report b on a.mail_report_id = b.id where b.player_id = a_player_id;
-- mail_report
	delete from mail_report where player_id = a_player_id;
-- mail_system_attachment
	delete a from mail_system_attachment a LEFT JOIN mail_system b on a.mail_system_id = b.id where b.player_id=a_player_id;
-- mail_system
	delete from mail_system where player_id = a_player_id;
-- map_collect
	delete from map_collect where player_id=a_player_id;
-- map2cover_drop_action
	delete a from map2cover_drop_action a LEFT JOIN map2cover b on a.map_id = b.map_id where b.cover_type!=4 and b.owner_id =a_player_id;
-- map2cover
	update map2cover set cover_type = 0,owner_id=-1,peace_time=0 where cover_type = 1 and owner_id= a_player_id; 
-- march
	delete from march where player_id=a_player_id;
-- officer2skill
	delete a from officer2skill a LEFT JOIN officer b on a.officer_id = b.id where b.player_id=a_player_id;
-- troop2officer
	delete a from troop2officer a LEFT JOIN officer b on a.officer_id = b.id where b.player_id=a_player_id;
-- officer
	delete from officer where player_id =a_player_id;
-- personal_event
	delete from personal_event where player_id =a_player_id;
-- player
	delete from player where id = a_player_id;
-- player_blacklist
	delete from player_blacklist where player_id = a_player_id;
	delete from player_blacklist where mask_player_id=a_player_id;
-- player_feedback
	delete from player_feedback where player_id =a_player_id;
-- player_hunt_info
	delete from player_hunt_info where player_id=a_player_id;
-- player_login_info
	delete from player_login_info where player_id =a_player_id;
-- player_login_reward_info
	delete from player_login_reward_info where player_id=a_player_id;
-- player2alliance
	delete from player2alliance where position != 5 and player_id =a_player_id;
-- player2campaign
	delete from player2campaign where player_id =a_player_id;
-- player2item
	delete from player2item where player_id =a_player_id;
-- player2notification
	delete from player2notification where player_id=a_player_id;
-- player2resource_domain
	update map2cover a , player2resource_domain b  set a.cover_type = 0,a.owner_id=-1,a.peace_time=0 where b.player_id = a_player_id and a.map_id=b.map_id;
	delete from player2resource_domain where player_id =a_player_id;
-- player2technology
	delete from player2technology where player_id=a_player_id;
-- player2technology_action
	delete from player2technology_action where player_id=a_player_id;
-- task_campaign
	delete from task_campaign where player_id = a_player_id;
-- task_campaign_event
	delete from task_campaign_event where player_id = a_player_id;
-- task_common
	delete from task_common where player_id = a_player_id;
-- task_common_chapter
	delete from task_common_chapter where player_id =a_player_id;
-- task_common_event
	delete from task_common_event where player_id = a_player_id;
-- task_event
	delete from task_event where player_id=a_player_id;
-- troop 
	delete from troop where player_id =a_player_id;
	
END;



CREATE PROCEDURE back_up(IN playerId long)
BEGIN
	declare a_player_id bigint default 0;
	set a_player_id = playerId;
	INSERT into back_up_data select 0, a_player_id, 'city', CONCAT_ws(',',id,name,player_id,map_id,level,durability,last_plundered_time,last_level_update_timestamp,last_durability_update_timestamp,is_fall) from city where  player_id  =a_player_id;

	INSERT into back_up_data select 0, a_player_id, 'city_data', CONCAT_ws(',',city_id,player_id,cap,res1,res2,res3,energy,forsaken_population,inheritor_population,tribe_population,resource_domain_calculate_timestamp) from city_data where  player_id =a_player_id;

	INSERT into back_up_data select 0, a_player_id, 'fort', CONCAT_ws(',',map_id,player_id,level,last_dur_update_time,durability,name,update_time,is_updating) from fort where  player_id=a_player_id;

	INSERT into back_up_data select 0, a_player_id, 'officer2skill', CONCAT_ws(',',a.officer_id,a.skill_id,a.skill_level,a.position) from officer2skill a left JOIN officer b on a.officer_id = b.id where  b.player_id=a_player_id;

	INSERT into back_up_data select 0, a_player_id, 'officer', CONCAT_ws(',',id,pro_id,player_id,city_id,level,experience,star_level,star_progress,vigor,army_amount,wound_amount,is_locked,troop_id,last_vigor_time) from officer where  player_id =a_player_id;

	INSERT into back_up_data select 0, a_player_id, 'player', CONCAT_ws(',',id,user_id,name,default_avatar,custom_avatar,custom_avatar_update_timestamp,flag,area,newbie_step,vip_level,vip_point,medal_level,medal_point,prosperity,honour,accumulation_diamond,diamond,protection_finish_timestamp,is_gm,is_have_month_card,is_have_alliance_card,personal_profile,current_install_id,current_platform,current_channel,current_language,current_package_id,current_country,create_time,state,world_post_count,domain_extra_count) from player where  id=a_player_id;

	INSERT into back_up_data select 0, a_player_id, 'player2item', CONCAT_ws(',',player_id,item_id,item_count) from player2item where  player_id=a_player_id;

	INSERT into back_up_data select 0, a_player_id, 'player2resource_domain', CONCAT_ws(',',map_id,player_id,durability,last_update_timestamp) from player2resource_domain where  player_id=a_player_id;

	INSERT into back_up_data select 0, a_player_id, 'player2technology', CONCAT_ws(',',player_id,tech_pro_id,level,action_id) from player2technology where  player_id=a_player_id;
	
	CALL clear(a_player_id);
END;

CALL back_up(1000100000000008);


drop procedure back_up;
drop procedure clear;


--    ------
CREATE PROCEDURE back_up(IN playerId long)
BEGIN
	declare a_DATA TEXT DEFAULT "";
	declare a_player_id bigint default 0;
	set a_player_id = playerId;

	-- accusation_player_info
	SELECT * from accusation_player_info where accusation_player_id = a_player_id;
	SELECT * from accusation_player_info where informer_player_id = a_player_id;


END;
CALL back_up(1000100000000005);


-- 查询结果是字符串没法直接用于SQL语句，必须拼接成sql语句重新执行
CREATE PROCEDURE back_up()
BEGIN
declare tmp_sql VARCHAR (200);
declare done int default 0;
declare cur_test CURSOR for 
SELECT CONCAT('select CONCAT_ws(\',\',', GROUP_CONCAT(COLUMN_NAME),') from ', 'accusation_player_info') from information_schema.columns where table_name = 'accusation_player_info' and TABLE_SCHEMA ='game';
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
open cur_test;
	repeat
	FETCH  cur_test into tmp_sql;
	IF NOT DONE THEN 
		SET @exesql1 = tmp_sql;
		prepare stmt1 from @exesql1;
		execute stmt1;
		DEALLOCATE prepare stmt1;
	END IF; 
  UNTIL done END REPEAT;
END;
CALL back_up();
drop procedure back_up;


SELECT CONCAT_ws(',',informer_player_id,accusation_player_id,type,descriptor,report_date) FROM accusation_player_info 

SELECT GROUP_CONCAT(COLUMN_NAME) from information_schema.columns where table_name in ('accusation_player_info','alert' )and TABLE_SCHEMA ='game' GROUP BY TABLE_name

SELECT TABLE_name from information_schema.`TABLES` where table_name in ('accusation_player_info','alert' )and TABLE_SCHEMA ='game'
