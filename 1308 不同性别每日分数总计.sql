1308. 不同性别每日分数总计

https://leetcode-cn.com/problems/running-total-for-different-genders/

#方法一：连接
select 
ta.gender
,ta.day 
,sum(score_points) as total
from(

    select 
    t1.gender
    ,t1.day 
    ,t2.day as t2_day
    ,t2.score_points
    from Scores t1
    inner join Scores t2
    on t1.gender = t2.gender
    where  t2.day <= t1.day


)ta
group by ta.gender,ta.day
order by ta.gender,ta.day



#方法二：开窗函数
select 
    gender
    ,day
    ,sum(score_points) over(partition by gender order by day) as total
from Scores


