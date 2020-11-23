612. 平面上的最近距离

https://leetcode-cn.com/problems/shortest-distance-in-a-plane/submissions/

#考察知识点：表连接条件


#写法1
select 
min(round(sqrt(power((t1.x - t2.x),2) + power((t1.y - t2.y),2)),2)) as shortest
from point_2d t1
join point_2d t2
on (t1.x,t1.y) <> (t2.x,t2.y) 


#写法2
select 
min(round(sqrt(power((t1.x - t2.x),2) + power((t1.y - t2.y),2)),2)) as shortest
from point_2d t1
join point_2d t2
#用or不用and是因为只要横坐标或者纵坐标有一个不一样就是两个不一样的点了
on t1.x <> t2.x or t1.y <> t2.y


