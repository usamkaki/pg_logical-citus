//To download sample data

curl https://examples.citusdata.com/tutorial/companies.csv > companies.csv 

curl https://examples.citusdata.com/tutorial/campaigns.csv > campaigns.csv

curl https://examples.citusdata.com/tutorial/ads.csv > ads.csv

//Coordinator running on Port:9700

CREATE DATABASE citus_demo;

CREATE EXTENSION Citus;

SELECT * from master_add_node('localhost', 9701); // To connect coordinator node with worker1 node

SELECT * from master_add_node('localhost', 9702); // To connect coordinator node with worker2 node

select * from master_get_active_worker_nodes(); // To verify that both worker nodes are connected to coordinator node

CREATE TABLE companies (
    
    id bigint NOT NULL,
    
    name text NOT NULL,
    
    image_url text,
    
    created_at timestamp without time zone NOT NULL,
    
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE campaigns (
    
    id bigint NOT NULL,
    
    company_id bigint NOT NULL,
    
    name text NOT NULL,
    
    cost_model text NOT NULL,
    
    state text NOT NULL,
    
    monthly_budget bigint,
    
    blacklisted_site_urls text[],
    
    created_at timestamp without time zone NOT NULL,
    
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE ads (
    
    id bigint NOT NULL,
    
    company_id bigint NOT NULL,
    
    campaign_id bigint NOT NULL,
    
    name text NOT NULL,
    
    image_url text,
    
    target_url text,
    
    impressions_count bigint DEFAULT 0,
    
    clicks_count bigint DEFAULT 0,
    
    created_at timestamp without time zone NOT NULL,
    
    updated_at timestamp without time zone NOT NULL
);

// To create PRIMARY KEYS in tables

ALTER TABLE companies ADD PRIMARY KEY (id);

ALTER TABLE campaigns ADD PRIMARY KEY (id, company_id);

ALTER TABLE ads ADD PRIMARY KEY (id, company_id);

SET citus.replication_model = 'streaming';

// To distribute the tables in the worker nodes

SELECT create_distributed_table('companies', 'id');

SELECT create_distributed_table('campaigns', 'company_id');

SELECT create_distributed_table('ads', 'company_id');

// load the data into the tables using \copy command

\copy companies from '/home/thihami/Documents/companies.csv' with csv
\copy campaigns from '/home/thihami/Documents/campaigns.csv' with csv
\copy ads from '/home/thihami/Documents/ads.csv' with csv

// Run some queries

1.INSERT INTO companies VALUES (5000, 'New Company', 'https://randomurl/image.png', now(), now());

2.UPDATE campaigns

  SET monthly_budget = monthly_budget*2

  WHERE company_id = 5;

3.DELETE FROM campaigns WHERE id = 46 AND company_id = 5;

4.SELECT name, cost_model, state, monthly_budget
  FROM campaigns
  WHERE company_id = 5
  ORDER BY monthly_budget DESC
  LIMIT 10;
  
//Worker1 node running on port:9701
 
 CREATE EXTENSION citus;

\d //run this command to view the list of distributed tables

//Worker2 node running on port:9702

CREATE EXTENSION citus;

\d //run this command to view the list of distributed tables
