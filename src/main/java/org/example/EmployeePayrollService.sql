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

# UC3_InsertDataInEmployeePayrollTable

INSERT INTO employee_payroll (name, salary, startdate) VALUES("Prashik", 50000, "2020-12-29"),
                                   ("Ratnadip", 60000, "2021-10-28"),
                                   ("Priyanka", 70000, "2021-03-10"),
                                   ("Mazhar", 80000, "2020-05-19");

# UC4_RetrieveAllDataFromEmployeePayrollData

SELECT * FROM employee_payroll;