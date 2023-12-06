CREATE OR REPLACE FUNCTION FIND_CUSTOMER_FUNCTION(
var_name varchar default null,
var_phone varchar default null,
var_address varchar default null,
order_by varchar default 'created_on',
asc_dir int default 0,
page_number int default 0,
page_size int default 50)
returns setof customers
language plpgsql
as
$$
begin
	if var_phone is null and var_name is null and var_address is null then
	    return QUERY
            select cus.* from customers cus
         	 	order by
         	 	(case when order_by ilike 'address' and asc_dir = 1 then cus.address end) asc,
                (case when order_by ilike 'address' and asc_dir = 0 then cus.address end) desc,
         	 	(case when order_by ilike 'phone_number' and asc_dir = 1 then cus.phone_number end) asc,
         	 	(case when order_by ilike 'phone_number' and asc_dir = 0 then cus.phone_number end) desc,
         	 	(case when order_by ilike 'full_name' and asc_dir = 1 then cus.full_name end) asc,
                (case when order_by ilike 'full_name' and asc_dir = 0 then cus.full_name end) desc,
         	 	(case when order_by ilike 'created_on' and asc_dir = 1 then cus.created_on end) asc,
         	 	(case when order_by ilike 'created_on' and asc_dir = 0 then cus.created_on end) desc
         	 	limit page_size
         	 	offset (page_number * page_size);
    end if;
	return QUERY
	 	select cus.* from customers cus
	 	where
	 	(cus.full_name ilike '%' || var_name || '%' and var_name is not null)
	 	or
	 	(cus.phone_number ilike '%' || var_phone || '%' and var_phone is not null)
	 	or
        (cus.address ilike '%' || var_address || '%' and var_address is not null)
	 	order by
            (case when order_by ilike 'address' and asc_dir = 1 then cus.address end) asc,
            (case when order_by ilike 'address' and asc_dir = 0 then cus.address end) desc,
            (case when order_by ilike 'phone_number' and asc_dir = 1 then cus.phone_number end) asc,
            (case when order_by ilike 'phone_number' and asc_dir = 0 then cus.phone_number end) desc,
            (case when order_by ilike 'full_name' and asc_dir = 1 then cus.full_name end) asc,
            (case when order_by ilike 'full_name' and asc_dir = 0 then cus.full_name end) desc,
            (case when order_by ilike 'created_on' and asc_dir = 1 then cus.created_on end) asc,
            (case when order_by ilike 'created_on' and asc_dir = 0 then cus.created_on end) desc
        limit page_size
        offset (page_number * page_size);
end;
$$
