SELECT id_client, count(*)  FROM balance_history
where balance_change_date like '$date-%'
group by id_client