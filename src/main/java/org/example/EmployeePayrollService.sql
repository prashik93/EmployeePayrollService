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

# UC7 Finding Sum, Avg, Min, Max, Count And Number Of Male And Female Employees

SELECT gender, SUM(salary) FROM employee_payroll WHERE gender = 'M' GROUP BY gender;
SELECT gender, SUM(salary) FROM employee_payroll GROUP BY gender;

SELECT gender, AVG(salary) FROM employee_payroll GROUP BY gender;

SELECT gender, MIN(salary) FROM employee_payroll GROUP BY gender;

SELECT gender, MAX(salary) FROM employee_payroll GROUP BY gender;

SELECT gender, COUNT(salary) FROM employee_payroll GROUP BY gender;

# UC8 Extending Employee Payroll Table i.e to Adding Phone, Address And Department as a new Columns.

ALTER TABLE employee_payroll ADD phone VARCHAR(13) AFTER name,
                             ADD address VARCHAR(100) DEFAULT "Akola" AFTER phone,
                             ADD department VARCHAR(50) NOT NULL AFTER address;

# UC9 Extending Employee Payroll Table i.e to Adding BasicPay, Deductions, TaxablePay, IncomeTax And NetPay Columns as a new columns.

ALTER TABLE employee_payroll RENAME COLUMN salary To basicPay;

ALTER TABLE employee_payroll ADD deductions DOUBLE NOT NULL AFTER basicPay,
                             ADD taxablePay DOUBLE NOT NULL AFTER deductions,
                             ADD incomeTax DOUBLE NOT NULL AFTER taxablePay,
                             ADD netPay DOUBLE NOT NULL AFTER incomeTax;

# UC10 Ability to make Employee As Part of Both Sales And Marketing Department.

INSERT INTO employee_payroll (name, phone, address, department, gender, basicPay, deductions, taxablePay, incomeTax, netPay, startdate)
                      VALUES ('Terisa', '78787878787', 'Mumbai', 'Sales', 'F', 20000, 2000, 1000, 200, 18000, '2020-10-22'),
                             ('Terisa', '78787878787', 'Mumbai', 'Marketing', 'F', 20000, 2000, 1000, 200, 18000, '2020-10-22');

# UC11 Creating Corresponding Tables i.e Company, Employee, Department, And Payroll in payroll_service Database.

CREATE TABLE company (
                       companyID INT,
                       companyName VARCHAR(70) NOT NULL,
                       PRIMARY KEY (companyID)
                     );

CREATE TABLE employee (
                        employeeId INT AUTO_INCREMENT PRIMARY KEY,
                        companyId INT NOT NULL,
                        name VARCHAR(70) NOT NULL,
                        phone VARCHAR(13) NOT NULL,
                        address VARCHAR(70) NOT NULL,
                        gender CHAR(1) NOT NULL,
                        FOREIGN KEY (companyID) REFERENCES company(companyID)
                      );

CREATE TABLE payroll (
                       payrollId INT NOT NULL,
                       basicPay DOUBLE NOT NULL,
                       deductions DOUBLE NOT NULL,
                       taxablePay DOUBLE NOT NULL,
                       incomeTax DOUBLE NOT NULL,
                       netPay DOUBLE NOT NULL,
                       FOREIGN KEY (payrollId) REFERENCES employee(employeeId)
                     );

CREATE TABLE department(
                         deptId INT PRIMARY KEY,
                         deptName VARCHAR(30) NOT NULL
                       );

CREATE TABLE employeeDepartment(
                                  employeeId INT NOT NULL,
                                  departmentId INT NOT NULL,
                                  FOREIGN KEY (employeeId) REFERENCES employee(employeeId),
                                  FOREIGN KEY (departmentId) REFERENCES department(deptId)
                               );