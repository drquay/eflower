--https://stackoverflow.com/questions/39896329/how-to-write-function-for-optional-parameters-in-postgresql

CREATE OR REPLACE FUNCTION GET_ORDERS_FOR_SHIPPERS(
var_shipper_id varchar default null,
var_code varchar default null,
var_phone_buyer varchar default null,
var_phone_receiver varchar default null,
order_by varchar default 'created_on',
asc_dir int default 0,
page_number int default 0,
page_size int default 50)
returns setof orders
language plpgsql
as
$$
begin
	if (var_phone_buyer is null) and (var_phone_receiver is null) then
    	return QUERY
            select
                ord.*
            from
                (select * from orders where source <> 'OTHER' and status in ('SHIPPING', 'FINISHED', 'SHIPPED_WITH_PAYMENT', 'SHIPPED_WITH_NONPAYMENT')) ord
                inner join
                (select * from order_assignment_histories where person_in_charse = var_shipper_id) ass
                on
                ord.id = ass.order_id
            where
                (ord.code ilike ('%' || var_code || '%') or var_code is null)
            order by
            	(case when order_by ilike 'code' and asc_dir = 1 then ord.code end) asc,
                (case when order_by ilike 'code' and asc_dir = 0 then ord.code end) desc,
            	(case when order_by ilike 'created_on' and asc_dir = 1 then ord.created_on end) asc,
            	(case when order_by ilike 'created_on' and asc_dir = 0 then ord.created_on end) desc,
            	(case when order_by ilike 'source' and asc_dir = 1 then ord.source end) asc,
            	(case when order_by ilike 'source' and asc_dir = 0 then ord.source end) desc,
            	(case when order_by ilike 'delivery_date' and asc_dir = 1 then ord.delivery_date end) asc,
                (case when order_by ilike 'delivery_date' and asc_dir = 0 then ord.delivery_date end) desc,
            	(case when order_by ilike 'price' and asc_dir = 1 then ord.price end) asc,
            	(case when order_by ilike 'price' and asc_dir = 0 then ord.price end) desc
            limit page_size
            offset (page_number * page_size);
    else
        return QUERY
            select
                ord.*
            from
                (select * from orders where source <> 'OTHER' and status like 'SHIPPING') ord
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
                (cus.phone_number ilike ('%' || var_phone_receiver || '%') or var_phone_receiver is null)
            order by
                (case when order_by ilike 'code' and asc_dir = 1 then ord.code end) asc,
                (case when order_by ilike 'code' and asc_dir = 0 then ord.code end) desc,
                (case when order_by ilike 'created_on' and asc_dir = 1 then ord.created_on end) asc,
                (case when order_by ilike 'created_on' and asc_dir = 0 then ord.created_on end) desc,
                (case when order_by ilike 'source' and asc_dir = 1 then ord.source end) asc,
                (case when order_by ilike 'source' and asc_dir = 0 then ord.source end) desc,
                (case when order_by ilike 'delivery_date' and asc_dir = 1 then ord.delivery_date end) asc,
                (case when order_by ilike 'delivery_date' and asc_dir = 0 then ord.delivery_date end) desc,
                (case when order_by ilike 'price' and asc_dir = 1 then ord.price end) asc,
                (case when order_by ilike 'price' and asc_dir = 0 then ord.price end) desc
            limit page_size
            offset (page_number * page_size);
    end if;
end;
$$
