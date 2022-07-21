create database superstores;
/* Task 1:- Understanding the Data
   This database contains Sales details of each transaction of a superstore. 
   The database has 5 tables are as follows:
1. cust_dimen: This table contains details of all customers.
2. market_fact: This table contains details of market facts of each order like Sales, Discount, Profit etc.
3. orders_dimen: This table contains details of each order like Order ID, Date, Priority etc.
4. prod_dimen: This table contains details of product category and sub category
5. shipping_dimen: This table contains details of shipping of orders like Shipping Id, Date, Mode etc.

Details about the Primary and Foreign keys of each table.
1. cust_dimen
    Primary key in this table is Cust_id.
	There is no Foreign Key in this table.
	
2. market_fact
	There is no Primary Key in this table.
	Foreign keys in this table are Ord_id, Prod_id, Ship_id and Cust_id.
	
3. orders_dimen
	Primary key in this table is Ord_id.
	There is no Foreign Key in this table.
	
4. prod_dimen
	Primary key in this table are Prod_id and Product_Sub_Category.
	There is no Foreign Key in this table.
	
5. shipping_dimen
	Primary key in this table is Ship_id.
	Foreign key in this table is Order_id.
    */
    
-- Task 2:- Basic & Advanced Analysis

-- 1. Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen.
select Customer_Name as `Customer Name`,Customer_Segment as `Customer Segment` from superstores.cust_dimen;

-- 2. Write a query to find all the details of the customer from the table cust_dimen order by desc.
select * from superstores.cust_dimen
order by Customer_Name desc;

-- 3. Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high.
select Order_Id, Order_date from superstores.orders_dimen
where Order_Priority='HIGH';

-- 4. Find the total and the average sales (display total_sales and avg_sales)
select sum(Sales) as 'Total_sales', avg(Sales) as 'Avg_sales' from superstores.market_fact;

-- 5. Write a query to get the maximum and minimum sales from maket_fact table.
select max(sales) as 'Maximum_sales' ,min(sales) as 'Minimum_sales' from superstores.market_fact;

-- 6. Display the number of customers in each region in decreasing order of no_of_customers. 
--    The result should contain columns Region, no_of_customers.
select Region,count(*) as 'no_of_customers' from superstores.cust_dimen
group by Region 
order by no_of_customers desc;

-- 7. Find the region having maximum customers (display the region name and max(no_of_customers)
select Region,count(*) as no_of_customers from superstores.cust_dimen
group by Region 
order by no_of_customers desc
limit 1;

-- 8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and 
--    the number of tables purchased (display the customer name, no_of_tables purchased)
select a.Customer_name, sum(b.Order_Quantity) as 'no_of_tables purchased' from cust_dimen a 
inner join market_fact b
on b.Cust_id = a.Cust_id inner join prod_dimen c 
on c.Prod_id = b.Prod_id 
where a.Region = 'ATLANTIC' and c.Product_Sub_Category = 'TABLES'
group by a.Customer_name;

-- 9. Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners)
select Customer_name, count(Customer_segment) as `no of small business owners` from superstores.cust_dimen
where Province='Ontario' and Customer_Segment='SMALL BUSINESS'
group by Customer_Name;

-- 10. Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold)
select Prod_id, count(Order_Quantity) as 'no of products sold' from superstores.market_fact     
group by Prod_id     
order by 'no of products sold' desc;

-- 11. Display product Id and product sub category whose produt category belongs to Furniture and Technlogy. 
--     The result should contain columns product id, product sub category.
select Prod_id, Product_Sub_Category from superstores.prod_dimen
where Product_Category IN ('Furniture','Technolgy');

-- 12. Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?
select a.Product_Category,sum(b.profit) from superstores.prod_dimen as a
inner join superstores.market_fact as b
on a.Prod_id=b.Prod_id
group by Product_Category
order by Profit desc;

-- 13. Display the product category, product sub-category and the profit within each subcategory in three columns.
select a.Product_Category,a.Product_Sub_Category,sum(b.profit) as Profit from superstores.prod_dimen as a
inner join superstores.market_fact as b
on a.Prod_id=b.Prod_id
group by Product_Category, Product_Sub_Category;

-- 14. Display the order date, order quantity and the sales for the order.
select a.Order_Date,sum(b.Order_Quantity) as 'Order Quantity',b.sales as Sales from superstores.market_fact b
inner join superstores.orders_dimen a
on a.Ord_id=b.Ord_id
group by a.Ord_id;

-- 15. Display the names of the customers whose name contains the
--      i) Second letter as ‘R’
--      ii) Fourth letter as ‘D’

-- If both condition is to be fulfilled
select Customer_Name from superstores.cust_dimen
where Customer_Name like '_R_D%';

-- If any of the condition is to be fulfilled
select Customer_Name from superstores.cust_dimen
where Customer_Name like '_R%' or '___D%';

-- i) Second letter as ‘R’
select Customer_Name from superstores.cust_dimen
where Customer_Name like '_R%';

-- ii) Fourth letter as ‘D’
select Customer_Name from superstores.cust_dimen
where Customer_Name like '___D%';


-- 16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000.
select a.Cust_Id, a.Customer_Name, a.Region, b.Sales from superstores.cust_dimen a
inner join superstores.market_fact b
on a.Cust_id=b.Cust_id
where b.sales between 1000 and 5000
group by a.Cust_id;


-- 17. Write a SQL query to find the 3rd highest sales.
select sales from superstores.market_fact
order by sales desc
limit 1 offset 2;

-- 18. Where is the least profitable product subcategory shipped the most? 
--     For the least profitable product sub-category, display the region-wise no_of_shipments and 
--     the profit made in each region in decreasing order of profits 
--     (i.e. region, no_of_shipments, profit_in_each_region)
select a.region, count(distinct c.ship_id) as no_of_shipments, sum(b.profit) as profit_in_each_region from market_fact b
inner join cust_dimen a
on a.cust_id = b.cust_id
inner join shipping_dimen c 
on b.ship_id = c.ship_id
inner join prod_dimen d ON b.prod_id = d.prod_id
where d.product_sub_category in (select d.product_sub_category from market_fact b      -- Query for least Profitable sub-catagory
inner join prod_dimen d 
on b.prod_id = d.prod_id
group by d.product_sub_category
having sum(b.profit) <= ALL
(select sum(b.profit) as profits from market_fact b
inner join prod_dimen d 
on b.prod_id = d.prod_id
group by d.product_sub_category))
group by a.region
order by profit_in_each_region desc;

