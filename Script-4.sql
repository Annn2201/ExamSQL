
-- cau 2
select * 
from offices o 
where country = 'USA'

-- cau 3
alter table employees 
add fullname varchar(255)

update employees 
set fullname = 
concat(firstName, lastName)
where fullname is null ;


-- CAU 4
select * from employees e left join offices o on e.officeCode = o.officeCode

-- cau 6
select count(employeeNumber)
from employees e 

-- cau 5
select * from offices o2 where officeCode not in (select officeCode from employees e)

-- cau 9
select * from customers c where salesRepEmployeeNumber is not null 

-- cau 8
select * from customers c join payments p on c.customerNumber = p.customerNumber 
order by p.paymentDate asc limit 0, 10

-- cau 7
select c.customerNumber, count(p.customerNumber) countPayment from customers c 
inner join payments p ON p.customerNumber = c.customerNumber 
group by p.customerNumber 
having count(p.customerNumber) <= 3;

-- cau 10
select c.customerNumber, count(p.customerNumber) countPayment from customers c 
inner join payments p ON p.customerNumber = c.customerNumber 
group by p.customerNumber 
order by countPayment desc 
limit 10

-- cau 11
select * 
from orders o 
where orderDate between '2003-11-01' and '2003-11-30'

-- cau 12
insert into employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) values 
(1705, 'AN', 'Nguyen', 'x1234', 'an1500165@nuce.edu.vn', 1, 1088, 'Sales Rep'),
(1704, 'AN', 'Nguyen', 'x1234', 'an1500165@nuce.edu.vn', 1, 1088, 'Sales Rep')

-- cau 13
insert into offices (officeCode ,city, phone, addressLine1 , addressLine2 , state , country , postalCode, territory) values 
(8, 'Ha Noi', '0265198472', '59 Giai Phong', '96 Le Thanh Nghi', 'Ha Noi', 'Viet Nam', '1111111', 'SEA'),
(9, 'Ha Noi', '0265198472', '59 Giai Phong', '96 Le Thanh Nghi', 'Ha Noi', 'Viet Nam', '1111111', 'SEA')

-- cau 14
update customers  
set addressLine2 = '31 street Red'
where salesRepEmployeeNumber in ( 
select employeeNumber from offices o join employees e on o.officeCode = e.officeCode where e.officeCode = 1)
-- );

-- cau15
update customers 
set addressLine2 = addressLine1 
where addressLine2 is null 

-- cau 16
update customers 
set state = concat(upper(left (city, 1)), substring(city, 2, 2))
where state is null 

-- cau 17
select c.customerNumber, count(o.customerNumber) countOrders from customers c 
inner join orders o  ON o.customerNumber = c.customerNumber 
group by o.customerNumber 
order by countOrders desc 
limit 10

-- cau 18
select * from orderdetails o 

-- cau 19
select * from orderdetails o 
where left (productCode, 3) = 'S10' 


-- cau 20
select p.productCode, count(o.productCode) countDetails from products p left join orderdetails o 
on p.productCode = o.productCode 
group by p.productCode 
order by countDetails desc 
limit 11

-- cau 21
select p.productCode, p.productLine, o.orderNumber ,o.quantityOrdered , o.priceEach , o.orderLineNumber 
from products p left join orderdetails o 
on p.productCode = o.productCode

-- cau 22
insert into products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP) values
('S99_1234', 'Lamborghini', 'Classic Cars', '1:18', 'Audi Auto', 'Beautiful Car', 10000, 100.00, 1000),
('S99_1235', 'Lamborghini Huracan', 'Classic Cars', '1:18', 'Audi Auto', 'Beautiful Car', 9999, 100.00, 649),
('S99_1239', 'Lamborghini Aventador', 'Classic Cars', '1:18', 'Audi Auto', 'Beautiful Car', 16594, 100.00, 4849);

-- cau 23 
delete from customers 
where customerNumber not in (select customerNumber from orders )

-- cau 24
select * from orders o join orderdetails o2 ON o.orderNumber = o2.orderNumber 
order by customerNumber asc

-- cau 25
with USA_Customers as (
select * from customers c 
where c.country = 'USA'
)
select p.customerNumber, USA_Customers.customerName, count(p.customerNumber) countPayments
from payments p join USA_Customers 
on p.customerNumber = USA_Customers.customerNumber
group by p.customerNumber 
order by countPayments desc 
limit 1

-- cau 26
select * 
from payments p 
order by amount 
limit 3

-- cau 27
with cau_27 as(
select * 
from products p natural join orderdetails o 
)
, cau_27_2 as (
select * from cau_27 natural join orders o2
)
-- select * from cau_27_2 join payments p 
-- on cau_27_2.customerNumber = p.customerNumber
select cau_27_2.productCode, count(p.customerNumber) countPayments from cau_27_2 join payments p 
on cau_27_2.customerNumber = p.customerNumber
group by p.customerNumber
order by countPayments desc
limit 5

-- cau 28
select * 
from orders o join payments p 
on o.customerNumber = p.customerNumber 
where (p.paymentDate between '2003-04-01' and '2003-04-30') 
or (p.paymentDate between '2003-12-01' and '2003-12-31')

-- cau 29
with cau_29 as (
select *
from customers c join employees e
on c.salesRepEmployeeNumber = e.employeeNumber 
) , cau_29_2 as (
select officeCode, count(officeCode) countEmRep from cau_29 
group by officeCode
order by countEmRep desc 
) 
select * from cau_29_2 natural join offices o 
order by countEmRep desc 
limit 1

-- cau 30
select * 
from customers c 
where creditLimit < 20000 

-- cau 31
select *
from products p 
order by quantityInStock desc 
limit 2

-- cau 32
-- select *
-- from products p 
-- where productCode in (select productCode from orders o)
-- order by buyPrice asc 
-- limit 10
-- cau 32
with cau_32 as (
select productCode , priceEach , sum(quantityOrdered) totalOrder from orderdetails
group by productCode 
order by totalOrder desc
limit 10
)
select * from cau_32
order by priceEach 
-- order by squantityOrdered desc, priceEach asc

-- cau 33
select productCode, status , count(productCode) countProduct  from orders o natural join orderdetails o2 
where status = 'Cancelled'
group by productCode 
order by countProduct desc
limit 5

-- cau 34
select productCode, shippedDate  from orders o natural join orderdetails o2 
where shippedDate between '2004-01-01' and '2004-12-31'
limit 5

-- cau 35
select customerNumber , sum(amount) totalAmount from payments p
where paymentDate between '2004-01-01' and '2004-12-31'
group by customerNumber 

-- cau 36
select *, count(reportsTo) countReport from employees e
group by reportsTo 
order by countReport desc
limit 2

-- cau 37
with cau_37 as (
select productCode, orderNumber, orderDate from orders o natural join orderdetails o2
where orderDate not between '2005-01-01' and '2005-12-31'
) 
select * from cau_37

-- cau 38
select * from orders o 
where datediff(shippedDate, orderDate) < 3 
limit 10

-- cau 39
select * from orders o 
where shippedDate between '2004-12-01' and '2004-12-31'
limit 10