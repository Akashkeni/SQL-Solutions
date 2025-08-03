
# @ Database commands

CREATE DATABASE myDB;	
# Creates a database

USE myDB;	
# Selects the database 	

DROP DATABASE myDB;	
# Deletes the database

ALTER DATABASE myDB READ ONLY = 1;	
# Makes database read only , no modifications, no deletion

ALTER DATABASE myDB READ ONLY = 0;	
# Makes database back into read-write mode 

# @ Table commands

CREATE TABLE employees (
	   employee_id INT,            # for interger datatype
    first_name VARCHAR(50),		# for string datatype
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5,2), 	# for float datatype 5-for max no. before decimals , 2 max mo after decimals 
    hire_date DATE				# for storing specific date
);
# for creating a table in the database

USE mydb;

SELECT * FROM employees;
# selecting a table 

RENAME TABLE employees TO workers;
# renaming a table

RENAME TABLE workers TO employees;

DROP TABLE employees; 
# Deletes a table

ALTER TABLE employees 
ADD phone_number VARCHAR(15) ;
# adds a column in the table with datatype

ALTER TABLE employees 
rename column phone_number to email;
# renaming a column in the table 

alter table employees 
modify column email varchar(100);
# changing the column datatype

alter table employees
modify email  varchar(100) 
after last_name;
# changing the order of the column in the table

select * from employees;

alter table employees
modify email varchar(100) 
first;
# changing the order of the column in the table to first

alter table employees
drop column email;
# deleting a column in the table

select * from employees;

# Inserts rows (values) in the column

# Inserting one value/row in the column
insert into employees
values( 1,"Tom","Brody",10.28,"2025-05-28");

select * from employees;
 
# Inserting multiple values/rows in the column 
insert into employees
values	(2,"Tony","Stark",99.99,"2024-09-29"),
		(3,"Bruce","Banner",50.00,"2023-08-12"),
        (4,"Edward","Kenway",20,"2026-08-22"),
        (5,"Connor","Kenway",20.99,"2027-07-01");
select * from employees;

# inserting specific field values into the column 
insert into employees (employee_id,first_name,last_name)
values (6,"Howard", "Stark");
select * from employees;

# Select
select * from  employees;

# Selecting specific columns with values in the table , order is set based on the order of columns
select first_name,last_name from employees;
select last_name,first_name from employees;

# where clause in select
select * from employees where employee_id =5 ;
select * from employees where hourly_pay >=30 ;
select * from employees where hire_date <= "2025-01-01";
select * from employees where employee_id != 2;
select first_name,last_name from employees where hourly_pay is null;
select * from employees where hire_date is null;
select * from employees where hire_date is not null;

# Update and Delete data from the table

# Update a single field value in the column
update employees set hourly_pay = 10.37 where employee_id = 6; 
select * from employees;

# Update multiple field values in the column
update employees set hourly_pay = 102.33 , hire_date = "2025-12-11" where employee_id = 6;
select * from employees where employee_id = 6;

# Setting a single field value to null
update employees set hire_date = null where employee_id = 5 ;
select * from employees where employee_id = 5;

# Set a value across all the rows in the column
update employees set hourly_pay = 10.37 ;

# Delete all the rows in the column
delete from employees;

# Delete specific rows in the column
delete from employees where employee_id = 5;
select * from employees;

USE mydb;
# Autocommit , Commit , Rollback
select * from employees;
delete from employees;

set autocommit = off;			 # Transactions will not save automatically
Commit;                          # creates a safepoint
select * from employees;
delete from employees;
rollback;						# To undo any changes
select * from employees;

# Date , Time & DateTime
create table test (
	my_date date,
    my_time time,
    my_DateTime datetime
);

select * from test;
commit;

insert into test values ( current_date(),current_time(),now() );
select * from test;

insert into test values (current_date()+1,null,null);
select * from test;

insert into test values (current_date()-1,null,null);
select * from test;
commit;

drop table test;
select * from test;

rollback;
select * from test;

# Unique constraint - ensures every value in the column is different

create table products (
	product_id int,
    product_name varchar(25) unique, 
    price decimal(4,2)
);

create table products (
	product_id int,
    product_name varchar(25),
    price decimal(4,2)    
);

alter table products add constraint unique(product_name);
select * from products;

insert into products 
values  (101,"Pizza",10.99),
		(102,"Burger",12.99),
        (103,"Cake",5.77),
        (104,"Cookie",12.08);
select * from products;

# NOT NULL constraint
create table products (
	product_id int,
    product_name varchar(25),
	price decimal(4,2) not null    
);

alter table  products modify price decimal(4,2) not null;

insert into products 
values (105,"Fries",0);
select * from products;

# Check Constraint

create table employees(
	employee_id int,
    first_name varchar(25),
    last_name varchar(25),
    hourly_pay decimal(5,2),
    hire_date date 
    constraint chk_hourly_pay check (hourly_pay >= 10.00 )
);

alter table employees
add constraint chk_hourly_pay check (hourly_pay >10 );

insert into employees values(7,"Sheldon","Copper",19.99,current_date());
select * from employees;

alter table employees drop check chk_hourly_pay;

# Default constraint
USE mydb;
select * from products;
 
        
create table products(
	product_id int,
    product_name varchar(25),
    price decimal(4,2) default 0
);

alter table products
alter price set default 0;

insert into products (product_id, product_name) 
values  (106,"Ice"),
		(107,"Popcorn"),
        (108,"Chocolate"),
        (109,"Rice");
select * from products ;

create table txns(
	t_id int,
    amt decimal(5,2),
    t_date datetime default now()
);
select * from txns;

insert into txns (t_id,amt)
values  (111,100.99),
		(112,239.78),
        (113,234.74),
        (114,438.90);
select * from txns;

insert into txns (t_id,amt)
values  (115,134.99),
		(116,290.78),
        (117,224.74),
        (118,228.90);
select * from txns;

# Primary key constraint it is unique and not null and only one primary key per table

create table txns(
	t_id int primary key,
    amt decimal(5,2) 
);

alter table txns 
add constraint
primary key(t_id);
select * from txns;

insert into txns (t_id ,amt)
values  (123,823.99);

select amt from txns
where t_id = 120;

# Auto increment attribute  
# it is associated with primary key 
drop table txns;

# takes value = 1 as default and then increments the value for further insertions
create table txns(
	t_id int primary key auto_increment,
    amt decimal(5,2)
);
select * from txns;

insert into txns(amt)
values(122.55);
select * from txns;

# takes value of primary key as given value
alter table txns
auto_increment =1000;

delete from txns;
select * from txns;

insert into txns (amt)
values (129.32);
select * from txns;

# Foreign Keys
create table customers(
	c_id int primary key auto_increment,
    first_name varchar(25),
    last_name varchar(25)
);
select * from customers;

insert into customers(first_name,last_name)
values	("Tony","Stark"),
		("Bruce","Banner"),
        ("Peter","PArker");
select * from customers;

drop table txns;

# creating a foreign key in the table
create table txns(
	t_id int primary key auto_increment,
    amt decimal(5,2),
    c_id int ,
    foreign key (c_id)references customers(c_id)
);
select * from txns;

# Deleting a foreign key
alter table txns 
drop foreign key txns_ibfk_1;

# Creating a foreign key reference between 2 tables
alter table txns
add constraint fk_c_id
foreign key(c_id) references customers(c_id);

select * from txns;
delete from txns;
select * from txns;

alter table txns 
auto_increment=1000;


insert into txns (amt,c_id) 
values 	(4.99,3),
		(2.89,2),
        (3.24,3),
        (23.23,1);
select * from txns;

delete from customers
where c_id = 3 ;
# since the table contains foreign key , it won't delete the row values

# Joins
use mydb;
insert into txns (amt,c_id)
values (1.00,null);
select * from txns;

insert into customers (first_name,last_name)
values ("Black","Panther");
select *  from customers;

# inner joins = provides the common columns
select *
from txns inner join customers
on txns.c_id = customers.c_id;

select t_id , amt , first_name , last_name
from txns inner join customers
on txns.c_id = customers.c_id;

# Left join - shows all the rows from the left table even if some values in the rows are null
select * 
from txns left join customers
on txns.c_id = customers.c_id;

# Right Join - shows all the tables from the right table even if some values are null
select * 
from txns right join customers
on txns.c_id = customers.c_id;

# Functions
use mydb;

# Count() - total number of rows
select count(amt) as "Today's Txns"
from txns;

# max() - maximum value in the column
select max(amt) as "Max value"
from txns ;

# min() - minimum value in the column
select min(amt) as "Min value"
from txns ;

# avg() - gives avg value of the column
select avg(amt) as "Avg value"
from txns;

# sum() - gives total value of the column
select sum(amt) as "Total value"
from txns;

# concat() - joins  columns in the table 
select * from employees;

select concat(first_name,last_name) as full_name
from employees; 

# " " adds a space between two values of two columns
select concat(first_name," ",last_name) as full_name    
from employees;

# Logical operators
select * from employees;

alter table employees 
add column job varchar(25) after hourly_pay;
select * from employees;

update employees
set job = "IT guy"
where employee_id =7;
select * from employees;

# AND 
select * 
from employees
where hire_date <"2026-01-01" and job ="cook";

# OR
select * 
from employees
where job="cook" or job="cashier";

# NOT
select * 
from employees
where not job = "manager";

# 
select * 
from employees
where not job = "manager" and not job = "asst. manager";

# BETWEEN
select * 
from employees
where hire_date between "2024-12-12" and "2025-12-12" ;

# IN
select * 
from employees
where job in("cook","cashier","janitor");

# wild cards characters % _  used to substitute one or more chracters in a string

use mydb;

select * from employees
where first_name like "s%";

select * from employees
where hire_date like "2025%";

select * from employees
where first_name like "to%";

select * from employees 
where job like "_ook";


select * from employees
where job like "_ook_";
# not the same as above as this would look for 5 letter words

select * from employees
where hire_date like "____-12-__";

select * from employees;

select * from employees
where job like "_a%";

# Order By Clause

select * from employees
order by last_name desc;

select * from employees
order by last_name asc;

select * from employees
order by hire_date desc; 

select * from txns
order by amt ,c_id;   
-- select * from txns order by amt desc , c_id asc;
# if two values are same in that column , add another column to perform ASC or DESC

# Limit clause - limit the no. of records , can display large datasets on pages (pagination)

select * from customers
order by last_name 
limit 3;

select * from customers
order by last_name desc
limit 3;

select * from customers
order by last_name desc
limit 1,1;                  
# returns the record after first record ie the second record  limit 1-offset limit,1

# conside a dataset of 100 rows
# for first 10 rows (1-10)
select * from customers
limit 10; 

# for next ten rows (11-20)
select * from customers
limit 10,10;

# for next ten rows (21-30)
select * from customers
limit 20,10;

 # Union operator - combines results of two or more select statements
 # does not include duplicates
 create table income(
	i_name varchar(20),
    amt decimal 
 );
 insert into income values
	("orders",1000),
    ("mechandise",20000),
    ("services",30000);
select * from income;

create table exp(
	e_name varchar(25),
    amt decimal(7,2)
);
 insert into exp values 
	("wages",-21331),
    ("tax",1242.3),
    ("repairs",1232.23);
 select * from exp;
 
 select * from income
 union
 select * from exp;
 
 
 select first_name,last_name from employees 
 union
 select first_name,last_name from customers;
 
 # Union all - includes duplicates if any

 select first_name,last_name from employees 
 union all
 select first_name,last_name from customers;
 
# Self Joins - joins another copy of the table to itself 
-- used to compare rows of the same table
-- helps to display a hierarchy of data

alter table customers
add referral_id int;
select * from customers;

update customers 
set referral_id = 1
where c_id = 2 ;
select * from customers;

update customers 
set referral_id =2 
where c_id = 3 or c_id=4 ;
select * from customers;

select * 
from customers as a 
inner join customers as b 
on a.referral_id = b.c_id;

select  a.c_id , a.first_name , a.last_name  , 
		concat (b.first_name," ", b.last_name) as referred_by
from customers as a
inner join customers as b
on a.referral_id = b.c_id;


select  a.c_id , a.first_name , a.last_name  , 
		concat (b.first_name," ", b.last_name) as referred_by
from customers as a
left join customers as b
on a.referral_id = b.c_id;

select * from employees;

alter table employees
add supervisor_id int;
select * from employees;

update employees
set supervisor_id = 5
where employee_id = 2  ;
select * from employees;


update employees
set supervisor_id = 1
where employee_id = 5  ;
select * from employees;


update employees
set supervisor_id = null
where employee_id = 1  ;
select * from employees;

select a.first_name,a.last_name,
		concat(b.first_name," ",b.last_name) as "reports to"
from employees as a
inner join employees as b
on a.supervisor_id = b.employee_id;


select a.first_name,a.last_name,
		concat(b.first_name," ",b.last_name) as "reports to"
from employees as a
left join employees as b
on a.supervisor_id = b.employee_id;

# Views
-- a virtual table based 
-- the fields in a view are fields from one or more real tables in the database
-- Not real tables , but can be interacted with as if they were
-- any changes ot one or more real tables will have a change on the view
select * from employees;


# Creating a view
use mydb;

create view employee_attendence as
select first_name,last_name
from employees;

select * from employee_attendence
order by last_name asc;

drop view employee_attendence;
 
select * from customers;

alter table customers
add column email varchar(30);
select * from customers;

update customers
set email = "TStark@gmail.com"
where c_id = 1 ;
select * from customers;

update customers
set email = "BBanner@gmail.com"
where c_id = 2;
select * from customers;

update customers
set email = "PParker@gmail.com"
where c_id = 3;
select * from customers;

update customers
set email = "BPanther@gmail.com"
where c_id = 4;
select * from customers;


create view c_emails as
select email
from customers;

select * from c_emails;

select * from customers;

insert into customers
values (5,"Thor","Odinson",null,"TOdinson@gmail.com");
select * from customers;

select * from c_emails;

# INDEXES (B tree data structure)
-- they are used to find values within a specific column
-- MySQL normally searches sequentially through a column
-- Longer the column , the more expensive the operation is 
-- UPDATE takes more time , select takes less time

# Display an index
show indexes  from customers;

# Creating an index
create index last_name_idx
on customers(last_name);

# This operation would be much faster because of indexes
select * from customers
where last_name="Banner";
show indexes from customers;

# Multi column index
create index first_name_last_name_idx
on customers(last_name,first_name);

show indexes from customers;

# Deleting an Index
alter table customers
drop index last_name_idx;
show indexes from customers;

select * from customers
where last_name ="Banner" and first_name ="Bruce";

# Subqueries - a query enclosed in another query
select * from employees;

select avg(hourly_pay) from employees;

select first_name,last_name,hourly_pay,
	(select avg(hourly_pay) from employees )as AVG_PAY
from employees;

select first_name,last_name,job,hourly_pay
from employees
where hourly_pay > (select avg(hourly_pay) from employees);

select * from customers; 

select * from customers where c_id is not null;

select first_name,last_name from customers
where c_id NOT  IN 
( select distinct c_id
from txns where c_id is not null);

# Group by clause

select * from txns;

insert into txns
values (1005,2.49,4),(1006,5.48,null);
select * from txns;

alter table txns
add column order_date date ;
select * from txns;

UPDATE  txns  
set order_date=   "2023-01-03"
where t_id = 1006;
select * from txns;

delete from txns
where t_id > 1006;
select * from ;

select sum(amt) , order_date 
from txns
group by order_date;

select max(amt) , order_date
from txns
group by order_date;

select count(amt) , order_date
from txns
group by order_date;

select * from txns;

select sum(amt), c_id from txns
group by c_id;         

use mydb;

# Having is uesd with group by , where cannot -> error
select  count(amt),c_id
from txns
group by c_id
having count(amt)>1 and c_id is not null;
          
# Rollup - extension of group by clause 
-- produces another row adn shows the grand total(super aggregated value)

select * from txns;

select sum(amt),order_date
from txns
group by order_date with rollup ;

select count(t_id),order_date
from txns
group by order_date with rollup;

select count(t_id) as "# of orders",c_id
from txns
group by c_id with rollup;

select * from employees;

select sum(hourly_pay) as "Hour Pay",employee_id
from employees
group by employee_id with rollup;

# ON DELETE
# on delete set null = when FK is deleted , replace FK with NULL
# on delete cascade = when FK is deleted , delete row

select * from txns;

select * from customers;


set foreign_key_checks = 0; # so FK can be deleted
delete from customers
where c_id =4;
select * from customers;

set foreign_key_checks = 1; # so FK cannot be deleted

select * from txns;

insert into customers 
values (4,"Black","Panther","2","BPanther@gmail.com");
select * from customers;

# using on delete set null while creating a table
create table txns(
	t_id int primary key,
    amt decimal(5,2),
    c_id int,
    order_date DATE,
    foreign key (c_id) references customers(c_id)
    on delete set null
);

# Deleting foreign key

alter table txns
drop foreign key fk_c_id;

alter table txns
add constraint fk_c_id
foreign key(c_id)references customers(c_id)
on delete set null;

select * from txns;

delete from customers
where c_id = 4;
select * from customers;
select * from txns;

alter table txns
drop foreign key fk_c_id;

# on delete cascade to an existing table
alter table txns
add constraint fk_txns_id
foreign key (c_id) references customers(c_id)
on delete cascade;


delete from customers
where c_id = 4;
select * from txns;

# Stored Procedure - is prepared SQL code that can be saved 
-- reduces network traffic
-- increases performance
-- secure , admin can grant permission to use
-- increases memory usage of every connection

use mydb;

# Creating a procedure
# Delimiter - used when multiple semicolons are used in a query  
# $$ or // can be used

delimiter $$
create procedure get_customers()
begin
	select * from customers;
end $$
delimiter ;

# To run the query in the procedure
call get_customers();

# Deleting a procedure
drop procedure get_customers;

delimiter $$
create procedure find_customer(in id int )
begin
	select * from customers
    where c_id = id;
end $$
delimiter ;

call find_customer(2);

drop procedure find_customer;

delimiter $$ 
create procedure find_customer(in f_name varchar(25),
							   in l_name varchar(25))
begin
	select * from customers
    where first_name = f_name and last_name = l_name;
end $$
delimiter ;

select * from customers;
call find_customer("Bruce","Banner"); 

# Triggers
-- does an operation (eg: insert ,delete ,update) when something happens or a query code is executed

select * from employees;

alter table employees
add column salary decimal(10,2) after hourly_pay;
select * from employees;

update employees
set salary = hourly_pay * 2080;
select * from employees;

# Creating a Trigger
create trigger before_hourly_pay_update
before update on employees
for each row
set new.salary = (new.hourly_pay*2080);

# shows all triggers
show triggers;

select * from employees;

update employees
set hourly_pay = 150
where employee_id =1;
select * from employees; 

update employees
set hourly_pay = hourly_pay +1;
select * from employees;

delete from employees
where employee_id = 6 ;
select * from employees;

create trigger before_hourly_pay_insert
before insert on employees
for each row
set new.salary = (new.hourly_pay*2080);

select * from employees;

insert into employees
values (6,"Howard","Stark",20,null,"janitor",current_date(),5);
select * from employees;

create table expenses(
	exp_id int primary key,
    exp_name varchar(50),
    exp_total decimal(10,2)
);
select * from expenses; 

insert into expenses
values  (1,"salaries",0),
		(2,"supplies",0),
        (3,"taxes",0);
select * from expenses;

update expenses
set exp_total = (select sum(salary) from employees )
where exp_name = "salaries";
select * from expenses;

create trigger after_salary_deleting_
after delete on employees
for each row
update expenses
set exp_total = exp_total - OLD.salary
where exp_name ="salary";

select * from expenses;

delete from employees
where employee_id = 6;
select * from expenses;
select * from employees;

use mydb;

# when a new employee is added it's salary get added into the salary row in the expense table
create trigger after_salary_insert
after insert on employees
for each row
update expenses
set exp_total = exp_total + new.salary
where exp_name = "salaries";

select * from expenses;

select * from employees;

create trigger after_salary_update
after update on employees
for each row
update expenses
set exp_total = exp_total + (new.salary-old.salary)
where exp_name = "salaries";

select * from expenses;

update employees
set hourly_pay = 100
where employee_id =1;
select * from expenses;






































































































































