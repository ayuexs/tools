update city_data a LEFT JOIN troop b on a.city_id = b.city_id SET a.food = a.food+b.food WHERE b.food >0;

update city_data a LEFT JOIN troop b on a.city_id = b.city_id SET a.wood = a.wood+b.wood where b.wood >0;

update city_data a LEFT JOIN troop b on a.city_id = b.city_id SET a.water = a.water+b.water WHERE b.water>0;

UPDATE troop
SET state = -1,
action = NULL,
action_start_timestamp=NULL,
state_update_timestamp=unix_timestamp(now()),
target_id=null,
target_type=null,
target_speed_age=NULL,
win_streak_count=0,
win_npc_streak_count=0,
wounded_cure_timestamp=-1,
create_time=null,
start_map_id=null,
current_map_id=null,
food=0,
water=0,
wood=0,
energy=0,
population=0,
credit =0,
core_unit_efficiency=0,
total_space=0,
exterior_id=null,
oil_cost=0,
current_item_id=NULL;

DELETE FROM march;

DELETE FROM troop_attack_alert;

DELETE FROM troop_intercept_alert;

DELETE FROM alliance_event where event_type = 0 or event_type = 1;

update city_schedule SET schedule_value = 1;

DELETE FROM alliance_building_schedule;

update alliance_building SET state = 0;

update npc_mine SET gather_player_id = NULL,gather_troop_id = NULL,gather_output = NULL ,gather_amount = NULL,gather_start_timestamp = NULL,gather_update_timestamp = NULL,gather_end_timestamp = NULL;

update npc_greatmine set state = 0 where state = 1;

DELETE FROM troop_scavenge;




