// Provider running on port:5433

CREATE DATABASE sample;

CREATE EXTENSION pglogical;

CREATE TABLE test(id INT PRIMARY KEY,name TEXT,job TEXT);

SELECT pglogical.create_node(
    node_name := 'provider',
    dsn := 'host=localhost port=5433 dbname=sample'
);

select pglogical.replication_set_add_table(set_name := 'default', relation := 'sample' , synchronize_data := 'true');

INSERT INTO test VALUES (1,'john','Automation testing');

INSERT INTO test VALUES (2,'Ilyas','Data admin');
 
INSERT INTO test VALUES (3,'Riyaz','Java developer');
 
INSERT INTO test VALUES (4,'Junaid','Automation testing');
 
INSERT INTO test VALUES (5,'Deepak','Phyton developer');
 
INSERT INTO test VALUES (6,'Wasim','Devops');

// Subscriber running on port:5434

CREATE DATABASE sample;

CREATE EXTENSION pglogical;

CREATE TABLE test(id INT PRIMARY KEY,name TEXT,job TEXT);

SELECT pglogical.create_node(
    node_name := 'subscriber',
    dsn := 'host=localhost port=5434 dbname=sample'
);

SELECT pglogical.create_subscription(
    subscription_name := 'subscription',
    provider_dsn := 'host=locahost port=5433 dbname=sample'
);

SELECT * FROM sample;
