1205. 每月交易II

https://leetcode-cn.com/problems/monthly-transactions-ii/submissions/

#这道题比较烦的点在于退单时间和原始交易时间会跨月，且退单表的字段有限；
#思路是先补全退单表的数据并新增一个可以识别退单的tag，再和交易表进行union all,最后用if()函数或者case when进行计算



select 
date_format(trans_date,'%Y-%m') as month
,country
,ifnull(sum(if(state='approved',1,0)),0) as approved_count
,ifnull(sum(if(state='approved',amount,0)),0) as approved_amount
,ifnull(sum(if(state='chargebacks',1,0)),0) as chargeback_count
,ifnull(sum(if(state='chargebacks',amount,0)),0) as chargeback_amount
from(

    select * from Transactions
    where state = 'approved'
    union all
    select 
    t1.id,t1.country,'chargebacks' as state,t1.amount,t2.trans_date
    from Transactions t1
    inner join Chargebacks t2
    on t1.id = t2.trans_id

)ta
group by date_format(trans_date,'%Y-%m') ,country




