608. 树节点

https://leetcode-cn.com/problems/tree-node/


#观察三种节点的特点，Root的p_id为null，Leaf的id不出现在p_id中，Inner的id在两列中均出现
#写法1 case...when...
select 
id
,case when p_id is null then 'Root'
      when id in (select p_id from tree) then 'Inner'
      else 'Leaf' end as Type
from tree


#写法2 if函数
select
id,
if(p_id is null,'Root',if(id in (select p_id from tree),'Inner','Leaf')) as Type
from tree
