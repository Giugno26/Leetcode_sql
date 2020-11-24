1321. 餐馆营业额变化增长

https://leetcode-cn.com/problems/restaurant-growth/

知识点：窗口函数（滑动窗口函数），还是不熟练啊呜呜呜～～


#菜鸟方法1：

select 
tc.visited_on
,sum(amount) as amount
,round(sum(amount)/7,2) as average_amount
from(


    select 
    ta.visited_on
    ,tb.visited_on as visited
    ,tb.amount
    from(

        select 
        distinct t2.visited_on
        ,t1.visited_on as start_visited_on
        from Customer t1
        inner join Customer t2
        on 1=1
        where date_sub(t2.visited_on,interval 6 day) = t1.visited_on


    )ta
    inner join Customer tb
    on 1=1
    where tb.visited_on >= ta.start_visited_on
    and tb.visited_on <= ta.visited_on


)tc
group by tc.visited_on
order by tc.visited_on



#高端方法2：窗口函数+row preceding


select 
visited_on
,amount
,average_amount
from(


    select 
    visited_on
    ,lag(visited_on,6) over(order by visited_on) as lag_6
    ,sum(amount) over(order by visited_on rows 6 preceding) as amount
    ,round((sum(amount) over(order by visited_on rows 6 preceding)) /7,2) as average_amount
    from(

        select visited_on,sum(amount) as amount  
        from Customer
        group by visited_on

    )ta
)tb
where tb.lag_6 is not null




