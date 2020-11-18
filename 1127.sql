1127. 用户购买平台

https://leetcode-cn.com/problems/user-purchase-platform/



step1. 构建各种组合

select distinct spend_date,'mobile' as platform from Spending
union all
select distinct spend_date,'desktop' as platform from Spending
union all
select distinct spend_date,'both' as platform from Spending



step2...
select 
ta.spend_date
,ta.plat
,sum(ta.amount) as total_amount
,count(distinct ta.user_id) as total_users
from(
    select 
    user_id
    ,spend_date
    --巧用max返回只有一种类型platfrom类型
    ,(case when count(distinct platform) =1 then max(platform) else 'both' end) as plat
    ,sum(amount) as amount
    from Spending
    group by user_id,spend_date
)ta
group by ta.spend_date,ta.plat




step3. 合并


select 
t1.spend_date
,t1.platform
,ifnull(t2.total_amount,0)
,ifnull(t2.total_users,0)
from(
    select distinct spend_date,'mobile' as platform from Spending
    union all
    select distinct spend_date,'desktop' as platform from Spending
    union all
    select distinct spend_date,'both' as platform from Spending
)t1

left join (
    select 
    ta.spend_date
    ,ta.plat
    ,sum(ta.amount) as total_amount
    ,count(distinct ta.user_id) as total_users
    from(
        select 
        user_id
        ,spend_date
        --巧用max返回只有一种类型platfrom类型
        ,(case when count(distinct platform) =1 then max(platform) else 'both' end) as plat
        ,sum(amount) as amount
        from Spending
        group by user_id,spend_date
    )ta
    group by ta.spend_date,ta.plat
)t2
on t1.spend_date = t2.spend_date
and t1.platform = t2.plat


