618.学生地理信息报告

https://leetcode-cn.com/problems/students-report-by-geography/submissions/


#case when可以实现行转列，重点：是null值。
#关键点是先对原表进行分组排序，再此基础上进行case when （+聚合） group by 分组即可。


# Write your MySQL query statement below



select
max(case when continent = 'America' then name else null end) as 'America'
,max(case when continent = 'Asia' then name else null end) as 'Asia'
,max(case when continent = 'Europe' then name else null end) as 'Europe'
from(

    select 
        name,continent,row_number() over(partition by continent order by name) as group_id
    from student

)t
group by group_id




