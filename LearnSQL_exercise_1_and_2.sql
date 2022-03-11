#LearnSQL SQL exercises





#-------------------------------------------------------------------------------------------------




#Select all the information from the employees table.


SELECT *
FROM employees;


#Select each customer's ID, company name, contact name, contact title, city, and country. Order the results by the name of the country.


SELECT customer_id, company_name, contact_name, contact_title, city, country
FROM customers
ORDER BY country;



#For each product, display its name (product_name), the name of the category it belongs to (category_name), quantity per unit (quantity_per_unit), the unit price (unit_price), 
#and the number of units in stock (units_in_stock). Order the results by unit price.



SELECT p.product_name, c.category_name, p.quantity_per_unit, p.unit_price, p.units_in_stock
FROM products AS p
JOIN categories AS c
ON p.category_id = c.category_id
ORDER BY p.unit_price;



#We'd like to see information about all the suppliers who provide the store four or more different products. 
#Show the following columns: supplier_id, company_name, and products_count (the number of products supplied).


SELECT s.supplier_id, s.company_name, COUNT(*) as products_count
FROM suppliers AS s
JOIN products AS p
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.company_name
HAVING COUNT(*) >= 4;



#Display the list of products purchased in the order with ID equal to 10250. 
#Show the following information: product name (product_name), the quantity of the product ordered (quantity), 
#the unit price (unit_price from the order_items table), the discount (discount), and the order_date. Order the items by product name.



SELECT p.product_name, o.quantity, o.unit_price, o.discount, o2.order_date
FROM products p
JOIN order_items o
ON p.product_id = o.product_id
JOIN orders o2
ON o.order_id = o2.order_id
WHERE o.order_id = 10250
ORDER BY p.product_name;



#Show the following information related to all items with order_id = 10248: the product name, the unit price (taken from the order_items table), 
#the quantity, and the name of the supplier's company (as supplier_name).



  SELECT p.product_name, o.unit_price, o.quantity, s.company_name as supplier_name
  FROM order_items o
  JOIN products p
  ON o.product_id = p.product_id
  JOIN suppliers s
  ON p.supplier_id = s.supplier_id
  WHERE o.order_id = 10248;




#Show the following information for each product: the product name, the company name of the product supplier (use the suppliers table), 
#the category name, the unit price, and the quantity per unit.



SELECT p.product_name, s.company_name, c.category_name, p.unit_price, p.quantity_per_unit
FROM products p
JOIN suppliers s
ON p.supplier_id = s.supplier_id
JOIN categories c
ON p.category_id = c.category_id;




#Count the number of employees hired in 2013. Name the result number_of_employees.


SELECT COUNT(*) as number_of_employees
FROM employees
WHERE hire_date >= '2013-01-01' AND hire_date < '2014-01-01';



#Show each supplier_id alongside the company_name and the number of products they supply (as the products_count column). Use the products and suppliers tables.


SELECT s.supplier_id, s.company_name, COUNT(p.product_name) products_count
FROM suppliers s
JOIN products p
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id;



#The template code shows the query from the explanation. The Northwind store offers its customers discounts for some products. 
#The discount for each item is stored in the discount column of the order_items table. 
#(For example, a 0.20 discount means that the customer pays 1 - 0.2 = 0.8 of the original price.) Your task is to add a second column named total_price_after_discount.



SELECT SUM(unit_price * quantity) AS total_price, SUM(unit_price * quantity * (1 - discount)) AS total_price_after_discount
FROM orders o
JOIN order_items oi 
  ON o.order_id = oi.order_id
WHERE o.order_id = 10250;




#We want to know the number of orders processed by each employee. Show the following columns: employee_id, first_name, last_name, and the number of orders processed as orders_count.



SELECT e.employee_id, first_name, last_name, COUNT(o.*) as orders_count
FROM employees e
JOIN orders o
ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;




#How much are the products in stock in each category worth? Show three columns: category_id, category_name, and category_total_value.
# You'll calculate the third column as the sum of unit prices multiplied by the number of units in stock for all products in the given category.


SELECT c.category_id, category_name, SUM(p.unit_price * p.units_in_stock) as category_total_value
FROM categories c
JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;




#Count the number of orders placed by each customer. Show the customer_id, company_name, and orders_count columns.



SELECT c.customer_id, company_name, COUNT(o.*) as orders_count
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.company_name;




#Which customers paid the most for orders made in June 2016 or July 2016? Show two columns:
#company_name
#total_paid, calculated as the total price (after discount) paid for all orders made by a given customer in June 2016 or July 2016.
#Sort the results by total_paid in descending order.



SELECT c.company_name, SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) as total_paid
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.order_date >= '2016-06-01' AND o.order_date <= '2016-07-31'
GROUP BY c.customer_id, c.company_name
ORDER BY total_paid DESC;





#Count the number of customers with and all those without a fax number. Show two columns: all_customers_count and customers_with_fax_count



SELECT COUNT(*) as all_customers_count, COUNT(fax) as customers_with_fax_count
FROM customers;




#Find the total number of products provided by each supplier. 
#Show the company_name and products_count (the number of products supplied) columns. Include suppliers that haven't provided any products.



SELECT s.company_name, COUNT(p.product_id) as products_count
FROM suppliers s
LEFT JOIN products p
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.company_name;



#Show the number of unique companies (as number_of_companies) that had orders shipped to Spain.



SELECT COUNT(DISTINCT customer_id) as number_of_companies
FROM orders
WHERE ship_country = 'Spain';




#Find the total number of products supplied by each supplier. Show the following columns: supplier_id, company_name, 
#and products_supplied_count (the number of products supplied by that company).



SELECT s.supplier_id, company_name, count(p.supplier_id) as products_supplied_count
FROM suppliers s
JOIN products p
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.company_name;




#How many distinct products are there in all orders shipped to France? Name the result distinct_products.



SELECT COUNT(DISTINCT oi.product_id) as distinct_products
FROM order_items oi
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.ship_country = 'France';




#Show three kinds of information about product suppliers:
#all_suppliers (the total number of suppliers)
#suppliers_region_assigned (the total number of suppliers who are assigned to a region)
#unique_supplier_regions (the number of unique regions suppliers are assigned to)



SELECT COUNT(supplier_id) as all_suppliers , COUNT(region) as suppliers_region_assigned, COUNT(DISTINCT region) as unique_supplier_regions
FROM suppliers;




#For each employee, compute the total order value before discount from all orders processed by this employee between 5 July 2016 and 31 July 2016. 
#Show the following columns: first_name, last_name, and sum_orders. Sort the results by sum_orders in descending order.



SELECT e.first_name, e.last_name, SUM(oi.unit_price * oi.quantity) as sum_orders
FROM employees e
JOIN orders o
ON e.employee_id = o.employee_id
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE order_date >= '2016-07-05' AND order_date <= '2016-07-31'
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY sum_orders DESC

