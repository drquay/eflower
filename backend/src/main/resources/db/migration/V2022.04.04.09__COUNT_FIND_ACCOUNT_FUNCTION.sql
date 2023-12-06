CREATE OR REPLACE FUNCTION COUNT_FIND_ACCOUNT_FUNCTION(
var_name varchar default null,
var_phone varchar default null,
var_username varchar default null)
returns bigint
language plpgsql
as
$$
declare
	totals bigint;
begin
	if var_phone is null and var_name is null and var_username is null then
	    select count(*) into totals from accounts;
        return totals;
    else
        select count(*) into totals from accounts acc where
            (acc.full_name ilike '%' || var_name || '%' and var_name is not null)
            or
            (acc.phone_number ilike '%' || var_phone || '%' and var_phone is not null)
            or
            (acc.username like var_username and var_username is not null);
        return totals;
    end if;
end;
$$
