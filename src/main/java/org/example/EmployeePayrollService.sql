# UC1_CreatePayrollServiceDatabase

CREATE DATABASE payroll_service;    # To Create Database
SHOW DATABASES;                     # To Show Databases in the MySql
USE payroll_service;                # To Use Perticular Database

# UC2_CreateEmployeeTable
create table employee_payroll(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    salary FLOAT NOT NULL,
    startdate DATE NOT NULL
);
