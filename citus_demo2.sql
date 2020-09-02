
// Coordinator running on port:9700

CREATE EXTENSION citus;

create table person (
	
	id INT,
	
	first_name VARCHAR(50),
	
	last_name VARCHAR(50),
	
	email VARCHAR(50),
	
	gender VARCHAR(50),
	
	phone VARCHAR(50)
);

create table employees (
	
	id INT,
	
	name VARCHAR(50),
	
	job VARCHAR(50),
	
	city VARCHAR(50),
	
	country VARCHAR(50)
);

ALTER TABLE person ADD PRIMARY KEY (id);

ALTER TABLE employees ADD PRIMARY KEY (id);

SET citus.replication_model = 'streaming';

SELECT create_distributed_table('person', 'id');

SELECT create_distributed_table('employees', 'name');

\i /home/thihami/Documents/person.sql //command to load the tables from a file

\i /home/thihami/Documents/employees.sql //command to load the tables from a file

\\ Run some queries

1.SELECT id,name,city

FROM employees

ORDER BY city DESC

LIMIT 10;

2.CREATE PROCEDURE insert_data(INT,VARCHAR(50),VARCHAR(50),VARCHAR(50),VARCHAR(50))

  LANGUAGE 'plpgsql'

  AS $$

  BEGIN

  INSERT INTO employees(id,name,job,city,country) VALUES ($1,$2,$3,$4,$5);

  COMMIT;

  END;

  $$

CALL insert_data(1010,'kim bon','Senior Developer','paris','france');

CALL insert_data(1011,'go aeren','Quality Analyst','paris','france');

3.update employees

  set country='japan'

  where country='france'

4.select count(name) from employees as Total Employees;

// Worker1 running on port:9701

CREATE EXTENSION citus;

\d //To view the distributed tables

select * from person_102104; 

select * from employees_102204;

// Worker2 running on port:9702

CREATE EXTENSION citus;

\d // To view the distributed tables

select * from employees_102231;

select * from person_102135; 
