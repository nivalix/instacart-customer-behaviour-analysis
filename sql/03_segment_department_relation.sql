-- For Power BI dashboard
-- Data imported from segmentation result in jupyter notebook

-- Create the Segmentation Overview
create or replace view customer_segment_overview as
select
	user_id,
	round(recency::numeric, 2) as average_day_between_orders,
	purchase_count as total_orders,
	total_items_purchased,
	round(reorder_ratio::numeric, 4) as reorder_ratio,
	cluster,
	segment
from customer_segments;
	
-- Create relation view between segments and departments
create or replace view segment_department_relation as
select
	cs.segment,
	d.department,
	count(op.order_id) as total_orders,
	round(
		100.0 * count(op.order_id) / sum(count(op.order_id)) over (partition by cs.segment), 2
	) as segment_orders_percentage
from customer_segments cs
join orders o on cs.user_id = o.user_id 
join order_products op on o.order_id = op.order_id 
join products p on op.product_id = p.product_id 
join departments d on p.department_id = d.department_id 
group by cs.segment, d.department
order by cs.segment, total_orders desc;

select * from customer_segment_overview;
select * from segment_department_relation;

