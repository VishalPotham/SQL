show databases;
create database BankingDB;
use BankingDB;
create table Customer(
    CustomerID int primary key,
    FirstName varchar(50),
    Email varchar(100),
	Phone varchar(15),
    AccountCreation_Date date
    );
    
create table Accounts(
    AccountID int,
    AccountType varchar(20),
    Balance decimal(10,2)
    );
    
create table Transactions(
    TransactionID int,
    TransactionDate date,
    Amount decimal(10,2),
    TransactionType varchar(20)
    );
    
create table Branches(
    BranchID int,
    BranchName varchar(100),
    BranchAddress varchar(200),
    BranchPhone varchar(15)
    );
    
create table AccountBranches(
    AssignmentDate date
    );
    
create table Loans(
    LoanID int,
    LoanAmount decimal(10,2),
    InterestRate decimal(5,2),
    StartDate date,
    EndDate date
    );
    
alter table Customer add DOB date;
alter table Customer modify phone varchar(20);
alter table Customer drop DOB;

alter table Accounts add primary key (AccountID);

drop database dr332;

create table dr332(
    LearnerID int primary key,
    FirstName varchar(50) not null,
    LastName varchar(50) unique,
    Progress decimal(5,2) check(Progress>75),
    Branch varchar(50) default "Dadar"
    );
    
select * from dr332;    

alter table branches add primary key (BranchID);
alter table branches add courses varchar(50);
alter table branches rename column courses to Courses;
select * from branches;

alter table Accounts add CustomerID int;

alter table Accounts
add constraint FK_Accounts_Customers
foreign key (CustomerID) references customer(CustomerID);

alter table customer drop LastName;
alter table customer add LastName varchar(50) after FirstName;
select * from customer;

#DML - Data Manipulation Language

insert into customer(CustomerID, FirstName, LastName, Email, phone, AccountCreation_Date)
values(001, "Vishal", "Potham", "vishalpotham@abc.com", 8850359915, '2026-07-01');

insert into customer(CustomerID, FirstName, LastName, Email, phone, AccountCreation_Date)
values(002, "Sumit", "Khaire", "sumitkhaire@abc.com", 5498756555, '2026-07-02'),
(003, "Daya", "Sagar", "dayasagar@abc.com", 9897456464, '2026-07-03');

insert into customer(CustomerID, FirstName, LastName, phone, AccountCreation_Date)
values(004, "Rushi", "Ingale", 98898998978, '2026-07-04');

insert into customer(customerid, firstname, email, phone, accountcreation_date)
values(005, "Tejal", "tejal@gmail.com", 7877787997, '2026-07-05');

#update 
update customer set phone=6965656646 where  customerid=1;

update customer set phone=1212122121;
set sql_safe_updates=0; 

#delete - specific row/ table, can be rollback if start transaction is used;
start transaction;
delete from customer where firstname="Rushi";
rollback; 

delete from customer;
rollback;

#truncate - delete whole data but not the table structure
truncate table customer;

#DQL - Data Query Language
select * from customer;
select * from customer where firstname="Vishal";
select email from customer;
select firstname, email from customer;
select firstname, email from customer where firstname="Daya";

select * from customer where firstname like "%a"; #endswith
select * from customer where firstname like "t%"; #startswith
select * from customer where firstname like "%t%"; #startsORendswith

select * from customer order by firstname;
select * from customer order by firstname desc;
select * from customer order by accountcreation_date; #by default ascending #oldest to latest
select * from customer order by accountcreation_date desc; #latest to oldest
select * from customer order by accountcreation_date desc limit 1; #latest customer
select * from customer order by accountcreation_date desc limit 1 offset 1; #second latest customer, offset 1 ignores - 1st record

select * from accounts;
select * from customer;
insert into accounts(accountid, accounttype, balance, customerid)
values(101, "Salary",  23000, 1),
(102, "Savings", 50000, 2),
(103, "Salary", 10000, 3),
(104, "Current", 15000, 4);
insert into accounts(accountid, accounttype, balance, customerid)
values(105, "Salary",  32000, 5);
select * from accounts;
select * from accounts order by balance;
select * from accounts order by balance limit 2;
select * from accounts order by balance limit 2 offset 1;
select * from accounts where balance > 15000;
select * from accounts where balance > 15000 and accounttype="Savings";
select * from accounts where balance > 15000 or accounttype="Savings";
select * from accounts where balance between 15000 and 32000;

use bankingdb;
show tables;
desc branches;
insert into branches (branchid, branchname, branchaddress, branchphone, courses)
    values(1, "IT Vedant", "Dadar", 9898989898, "DSDA"),
		  (2, "IT Vedant", "Thane", 8989898989, "Python"),
          (3, "IT Vedant", "Pune", 7979797979, "Full Stack"),
          (4, "IT Vedant", "Delhi", 8686688689, "Cyber Security"),
          (5, "IT Vedant", "Hyderabad", 8457598456, "Digital Marketing");
select * from branches; 

show tables;
desc loans;
insert into loans (loanid, loanamount, interestrate, startdate, enddate)
    values(1, 100000, 10.2, '2026-07-01', '2027-07-01'),
          (2, 150000, 13.2, '2026-06-01', '2027-06-01'),
          (3, 123000, 11.9, '2026-08-01', '2027-08-01'),
          (4, 147000, 9.0, '2026-03-01', '2027-03-01'),
          (5, 189000, 14.4, '2026-09-01', '2027-09-01');
select * from loans;    

select * from accounts;
select distinct(AccountType) from accounts;
#group by
select min(balance) as minimum, accounttype from accounts group by accounttype;
select max(balance) as maximum, accounttype from accounts group by accounttype;  
select avg(balance) as average, accounttype from accounts group by accounttype;   
select sum(balance) as sum, accounttype from accounts group by accounttype;   
select count(balance) as count, accounttype from accounts group by accounttype;  

select min(balance) as minimum, max(balance) as maximum, avg(balance) as average, sum(balance) as sum, count(balance) as count, accounttype 
from accounts group by accounttype;  

select * from branches;
update branches set branchaddress = "Dadar" where branchaddress = "Hyderabad";
set sql_safe_updates=0;
update branches set branchaddress = "Thane" where branchaddress = "Delhi";
select distinct(branchaddress) from branches; 
select branchaddress from branches group by branchaddress;

select * from customer;
select * from customer where email is null;
select * from customer where email is not null;
select * from customer where lastname is null;
select * from customer where lastname is not null;

show tables;
desc transactions;
insert into transactions(transactionid, transactiondate, amount, transactiontype)
    values(1, '2026-2-23', 3999, "UPI"),
          (2, '2025-4-21', 657, "Debit Card"),
          (3, '2023-7-4', 788, "UPI"),
          (4, '2025-6-8', 9899, "Debit Card"),
          (5,'2023-5-30', 7867, "Net Banking");
select * from transactions;
select * from loans;
select * from loans where startdate > '2026-06-02';
select max(interestrate) from loans;
select * from loans order by interestrate desc limit 1;   
select interestrate from loans order by interestrate desc limit 1;         

select * from accounts;
select accountid, accounttype, balance,
case
    when balance>30000 then "Excellent Balance"
    when balance>14000 then "Good Balance"
    else "Insufficient Balance"
    end
    as Balance_Type from accounts;
    
use bankingdb;
select * from accountbranches;
desc accountbranches;
select * from customer;
set sql_safe_updates=0;
update customer set email="rushi@gmail.com" where firstname="Rushi";
update customer set lastname="Kesarkar" where firstname="Tejal";
insert into customer(customerid, firstname, lastname, email, phone, accountcreation_date)
    values(7, "Ajay", "Sharma", "ajay@yahoo.com", 8546987125, '2026-6-4'),
    (8, "Vijay", "Yadav", "vijay@ebay.com", 8546987125, '2026-6-4'),
    (9, "Sujay", "Prasad", "sujay@gmail.com", 8578151425, '2026-5-12'),
    (10, "Ram", "Kapoor", "ram@amazon.com", 8955455575, '2026-6-20'),
    (11, "Shyam", "Sharma", "shyam@yahoo.com", 8546987125, '2026-5-10');
insert into customer(customerid, firstname, lastname, email, phone, accountcreation_date)
    values(6, "Jay", "Rathod", "jay@microsoft.com", 8578524555, '2026-7-7');  
    
select * from accounts;    
    insert into accounts(accountid, accounttype, balance, customerid)
        values(106, "Salary", 56000, 6),
			  (107, "Savings", 69000, 7),
              (108, "Salary", 25000, 8),
              (109, "Current", 42000, 9),
              (110, "Salary", 7000, 10),
              (111, "Current", 14000, 11);
              
select * from branches;
alter table branches
modify branchname varchar(25) default "IT Vedant";  
desc branches;  
alter table branches 
modify branchid int auto_increment;   
insert into branches(branchaddress, branchphone, courses)
    values("Kalyan", 7891597535, "Automation Testing"),  
          ("Pune", 7897844535, "Manual Testing"), 
          ("Dadar", 9856597535, "C Programming"), 
          ("Kalyan", 7891558964, "SQL Developer"), 
          ("Pune", 9045597535, "Gen AI"), 
          ("Kalyan", 9056477535, "Agentic AI");
          
select distinct branchaddress from branches;  

update branches set branchphone=9856597535 where branchaddress="Dadar";  
update branches set branchphone=8945685275 where branchaddress="Thane";  
update branches set branchphone=9045597535 where branchaddress="Pune";  
update branches set branchphone=7891597535 where branchaddress="Kalyan";      
    
select * from loans;   
alter table loans 
modify loanid int auto_increment primary key; 
insert into loans(loanamount, interestrate, startdate, enddate)
    values(340000, 10.00, '2025-8-1', '2026-8-1');
insert into loans(loanamount, interestrate, startdate, enddate)
    values(270000, 10.00, '2025-9-1', '2026-9-1'),
          (140000, 13.33, '2024-6-1', '2025-6-1'),
          (150000, 12.6, '2024-4-1', '2025-4-1'),
          (160000, 15.4, '2026-7-1', '2027-7-1'),
          (172000, 08.44, '2026-3-1', '2027-3-1');
          
select * from transactions;
alter table transactions
modify transactionid int auto_increment primary key;
insert into transactions(transactiondate, amount, transactiontype)
    values('2024-8-4', 3200, "Debit Card"),
          ('2025-7-4', 5400, "Net Banking"),
          ('2024-3-4', 420, "UPI"),
          ('2025-8-3', 330, "UPI"),
          ('2026-7-5', 770, "Debit Card"),
          ('2026-5-8', 9910, "Net Banking");
          
select * from dr332;
drop table dr332;
use bankingdb;
select * from accountbranches;
select * from accounts;
select * from branches;
select * from customer;
select * from loans;
select * from transactions;

# Rank without partition 
select accountid, balance, rank() over (order by balance desc) from accounts; # 1, 1, 3, 4
update accounts set balance=69000 where accountid=106;
select accountid, balance, dense_rank() over (order by balance desc) from accounts; # 1, 1, 2, 3

select loanid, loanamount, rank() over (order by loanamount desc) from loans;  # 1, 1, 3, 4
select loanid, loanamount, dense_rank() over (order by loanamount desc) from loans; # 1, 1, 2, 3

#Rank with partition
select accountid, balance, accounttype, 
rank() over(partition by accounttype order by balance desc) as ranking_with_partition from accounts;

update accounts set balance=25000 where accountid=108;
select accountid, balance, accounttype,
dense_rank() over(partition by accounttype order by balance desc) as ranking_with_partition from accounts;

#Percent Rank
select accountid, balance, accounttype, 
percent_rank() over(partition by accounttype order by balance desc) as ranking_with_partition from accounts;

#Lead and Lag
select accountid, balance, lead(balance) over(order by balance desc) as lead_balance from accounts;
select accountid, balance, lag(balance) over(order by balance desc) as lag_balance from accounts;

#Membership (IN)
select accountid, accounttype, balance from accounts where accounttype="Savings" or accounttype="Current";
select accountid, accounttype, balance from accounts where accounttype in("Savings", "Current");

#Window functions - rank(), dense_rank()[partition by, order by], percent_rank(), lead(), lag()

select * from loans;
#rank, dense rank, percent rank without partition
select loanid, loanamount, rank() over(order by loanamount desc) as rankings from loans;
select loanid, loanamount, dense_rank() over(order by loanamount desc) as rankings from loans;
select loanid, loanamount, percent_rank() over(order by loanamount desc) as rankings from loans;

select * from transactions;
#rank, dense rank, percent rank with partition
select transactionid, amount, transactiontype, rank() over(partition by transactiontype order by amount desc) as rankings from transactions;
select transactionid, amount, transactiontype, dense_rank() over(partition by transactiontype order by amount desc) as rankings from transactions;
select transactionid, amount, transactiontype, percent_rank() over( partition by transactiontype order by amount desc) as rankings from transactions;

#lead, lag
select loanid, loanamount, lead(loanamount) over(order by loanamount desc) as lead_amount from loans;
select loanid, loanamount, lag(loanamount) over(order by loanamount desc) as lag_amount from loans;

#having clause - used with aggregation functions and order by

select * from accounts;
select min(balance), accounttype from accounts group by accounttype;
select min(balance), accounttype from accounts group by accounttype order by min(balance) desc;

select min(balance), accounttype from accounts group by accounttype
having (min(balance)>9000) order by min(balance);

select accounttype from accounts group by accounttype;
select distinct accounttype from accounts;

select * from transactions;
select max(amount), transactiontype from transactions group by transactiontype;
select max(amount), transactiontype from transactions group by transactiontype  order by max(amount) desc;
select max(amount), transactiontype from transactions group by transactiontype
having(max(amount)>4000) order by max(amount);




 
          
    
          
          
          

















    
    
    
    
    
    
    
    
    
    


    


    