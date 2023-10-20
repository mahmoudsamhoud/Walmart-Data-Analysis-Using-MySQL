CREATE DATABASE IF NOT EXISTS WalmartSales;
CREATE TABLE IF NOT EXISTS Sales_data(
	invoice_id VARCHAR(20) NOT NULL primary KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL, 
    cust_type VARCHAR(10) NOT NULL,
    gender VARCHAR(10) NOT NULL, 
    product_line VARCHAR (50) NOT NULL,
    unit_price DECIMAL (10,2) NOT NULL,
    quantity INT NOT NULL,
    tax FLOAT (6,3) NOT NULL,
    total DECIMAL (12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL (10,2) NOT NULL,
    gross_margin_pct FLOAT(15,10)NOT NULL,
    gross_income DECIMAL (15, 5) NOT NULL,
    rating FLOAT (2, 1) NOT NULL
    );
    
    -- A csv file were imported to fill the sales_data table created above
    -- Each column of the csv file was assigned to its corresponding column in sales_data
    -- We are sure that there are no null values in our table
    -- because of the way we created each column
    
    
    -- ---------------------------------------------------------------------
    -- ---------------------- Feature Engineering --------------------------
    
    
    -- Adding the day_time column which identifies 
	-- each interval of the day (morning, afternoon, evening, and night )
    
    Select 
		time,
        (CASE 
			WHEN `time` BETWEEN "04:00:00" AND "12:00:00" THEN "Morning"
            WHEN `time` BETWEEN "12:01:00" AND "17:00:00" THEN "Afternoon"
            WHEN `time` BETWEEN "17:01:00" AND "21:00:00" THEN "Evening"
            ELSE "Night"
        END) AS day_time
		FROM sales_data;
        
	ALTER TABLE sales_data ADD COLUMN day_time VARCHAR(15);
    
    UPDATE sales_data 
    set day_time = (CASE 
			WHEN `time` BETWEEN "04:00:00" AND "12:00:00" THEN "Morning"
            WHEN `time` BETWEEN "12:01:00" AND "17:00:00" THEN "Afternoon"
            WHEN `time` BETWEEN "17:01:00" AND "21:00:00" THEN "Evening"
            ELSE "Night"
        END
    );
    
    -- Adding the day_name column to identify each day of the week
    
    SELECT
		date,
        DAYNAME(date) AS day_name
        FROM sales_data;
	ALTER TABLE sales_data ADD COLUMN day_name VARCHAR(10);
    UPDATE sales_data
    set day_name = DAYNAME(date);
    
-- Adding month_name column to identify each month of the year

    SELECT
		date,
        MONTHNAME(date) AS month_name
        FROM sales_data;
	
    ALTER TABLE sales_data ADD COLUMN month_name VARCHAR(10);
    UPDATE sales_data
    set month_name = MONTHNAME(date);
    

-- ----------------------------------------------------------------------------
-- ------------------------Exploratory Data Analysis (EDA) --------------------
-- ----------------------------------------------------------------------------

-- ----------------------------- General Questions ----------------------------
--  How many cities is Walmart located in?
SELECT
		DISTINCT city
    FROM sales_data;

-- How many branches are in each city?
SELECT 
	DISTINCT branch
FROM sales_data;
    
SELECT 
	COUNT(DISTINCT city, branch)
FROM sales_data;
    
-- What are the types of branches for each city?
SELECT 
	DISTINCT city, branch
FROM sales_data;
    
-- -------------------------- Product Analysis --------------------------------

-- How many unique product categories does the data have?
SELECT 
	DISTINCT product_line
FROM sales_data;
    
SELECT 
	COUNT(DISTINCT product_line)
FROM sales_data;

-- What is the most selling product category?
SELECT 
	product_line,
    COUNT(product_line) AS pl_sales
FROM sales_data
GROUP BY product_line
ORDER BY pl_sales DESC;

-- Which product line has the largest Tax?
SELECT
	product_line, 
    AVG(tax) AS tax_avg
    FROM sales_data
    GROUP BY product_line
    ORDER BY tax_avg DESC;

 -- What is the most common product line by gender?
 SELECT 
	gender,
    product_line,
    COUNT(gender) AS gender_count
    FROM sales_data
    GROUP BY gender, product_line
    ORDER BY gender_count DESC;
    
-- What is the average rating of each product line?
SELECT 
	ROUND(AVG(rating),2) AS rating_avg,
    product_line
    FROM sales_data
    GROUP BY product_line
    ORDER BY rating_avg DESC;

    
-- ------------------------ Sales Analysis ------------------------------------

-- What is the total revenue by month?
SELECT 
	month_name AS month,
    SUM(total) AS total_rev
    FROM sales_data
    GROUP BY month_name
    ORDER BY total_rev DESC;
    
-- What month had the largest COGS?
SELECT 
	month_name AS month,
    SUM(cogs) AS cogs_per_month
    FROM sales_data
    GROUP BY month
    ORDER BY cogs_per_month DESC;
    
-- What product line had the largest revenue?
SELECT 
	product_line AS product_line,
    SUM(total) AS total_rev
    FROM sales_data
    GROUP BY product_line
    ORDER BY total_rev DESC;
    
-- What is the city with the largest revenue?
SELECT 
	city as city,
    SUM(total) AS total_rev
    FROM sales_data
    GROUP BY city
    ORDER BY total_rev DESC;

-- Which branch sold more products than the average product sold?
SELECT
	branch,
    (SUM(quantity)/3) as qty_avg,
    SUM(quantity) as qty
    FROM sales_data
    GROUP BY (branch)
    HAVING qty > (SELECT AVG(quantity) FROM sales_data);

-- Number of sales made at each time of the day per weekday
SELECT 
	day_time,
	COUNT(*) AS total_sales
    FROM sales_data
    WHERE day_name = "Saturday" -- Type tha name of the day u want
    GROUP BY day_time
    ORDER BY total_sales DESC;
    
    
-- Which of the customer types brings the most revenue?
SELECT 
	cust_type,
    SUM(total) AS total_rev
    FROM sales_data
    GROUP BY cust_type
    ORDER BY total_rev DESC;

-- Which city has the largest tax percentage/ VAT (Value Added Tax)?
SELECT 
	city, 
    AVG(tax) AS tax_avg
    FROM sales_data
    GROUP BY city
    ORDER BY tax_avg DESC;

-- Which customer type pays the most in VAT?
SELECT 
	cust_type, 
    AVG(tax) AS tax_avg
    FROM sales_data
    GROUP BY cust_type
    ORDER BY tax_avg DESC;


-- -----------------------Customer Analysis -----------------------------------

-- What is the most common payment method?

SELECT 
	payment_method, 
    COUNT(payment_method)
FROM sales_data
GROUP BY payment_method;

-- How many unique customer types does the data have?
SELECT 
	DISTINCT cust_type
    FROM sales_data;

SELECT 
	COUNT(DISTINCT cust_type)
    FROM sales_data;

-- How many unique payment methods does the data have?
SELECT 
	DISTINCT payment_method
    FROM sales_data;

SELECT 
	COUNT(DISTINCT payment_method)
    FROM sales_data;

-- What is the most common customer type?
SELECT 
	cust_type, 
    COUNT(cust_type) AS total_cust_type
    FROM sales_data
    GROUP BY cust_type
    ORDER BY total_cust_type DESC;

-- Which customer type buys the most?
SELECT 
	cust_type,
    COUNT(*) AS cust_count
    FROM sales_data
	GROUP BY cust_type
    ORDER BY cust_count DESC;

-- What is the gender of most of the customers?
SELECT 
	gender,
    COUNT(*) AS gender_count
    FROM sales_data
    GROUP BY gender
    ORDER BY gender_count DESC;
 
 -- What is the gender distribution per branch?
 SELECT 
	gender,
    COUNT(*) AS gender_count
    FROM sales_data
    WHERE branch = "C"   -- Select any branch you want ( A, B, C)
    GROUP BY gender
    ORDER BY gender_count DESC;

-- Which time of the day do customers give the most ratings?
SELECT 
	day_time,
    AVG(rating) AS avg_rating
    FROM sales_data
    GROUP BY (day_time)
    ORDER BY avg_rating DESC;

-- Which time of the day do customers give the most ratings per branch?
SELECT 
	day_time,
    AVG(rating) AS avg_rating
	FROM sales_data
	WHERE branch = "A"       -- Select any branch you want ( A, B, C)
    GROUP BY (day_time)
    ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings?
SELECT 
	day_name,
    AVG(rating) AS avg_rating
	FROM sales_data
	GROUP BY (day_name)
	ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
    AVG(rating) AS avg_rating
	FROM sales_data
    WHERE branch = "A"          -- Select any branch you want ( A, B, C)
	GROUP BY (day_name)
	ORDER BY avg_rating DESC;
    
