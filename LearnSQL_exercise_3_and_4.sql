# Learn SQL exercise 3 and 4










#-----------------------------------------------------------------------------



#We want to create a report measuring the level of experience each Northwind employee has with the company. Show the first_name, last_name, hire_date, and experience columns for each employee. 
#The experience column should display the following values:
#'junior' for employees hired after Jan. 1, 2014.
#'middle' for employees hired after Jan. 1, 2013 but before Jan. 1, 2014.
#'senior' for employees hired on or before Jan. 1, 2013.




SELECT first_name, last_name, hire_date,
CASE
WHEN hire_date > '2014-01-01' THEN 'junior'
WHEN hire_date > '2013-01-01' AND hire_date < '2014-01-01' THEN 'middle'
WHEN hire_date <= '2013-01-01' THEN 'senior'
END AS experience
FROM employees;




#We want to show the following basic customer information (from the customers table):
#customer_id
#company_name
#country
#language
#The value of the language column will be decided by the following rules:
#'German' for companies from Germany, Switzerland, and Austria.
#'English' for companies from the UK, Canada, the USA, and Ireland.
#'Other' for all other countries.




SELECT customer_id, company_name, country,
CASE
WHEN country IN ('Germany', 'Switzerland', 'Austria') THEN 'German'
WHEN country IN ('UK', 'Canada', 'USA', 'Ireland') THEN 'English'
ELSE 'Other'
END AS language
FROM customers;




#Let's create a report that will divide all products into vegetarian and non-vegetarian categories. For each product, show the following columns:
#product_name
#category_name
#diet_type:
#'Non-vegetarian' for products from the categories 'Meat/Poultry' and 'Seafood'.
#'Vegetarian' for any other category



SELECT p.product_name, c.category_name,
CASE
WHEN c.category_name IN ('Meat/Poultry', 'Seafood') THEN 'Non-vegetarian'
ELSE 'Vegetarian'
END as diet_type
FROM products as p
JOIN categories as c
on p.category_id = c.category_id;





#Create a report that shows the number of products supplied from a specific continent. Display two columns: supplier_continent and product_count. The supplier_continent column should have the following values:
#'North America' for products supplied from 'USA' and 'Canada'.
#'Asia' for products from 'Japan' and 'Singapore'.
#'Other' for other countries.



SELECT CASE
WHEN s.country IN ('USA', 'Canada') THEN 'North America'
WHEN s.country IN ('Singapore', 'Japan') THEN 'Asia'
ELSE 'Other'
END AS supplier_continent,
COUNT(p.product_id) AS product_count
FROM suppliers s
JOIN products p
ON s.supplier_Id = p.supplier_id
GROUP BY supplier_continent;




#We want to create a simple report that will show the number of young and old employees at Northwind. Show two columns: age and employee_count.
#The age column has the following values:
#'young' for people born after Jan. 1, 1980.
#'old' for all other employees.



SELECT COUNT(employee_id) as employee_count,
CASE
WHEN birth_date > '1980-01-01' THEN 'young'
ELSE 'old'
END AS age
FROM employees
GROUP BY age;




#How many customers are represented by owners (contact_title = 'Owner'), and how many aren't? Show two columns with appropriate values: represented_by_owner and not_represented_by_owner.



SELECT COUNT(CASE
             WHEN contact_title = 'Owner' THEN customer_id END) AS represented_by_owner,
       COUNT(CASE
             WHEN contact_title != 'Owner' THEN customer_id END) AS not_represented_by_owner
FROM customers;




#Washington (WA) is Northwind's primary region. How many orders have been processed by employees in the WA region, and how many by employees in other regions? 
#Show two columns with their respective counts: orders_wa_employees and orders_not_wa_employees.



SELECT COUNT(CASE
             WHEN e.region = 'WA' THEN o.order_id END) as orders_wa_employees,
       COUNT(CASE
             WHEN e.region != 'WA' THEN o.order_id END) as orders_not_wa_employees
FROM employees e
JOIN orders o
ON e.employee_id = o.employee_id;




#We need a report that will show the number of products with high and low availability in all product categories. 
#Show three columns: category_name, high_availability (count the products with more than 30 units in stock) and low_availability (count the products with 30 or fewer units in stock).



SELECT c.category_name, COUNT(CASE
                            WHEN p.units_in_stock > 30 THEN p.product_id END) as high_availability,
                      COUNT(CASE
                            WHEN p.units_in_stock <= 30 THEN p.product_id END) as low_availability
FROM products p
JOIN categories c
ON p.category_id = c.category_id
GROUP BY c.category_name;




#There have been a lot of orders shipped to France. Of these, how many order items were sold at full price and how many were discounted? Show two columns with the respective counts: 
#full_price and discounted_price.




SELECT SUM(CASE
           WHEN oi.discount = 0  THEN 1 END) as full_price,
       SUM(CASE
           WHEN oi.discount !=0  THEN 1 END) as discounted_price
FROM order_items oi
JOIN orders o
ON oi.order_id = o.order_id AND o.ship_country = 'France';




#This time, we want a report that will show each supplier alongside their number of units in stock and their number of expensive units in stock. Show four columns: 
#supplier_id, company_name, all_units (all units in stock supplied by that supplier), and expensive_units (units in stock with a unit price over 40.0, supplied by that supplier).




SELECT 
  s.supplier_id,
  s.company_name,
  SUM(units_in_stock) AS all_units,
  SUM(CASE
    WHEN unit_price > 40.0 THEN units_in_stock
    ELSE 0
  END) AS expensive_units
FROM products p
JOIN suppliers s
  ON p.supplier_id = s.supplier_id
GROUP BY s.supplier_id,
  s.company_name;





# For each product, show the following columns: product_id, product_name, unit_price, and price_level. The price_level column should show one of the following values:
#'expensive' for products with a unit price above 100.
#'average' for products with a unit price above 40 but no more than 100.
#'cheap' for other products.



SELECT product_id, product_name, unit_price, CASE 
                                             WHEN unit_price > 100 THEN 'expensive'
                                             WHEN unit_price > 40 and unit_price < 100 THEN 'average'
                                             ELSE 'cheap'
                                             END as price_level
                                             
FROM products;                                          




#We would like to categorize all orders based on their total price (before any discount). For each order, show the following columns:
#order_id
#total_price (calculated before discount)
#price_group, which should have the following values:
#'high' for a total price over $2,000.
#'average' for a total price between $600 and $2,000, both inclusive.
#'low' for a total price under $600.



SELECT
  order_id,
  SUM(unit_price * quantity) AS total_price,
  CASE
    WHEN SUM(unit_price * quantity) > 2000 THEN 'high'
    WHEN SUM(unit_price * quantity) > 600 THEN 'average'
    ELSE 'low'
  END AS price_group
FROM order_items
GROUP BY order_id;




#Group all orders based on the freight column. Show three columns in your report:
#low_freight – the number of orders where the freight value is less than 40.0.
#avg_freight – the number of orders where the freight value is greater than equal to or 40.0 but less than 80.0.
#high_freight – the number of orders where the freight value is greater than equal to or 80.0.




SELECT COUNT(CASE WHEN freight < 40.0 THEN 1 END) as low_freight,
       COUNT(CASE WHEN freight >= 40.0 AND freight < 80.0 THEN 1 END) avg_freight,
       COUNT(CASE WHEN freight > 80 THEN 1 END) as high_freight
FROM orders;


