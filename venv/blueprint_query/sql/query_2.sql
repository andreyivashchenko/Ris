select se.id_service, ser.name_ser, ser.price_ser, se.date_of_activation from client cl
join(select * from service_status where date_of_disconnection is null) as se
on cl.id_cl = se.id_client
join (select * from services) as ser
on se.id_service = ser.id_ser
where cl.name_cl = '$Name' and cl.id_cl = '$Id'