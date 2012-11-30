CREATE TABLE items
(
   id INT(11) AUTO_INCREMENT,
   order_id INT,
   itemnumber CHAR(30),
   price INT,
   quantity SMALLINT,
   PRIMARY KEY (id)
);

CREATE TABLE orders
(
   id INT(11) AUTO_INCREMENT,
   ordernumber CHAR(14) not null,
   orderdate DATETIME,
   addrip VARCHAR(15),
   warning VARCHAR(500),
   specialinstructions VARCHAR(500),
   ccauthcode CHAR(6),
   cchasavs CHAR(1),
   cctransid VARCHAR(13),
   billingfirstname VARCHAR(50),
   billinglastname VARCHAR(50),
   billingcompany VARCHAR(50),
   billingstreet VARCHAR(50),
   billingcity VARCHAR(30),
   billingstate CHAR(2),
   billingzip VARCHAR(10),
   billingcountry VARCHAR(50),
   billingphone CHAR(12),
   billingemail VARCHAR(50),
   shippingfirstname VARCHAR(50),
   shippinglastname VARCHAR(50),
   shippingcompany VARCHAR(50),
   shippingstreet VARCHAR(50),
   shippingcity VARCHAR(30),
   shippingstate CHAR(2),
   shippingzip VARCHAR(10),
   shippingcountry VARCHAR(50),
   ordersubtotal INTEGER,
   ordershippingcost INTEGER,
   ordertotal INTEGER,
   ordersalestax INTEGER,
   ordershippingmethod VARCHAR(100),
   discountcode CHAR(1),
   PRIMARY KEY (id)
);


