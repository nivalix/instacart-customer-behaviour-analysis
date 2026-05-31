-- CREATE TABLES

create table aisles (
	aisle_id INT primary key,
	aisle VARCHAR(100)
);

create table departments (
	department_id INT primary key,
	department VARCHAR(100)
);

create table orders (
	order_id INT primary key,
	user_id INT,
	eval_set VARCHAR(10),
	order_number INT,
	order_dow INT,
	order_hour_of_day INT,
	days_since_prior_order FLOAT
);

create table products (
	product_id INT primary key,
	product_name VARCHAR(255),
	aisle_id INT,
	department_id INT
);

create table order_products (
	order_id INT,
	product_id INT,
	add_to_cart_order INT,
	reordered INT
);


-- IMPORT FILES
copy aisles from 'C:/instacart-data/aisles.csv' with (format csv, header true);
copy departments from 'C:/instacart-data/departments.csv' with (format csv, header true);
copy orders from 'C:/instacart-data/orders.csv' with (format csv, header true);
copy products from 'C:/instacart-data/products.csv' with (format csv, header true);
copy order_products from 'C:/instacart-data/order_products__prior.csv' with (format csv, header true);
copy order_products from 'C:/instacart-data/order_products__train.csv' with (format csv, header true);

-- COUNT ROW IN EACH TABLE
select 'aisles' as table_name, count(*) from aisles a
union all
select 'department', count(*) from departments d
union all
select 'products', count(*) from products p
union all
select 'orders', count(*) from orders o
union all
select 'order_products', count(*) from order_products;
