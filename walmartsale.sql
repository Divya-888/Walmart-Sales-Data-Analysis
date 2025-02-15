Create Database Walmart

Create Table Sales (
Invoice_id varchar (30) NOT NULL PRIMARY KEY,
Branch VARCHAR (5) NOT NULL,
city VARCHAR (30) NOT NULL,
cutomer_type VARCHAR (30) NOT NULL,
gender VARCHAR (10) NOT NULL,
Product_line VARCHAR (100) NOT NULL,
Unit_price DECIMAL (10, 2),
quantity INT NOT NULL,
VAT DECIMAL (6 , 4) NOT NULL,
total DECIMAL (12, 4)  NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment_method VARCHAR (15),
cogs DECIMAL (10, 2),
Gross_margin_pct decimal (11, 9),
gross_income DECIMAL (10, 2),
rating DECIMAL (2,1)
);
 
 SELECT * FROM walmart.sales;

SELECT 
    time,
    CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'AfterNoon'
        ELSE 'Evening'
     END AS time_of_date
FROM
    sales
    
    Alter table sales 
    add column time_of_day varchar(20)
    
UPDATE sales 
SET 
    time_of_day = (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'AfterNoon'
        ELSE 'Evening'
    END)
WHERE
    time_of_day IS NULL
    SET SQL_SAFE_UPDATES = 0
    
 -- day name
 
 select date, dayname(date) from sales 
 
 Alter table sales 
    add column day_name varchar(20)
    
    UPDATE sales 
SET 
    day_name = dayname(date)
WHERE
    day_name IS NULL
 
SELECT 
    date, MONTHNAME(date)
FROM
    sales
    
    Alter table sales 
    add column month_name varchar(10)
    
    UPDATE sales 
SET 
    month_name = monthname(date)
WHERE
    month_name IS NULL
    
-- How many unique cities does the data have?

select
distinct city 
from sales

-- In which city is each branch?

SELECT DISTINCT
    branch
FROM
    sales
 SELECT DISTINCT
    city, branch
FROM
    sales
    
    -- How many unique product lines does the data have?

SELECT
count( DISTINCT
    product_line)
FROM
    sales
    
    -- What is the most common payment method?

select payment_method,
count(payment_method) as cnt
from sales
group by payment_method
order by cnt desc

-- What is the most selling product line?
select product_line,
count(product_line) as selling_product
from sales
group by product_line
order by selling_product desc

-- What is the total revenue by month?
SELECT 
    month_name, sum(total) as total_revenue
FROM
    sales
GROUP BY month_name
order by total_revenue desc

-- What month had the largest COGS?
SELECT 
    month_name , sum(cogs) as cogs
FROM
    sales
GROUP BY month_name
order by cogs desc

-- What product line had the largest revenue?
select product_line,
sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc limit  1

-- What is the city with the largest revenue?
select city,
sum(total) as total_revenue
from sales
group by city
order by total_revenue desc

-- What product line had the largest VAT
select product_line,
sum(vat) as total_vat
from sales
group by product_line
order by total_vat desc limit 1
-- or--
SELECT 
    product_line, AVG(vat) AS avg_vat
FROM
    sales
GROUP BY product_line
ORDER BY avg_vat DESC limit 1

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT 
    Product_line,
    AVG(total) AS avg_sales,
    CASE 
        WHEN AVG(total) < (SELECT AVG(total) FROM sales) THEN 'bad'
        ELSE 'good'
    END AS performance
FROM 
    sales
GROUP BY 
    Product_line; 
    
    alter table sales
    add performance varchar (10)
    
    insert into sales (performance)
 values ( SELECT 
    Product_line,
    AVG(total) AS avg_sales,
    CASE 
        WHEN AVG(total) < (SELECT AVG(total) FROM sales) THEN 'bad'
        ELSE 'good'
    END AS performance
FROM 
    sales
GROUP BY 
    Product_line)
    
    
    UPDATE sales
SET performance = CASE 
    WHEN total < (SELECT AVG(total) FROM sales) THEN 'bad'
    ELSE 'good'
END;

-- Which branch sold more products than average product sold?

SELECT 
    branch, SUM(quantity) AS qty
FROM
    sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT 
        AVG(quantity)
    FROM
        sales)
ORDER BY qty DESC

-- What is the most common product line by gender ?

select product_line,
gender,
count(*) as product_count
from sales
group by product_line , gender
order by  product_count desc
-- or---
SELECT 
    gender, product_line, COUNT(gender) AS total_cnt
FROM
    sales
GROUP BY gender , product_line
ORDER BY total_cnt DESC

-- What is the average rating of each product line ?
select
round(avg(rating), 2) as rt,
product_line
from sales
group by product_line
order by rt desc

-- Number of sales made in each time of the day per weekday
 select
 time_of_day,
 count(*) as total_sales
 from sales
 where day_name = "Sunday"
 group by time_of_day
 order by total_sales desc
 
 -- Which of the customer types brings the most revenue?
SELECT 
    customer_type, SUM(total) AS total_revenue
FROM
    sales
GROUP BY customer_type
ORDER BY total_revenue DESC

-- Which city has the largest tax/VAT percent?
select 
city,
round(avg(VAT) , 2) as avg_vat
from sales
group by city 
order by avg_vat desc

alter table sales
rename column cutomer_type to customer_type

-- Which customer type pays the most in VAT?
select customer_type,
avg(vat) as avg_vat
from sales
group by customer_type
order by avg_vat desc

-- How many unique customer types does the data have?
select 
distinct customer_type
from sales

-- How many unique payment methods does the data have?
select 
distinct payment_method
from sales

-- What is the most common customer type? 
select customer_type,
avg(quantity) as total_sales
from sales
group by  customer_type
order by total_sales desc

-- Which customer type buys the most?


-- What is the gender of most of the customers ?
select gender,
count(customer_type) as total_cst
from sales
group by gender
order by total_cst desc

-- What is the gender distribution per branch?
SELECT 
    branch, 
    gender, 
    COUNT(*) AS gender_count, 
    (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (PARTITION BY branch) AS gender_percentage
FROM sales
GROUP BY branch, gender
ORDER BY branch, gender_percentage DESC

--  Which time of the day do customers give most ratings
select time_of_day,
round(avg(rating), 2) as avg_rating
from sales
group by time_of_day
order by avg_rating desc

-- Which time of the day do customers give most ratings per branch
select time_of_Day , branch,
round(avg(rating), 2) as avg_rating
from sales
group by time_of_day , branch
order by avg_rating desc

-- Which day of the week has the best avg ratings
select day_name,
avg(rating) as total_rating
from sales
group by day_name
order by total_rating desc

-- Which day of the week has the best average ratings per branch?
SELECT 
    day_name, branch, AVG(rating) AS total_rating
FROM
    sales
GROUP BY day_name , branch
ORDER BY total_rating DESC 

    
