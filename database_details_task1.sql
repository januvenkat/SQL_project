
-- Q 1.1

use classicmodels;
-- Query 1

SELECT customerNumber, customerName, contactLastName, contactFirstName, phone
FROM customers
ORDER BY customerNumber DESC
LIMIT 10;

-- Answer - Retrieve the top 10 customers (based on their customerNumber) and their contact details. This query can be useful for businesses to quickly get in touch with the most recently added customers.

-- Query 2

SELECT country, COUNT(*) as NumberOfCustomers
FROM customers
GROUP BY country
ORDER BY NumberOfCustomers DESC;

-- Answer - This query helps businesses understand the distribution of their customer base by country, which can be valuable for marketing and expansion strategies.

-- Q 1.2

-- Query 1

SELECT o.orderNumber, o.orderDate, c.customerName, c.contactLastName, c.contactFirstName, c.phone
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
ORDER BY o.orderDate DESC;

-- Answer - This query is helpful for customer service representatives to correlate orders with customers and potentially reach out to them.

-- Query 2

SELECT p.productName, p.productLine, AVG(od.quantityOrdered) as averageQuantity
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName, p.productLine
ORDER BY averageQuantity DESC;

-- Answer - This query provides insights into which products are ordered in higher quantities, which can be useful for inventory management.

-- Query 3

SELECT e.firstName, e.lastName, o.city, o.country, o.phone as officePhone
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode;

-- Answer - This query is useful for HR and administrative functions to understand where each employee is based.

-- Query 4

SELECT c.customerName, SUM(p.amount) as totalPayments
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
ORDER BY totalPayments DESC;

-- Answer - This query gives insights into the top-paying customers, which is valuable for sales and account management teams.

-- Q 1.3

-- Query 1

SELECT productCode, AVG(orderAmount) as averageOrderAmount
FROM (
    SELECT od.productCode, (od.quantityOrdered * od.priceEach) as orderAmount
    FROM orderdetails od
) AS subquerys
GROUP BY productCode;

-- Answer - In this query, the subquery calculates the total amount for each product in every order (quantity multiplied by price) and gives it an alias orderAmount. The outer query then calculates the average amount for each product.

-- Query 2

SELECT customerName, SUM(amount) as totalPayments
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY customerName
HAVING totalPayments > (
    SELECT AVG(amount) 
    FROM payments
);

-- Answer - In this query, the subquery calculates the average payment amount. The main query then aggregates the total payments by each customer and filters out only those customers whose total payments exceed the average payment amount.

-- Q 1.4 

-- Query 1

SELECT 
    customerNumber,
    paymentDate,
    amount,
    SUM(amount) OVER(PARTITION BY customerNumber ORDER BY paymentDate) as runningTotal
FROM payments
ORDER BY customerNumber, paymentDate;

-- Answer - Calculate the running total of payments for each customer, ordered by payment date.

-- Query 2

SELECT 
    productName,
    productLine,
    buyPrice,
    RANK() OVER(PARTITION BY productLine ORDER BY buyPrice DESC) as rankWithinProductLine
FROM products;

-- Answer -  rank products based on their list price within each product line.











