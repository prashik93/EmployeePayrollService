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

# UC5_RetrieveSalaryDataForAParticularEmployee as well as TheEmployeeWhoHasJoinedInAParticularDateRange

SELECT salary FROM employee_payroll WHERE name = "Prashik";

SELECT salary FROM employee_payroll WHERE startdate BETWEEN CAST('2021-01-01' AS DATE) AND DATE (NOW());

# UC6_AddingGenderToEmployeePayrollTable

ALTER TABLE employee_payroll ADD gender CHAR(1) AFTER name;

UPDATE employee_payroll SET gender = 'M' WHERE name = "Prashik" OR name = "Ratnadip" OR name = "Mazhar";