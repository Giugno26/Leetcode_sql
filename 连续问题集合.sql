1225. 报告系统状态的连续日期

https://leetcode-cn.com/problems/report-contiguous-dates/submissions/

select 
period_state
,start_date
,end_date
from(

    #失败的
    #step2 按照group_id区分
    #组内的最小日期为起始日期，最大日期为终止日期
    select 
    ta.period_state
    ,min(fail_date) as start_date
    ,max(fail_date) as end_date
    from(

        #step1 创建连续日期的tag
        select 
            'failed' as period_state
            ,fail_date
            ,date_sub(fail_date,interval row_number() over(order by fail_date) day) as group_id
        from Failed
        where fail_date >= '2019-01-01'
        and fail_date <= '2019-12-31'
 
    )ta
    group by ta.period_state,ta.group_id


    union all

    #成功的
    #step2 按照group_id区分
    select 
    ta.period_state
    ,min(success_date) as start_date
    ,max(success_date) as end_date
    from(

        #step1 创建连续日期的
        select 
            'succeeded' as period_state
            ,success_date
            ,date_sub(success_date,interval row_number() over(order by success_date) day) as group_id
        from Succeeded
        where success_date >= '2019-01-01'
        and success_date <= '2019-12-31'

    )ta
    group by ta.period_state,ta.group_id



)t11
order by start_date




1454. 活跃用户

https://leetcode-cn.com/problems/active-users/submissions/



#方法一：利用等差数列的原则：连续日期的差值是相同的
select 
    distinct tc.id,td.name
from(

    select 
        id,
        count(*) over(partition by id,group_id) as num
    from(
        select 
            id
            ,login_date
            ,date_sub(login_date,interval row_number() over(partition by id order by login_date) day) as group_id
        from(select distinct id,login_date from Logins)ta
    )tb
)tc
inner join Accounts td
on tc.id = td.id
where tc.num >= 5
order by tc.id


#方法二：用lead函数把某行日期按照时间正序排列的下方第5个日期选取，
#看两个日期差值是否等于5，如果是的话那么该行日期就是连续登陆5天的第一天

select 
distinct tb.id,tc.name
from(

    select 
    id
    ,login_date
    #连续5天，向下取4天的差值是不是4
    ,datediff(lead(login_date,4) over(partition by id order by login_date),login_date) as grouo_id
    from(
        select distinct id,login_date from Logins
    )ta

)tb
inner join Accounts tc
on tb.id = tc.id
where tb.grouo_id = 4
order by tb.id

