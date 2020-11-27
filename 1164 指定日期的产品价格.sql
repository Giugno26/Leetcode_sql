1164. 指定日期的产品价格

https://leetcode-cn.com/problems/product-price-at-a-given-date/submissions/

#知识点：逻辑
#找出每个每个product change_date在2019-08-16及之前的记录中最后一次变更时候的价格，即为该product在2019-08-16当日的价格；
#有的product在2019-08-16及之前未发生改变，则标记为10

# Write your MySQL query statement below

#知识点：逻辑
#先找到2019-08-16之前最后一次价格，如果没有应该是10
select 
t1.product_id
,ifnull(t2.new_price,10) as price
from (
    select distinct product_id from Products 
)t1
left join (

    select 
    product_id,new_price,change_date
    from(

        select 
        product_id,new_price,change_date
        ,row_number() over(partition by product_id order by change_date desc) as seq
        from Products
        where change_date <= '2019-08-16'
    )ta
    where ta.seq = 1
)t2
on t1.product_id = t2.product_id




