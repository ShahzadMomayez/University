DROP DATABASE IF EXISTS Q6;
CREATE DATABASE Q6;
USE Q6;


CREATE TABLE Customer (
                        cid CHAR(30),
			name CHAR(50),
                        contact_info CHAR(50),                        
                PRIMARY KEY (cid)
);   

CREATE TABLE Admin (
                        aid CHAR(30),
                        name CHAR(50),
			salary REAL,
                        role CHAR(50),

                PRIMARY KEY (aid)
);

CREATE TABLE Student (
                        sid CHAR(30),
                        university CHAR(50),
                        discount CHAR(50),
                        PRIMARY KEY (sid),
                FOREIGN KEY (cid) REFERENCES Customer(cid)
                
);

CREATE TABLE Score(
                        cid CHAR(30),
                        gid CHAR(30),
                        score INTEGER,
                PRIMARY KEY (cid , gid),
                FOREIGN KEY (gid) REFERENCES BoardGame_Admin(gid),
                FOREIGN KEY (cid) REFERENCES Customer(cid)
);


CREATE TABLE Genre (
                        gid CHAR(30),
			name CHAR(50),
                PRIMARY KEY (gid)
);





CREATE TABLE BoardGame_Admin (
                        gid CHAR(30),			
                        aid CHAR(30) NOT NULL,
                        status CHAR(50),
                        name CHAR(50),
                        version CHAR(50),
                        price REAL ,
                        publisher CHAR(50),
                PRIMARY KEY (gid),
                FOREIGN KEY (aid) REFERENCES Admin
); 


CREATE TABLE BoardGame_Genre (
                        gid CHAR(30),
                        name CHAR(50),
                PRIMARY KEY (gid , name),
                FOREIGN KEY (name) REFERENCES Genre(name),
                FOREIGN KEY (gid) REFERENCES BoardGame_Admin(gid)
                
);

     

CREATE TABLE Order_Hass(
                        oid CHAR(30), 
			cid CHAR(30) NOT NULL,
                        delivery_price REAL,
                        total_cost REAL,
                        delivery_date DATE,
                        
                PRIMARY KEY (oid),
                FOREIGN KEY (cid) REFERENCES Customer(cid) ON DELETE CASCADE

);


CREATE TABLE Order_Has_Physical_BG( 
			gid CHAR(30) NOT NULL,
                        oid CHAR(30),
                        PRIMARY KEY (oid , gid), 
                FOREIGN KEY (oid) REFERENCES Order_Hass(oid) ON DELETE NO ACTION ,
                FOREIGN KEY (gid) REFERENCES Physical_BoardGame_Admin(gid) ON DELETE NO ACTION
);



CREATE TABLE Has_Delivery (
			oid CHAR(30),
                        did CHAR(30) NOT NULL,                       
                PRIMARY KEY (oid), 
                FOREIGN KEY (oid) REFERENCES Order_Hass(oid) ON DELETE NO ACTION ,
                FOREIGN KEY (did) REFERENCES delivery(did) ON DELETE NO ACTION 
);

CREATE TABLE Physical_BoardGame_Admin (
                        gid CHAR(30),
                PRIMARY KEY (gid) ,
                FOREIGN KEY (gid) REFERENCES BoardGame_Admin(gid)
);      


CREATE TABLE Digital_BoardGame_Admin (
                        gid CHAR(30),
                PRIMARY KEY (gid) ,
                FOREIGN KEY (gid) REFERENCES BoardGame_Admin(gid)
);      




CREATE TABLE Download (
                        gid CHAR(30),
                        cid CHAR(30),
                        date DATE ,  
                PRIMARY KEY (gid , cid),
                FOREIGN KEY (gid) REFERENCES Digital_BoardGame_Admin(gid) ON DELETE NO ACTION,
                FOREIGN KEY (cid) REFERENCES Customer(cid) ON DELETE CASCADE 
);


CREATE TABLE delivery(
                        did CHAR(30),
                        name CHAR(30),
                        delivery_type CHAR(50),
                        commision INTEGER, 
                        contact_info CHAR(100),
                PRIMARY KEY (did)
);



