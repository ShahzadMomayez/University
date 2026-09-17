use company;

/*1 تعداد مشتریانی که هیچ وقت سفارشی ثبت نکردهاند*/
SELECT COUNT(*)
FROM customers c 
WHERE c.customer_id NOT IN (SELECT o.customer_id FROM orders o);

/*2 نام و نام خانوادگی  3کارمندی که بیشترین تعداد سفارش را بررسی کردهاند.*/
use company;
SELECT s.first_name , s.last_name 
FROM staffs s, orders o
WHERE s.staff_id = o.staff_id
GROUP BY o.staff_id
ORDER BY COUNT(s.first_name) DESC
LIMIT 3;

/*3 مشخصات تمام سفارشهایی که در وضعیت  Processingقرار دارند یا توسط مشتریانی ثبت شدهاند که نام آنها با حرف ’ ‘Aشروع میشود*/
SELECT o.*
FROM orders o
WHERE o.order_status = 2
UNION
SELECT o.*
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.first_name LIKE 'A%';


/*4     شناسه، نام و قیمت محصولاتی که قیمت آنها از میانگین قیمت محصولات بیشتر است.*/
SELECT p.product_id , p.product_name , p.list_price
FROM products p
WHERE p.list_price > (
	SElECT AVG(p.list_price)
    FROM products p);
    
/*5    شناسه فروشگاههایی که حداقل دو کارمند دارند و کارمندی دارند که نام او  5حرفی است */

SELECT stores.store_id
FROM stores , staffs
WHERE stores.store_id = staffs.store_id AND  staffs.first_name LIKE '_____' AND 
stores.store_id IN (
		SELECT stores.store_id 
		FROM stores  , staffs 
		WHERE stores.store_id = staffs.store_id 
		GROUP BY stores.store_id 
		HAVING COUNT(*)>1 );

/* 6  شناسه فروشگاههایی که کارمندی دارند که نام او  5حرفی است و حداقل دو کارمند با این مشخصات دارند. */
SELECT stores.store_id 
FROM stores  , staffs 
WHERE stores.store_id = staffs.store_id AND LENGTH( staffs.first_name) = 5
GROUP BY stores.store_id 
HAVING COUNT(staffs.store_id)>1 ;

/*7   شناسه، نام و نام خانوادگی مشتری به همراه میانگین تعداد کل محصولات خریداری شده توسط مشتریانی که بیش از  8سفارش دارند*/
SELECT 
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    AVG(oc.num_of_orders) AS avg_of_bought_products
FROM 
    customers 
JOIN 
    (
        SELECT 
            o.customer_id,
            SUM(item.quantity) AS num_of_orders
        FROM 
            orders o
        JOIN 
            order_items item ON o.order_id = item.order_id
        GROUP BY 
			o.order_id,
            o.customer_id
    ) AS oc ON customers.customer_id = oc.customer_id
GROUP BY 
    customers.customer_id
HAVING 
    COUNT(*) > 8;
    

/*8  شناسه، نام و موجودی کل برای محصولاتی که در تمامی فروشگاهها موجود هستند. (تعداد موجودی این محصولات باید بزرگتر از ۰ باشد*/
SELECT stocks.product_id, products.product_name, SUM(stocks.quantity) AS total_quantity
FROM stocks 
JOIN products  ON products.product_id = stocks.product_id
WHERE stocks.quantity > 0
GROUP BY stocks.product_id
HAVING COUNT(DISTINCT stocks.store_id) = (SELECT COUNT(DISTINCT store_id) FROM stocks)
;

/*9*/
SELECT brands.brand_name, p.product_name , p.product_id, p.list_price
FROM (
    SELECT brand_id, MAX(total_quantity) AS max_quantity
    FROM (
	    SELECT p.brand_id, item.product_id, SUM(item.quantity) AS total_quantity
	    FROM order_items item, products p
	    WHERE item.product_id = p.product_id
	    GROUP BY p.brand_id, item.product_id
	)AS brand_total_sale
    GROUP BY brand_id
)AS temp
JOIN products p ON temp.brand_id = p.brand_id 
AND temp.max_quantity = (  
					SELECT SUM(item.quantity) 
					FROM order_items item
					WHERE item.product_id = p.product_id
                      )
JOIN brands ON p.brand_id = brands.brand_id;

/*10*/
SELECT i.product_id, 
       COUNT(DISTINCT orders.customer_id) AS num_of_customers
FROM order_items AS i
JOIN orders  ON i.order_id = orders.order_id
GROUP BY i.product_id
HAVING COUNT(DISTINCT orders.customer_id) > 40
ORDER BY num_of_customers DESC;

/*11*/
SELECT DISTINCT c.customer_id, c.last_name
FROM customers c, orders o, stores s
WHERE c.customer_id = o.customer_id AND s.store_id = o.store_id AND c.city != s.city;

/*12*/
CREATE VIEW q12 AS
SELECT c.category_name , o.order_date , SUM(i.list_price) 
FROM products p , categories c , order_items i , orders o 
WHERE i.order_id = o.order_id AND c.category_id = p.category_id AND  p.product_id = i.product_id 
GROUP BY o.order_date , c.category_id ;

/*13*/
CREATE VIEW q13 AS
SELECT P.product_name, o.order_status, o.order_id
FROM products P, orders o, order_items i
WHERE P.product_id = i.product_id AND	
	  o.order_id = i.order_id;

/*14*/

CREATE VIEW q14 AS 
WITH stock_summary AS (
    SELECT s.store_id, brands.brand_id, SUM(s.quantity) AS  total_of_stocks      
    FROM brands 
    JOIN products p ON brands.brand_id = p.brand_id
    JOIN stocks s ON p.product_id = s.product_id
    GROUP BY s.store_id, brands.brand_id
),
minimum_stock_per_store AS (
    SELECT store_id, MIN(total_of_stocks) AS minimum_total_of_stocks
    FROM stock_summary
    GROUP BY store_id
)
SELECT ss.store_id, ss.brand_id
FROM stock_summary ss
JOIN minimum_stock_per_store m ON ss.store_id = m.store_id AND ss.total_of_stocks = m.minimum_total_of_stocks
ORDER BY ss.store_id;


/*15*/
DELIMITER //

CREATE TRIGGER increase_stock_after_delete
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    UPDATE stocks 
    SET quantity = quantity + OLD.quantity
    WHERE product_id = OLD.product_id;
END;

//

DELIMITER ;

/*16*/
DELIMITER //
CREATE TRIGGER prevent_having_many_managers
AFTER UPDATE ON staffs
FOR EACH ROW 
BEGIN 
    DECLARE num_of_mngr INT;
    SELECT COUNT(*) INTO num_of_mngr
    FROM staffs s
    WHERE s.manager_id = NEW.manager_id;

    IF num_of_mngr > 1 THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Specified manager is full!';
    END IF;
END;
//
DELIMITER ;


/*17*/
DELIMITER //

CREATE TRIGGER check_length_of_phone_digits
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    DECLARE phone_length INT;
    SET phone_length = CHAR_LENGTH(NEW.phone);
    
    IF phone_length < 7 OR phone_length > 15 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Phone number must have between 7 and 15 digits!';
    END IF;
END;
//

DELIMITER ;
