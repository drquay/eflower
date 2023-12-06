CREATE OR REPLACE FUNCTION COUNT_ORDERS_FOR_SHIPPERS(
var_shipper_id varchar default null,
var_code varchar default null,
var_phone_buyer varchar default null,
var_phone_receiver varchar default null
)
returns bigint
language plpgsql
as
$$
declare
	totals bigint;
begin
	if (var_phone_buyer is null) and (var_phone_receiver is null) then
    	select count(*) into totals
    	from
    	   (select * from orders where source <> 'OTHER' and status like 'SHIPPING') ord
           inner join
           (select * from order_assignment_histories where person_in_charse = var_shipper_id) ass
           on
           ord.id = ass.order_id
    	where
            (ord.code ilike ('%' || var_code || '%') or var_code is null);
    	return totals;
    else
        select count(ord.*) into totals
            from
                (select * from orders where source <> 'OTHER' and status in ('SHIPPING', 'FINISHED', 'SHIPPED_WITH_PAYMENT', 'SHIPPED_WITH_NONPAYMENT')) ord
                inner join
                (select * from order_assignment_histories where person_in_charse = var_shipper_id) ass
                on
                ord.id = ass.order_id
                inner join
                customers cus
                on
                (ord.buyer_id = cus.id OR ord.receiver_id = cus.id)
            where
                (ord.code ilike ('%' || var_code || '%') or var_code is null)
                and
                (cus.phone_number ilike ('%' || var_phone_buyer || '%') or var_phone_buyer is null)
                and
                (cus.phone_number ilike ('%' || var_phone_receiver || '%') or var_phone_receiver is null);
        return totals;
    end if;
end;
$$
