
// Publisher running on port:5433

CREATE DATABASE demo1;

CREATE EXTENSION pglogical;

CREATE TABLE demo1(id int primary key,name text,address text,city text);

SELECT pglogical.create_node(node_name := 'provider',dsn := 'host=localhost port=5433 dbname=demo1');

select pglogical.replication_set_add_table(set_name := 'default',relation := 'demo1',synchronize_data := true ,columns :='{id,name}',row_filter := 'id>5');

INSERT INTO demo1 VALUES(1,'Arun','tondiarpet','chennai');

INSERT INTO demo1 VALUES(2,'Vijay','Broadway','chennai');

INSERT INTO demo1 VALUES(3,'Ajay','Thiruvanmiyur','chennai');

INSERT INTO demo1 VALUES(4,'Junaid','Royapettah','chennai');

INSERT INTO demo1 VALUES(5,'Usaid','Triplicane','chennai');

INSERT INTO demo1 VALUES(6,'Fazil','Egmore','chennai');

INSERT INTO demo1 VALUES(7,'Izhan','Urapakkam','chennai');

INSERT INTO demo1 VALUES(8,'Anas','Guduvanchery','chennai');

// Subscriber running on port:5434

CREATE DATABASE Demo1;

CREATE DATABASE pglogical;

CREATE TABLE demo1(id int primary key,name text,address text,city text);

SELECT pglogical.create_node(node_name := 'subscriber',dsn := 'host=localhost port=5434 dbname=demo1');

SELECT pglogical.Create_subscription(subscription_name := 'subscription' ,provider_dsn := 'host=localhost port=5433 dbname=demo1');

SELECT * FROM demo;

// Subscriber running on port:5434

CREATE DATABASE demo_01;

CREATE EXTENSION pglogical;

CREATE TABLE demo1(id int primary key,name text,address text,city text);

SELECT pglogical.create_node(node_name := 'subscriber1',dsn := 'host=localhost port=5434 dbname=demo_01');

SELECT pglogical.Create_subscription(subscription_name := 'subscription1' ,provider_dsn := 'host=localhost port=5433 dbname=demo1');



