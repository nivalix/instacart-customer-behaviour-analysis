-- INFO 1: Peak Ordering Behaviour
-- Q: When do customers order most by day and hour?
select
	o.order_dow,
	o.order_hour_of_day,
	count(o.order_id) as total_order
from orders o
group by o.order_dow, o.order_hour_of_day
order by total_order desc;

-- INFO 2: Top Reordered Products
-- Q: Which Products drive the most reorder revenue?
select
	p.product_name,
	count(op.order_id) as total_orders,
	SUM(op.reordered) as total_reorders,
	round(avg(op.reordered::numeric) * 100, 2) as reorder_rate	
from order_products op
join products p on op.product_id = p.product_id
group by p.product_name
having count(op.order_id) >= 500
order by reorder_rate desc
limit 20;

-- INFO 3: Top Reordered Department
-- Q: Which department have the most reorder / strongest retention?
select
	d.department,
	count(op.order_id) as total_orders,
	sum(op.reordered) as total_reorders,
	round(avg(op.reordered::numeric) * 100, 2) as reorder_rate
from order_products op
join products p on op.product_id = p.product_id
join departments d on p.department_id = d.department_id
group by d.department
having count(op.order_id) >= 1000
order by reorder_rate desc;

-- INFO 4: Customer Segmentation based on Order Frequency
-- Segment customer into light, medium, heavy buyers
-- Using window functions: NTILE() OVER
with customer_order_counts as (
	select
		orders.user_id,
		count(orders.order_id) as total_orders,
		AVG(orders.days_since_prior_order) as avg_days_between_orders
	from orders
	group by orders.user_id
)
select
	user_id,
	total_orders,
	round(avg_days_between_orders::numeric, 2) as avg_days_between_orders,
	ntile(3) over (order by total_orders desc) as frequency_segment,
	case ntile(3) over (order by total_orders desc)
		when 1 then 'Heavy Buyer'
		when 2 then 'Medium Buyer'
		when 3 then 'Light Buyer'
	end as segment_label
from customer_order_counts
order by total_orders desc;

-- INFO 5: RFM-Inspired Feature Engineering
-- Recency, Frequency, Monetary(proxy) analysis per customer
with customer_stats as (
	select
		user_id,
		max(orders.order_number) as frequency,
		avg(orders.days_since_prior_order) as recency
	from orders
	group by orders.user_id
),
product_stats as (
	select
		o.user_id,
		count(op.product_id) as total_items,
		round(avg(op.reordered::numeric) * 100, 2) as reorder_rate
	from order_products op
	join orders o on op.order_id = o.order_id
	group by o.user_id
),
rfm as (
	select
		cs.user_id,
		cs.frequency,
		round(cs.recency::numeric, 2) as recency_proxy,
		ps.reorder_rate,
		ps.total_items,
		ntile(3) over (order by cs.frequency desc) as frequency_segment,
		ntile(3) over (order by ps.reorder_rate desc) as loyalty_segment
	from customer_stats cs
	join product_stats ps on cs.user_id = ps.user_id
)
select
	rfm.user_id,
	rfm.frequency,
	rfm.recency_proxy,
	rfm.total_items,
	rfm.reorder_rate,
	case frequency_segment
		when 1 then 'High Frequency'
		when 2 then 'Medium Frequency'
		when 3 then 'Low Frequency'
	end as frequency_label,
	case loyalty_segment 
		when 1 then 'High Loyalty'
		when 2 then 'Medium Loyalty'
		when 3 then 'Low Loyalty'
	end as loyalty_label
from rfm
order by rfm.user_id ;