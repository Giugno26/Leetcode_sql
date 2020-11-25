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


