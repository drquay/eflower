CREATE OR REPLACE FUNCTION PROFIT_REPORT_FUNCTION(account_id varchar, from_date timestamp, to_date timestamp)
returns table (
        		report_date text,
        		profit numeric(19, 2)
        	  )
language plpgsql
as
$$
declare
	var_account varchar;
begin
	var_account = nullif(account_id, '');
	if var_account is null then
	    return QUERY
            select TO_CHAR(ord.created_on :: DATE, 'dd-mm-yyyy') as report_date, sum(ord.price) as profit
         	 	from orders ord
         	 	where ord.created_on >= from_date and ord.created_on <= to_date
         	 	group by report_date
         	 	order by report_date;
    else
        return QUERY
            select TO_CHAR(ord.created_on :: DATE, 'dd-mm-yyyy') as report_date, sum(ord.price) as profit
                from orders ord, order_assignment_histories ass
                where
                    ord.id = ass.order_id and
                    ord.created_on >= from_date and
                    ord.created_on <= to_date and
                    ass.person_in_charse = var_account
                group by report_date
                order by report_date;
    end if;
end;
$$
