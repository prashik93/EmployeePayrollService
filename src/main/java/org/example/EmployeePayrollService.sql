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

SELECT * FROM SELECT * FROM employeedepartment empdpt
                                                    JOIN employee emp
                                                    ON empdpt.employeeId = emp.employeeId
                                                    JOIN department dept
                                                    ON empdpt.departmentId = dept.deptId
                                                    JOIN payroll pay
                                                    ON emp.employeeId = pay.payrollId
                                                    JOIN company comp
                                                    ON emp.companyId = comp.companyId;

# UC5_RetrieveSalaryDataForAParticularEmployee as well as TheEmployeeWhoHasJoinedInAParticularDateRange

SELECT basicpay FROM employee emp
                                JOIN payroll pay
                                ON emp.employeeId = pay.payrollId
                                WHERE name = 'Prashik';

SELECT basicpay FROM employee emp
                                JOIN payroll pay
                                ON emp.employeeId = pay.payrollId
                                WHERE startdate
                                BETWEEN CAST('2021-01-01' AS DATE)
                                AND DATE(NOW());

# UC6_AddingGenderToEmployeePayrollTable

ALTER TABLE employee_payroll ADD gender CHAR(1) AFTER name;

UPDATE employee_payroll SET gender = 'M' WHERE name = "Prashik" OR name = "Ratnadip" OR name = "Mazhar";

# UC7 Finding Sum, Avg, Min, Max, Count And Number Of Male And Female Employees

SELECT SUM(basicpay) FROM employee emp
                                     JOIN payroll pay
                                     ON emp.employeeId = pay.payrollId
                                     WHERE gender = 'F'
                                     GROUP BY gender;

SELECT gender,
            SUM(basicpay)
            FROM employee emp
            JOIN payroll pay
            ON emp.employeeId = pay.payrollId
            GROUP BY gender;

SELECT gender,
            AVG(basicpay)
            FROM employee emp
            JOIN payroll pay
            ON emp.employeeId = pay.payrollId
            GROUP BY gender

SELECT gender,
            MIN(basicpay)
            FROM employee emp
            JOIN payroll pay
            ON emp.employeeId = pay.payrollId
            GROUP BY gender;

SELECT gender,
            MAX(basicpay)
            FROM employee emp
            JOIN payroll pay
            ON emp.employeeId = pay.payrollId
            GROUP BY gender;

SELECT gender,
            COUNT(basicpay)
            FROM employee emp
            JOIN payroll pay
            ON emp.employeeId = pay.payrollId
            GROUP BY gender;

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

# UC12 Ensure All Retrieve queries done are working or not specially UC4, UC5 and UC7 with new Table Structure.

INSERT INTO company VALUES (1, 'Google'),
                           (2, 'Amazon'),
                           (3, 'Facebook');

INSERT INTO employee (companyID, name, phone, address, gender)
                                                       VALUES(1, 'Prashik', '8806187589', 'Akola', 'M'),
                                                             (1, 'Ratnadip', '8983253634', 'Amravati', 'M'),
                                                             (2, 'Mazhar', '8125629427', 'Hyderabad', 'M'),
                                                             (3, 'Priyanka', '9999999999', 'Pune', 'F');

INSERT INTO payroll VALUES(1, 10000, 100, 50, 50, 9800),
                          (2, 20000, 200, 100, 100, 19600),
                          (5, 30000, 300, 150, 150, 29400),
                          (6, 40000, 400, 200, 200, 39200);

INSERT INTO department VALUES (1, 'HR'),
                              (2, 'Sales'),
                              (3, 'Marketing');

INSERT INTO employeeDepartment VALUES (1, 1),
                                      (2, 2),
                                      (5, 1),
                                      (5, 2),
                                      (6, 2),
                                      (6, 3);