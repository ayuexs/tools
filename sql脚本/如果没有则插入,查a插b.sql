delete from task_event where event_kind_id=1101;
#有多少条数据select产生多少条记录，但是显示不一定是全部记录
#可以确定每个玩家都插入一条记录
insert ignore into task_event (select player_id,904,-1,-1,-1,-1,0,now() from task_event);
insert ignore into task_event (select player_id,905,-1,-1,-1,-1,0,now() from task_event);
insert ignore into task_event (select player_id,404,-1,-1,-1,-1,0,now() from task_event);
insert ignore into task_event (select player_id,1001,-1,-1,-1,-1,0,now() from task_event);
insert ignore into task_event (select player_id,1002,-1,-1,-1,-1,0,now() from task_event);
insert ignore into task_event (select player_id,1003,-1,-1,-1,-1,0,now() from task_event);

UPDATE task_event a LEFT JOIN (SELECT player_id,total_amount FROM task_event WHERE event_kind_id = 1001) b ON a.player_id = b.player_id SET a.total_amount = a.total_amount + b.total_amount WHERE a.event_kind_id = 904;
UPDATE task_event a LEFT JOIN (SELECT player_id,total_amount FROM task_event WHERE event_kind_id = 1002) b ON a.player_id = b.player_id SET a.total_amount = a.total_amount + b.total_amount WHERE a.event_kind_id = 905;
UPDATE task_event a LEFT JOIN (SELECT player_id,total_amount FROM task_event WHERE event_kind_id = 1003) b ON a.player_id = b.player_id SET a.total_amount = a.total_amount + b.total_amount WHERE a.event_kind_id = 404;


delete from task_event where total_amount=0;
delete from task_event where event_kind_id in (1001,1002,1003);


insert ignore into text_data_en_prototype SELECT perk_name_key ,'nihao' FROM army_level_prototype

insert ignore into text_data_en_prototype SELECT perk_description_key ,'nihaoaaaa' FROM army_level_prototype