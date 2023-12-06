CREATE OR REPLACE FUNCTION GET_SHIPPER_ROUTE(
account_id varchar default null,
from_date timestamp default null,
to_date timestamp default null,
order_by varchar default 'created_on',
asc_dir int default 0,
page_number int default 0,
page_size int default 50)
returns setof shipper_routes
language plpgsql
as
$$
begin
	return QUERY
            select s.*
            from shipper_routes s
            where
                (s.shipper_id ilike account_id or account_id is null)
                and
                s.created_on >= from_date and s.created_on <= to_date
            order by
                (case when order_by ilike 'number_of_km' and asc_dir = 1 then s.number_of_km end) asc,
                (case when order_by ilike 'number_of_km' and asc_dir = 0 then s.number_of_km end) desc,
                (case when order_by ilike 'created_on' and asc_dir = 1 then s.created_on end) asc,
                (case when order_by ilike 'created_on' and asc_dir = 0 then s.created_on end) desc
            limit page_size
            offset (page_number * page_size);
end;
$$
