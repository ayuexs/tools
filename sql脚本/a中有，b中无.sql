SELECT * FROM alliance WHERE id NOT in (SELECT alliance_id FROM player2alliance WHERE alliance_id is not NULL)



SELECT campaign_id FROM task_campaign_prototype WHERE id not in(SELECT id FROM task_condition_prototype )


