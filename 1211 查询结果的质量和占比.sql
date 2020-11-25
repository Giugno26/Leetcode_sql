1211. 查询结果的质量和占比

#考察知识点：函数 以及 函数和if的结合
#(相结合还是做的不好，很简单的代码写的太复杂啦～)

https://leetcode-cn.com/problems/queries-quality-and-percentage/submissions/


#修改前的代码(又长又臭)
select 
ta.query_name,ta.quality,tb.poor_query_percentage
from(

    select 
    query_name,round(avg(quality),2)  as quality
    from(
        select query_name,result,rating /position as quality
        from Queries
    )ta
    group by query_name


)ta
inner join (

    select 
    query_name
    ,round((sum(case when rating <3 then 1 else 0 end) / count(*))*100,2) as poor_query_percentage
    from Queries
    group by query_name


)tb
on ta.query_name = tb.query_name




#修改后的代码
select 
query_name
,round(avg(rating /position),2) as quality
,round((sum(if(rating<3,1,0)) / count(*))*100,2) as poor_query_percentage
from Queries
group by query_name






