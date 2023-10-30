-- Database: Sales Data 

-- DROP DATABASE IF EXISTS "Sales Data ";

-- Task 4
CREATE DATABASE "Sales Data "
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- 1) Database creation 
Create table Sales_sample (Product_Id Int, Region Varchar(50), On_date Date, 
Sales_Amount Numeric, primary key (Product_Id));

Insert into Sales_sample (Product_Id, Region, On_date, Sales_Amount) values 
('1', 'East', '2023-10-10', '20000'),
('2', 'West', '2023-09-19', '')
