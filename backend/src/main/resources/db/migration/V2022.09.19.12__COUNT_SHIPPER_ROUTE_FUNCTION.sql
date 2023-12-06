CREATE OR REPLACE FUNCTION COUNT_SHIPPER_ROUTE(
account_id varchar default null,
from_date timestamp default null,
to_date timestamp default null
)
returns bigint
language plpgsql
as
$$
declare
	totals bigint;
begin
	select count(s.*) into totals
            from shipper_routes s
            where
                (s.shipper_id ilike account_id or account_id is null)
                and
                s.created_on >= from_date and s.created_on <= to_date;
    return totals;
end;
$$
