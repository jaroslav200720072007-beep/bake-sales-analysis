SELECT * FROM "BikeStores.xlsx - Data";


--Перевірка на NULL Значення
SELECT 
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN customers IS NULL THEN 1 ELSE 0 END) AS customers_nulls,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city_nulls,
    SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS state_nulls,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS order_date_nulls,
    SUM(CASE WHEN total_units IS NULL THEN 1 ELSE 0 END) AS total_units_nulls,
    SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS revenue_nulls,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS product_name_nulls,
    SUM(CASE WHEN category_name IS NULL THEN 1 ELSE 0 END) AS category_name_nulls,
    SUM(CASE WHEN brand_name IS NULL THEN 1 ELSE 0 END) AS brand_name_nulls,
    SUM(CASE WHEN store_name IS NULL THEN 1 ELSE 0 END) AS store_name_nulls,
    SUM(CASE WHEN sales_rep IS NULL THEN 1 ELSE 0 END) AS sales_rep_nulls
FROM "BikeStores.xlsx - Data";
 
 
 --Унікальні бренди велосипедів
 SELECT DISTINCT brand_name
 FROM "BikeStores.xlsx - Data"
 
 
 --Яких брендів найбільше висновком буде найпопулярніший бренд
 
 SELECT brand_name, COUNT(brand_name) AS count_brand_name
 FROM "BikeStores.xlsx - Data"
 GROUP BY brand_name
 ORDER BY count_brand_name DESC
 
 
 1.)
--Які бренди продаюця найкраще 
 SELECT brand_name, SUM(total_units) AS top_brand
 FROM "BikeStores.xlsx - Data"
 GROUP BY brand_name
 ORDER BY top_brand DESC
 
  
 2.)
 --Кількість товару кожного бренду 
 
 SELECT brand_name, COUNT(product_name) AS count_product
 FROM "BikeStores.xlsx - Data"
 GROUP BY brand_name

 3.)
 --Топ 5 брендів за кількістю продажів
 
 SELECT brand_name, COUNT(total_units) AS top_count 
 FROM "BikeStores.xlsx - Data"
 GROUP BY brand_name
 LIMIT 5

           
 4.)
 --Який Магазин Має найбільше замовлень 
 
 SELECT store_name, SUM(total_units) AS sum_units
 FROM "BikeStores.xlsx - Data"
 GROUP BY store_name 
 ORDER BY sum_units DESC
 LIMIT 1 
 
 5.) 
 --Загальний дохід по кожному магазину
 SELECT store_name, SUM(revenue) AS total_revenue 
 FROM "BikeStores.xlsx - Data"
 GROUP BY store_name
 
 6.)
 --Які товари продаюця найчастіше 
 SELECT product_name, COUNT(total_units) AS namber_of_goods
 FROM "BikeStores.xlsx - Data"
 GROUP BY product_name
 
 7.)
 --Загальний дохід компаніі по категоріям
SELECT 
    category_name, 
    SUM(revenue) OVER (PARTITION BY category_name) AS sum_revenue_category
FROM "BikeStores.xlsx - Data"

 
 8.)
 --Середній чек по кожній категоріі товару  щкруглений до 2 знаків після коми 
 SELECT category_name, ROUND(AVG(revenue), 2) AS avg_chack_category 
 FROM "BikeStores.xlsx - Data"
 GROUP BY category_name
 
9.)
--Кількість унікальних клієнтів та іх ініціали
SELECT customers, COUNT(DISTINCT customers)
FROM "BikeStores.xlsx - Data"
GROUP BY customers 

10.)
--Загальна кількість клієнтів
SELECT COUNT(DISTINCT customers)
FROM "BikeStores.xlsx - Data"

 11.)
 --Топ 10 клієнтів за витратами 
SELECT  customers, 
ROUND(SUM(revenue), 2) AS costs
FROM "BikeStores.xlsx - Data"
GROUP BY customers
ORDER BY SUM(revenue) DESC
LIMIT 10
 
 
 12.)
 --Кількість замовлень на місяць 
SELECT 
YEAR(order_date AS DATE) AS year,
MONTH(order_date AS DATE) AS month,
SUM(revenue) AS total_revenue
FROM "BikeStores.xlsx - Data"
GROUP BY 
YEAR(order_date AS DATE),
MONTH(order_date AS DATE)
ORDER BY 
year,
month;
 
13.)
--Топ 3 товари в кожній категоріі по кількості продажів
WITH top_3 AS(
SELECT category_name, product_name, total_units,
RANK() OVER (PARTITION BY category_name ORDER BY total_units DESC) AS rnk
FROM "BikeStores.xlsx - Data"
)
SELECT category_name, product_name, total_units
FROM top_3
WHERE rnk <= 3
 
 14.)
 --Скільки в середньому витратив клієнт значення заокруглено до 2 знаків після коми
 SELECT customers, ROUND(AVG(revenue),2) avg_revenue_custpomers
 FROM "BikeStores.xlsx - Data"
 GROUP BY customers
 
 15.)
--Аналіз повернення клієнтів
WITH customer_orders AS (
SELECT 
customers,
COUNT(order_id) AS total_orders
FROM "BikeStores.xlsx - Data"
GROUP BY customers
)

SELECT 
COUNT(*) AS total_customers,
    
SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS returning_customers,
    
ROUND(
SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) * 100.0 
/ COUNT(*), 2) AS returning_percentage

FROM customer_orders;
 
--Висновок: Аналіз показує яка частка клієнтів повертається для повторних покупок що є ключовим показником утримання клієнтів
 
 




