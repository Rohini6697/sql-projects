create database customer_churn;
use  customer_churn;

create table Bank(
RowNumber int,
CustomerId int primary key,
Surname varchar(50),
CreditScore int,
Geography varchar(50),
Gender varchar(50),
Age int,
Tenure int,
Balance float,
NumOfProducts int,
HasCrCard int,
IsActiveMember int,
EstimatedSalary float,
Exited int
);

select * from Bank;
select count(*) from Bank;

-- 1. Customer Churn Summary
select count(*) as total_customer,sum(Exited = 1) as exited_customers,sum(Exited = 0) as existing_customers,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank;

-- 2. Churn by Gender
select sum(Gender = 'Female') as Female,sum(Gender = 'Male') as Male,sum(Exited = 1) as Total
from Bank
where Exited = 1;

-- 3. Churn by Geography
select Geography,sum(Exited = 1) as exited,sum(Exited = 0) as existing,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank
group by Geography;

-- 4. Tenure vs Churn
select Tenure,sum(Exited = 1) as exited_count,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank
group by Tenure;

-- 5. Churn by Credit Score
select CreditScore,sum(Exited = 1) as exited,sum(Exited = 0) as existing,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank
group by CreditScore;

-- 6. Churn by Credit Score
select Age,sum(Exited = 1) as exited,sum(Exited = 0) as existing,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank
group by Age;

-- 7. Churn by Tenure
select Tenure,sum(Exited = 1) as exited,sum(Exited = 0) as existing,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank
group by Tenure;

-- 8. Churn by NumOfProducts
select NumOfProducts,sum(Exited = 1) as exited,sum(Exited = 0) as existing,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank
group by NumOfProducts;

-- 9. Churn by HasCrCard
select HasCrCard,sum(Exited = 1) as exited,sum(Exited = 0) as existing,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank
group by HasCrCard;

-- 10. Churn by IsActiveMember
select IsActiveMember,sum(Exited = 1) as exited,sum(Exited = 0) as existing,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank
group by IsActiveMember;

-- 11. Churn by EstimatedSalary
select EstimatedSalary,sum(Exited = 1) as exited,sum(Exited = 0) as existing,(sum(Exited =1)/count(*))*100 as churn_rate
from Bank
group by EstimatedSalary;