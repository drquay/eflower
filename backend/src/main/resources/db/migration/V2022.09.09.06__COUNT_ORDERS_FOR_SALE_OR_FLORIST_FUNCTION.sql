CREATE OR REPLACE FUNCTION COUNT_ORDERS_FOR_SALE_OR_FLORIST(
var_status varchar default null,
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
    	select count(*) into totals from (select * from orders where source <> 'OTHER') ord
    	where
            (ord.code ilike ('%' || var_code || '%') or var_code is null)
            and
            (ord.status ilike var_status or var_status is null);
    	return totals;
    else
        select count(ord.*) into totals
            from (select * from orders where source <> 'OTHER') ord INNER JOIN customers cus ON ord.buyer_id = cus.id OR ord.receiver_id = cus.id
            where
                (ord.code ilike ('%' || var_code || '%') or var_code is null)
                and
                (ord.status ilike var_status or var_status is null)
                and
                (cus.phone_number ilike ('%' || var_phone_buyer || '%') or var_phone_buyer is null)
                and
                (cus.phone_number ilike ('%' || var_phone_receiver || '%') or var_phone_receiver is null);
        return totals;
    end if;
end;
$$
