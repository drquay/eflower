CREATE OR REPLACE FUNCTION FIND_ACCOUNT_FUNCTION(
var_name varchar default null,
var_phone varchar default null,
var_username varchar default null,
order_by varchar default 'created_on',
asc_dir int default 0,
page_number int default 0,
page_size int default 50)
returns setof accounts
language plpgsql
as
$$
begin
	if var_phone is null and var_name is null and var_username is null then
	    return QUERY
            select acc.* from accounts acc
         	 	order by
         	 	(case when order_by ilike 'username' and asc_dir = 1 then acc.username end) asc,
                (case when order_by ilike 'username' and asc_dir = 0 then acc.username end) desc,
         	 	(case when order_by ilike 'phone_number' and asc_dir = 1 then acc.phone_number end) asc,
         	 	(case when order_by ilike 'phone_number' and asc_dir = 0 then acc.phone_number end) desc,
         	 	(case when order_by ilike 'full_name' and asc_dir = 1 then acc.full_name end) asc,
                (case when order_by ilike 'full_name' and asc_dir = 0 then acc.full_name end) desc,
         	 	(case when order_by ilike 'created_on' and asc_dir = 1 then acc.created_on end) asc,
         	 	(case when order_by ilike 'created_on' and asc_dir = 0 then acc.created_on end) desc
         	 	limit page_size
         	 	offset (page_number * page_size);
    else
        return QUERY
            select acc.* from accounts acc
            where
            (acc.full_name ilike '%' || var_name || '%' and var_name is not null)
            or
            (acc.phone_number ilike '%' || var_phone || '%' and var_phone is not null)
            or
            (acc.username like var_username and var_username is not null)
            order by
                (case when order_by ilike 'username' and asc_dir = 1 then acc.username end) asc,
                (case when order_by ilike 'username' and asc_dir = 0 then acc.username end) desc,
                (case when order_by ilike 'phone_number' and asc_dir = 1 then acc.phone_number end) asc,
                (case when order_by ilike 'phone_number' and asc_dir = 0 then acc.phone_number end) desc,
                (case when order_by ilike 'full_name' and asc_dir = 1 then acc.full_name end) asc,
                (case when order_by ilike 'full_name' and asc_dir = 0 then acc.full_name end) desc,
                (case when order_by ilike 'created_on' and asc_dir = 1 then acc.created_on end) asc,
                (case when order_by ilike 'created_on' and asc_dir = 0 then acc.created_on end) desc
            limit page_size
            offset (page_number * page_size);
    end if;
end;
$$
