UPDATE services
SET name_ser = '$name_ser',
    price_ser = '$price_ser',
    date_of_last_ser_change = current_date
WHERE id_ser = '$id_ser'