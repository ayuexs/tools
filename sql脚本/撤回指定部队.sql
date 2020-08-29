UPDATE troop
SET 
start_map_id=null,
current_map_id=null,
target_type=null,
target_id=null,
target_speed_age=NULL,
state = -1,
action = NULL,
create_time=null,
state_update_timestamp=unix_timestamp(now()),
action_start_timestamp=NULL,
win_streak_count=0,
win_npc_streak_count=0,
food=0,
water=0,
wood=0,
energy=0,
credit =0,
core_unit_efficiency=0,
total_space=0,
exterior_id=null,
oil_cost=0,
current_item_id=NULL,
is_captured = 0,
is_auto_replenish = 1 where id in(1000100000007831,1000100000008775,2000100000005605,2000100000005672);

DELETE FROM march where troop_id in(1000100000007831,1000100000008775,2000100000005605,2000100000005672);

update troop2officer set is_expedition = 0 where troop_id in(1000100000007831,1000100000008775,2000100000005605,2000100000005672);