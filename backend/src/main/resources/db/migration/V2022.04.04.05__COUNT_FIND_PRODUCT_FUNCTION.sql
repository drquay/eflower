CREATE OR REPLACE FUNCTION COUNT_FIND_PRODUCT_FUNCTION(var_name varchar default null,
                                                       var_code varchar default null)
returns bigint
language plpgsql
as
$$
declare
	totals bigint;
begin
	if var_code is null and var_name is null then
	    select count(*) into totals from products;
	    return totals;
    end if;
	select count(*) into totals
	from products prod
	where
	 	(prod.name ilike '%' || var_name || '%' and var_name is not null)
	 	or
	 	(prod.code ilike '%' || var_code || '%' or var_code is not null);
	return totals;
end;
$$
