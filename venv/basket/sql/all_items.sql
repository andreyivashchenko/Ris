select id_ser, name_ser, price_ser from services
left join (select id_service, id_client from service_status where id_client = '1') as ss
on id_ser = id_service
where id_client is NULL
