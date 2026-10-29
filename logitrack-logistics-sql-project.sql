
 --                                            LOGITRACK SQL PROJECT

CREATE DATABASE LOGITRACK_PROJECT;
USE LOGITRACK_PROJECT;

--         DATABASE DESIGN 

CREATE TABLE hubs (
    hub_id INT PRIMARY KEY,
    hub_name VARCHAR(50),
    city VARCHAR(30),
    capacity INT
);
CREATE TABLE delivery_agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(50),
    hub_id INT,
    joining_date DATE,
    vehicle_type VARCHAR(20),
    FOREIGN KEY (hub_id) REFERENCES hubs(hub_id)
);
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30),
    customer_type VARCHAR(20)   -- Retail / Corporate
);
CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY,
    customer_id INT,
    source_hub INT,
    destination_hub INT,
    shipment_date DATE,
    expected_delivery_date DATE,
    delivery_date DATE,
    shipment_status VARCHAR(20),   -- Delivered / In Transit / Delayed
    shipping_cost INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (source_hub) REFERENCES hubs(hub_id),
    FOREIGN KEY (destination_hub) REFERENCES hubs(hub_id)
);
CREATE TABLE shipment_tracking (
    tracking_id INT PRIMARY KEY,
    shipment_id INT,
    status VARCHAR(30),
    status_date DATE,
    remarks VARCHAR(100),
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id)
);
CREATE TABLE delivery_assignments (
    assignment_id INT PRIMARY KEY,
    shipment_id INT,
    agent_id INT,
    assigned_date DATE,
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id),
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(agent_id)
);
CREATE TABLE penalties (
    penalty_id INT PRIMARY KEY,
    shipment_id INT,
    penalty_amount INT,
    reason VARCHAR(50),
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id)
);
INSERT INTO hubs VALUES
(1,'Mumbai Hub','Mumbai',600),
(2,'Delhi Hub','Delhi',550),
(3,'Bangalore Hub','Bangalore',500),
(4,'Chennai Hub','Chennai',450),
(5,'Hyderabad Hub','Hyderabad',480);
INSERT INTO delivery_agents VALUES
(1,'Ramesh Kumar',1,'2022-01-10','Bike'),
(2,'Sanjay Verma',1,'2021-11-15','Van'),
(3,'Amit Shah',2,'2022-02-20','Truck'),
(4,'Rohit Meena',2,'2023-01-05','Bike'),
(5,'Vikas Rao',3,'2021-08-12','Van'),
(6,'Kiran Patil',3,'2022-05-18','Bike'),
(7,'Manoj Singh',4,'2020-09-25','Truck'),
(8,'Arjun Nair',4,'2023-02-14','Van'),
(9,'Naveen Reddy',5,'2021-12-03','Bike'),
(10,'Prakash Yadav',5,'2022-07-09','Van'),
(11,'Deepak Joshi',1,'2023-03-01','Bike'),
(12,'Suresh Pillai',2,'2021-06-17','Van'),
(13,'Imran Khan',3,'2020-10-10','Truck'),
(14,'Anil Das',4,'2022-04-21','Bike'),
(15,'Faizan Ali',5,'2023-01-30','Bike');
INSERT INTO customers VALUES
(1,'Flipkart','Mumbai','Corporate'),
(2,'Amazon','Delhi','Corporate'),
(3,'Reliance Retail','Mumbai','Corporate'),
(4,'BigBasket','Bangalore','Corporate'),
(5,'Myntra','Bangalore','Corporate'),
(6,'Ajay Stores','Delhi','Retail'),
(7,'Kiran Mart','Hyderabad','Retail'),
(8,'Rupa Traders','Chennai','Retail'),
(9,'Anita Boutique','Mumbai','Retail'),
(10,'Fresh Zone','Bangalore','Retail'),
(11,'Metro Cash','Delhi','Corporate'),
(12,'Smart Bazaar','Chennai','Corporate'),
(13,'Local Mart','Hyderabad','Retail'),
(14,'City Stores','Mumbai','Retail'),
(15,'QuickBuy','Bangalore','Retail'),
(16,'MegaMart','Delhi','Corporate'),
(17,'ValueShop','Hyderabad','Retail'),
(18,'Daily Needs','Chennai','Retail'),
(19,'SuperKart','Mumbai','Corporate'),
(20,'Urban Basket','Bangalore','Corporate');
INSERT INTO shipments VALUES
(1,1,1,2,'2023-06-01','2023-06-05','2023-06-06','Delayed',5500),
(2,2,2,3,'2023-06-02','2023-06-06','2023-06-06','Delivered',6200),
(3,3,1,4,'2023-06-03','2023-06-07','2023-06-08','Delayed',5800),
(4,4,3,1,'2023-06-04','2023-06-09','2023-06-09','Delivered',5000),
(5,5,3,5,'2023-06-05','2023-06-10','2023-06-11','Delayed',6100),
(6,6,2,1,'2023-06-06','2023-06-10','2023-06-10','Delivered',3200),
(7,7,5,3,'2023-06-07','2023-06-12','2023-06-13','Delayed',2800),
(8,8,4,2,'2023-06-08','2023-06-13','2023-06-13','Delivered',3000),
(9,9,1,5,'2023-06-09','2023-06-14','2023-06-15','Delayed',3600),
(10,10,3,4,'2023-06-10','2023-06-15','2023-06-15','Delivered',3300),
(11,11,2,4,'2023-06-11','2023-06-16','2023-06-18','Delayed',6400),
(12,12,4,1,'2023-06-12','2023-06-17','2023-06-17','Delivered',5200),
(13,13,5,2,'2023-06-13','2023-06-18','2023-06-19','Delayed',2900),
(14,14,1,3,'2023-06-14','2023-06-19','2023-06-19','Delivered',3100),
(15,15,3,2,'2023-06-15','2023-06-20','2023-06-21','Delayed',3400),
(16,16,2,5,'2023-06-16','2023-06-21','2023-06-21','Delivered',6000),
(17,17,5,4,'2023-06-17','2023-06-22','2023-06-23','Delayed',2700),
(18,18,4,3,'2023-06-18','2023-06-23','2023-06-23','Delivered',2900),
(19,19,1,2,'2023-06-19','2023-06-24','2023-06-25','Delayed',5600),
(20,20,3,1,'2023-06-20','2023-06-25','2023-06-25','Delivered',5200);
INSERT INTO delivery_assignments VALUES
(1,1,1,'2023-06-01'),
(2,2,3,'2023-06-02'),
(3,3,2,'2023-06-03'),
(4,4,5,'2023-06-04'),
(5,5,6,'2023-06-05'),
(6,6,4,'2023-06-06'),
(7,7,9,'2023-06-07'),
(8,8,7,'2023-06-08'),
(9,9,11,'2023-06-09'),
(10,10,8,'2023-06-10'),
(11,11,12,'2023-06-11'),
(12,12,14,'2023-06-12'),
(13,13,15,'2023-06-13'),
(14,14,13,'2023-06-14'),
(15,15,10,'2023-06-15');
INSERT INTO shipment_tracking VALUES
(1,1,'Dispatched','2023-06-01','Left Mumbai hub'),
(2,1,'In Transit','2023-06-03','Delayed due to rain'),
(3,2,'Delivered','2023-06-06','On time'),
(4,3,'In Transit','2023-06-06','Vehicle breakdown'),
(5,4,'Delivered','2023-06-09','Smooth delivery'),
(6,5,'Delayed','2023-06-10','Hub congestion'),
(7,6,'Delivered','2023-06-10','On time'),
(8,7,'Delayed','2023-06-12','Traffic issues'),
(9,8,'Delivered','2023-06-13','On time'),
(10,9,'Delayed','2023-06-15','Weather delay'),
(11,10,'Delivered','2023-06-15','On time'),
(12,11,'Delayed','2023-06-18','Route diversion'),
(13,12,'Delivered','2023-06-17','On time'),
(14,13,'Delayed','2023-06-19','Driver unavailability'),
(15,14,'Delivered','2023-06-19','On time');
INSERT INTO penalties VALUES
(1,1,500,'Late delivery'),
(2,3,500,'Late delivery'),
(3,5,700,'Hub delay'),
(4,7,400,'Traffic delay'),
(5,9,600,'Weather delay'),
(6,11,800,'Route issue'),
(7,13,400,'Driver delay'),
(8,15,500,'Late delivery'),
(9,17,300,'Minor delay'),
(10,19,700,'Repeated SLA breach');


SELECT * FROM hubs	;
SELECT * FROM delivery_agents;
SELECT * FROM customers;
SELECT * FROM shipments	;
SELECT * FROM shipment_tracking	;
SELECT * FROM delivery_assignments;	
SELECT * FROM penalties	;


-- 1.	Display all records from the shipments table.
SELECT * FROM shipments;

-- 2.	List shipment ID, shipment date, and shipping cost for all shipments.

SELECT shipment_id,shipment_date,shipping_cost FROM shipments;

-- 3.	Show all shipments that are marked as Delayed.

select * from shipments WHERE shipment_status = "delayed";  -- asked for shipment details so table is shipments

-- 4.	Find shipments with a shipping cost greater than 5000.

SELECT * FROM shipments WHERE shipping_cost > 5000;

-- 5.	Display all customers who belong to the Retail category.

SELECT customer_name,customer_type FROM customers WHERE customer_type ="RETAIL";

-- 6.	List customers from Mumbai or Delhi.

SELECT * FROM customers WHERE city in ( "MUMBAI" , "DELHI");

-- 7.	Find shipments shipped between 2023-06-05 and 2023-06-10.

select * from shipments where shipment_date BETWEEN "2023-06-05" and "2023-06-10";   

-- 8.	Display customers whose name contains the word “Mart”.

SELECT * FROM customers WHERE customer_name LIKE  "%Mart%";

-- 9.	List all shipments ordered by shipping cost in descending order.

SELECT * FROM shipments ORDER BY  shipping_cost DESC;
 
-- 10.	Show the top 5 most expensive shipments.

SELECT * FROM shipments ORDER BY  shipping_cost DESC
LIMIT 5;

/*  AGGREGATE FUNCTIONS (COUNT, SUM, AVG, MIN, MAX) */

-- 1.	Find the total number of shipment_id. 

SELECT COUNT(*)  FROM shipments ;

-- 2.	Calculate the total shipping cost of all shipments.

SELECT SUM(shipping_cost) FROM shipments;

-- 3.	Find the average shipping cost.

SELECT AVG(shipping_cost) FROM shipments;

-- 4.	Display the minimum and maximum shipping cost.

SELECT MIN(shipping_cost) as min_cost, MAX(shipping_cost) as max_cost  FROM shipments;

-- 5.	Count the number of shipments that are Delayed.

SELECT COUNT(*) FROM shipments WHERE shipment_status = "delayed";  -- asked for no.of shipments. so shipments table


-- 6.	Find the total number of customers in each city.

select CITY,  COUNT(*) AS TOTAL_CUSTOMER 
FROM customers
GROUP BY CITY ;

-- 7.	Calculate the average shipping cost for Delivered shipments only.

SELECT  AVG(shipping_cost) AS AVERAGE_SHIPPING_COST
FROM  shipments 
WHERE shipment_status = "delivered";

-- 8.	Show the total penalty amount collected.

SELECT SUM(penalty_amount) AS TOTAL_PENALTIE FROM penalties;

-- 9.	Find the number of shipments handled by each source hub.

SELECT source_hub, COUNT(*) AS shipment_count
FROM shipments
GROUP BY source_hub;

-- 10.	Display the average shipping cost per destination hub.

SELECT destination_hub,AVG(shipping_cost) AS AVERAGE_SHIPPING_COST 
FROM shipments
GROUP BY destination_hub;

/*  GROUP BY & HAVING */

-- 1.	Show the number of shipments per shipment status.

select shipment_status, count(*) from shipments
group by shipment_status;   -- final shipment_status is in shipmnet table, shipment_tracking can have multiple tracking details for 1 shipment. so dont use that


-- 2.	Find total shipping cost per customer.

SELECT customer_id, SUM(shipping_cost) AS TOTAL_SHIPPING_COST
FROM SHIPMENTS
GROUP BY customer_id;

-- 3.	Display hub-wise shipment count.

SELECT source_hub,COUNT(source_hub) AS HUB_WISE_COUNT 
FROM SHIPMENTS
GROUP BY source_hub;

-- 4.	Show customers who have more than 2 shipments.

SELECT customer_id, COUNT(*) AS shipment_count
FROM shipments
GROUP BY customer_id
HAVING COUNT(*) > 2;

-- 5.	Find hubs that handled shipments with an average cost greater than 5000.

SELECT source_hub,AVG(shipping_cost) AS FIND_HUB_GREATER
FROM SHIPMENTS
GROUP BY source_hub
HAVING AVG(shipping_cost) >5000;


-- 6.	Display the total penalty amount per reason.

SELECT reason, SUM(penalty_amount) AS PENALTIE_TOTAL 
FROM PENALTIES
GROUP BY reason;


-- 7.	Show the number of delayed shipments per destination hub.

SELECT Destination_Hub,COUNT(*) AS Delayed_Shipments
FROM shipments
WHERE shipment_status = 'Delayed'
GROUP BY Destination_Hub;

-- 8.	Find customers whose total shipping cost exceeds 10,000.

SELECT customer_id, SUM(shipping_cost) AS EXCEED_COST
FROM SHIPMENTS
GROUP BY customer_id
HAVING SUM(shipping_cost) >10000;

-- 9.	Display agents who have handled more than 2 deliveries.

select * from delivery_assignments;

SELECT agent_id, COUNT(*) AS NO_OF_DELIVERIES
FROM delivery_assignments
GROUP BY agent_id
HAVING COUNT(*) > 2;   

-- 10.	Find hubs with more than 5 delayed shipments.

SELECT source_hub, COUNT(*) AS MOST_DELAYED_HUB
FROM SHIPMENTS
WHERE shipment_status = "DELAYED"
GROUP BY source_hub
HAVING COUNT(*) >5;

/* JOINS (INNER, LEFT, RIGHT) */

 -- 1.	Display shipment details along with customer name.

SELECT  s.*,c.customer_name
FROM shipments s
JOIN customers c
ON s.customer_id = c.customer_id;   

-- 2.	Show shipment ID, source hub name, and destination hub name.

SELECT 
    s.shipment_id,
    SOURCE_HUB.hub_name AS source_hub_name,
    DESTINATON_HUB.hub_name AS destination_hub_name
FROM shipments s
JOIN hubs SOURCE_HUB
ON s.source_hub = SOURCE_HUB.hub_id
JOIN hubs DESTINATON_HUB  
ON s.destination_hub = DESTINATON_HUB.hub_id;

-- 3.	List shipment details along with delivery agent name.

select s.*, a.agent_name
FROM shipments s
LEFT JOIN delivery_assignments da
ON s.shipment_id = da.shipment_id
left join delivery_agents a
on da.agent_id = a.agent_id; 

-- 4.	Display customer name and number of shipments made by them.

SELECT 
    c.customer_name,
    COUNT(s.shipment_id) AS total_shipments
FROM customers c
LEFT JOIN shipments s
ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 5.	Show hub-wise total shipping cost.

SELECT HB.hub_name,
    sum(SH.shipping_cost) as hub_wise_total
FROM HUBS HB
JOIN shipments SH
ON sh.source_hub = hb.hub_id 
GROUP BY HB.hub_name;

-- 6.	List all shipments along with their penalty amount (if any).

SELECT SH.shipment_id,PN.penalty_amount
FROM shipments SH
LEFT JOIN penalties PN
ON PN.shipment_id = SH.shipment_id;   -- join with shipment_id 

-- 7.	Display delivery agent names and the shipments they handled.

select a.agent_name,da.shipment_id
FROM delivery_agents a
LEFT JOIN delivery_assignments da
on da.agent_id = a.agent_id; 

-- 8.	Show all customers and their shipments (include customers with no shipments).

SELECT CUST.*
FROM customers CUST
LEFT JOIN shipments SHIP
ON CUST.customer_id = SHIP.shipment_id;

SELECT CUST.*,SHIP.shipment_id
FROM customers CUST
LEFT JOIN shipments SHIP
ON CUST.customer_id = SHIP.customer_id;

-- 9.	Display all hubs and shipments sent from them (include hubs with no shipments

SELECT HUB.*,SHIP.*
FROM HUBS HUB
LEFT JOIN shipments SHIP  
ON SHIP.source_hub = HUB.hub_id;

select h.hub_id, h.hub_name,s.shipment_id
from hubs h
left join shipments s
on s.source_hub = h.hub_id ;

-- 10.	Show shipment tracking status along with shipment details.

SELECT SHIP.*,TRACK.*
FROM shipments SHIP
JOIN shipment_tracking  TRACK
ON SHIP.shipment_id = TRACK.shipment_id;


  /* SUBQUERIES  */
  -- 1.	Find shipments with shipping cost higher than the average shipping cost.

SELECT * FROM shipments WHERE shipping_cost> 
(SELECT AVG(shipping_cost) FROM shipments);


-- 2.	Display customers who have made more shipments than the average customer.

select customer_id from shipments
group by customer_id
having count(*) > (
select avg(x.total_shipments) from (
select customer_id , count(shipment_id) as total_shipments
from shipments
group by customer_id)x); 

-- 3.	Find the hub that handled the maximum number of shipments.
                  /* I DON'T UNDERSTAND*/
SELECT h.hub_name FROM hubs h
JOIN shipments s
ON h.hub_id = s.source_hub
GROUP BY h.hub_id, h.hub_name
HAVING COUNT(*) = (SELECT MAX(shipment_count)FROM (SELECT COUNT(*) AS shipment_count
FROM shipments
GROUP BY source_hub) AS t);

select source_hub from shipments
group by source_hub
having count(*) = (select max(total_shipments) from (select source_hub , count(*) as total_shipments 
from shipments
group by source_hub)x);

-- 4.	Show customers who have at least one delayed shipment.
SELECT DISTINCT C.* FROM customers C
JOIN shipments S
ON C.customer_id = S.customer_id
JOIN shipment_tracking T
ON S.shipment_id = T.shipment_id
WHERE T.status = 'Delayed';

select customer_name from customers where customer_id in (
select distinct customer_id from shipments where shipment_status ="delayed");

-- 5.	Display shipments that have a penalty applied.

SELECT PENA.*, SHIP.* FROM penalties PENA
JOIN shipments SHIP
ON SHIP.shipment_id = PENA.shipment_id;

select * from shipments where shipment_id in (
select shipment_id from penalties);

-- 6.	Find agents who handled shipments with penalties. /* WHICH OF THE FOLLOWING IS CORRECT */

-- ME 
SELECT DISTINCT DELI.* FROM delivery_agents DELI
JOIN penalties PENA
ON DELI.agent_id = PENA.shipment_id
JOIN shipments SHIP 
ON SHIP.shipment_id = PENA.shipment_id;

-- chatGPT
SELECT DISTINCT AG.* FROM delivery_agents AG
JOIN shipments SH
ON AG.agent_id = SH.agent_id
JOIN penalties P
ON SH.shipment_id = P.shipment_id; -- corect but here question is using subqueries

select agent_id,shipment_id from delivery_assignments where shipment_id in (
select shipment_id from penalties);


-- 7.	Show customers whose total shipping cost is higher than any retail customer. I DON'T UNDERSTAND 

SELECT c.customer_id, c.customer_name FROM customers c
JOIN shipments s
ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(s.shipping_cost) > ANY (SELECT SUM(s2.shipping_cost) FROM customers c2
JOIN shipments s2
ON c2.customer_id = s2.customer_id
WHERE c2.customer_type = 'Retail'
GROUP BY c2.customer_id);


SELECT customer_id, SUM(shipping_cost) AS total_cost
FROM shipments
GROUP BY customer_id
HAVING SUM(shipping_cost) > ANY (
    SELECT SUM(s.shipping_cost)
    FROM shipments s
    JOIN customers c 
        ON s.customer_id = c.customer_id
    WHERE c.customer_type = 'Retail'
    GROUP BY s.customer_id);

-- 8.	Find shipments with the highest shipping cost per destination hub.

SELECT * FROM shipments s
WHERE s.shipping_cost = (SELECT MAX(s2.shipping_cost)
FROM shipments s2
WHERE s2.destination_hub = s.destination_hub);

-- 9.	Display hubs that have never had delayed shipments.
                      /* EXPLAIN */

SELECT * FROM hubs h
WHERE h.hub_id NOT IN 
(SELECT DISTINCT s.source_hub
FROM shipments s
JOIN shipment_tracking t
ON s.shipment_id = t.shipment_id
WHERE S.shipment_status = 'DELAYED');


select * from hubs where hub_id not in   (                   
select source_hub as hub_id from shipments where shipment_status = "delayed");

-- 10.	Find customers who have never received a penalty.

SELECT * FROM customers CUST
WHERE CUST.customer_id NOT IN 
(SELECT DISTINCT PENA.penalty_id
FROM penalties PENA
JOIN customers CUST
ON CUST.customer_id = PENA.penalty_id);

select customer_name from customers where customer_id not in (
select customer_id from shipments where shipment_id  in (
select shipment_id from penalties));

/*  VIEWS  */
 -- 1.	Create a view that shows shipment ID, customer name, and shipment status.

CREATE VIEW shipment_customer_status AS
SELECT  SH.shipment_id,C.customer_name,ST.status
FROM shipments SH
JOIN customers C
ON SH.customer_id = C.customer_id
JOIN shipment_tracking ST
ON SH.shipment_id = ST.shipment_id;


-- no need of shipment tracking table
CREATE VIEW shipment_customer_status AS
SELECT s.shipment_id, c.customer_name, s.shipment_status
FROM shipments s
JOIN customers c
ON s.customer_id = c.customer_id;

SELECT * FROM shipment_customer_status;

-- 2.	Create a view to display hub-wise shipment counts.


CREATE VIEW hub_wise_shipment AS
SELECT HUB.hub_id,HUB.hub_name,COUNT(SHIP.shipment_id) AS SHIPMENT_COUNT
FROM HUBS HUB
JOIN shipments SHIP
ON HUB.hub_id = SHIP.source_hub
GROUP BY HUB.hub_id,HUB.hub_name;

SELECT * FROM hub_wise_shipment;

-- 3.	Create a view showing delayed shipments with penalty amount.

CREATE VIEW delayed_shipments AS
SELECT SHIP.shipment_id,SHIP.shipment_status,PENA.penalty_amount
FROM SHIPMENTS SHIP 
JOIN penalties PENA 
ON SHIP.shipment_id = PENA.shipment_id
WHERE SHIP.shipment_status = "DELAYED";

SELECT * FROM delayed_shipments;

-- 4.	Create a view for agent-wise delivery performance.

CREATE VIEW delivery_performance AS 
SELECT DISTINCT DELI.agent_id,DELI.agent_name,SHIP.status
FROM delivery_agents DELI
JOIN shipment_tracking SHIP
ON SHIP.shipment_id = DELI.agent_id;
SELECT * FROM delivery_performance;
drop view delivery_performance;

-- wrong join
CREATE VIEW delivery_performance AS
SELECT a.agent_id, a.agent_name, COUNT(da.shipment_id) AS total_deliveries
FROM delivery_agents a
LEFT JOIN delivery_assignments da
ON a.agent_id = da.agent_id
GROUP BY a.agent_id, a.agent_name;
SELECT * FROM delivery_performance;

-- 5.	Create a view showing customer-wise total shipping cost.

CREATE VIEW customer_wise_total_shipping_cost AS 
SELECT CUST.customer_id,CUST.customer_name,SUM(SHIP.shipping_cost) AS CUSTOMER_WISE_TOTAL
FROM CUSTOMERS CUST
JOIN shipments SHIP 
ON CUST.customer_id = SHIP.shipment_id
GROUP BY CUST.customer_id;

SELECT * FROM customer_wise_total_shipping_cost;

-- wrong join column customer_id should be joined with customer id
CREATE VIEW customer_wise_total_shipping_costs AS
SELECT c.customer_id, c.customer_name, SUM(s.shipping_cost) AS total_cost
FROM customers c
JOIN shipments s
ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT * FROM customer_wise_total_shipping_costs;
/* STORED PROCEDURES  */
-- 1.	Create a procedure to fetch shipment details by shipment ID.

DELIMITER $$

CREATE PROCEDURE get_shipment_by_id (IN p_shipment_id INT)
BEGIN
SELECT shipment_id,customer_id,source_hub,destination_hub,shipment_status,shipping_cost,delivery_date
    FROM shipments
    WHERE shipment_id = p_shipment_id;
END $$

DELIMITER ;
CALL get_shipment_by_id(3);

-- 2.	Create a procedure to return all shipments for a given customer.
DELIMITER $$

CREATE PROCEDURE get_shipments_by_customer (IN p_customer_id INT)
BEGIN
SELECT * FROM shipments
WHERE customer_id = p_customer_id;
END $$

DELIMITER ;
 
CALL get_shipments_by_customer(4);


-- 3.	Create a procedure to calculate total penalty for a shipment.

DELIMITER $$

CREATE PROCEDURE TOTAL_PENALTIE_SHIPMENTS (IN p_shipment_id INT)
BEGIN
SELECT SUM(penalty_amount) AS total_penalty
FROM penalties
WHERE shipment_id = p_shipment_id;
END $$

DELIMITER ;

CALL TOTAL_PENALTIE_SHIPMENTS(2);


-- 4.	Create a procedure to list delayed shipments between two dates
    /* NOT COMPLETED */

DELIMITER $$ 
DROP PROCEDURE delayed_shipments;
CREATE PROCEDURE delayed_shipments (
    IN p_start_date DATE,
    IN p_end_date DATE)
BEGIN
SELECT  shipment_id,customer_id,shipment_date,delivery_date,shipment_status
FROM shipments
WHERE shipment_status = 'DELAYED'
  AND delivery_date BETWEEN p_start_date AND p_end_date;

END $$
delimiter ;

CALL delayed_shipments( '2023-06-03','2023-06-08');                                     


-- 5.	Create a procedure to return hub-wise shipment summary.

DELIMITER $$

DROP PROCEDURE IF EXISTS hub_wise_summary $$

CREATE PROCEDURE hub_wise_summary()
BEGIN
    SELECT 
        source_hub AS hub_name,
        COUNT(*) AS total_shipments,
        SUM(CASE WHEN shipment_status = 'DELAYED' THEN 1 ELSE 0 END) AS delayed_shipments,
        SUM(CASE WHEN shipment_status = 'DELIVERED' THEN 1 ELSE 0 END) AS delivered_shipments,
        SUM(CASE WHEN shipment_status = 'IN_TRANSIT' THEN 1 ELSE 0 END) AS in_transit_shipments
    FROM shipments
    GROUP BY source_hub
    ORDER BY total_shipments DESC;
END $$

DELIMITER ;

CALL hub_wise_summary();

/*TRIGGERS*/
-- 1.	Create a trigger to automatically insert a penalty when a shipment is marked as delayed

DELIMITER $$

CREATE TRIGGER trg_insert_penalty_on_delay
AFTER UPDATE ON shipments
FOR EACH ROW
BEGIN
    IF OLD.shipment_status <> 'DELAYED'
       AND NEW.shipment_status = 'DELAYED' THEN

        INSERT INTO penalties (shipment_id,penalty_amount,penalty_date)
        VALUES (NEW.shipment_id,500, CURDATE());
    END IF;
END $$

DELIMITER ;

UPDATE shipments
SET shipment_status = 'DELAYED'
WHERE shipment_id = 5;
select * from penalties;

/* INSERT INTO penalties (shipment_id, penalty_amount, reason)
VALUES (NEW.shipment_id,500,'Late delivery');  becaue Table penalties has no penalty_date column */

-- 2.	Create a trigger to prevent inserting a shipment with a negative shipping cost.
                             /*  NOT COMPLETED */
DELIMITER $$ 
CREATE TRIGGER NEGATIVE_SHIPMENT_COST 
BEFORE INSERT ON SHIPMENTS
FOR EACH ROW 
BEGIN 
     IF NEW.shipping_cost < 0 THEN 
     SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shipping cost cannot be negative';
    END IF;
END $$ 


DELIMITER ;

SELECT * FROM SHIPMENTS;
INSERT INTO SHIPMENTS (shipment_id,customer_id,shipping_cost)
                   VALUES (23,25,6250);


-- 3.	Create a trigger to log shipment status changes.


CREATE TABLE shipment_status_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    shipment_id INT,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (shipment_id)
        REFERENCES shipments(shipment_id)
);

DELIMITER $$

CREATE TRIGGER trg_log_shipment_status_change
AFTER UPDATE ON shipments
FOR EACH ROW
BEGIN
    IF OLD.shipment_status <> NEW.shipment_status THEN
        INSERT INTO shipment_status_log (shipment_id,old_status,new_status)
        VALUES (NEW.shipment_id,OLD.shipment_status,NEW.shipment_status);
    END IF;
END $$

DELIMITER ;

SELECT * FROM shipment_status_log;
SELECT * FROM shipments;

UPDATE shipments
SET shipment_status = 'Delivered'
WHERE shipment_id = 3;

-- 4.	Create a trigger to prevent deletion of delivered shipments. 
                  -- CANNOT DELETE THIS 
DELIMITER $$
drop trigger prevent_deletion;
CREATE TRIGGER prevent_deletion 
BEFORE DELETE ON SHIPMENTS 
FOR EACH ROW 
BEGIN 
      IF OLD.shipment_status = 'delivered' then  -- IF OLD.shipment_status = 'Delivered' ealier it was delivered without quotes
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Delivered shipments cannot be deleted';
    END IF;
END $$ 
 DELIMITER ;
 
 SELECT * FROM shipments;
 
DELETE FROM shipments
WHERE shipment_id = 19 ;
 
 
 -- 5.	Create a trigger to update shipment status when delivery date is updated.

DELIMITER $$ 

CREATE TRIGGER SHIPMENT_STATUS_AUTO_UPDATE
BEFORE  UPDATE ON shipments 
FOR EACH ROW 
BEGIN  
    SET NEW.shipment_status =
 CASE   
   WHEN NEW.delivery_date IS NOT NULL   THEN  "DELIVERED" 
   ELSE NEW.shipment_status
   END;
END $$

DELIMITER ;

UPDATE shipments
SET delivery_date = '2024-02-10'
WHERE shipment_id = 22;
                 
SELECT * FROM  shipments;
   
/*TRANSACTIONS (TCL)  */
-- 1.	Write a transaction to assign a delivery agent to a shipment and commit the changes.

START TRANSACTION;

UPDATE shipments
SET customer_id = 3
WHERE shipment_id = 11;

COMMIT;

-- You should insert into delivery_assignments
START TRANSACTION;

INSERT INTO delivery_assignments
VALUES (16,20,5,CURDATE());

COMMIT;
SELECT * FROM shipments;

    
 -- 2.	Write a transaction that rolls back shipment assignment if agent ID is invalid.     
                                   /* not completed */


DELIMITER $$

CREATE PROCEDURE assign_agent_to_shipment(IN p_shipment_id INT)
BEGIN
START TRANSACTION;

IF EXISTS (SELECT 1 FROM shipments WHERE shipment_id = p_shipment_id) THEN

        UPDATE shipments
        SET shipping_cost = 7000
        WHERE shipment_id = p_shipment_id;

        COMMIT;
    ELSE
        ROLLBACK;
    END IF;

END$$

DELIMITER ;

    CALL assign_agent_to_shipment(10);

-- correct 
START TRANSACTION;

INSERT INTO delivery_assignments
VALUES (16,20,99,CURDATE());  -- 99 = invalid agent

-- check agent validity
SELECT * FROM delivery_agents WHERE agent_id = 99;

ROLLBACK;

   --  3.	Use a savepoint while assigning multiple shipments to an agent.  

START TRANSACTION;

UPDATE shipments
SET shipping_cost = 5000
WHERE shipment_id IN (1, 2, 3);

SAVEPOINT sp_assign_batch1;
 

UPDATE shipments
SET destination_hub = 2
WHERE shipment_id IN (4, 5, 6);

ROLLBACK TO sp_assign_batch1;

COMMIT;

    
 --   4.	Demonstrate rollback to a savepoint after partial failure.
                               /*   NOT COMPLETED  */ 
    
START TRANSACTION ;


-- 5.	Write a transaction to update shipment status and penalty together. 

START TRANSACTION;

UPDATE shipments
SET shipment_status = 'DELIVERED'
WHERE shipment_id = 5;

SAVEPOINT sp_after_status_update;

UPDATE penalties
SET penalty_amount = 500
WHERE shipment_id = 5;

COMMIT;

/*ADVANCED SQL (CTEs & WINDOW FUNCTIONS) */
-- 1.	Rank shipments by shipping cost within each destination hub.   

SELECT *,
RANK() OVER (PARTITION BY destination_hub ORDER BY shipping_cost DESC)
FROM shipments;

-- 2.	Find the top 3 most expensive shipments per hub.

SELECT *
FROM (SELECT s.shipment_id,s.source_hub,s.shipping_cost,
ROW_NUMBER() OVER (PARTITION BY s.source_hub ORDER BY s.shipping_cost DESC) AS rn
FROM shipments s) AS ranked_shipments
WHERE rn <= 3;


 -- 3.	Calculate running total of shipping cost by shipment date.


SELECT shipment_id,source_hub,shipment_date,shipping_cost,
SUM(shipping_cost) OVER (PARTITION BY source_hub ORDER BY shipment_date, shipment_id
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_shipping_price
FROM shipments
ORDER BY source_hub, shipment_date, shipment_id;


  -- 4.	Rank delivery agents based on number of shipments handled.

SELECT agent_id,total_shipments,
RANK() OVER (ORDER BY total_shipments DESC) AS ranks
FROM (SELECT agent_id, COUNT(*) AS total_shipments
FROM delivery_agents
GROUP BY agent_id) AS agent_shipments;  -- wrong table

-- correct
SELECT agent_id,
COUNT(*) AS total_shipments,
RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_agents
FROM delivery_assignments
GROUP BY agent_id;


-- 5.	Find customers with the highest total shipping cost using CTE.
                      /* EXPLAIN */

WITH customer_totals AS (SELECT customer_id,SUM(shipping_cost) AS total_shipping
FROM shipments
GROUP BY customer_id)
SELECT customer_id,total_shipping
FROM customer_totals
WHERE total_shipping = (SELECT MAX(total_shipping) FROM customer_totals);

-- 6.	Calculate percentage contribution of each hub to total shipments.
                       /*  I DON'T UNDERSTAND */
SELECT source_hub,COUNT(*) AS total_shipments,ROUND(
(COUNT(*) * 100.0) / (SELECT COUNT(*) FROM shipments), 2) AS percentage_contribution
FROM shipments
GROUP BY source_hub
ORDER BY percentage_contribution DESC;


-- 7.	Identify repeat delay customers using window functions.


SELECT *,
SUM(CASE WHEN shipment_status = 'DELAYED' THEN 1 ELSE 0 END) 
OVER (PARTITION BY customer_id) AS repeat_delay  FROM shipments;

-- 8.	Find month-over-month shipment growth.

SELECT *, shipping_cost AS current_month_revenue,LAG(shipping_cost) OVER (PARTITION BY shipment_id 
ORDER BY shipment_date) AS previous_month_revenue,shipping_cost - LAG(shipping_cost) OVER (
PARTITION BY shipment_id ORDER BY shipment_date) AS revenue_difference
FROM shipments;


-- corerct
WITH monthly_shipments AS (
    SELECT 
        DATE_FORMAT(shipment_date, '%Y-%m') AS month,
        COUNT(*) AS total_shipments
    FROM shipments
    GROUP BY DATE_FORMAT(shipment_date, '%Y-%m')
)

SELECT 
    month,
    total_shipments,
    LAG(total_shipments) OVER (ORDER BY month) AS previous_month_shipments,
    total_shipments - LAG(total_shipments) OVER (ORDER BY month) AS shipment_growth
FROM monthly_shipments;

-- 9.	Rank hubs based on delay percentage.

SELECT shipment_id,source_hub,shipping_cost,
RANK() OVER (PARTITION BY source_hub ORDER BY shipping_cost DESC) AS rank_within_hub
FROM shipments;

-- correct
WITH hub_delays AS (
    SELECT 
        source_hub,
        COUNT(*) AS total_shipments,
        SUM(CASE WHEN shipment_status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_shipments
    FROM shipments
    GROUP BY source_hub
)

SELECT 
    source_hub,
    total_shipments,
    delayed_shipments,
    ROUND((delayed_shipments * 100.0) / total_shipments,2) AS delay_percentage,
    RANK() OVER (ORDER BY (delayed_shipments * 100.0) / total_shipments DESC) AS delay_rank
FROM hub_delays;

-- 10.	Identify the most efficient delivery agent (least delays).
SELECT * FROM hubs	;
SELECT * FROM customers;
SELECT * FROM shipments	;
SELECT * FROM shipment_tracking	;
SELECT * FROM delivery_assignments;	
SELECT * FROM penalties	;
SELECT * FROM delivery_agents;

WITH agent_delays AS (SELECT DELI.agent_id,DELI.agent_name,
COUNT(SHIP.shipment_id) AS total_delays
FROM delivery_agents DELI
JOIN shipments SHIP
ON DELI.hub_id = SHIP.source_hub
WHERE SHIP.shipment_status = 'DELAYED'
GROUP BY DELI.agent_id, DELI.agent_name)

SELECT agent_id,agent_name,total_delays,
RANK() OVER (ORDER BY total_delays ASC) AS delay_rank
FROM agent_delays
ORDER BY delay_rank;

-- correct
WITH agent_delays AS (
    SELECT 
        a.agent_id,
        a.agent_name,
        COUNT(CASE WHEN s.shipment_status = 'Delayed' THEN 1 END) AS total_delays
    FROM delivery_agents a
    LEFT JOIN delivery_assignments da
        ON a.agent_id = da.agent_id
    LEFT JOIN shipments s
        ON da.shipment_id = s.shipment_id
    GROUP BY a.agent_id, a.agent_name
)

SELECT 
    agent_id,
    agent_name,
    total_delays,
    RANK() OVER (ORDER BY total_delays ASC) AS efficiency_rank
FROM agent_delays
ORDER BY efficiency_rank;













