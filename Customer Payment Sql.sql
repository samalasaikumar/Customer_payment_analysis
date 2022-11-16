CREATE VIEW customerPayments
AS 
SELECT 
    customerName, 
    checkNumber, 
    paymentDate, 
    amount
FROM
    customers
INNER JOIN
    payments USING (customerNumber);
    
    CREATE VIEW customerPayments
AS 
SELECT 
    customerName, 
    checkNumber, 
    paymentDate, 
    amount
FROM
    customers
INNER JOIN
    payments USING (customerNumber);

select customerNumber,amount from
 payments
where amount= (select max(amount) from payments);







#find the customers whose payments are greater than the average payment
select customernumber,amount from payments
where amount> (select avg(amount) from payments);

#find out the customers who have not placed any orders
select customernumber,customerName from customers
where customerNumber not in(select distinct customerNumber from orders);


select max(items), min(items), avg(items) from ( select
 orderNumber, count(ordernumber) as items from orderdetails
 group by ordernumber) as lineitems;

select max(items), min(items), floor(avg(items)) from ( select
 orderNumber, count(ordernumber) as items from orderdetails
 group by ordernumber) as lineitems;


select productname,buyprice from products p1
where buyprice> (select avg(buyprice) from products
where productline = p1.productline);



#subquery with exists and not exists
SELECT 
    orderNumber, 
    SUM(priceEach * quantityOrdered) total
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 60000;

SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE
    EXISTS( SELECT 
            orderNumber, SUM(priceEach * quantityOrdered)
        FROM
            orderdetails
                INNER JOIN
            orders USING (orderNumber)
        WHERE
            customerNumber = customers.customerNumber
        GROUP BY orderNumber
        HAVING SUM(priceEach * quantityOrdered) > 60000);
