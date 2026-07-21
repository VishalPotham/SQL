create database pizza_sales_analysis;
show databases;
use pizza_sales_analysis;
create table pizza_order(
    order_id int,
    order_date date
    );
alter table pizza_order add column order_time time;   
rename table pizza_order to pizza_orders;
alter table pizza_orders add primary key (order_id);
select * from pizza_orders;