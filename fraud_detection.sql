create database fraud_detection;
use fraud_detection;

create table customers(
customer_id int primary key,
name varchar(50),
dob date,
email varchar(50),
phone varchar(50),
country varchar(50)
);

create table accounts(
account_id int primary key,
customer_id int,
account_no varchar(30) unique,
branch varchar(50),
created_at timestamp default current_timestamp,
foreign key (customer_id) references customers(customer_id)
);

create table transaction(
t_id int primary key,
account_id int,
t_time timestamp not null,
amount decimal(10,2),
t_type varchar(50),
counterparty_account varchar(50),
channel varchar(50),
location varchar(100),
device_id varchar(50),
is_manual_review boolean default false,
foreign key (account_id) references accounts(account_id)
);


create table fraud_rules(
rule_id int primary key,
name varchar(50),
description varchar(100),
severity int,
enable boolean default true,
created_at timestamp default current_timestamp
);

create table fraud_alerts(
alert_id int primary key,
t_id int,
account_id int,
rule_id int,
score decimal(6,2),
created_at timestamp default current_timestamp,
acknowledged boolean default false,
foreign key (t_id) references transaction(t_id),
foreign key (account_id) references accounts(account_id),
foreign key (rule_id) references fraud_rules(rule_id)
);

drop table fraud_alerts;

create table blacklist(
list_id int primary key,
type varchar(50),
value varchar(100),
reason varchar(100),
blocked timestamp default current_timestamp
);

insert into customers(customer_id,name,dob,email,phone,country) values
(1, 'Rohit Sharma', '1990-04-15', 'rohit@gmail.com', '9876543210', 'India'),
(2, 'Ananya Gupta', '1995-09-10', 'ananya@gmail.com', '9123456789', 'India'),
(3, 'John Mathews', '1988-12-01', 'john@gmail.com', '9988776655', 'USA');

insert into accounts (account_id, customer_id, account_no, branch) values
(101, 1, 'IND-ACC-001', 'Mumbai'),
(102, 2, 'IND-ACC-002', 'Delhi'),
(103, 3, 'USA-ACC-003', 'California');

select * from accounts;

insert into transaction (t_id, account_id, t_time, amount, t_type, counterparty_account, channel, location, device_id)
values
(1001, 101, NOW(), 500.00, 'Online Transfer', 'ACC-777', 'NetBanking', 'Mumbai', 'DEV-101'),
(1002, 101, NOW(), 20000.00, 'ATM Withdrawal', 'N/A', 'ATM', 'Pune', 'ATM-45'),  -- Big cash withdrawal
(1003, 102, NOW(), 150.00, 'UPI Payment', 'UPI-999', 'UPI', 'Delhi', 'MOB-21'),
(1004, 103, NOW(), 95000.00, 'Online Transfer', 'ACC-5544', 'NetBanking', 'Texas', 'DEV-900'), -- High risk transfer
(1005, 102, NOW(), 45000.00, 'International Transfer', 'ACC-8877', 'SWIFT', 'Russia', 'DEV-44'); -- International suspicious


insert into fraud_rules (rule_id, name, description, severity) values
(1, 'High Amount Transfer', 'Transaction above 50,000', 5),
(2, 'International Transaction', 'International money transfer', 4),
(3, 'Multiple ATM Withdrawals', 'Frequent cash withdrawals', 3),
(4, 'Suspicious Location', 'Transaction from unusual location', 2);

insert into fraud_alerts (alert_id, t_id, account_id, rule_id, score) values
(1, 1002, 101, 3, 75.50),
(2, 1004, 103, 1, 92.30),
(3, 1005, 102, 2, 88.40);

insert into blacklist(list_id, type, value, reason) values
(1, 'Device', 'DEV-900', 'Used in previous fraud cases'),
(2, 'Account', 'ACC-8877', 'Blacklisted foreign account'),
(3, 'Phone', '9988776655', 'Reported fraud activity');


select fa.alert_id, c.name, fa.score, fr.name as rule_name
from fraud_alerts fa
join accounts a on fa.account_id = a.account_id
join customers c on a.customer_id = c.customer_id
join fraud_rules fr on fa.rule_id = fr.rule_id;

