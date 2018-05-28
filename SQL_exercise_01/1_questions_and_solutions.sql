-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store


-- 1.1 Select the names of all the products in the store.
-- 查询出所有产品名称
select Name from Products;

-- 1.2 Select the names and the prices of all the products in the store.
-- 查询出所有产品名称和价格
select name, price from products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
-- 查询价格少于200的产品
select name from products where price <= 200;


-- 1.4 Select all the products with a price between $60 and $120.
-- 查询价格在指定区间的产品
select * from products where price between 60 and 120;
select * from products where price >= 60 and price <= 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
-- 查询产品信息 金额用百分比表示 (价格字段需*100)
select name, price*100 from products;

select name, concat(price*100, ' cents') from products;

-- 1.6 Compute the average price of all the products.
-- 计算产品的平均价格
select avg(price) from products;
select sum(price)/count(price) from products;
 
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
-- 计算指定供应商 产品的平均价格
select avg(price) from products where  Manufacturer = 2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
-- 查询价格180 以上的产品数量
select count(*) from products where price>=180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
-- 查询单价180以上的name和price字段,先根据单价倒序,然后单价相同的根据名称排序
select name, price from products where price>=180 order by price desc, name asc;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
-- 查询产品所有数据,同时包含产品的每个供应商信息(根据products表的manufacturer字段加载供应商信息)
select a.*, b.name from products a join Manufacturers b on(a.manufacturer = b.code);
select a.*, b.name from products a, Manufacturers b where a.manufacturer = b.code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
-- 查询产品部分字段和供应商名称
select a.name, a.price, b.name from products a join Manufacturers b on(a.manufacturer = b.code);

SELECT Products.Name, Price, Manufacturers.Name
   FROM Products INNER JOIN Manufacturers
   ON Products.Manufacturer = Manufacturers.Code;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
-- 计算每个供应商的所有产品的平均价格,仅显示供应商code字段
SELECT AVG(Price), Manufacturer
    FROM Products
GROUP BY Manufacturer;


-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
-- 计算每个供应商的所有产品的平均价格,仅显示供应商名称
select avg(a.price), b.name 
from Products a join Manufacturers b 
on a.manufacturer = b.code
group by b.name;


-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
-- ...,筛选平均价格大于150的
select avg(a.price), b.name 
from Manufacturers b join Products a 
on b.code = a.Manufacturer
group by b.name
having avg(a.price)>=150;

SELECT AVG(Price) avgPrice, Manufacturers.Name
   FROM Products, Manufacturers
   WHERE Products.Manufacturer = Manufacturers.Code
   GROUP BY Manufacturers.Name
   HAVING avgPrice >= 150;
   
   
-- 1.15 Select the name and price of the cheapest product.
-- 选择最便宜的产品
select name, price from Products 
where price = (
select min(price)
from products);

-- explain 结果 type:all,extra:using fileSort
SELECT name,price
  FROM Products
  ORDER BY price ASC
  LIMIT 1;
  
--SQL SERVER SOLUTION (T-SQL)
-- sql server 解决方案
SELECT TOP 1 name
            ,price
FROM Products
ORDER BY price ASC
  

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
-- 选择 每个供应商名称,以及每个最贵产品的名称和价格
select max_price_mapping.name as manu_name, max_price_mapping.price, products_with_manu_name.name as product_name
from 
    (SELECT Manufacturers.Name, MAX(Price) price
     FROM Products, Manufacturers
     WHERE Manufacturer = Manufacturers.Code
     GROUP BY Manufacturers.Name)
     as max_price_mapping
   left join
     (select products.*, manufacturers.name manu_name
      from products join manufacturers
      on (products.manufacturer = manufacturers.code))
      as products_with_manu_name
 on
   (max_price_mapping.name = products_with_manu_name.manu_name
    and
    max_price_mapping.price = products_with_manu_name.price); 




-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into Products values (11, 'Loudspeakers', 70, 2);


-- 1.18 Update the name of product 8 to "Laser Printer".
update products
set name = 'Laser Printer'
where code=8;

-- 1.19 Apply a 10% discount to all products.
update products
set price=price*0.9;


-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
update products
set price = price * 0.9
where price >= 120; 


