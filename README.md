# Walmart-Data-Analysis-Using-MySQL
![image](https://github.com/mahmoudsamhoud/Walmart-Data-Analysis-Using-MySQL/assets/78819528/f46e3c18-ed7d-4b13-a8b4-e26b2b18da95)
## Introduction
Walmart Inc. is an American multinational retail corporation that operates a chain of hypermarkets, discount department stores, and grocery stores around the world.
The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).
In this project, we will study the Maynmar sales only

## Aim of Project
This project aims to explore Walmart Sales data in order to get insights into different products, sales, and customer behavior that will help improve sales strategies and hopefully increase sales.

## About Data
This dataset contains sales transactions from Walmart branches located in different cities of MaynmarThe data contains 17 columns and 1000 rows:
| Column                  | Description                                | Data Type      |
| :---------------------- | :----------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made                  | VARCHAR(20)    |
| branch                  | Branch at which sales were made            | VARCHAR(5)     |
| city                    | The location of the branch                 | VARCHAR(30)    |
| customer_type           | Custome membership (member or normal)      | VARCHAR(10)    |
| gender                  | Gender of the customer                     | VARCHAR(10)    |
| product_line            | Product Category                           | VARCHAR(50)    |
| unit_price              | price of one unit of the product           | DECIMAL(10, 2) |
| quantity                | The quantity of the sold product           | INT            |
| tax                     | The amount of tax on the purchase          | FLOAT(6, 3)    |
| total                   | The total cost of the purchase             | DECIMAL(12, 4) |
| date                    | The date on which the purchase was made    | DATE           |
| time                    | The time at which the purchase was made    | TIME           |
| payment                 | Payment Method (cash, credit card, etc..   | VARCHAR(15)    |
| cogs                    | Cost Of Goods sold                         | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                    | FLOAT(15, 10)  |
| gross_income            | Gross Income                               | DECIMAL(15, 5) |
| rating                  | Rating on scale from 1-10                  | FLOAT(2, 1)    |

## Performed Analyses
  Three categories of analyses were performed:
   - Product Analysis
   - Sales Analysis
   - Customer Analysis
## Questions To Be Answered
### General questions
   - How many cities is Walmart located in?
   - How many branches are in each city?
   - What are the types of branches for each city?
### 
