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

    
    












    
    
    
    
    
    
    
    
    
    


    


    