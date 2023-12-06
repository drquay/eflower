CREATE OR REPLACE FUNCTION FIND_PRODUCT_FUNCTION(
var_name varchar default null,
var_code varchar default null,
order_by varchar default 'created_on',
asc_dir int default 0,
page_number int default 0,
page_size int default 50)
returns setof products
language plpgsql
as
$$
begin
	if var_code is null and var_name is null then
	    return QUERY
            select prod.*
         	 	from products prod
         	 	order by
         	 	(case when order_by ilike 'code' and asc_dir = 1 then prod.code end) asc,
         	 	(case when order_by ilike 'code' and asc_dir = 0 then prod.code end) desc,
         	 	(case when order_by ilike 'name' and asc_dir = 1 then prod.name end) asc,
                (case when order_by ilike 'name' and asc_dir = 0 then prod.name end) desc,
         	 	(case when order_by ilike 'created_on' and asc_dir = 1 then prod.created_on end) asc,
         	 	(case when order_by ilike 'created_on' and asc_dir = 0 then prod.created_on end) desc
         	 	limit page_size
         	 	offset (page_number * page_size);
    end if;
	return QUERY
	 	select prod.*
	 	from products prod
	 	where
	 	(prod.name ilike '%' || var_name || '%' and var_name is not null)
	 	or
	 	(prod.code ilike '%' || var_code || '%' and var_code is not null)
	 	order by
	 	(case when order_by ilike 'code' and asc_dir = 1 then prod.code end) asc,
	 	(case when order_by ilike 'code' and asc_dir = 0 then prod.code end) desc,
	 	(case when order_by ilike 'name' and asc_dir = 1 then prod.name end) asc,
        (case when order_by ilike 'name' and asc_dir = 0 then prod.name end) desc,
	 	(case when order_by ilike 'created_on' and asc_dir = 1 then prod.created_on end) asc,
	 	(case when order_by ilike 'created_on' and asc_dir = 0 then prod.created_on end) desc
	 	limit page_size
	 	offset (page_number * page_size);
end;
$$
