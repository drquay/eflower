CREATE OR REPLACE FUNCTION COUNT_FIND_CUSTOMER_FUNCTION(
var_name varchar default null,
var_phone varchar default null,
var_address varchar default null)
returns bigint
language plpgsql
as
$$
declare
	totals bigint;
begin
	if var_phone is null and var_name is null and var_address is null then
	    select count(*) into totals from customers cus;
	    return totals;
    end if;
	select count(*) into totals
	 	from customers cus
	 	where
	 	(cus.full_name ilike '%' || var_name || '%' and var_name is not null)
	 	or
	 	(cus.phone_number ilike '%' || var_phone || '%' and var_phone is not null)
	 	or
        (cus.address ilike '%' || var_address || '%' and var_address is not null);
    return totals;
end;
$$
