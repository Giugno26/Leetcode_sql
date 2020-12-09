1355. 活动参与者

#知识点：子查询

https://leetcode-cn.com/problems/activity-participants/submissions/

with t1 as (
    select activity,count(distinct id) as nums
    from Friends
    group by activity
)
select activity
from t1
where nums > (select min(nums) from t1)
and nums < (select max(nums) from t1)
