create database bank;
use bank;
CREATE TABLE branch(
    branch_name VARCHAR(30) PRIMARY KEY,
    branch_city VARCHAR(30),
    assets INT
);
CREATE TABLE bankaccount(
    accno INT PRIMARY KEY,
    branch_name VARCHAR(30),
    balance INT,
    FOREIGN KEY (branch_name) REFERENCES branch(branch_name)
);

CREATE TABLE bankcustomer(
    customer_name VARCHAR(30) PRIMARY KEY,
    customer_street VARCHAR(30),
    customer_city VARCHAR(30)
);

CREATE TABLE depositor(
    customer_name VARCHAR(30),
    accno INT,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (customer_name) REFERENCES bankcustomer(customer_name),
    FOREIGN KEY (accno) REFERENCES bankaccount(accno)
);

CREATE TABLE loan(
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(30),
    amount INT,
    FOREIGN KEY (branch_name) REFERENCES branch(branch_name)
);
INSERT INTO branch VALUES
('SBI_Chamrajpet','Bangalore',50000),
('SBI_ResidencyRoad','Bangalore',10000),
('SBI_ShivajiRoad','Bombay',20000),
('SBI_ParliamentRoad','Delhi',10000),
('SBI_Jantarmantar','Delhi',20000);

INSERT INTO bankaccount VALUES
(1,'SBI_Chamrajpet',2000),
(2,'SBI_ResidencyRoad',5000),
(3,'SBI_ShivajiRoad',6000),
(4,'SBI_ParliamentRoad',9000),
(5,'SBI_Jantarmantar',8000),
(6,'SBI_ShivajiRoad',4000),
(8,'SBI_ResidencyRoad',4000),
(9,'SBI_ParliamentRoad',3000),
(10,'SBI_ResidencyRoad',5000),
(11,'SBI_Jantarmantar',2000);

INSERT INTO bankcustomer VALUES
('Avinash','Bull_Temple_Road','Bangalore'),
('Dinesh','Bannergatta_Road','Bangalore'),
('Mohan','NationalCollege_Road','Bangalore'),
('Nikil','Akbar_Road','Delhi'),
('Ravi','Prithviraj_Road','Delhi');

INSERT INTO depositor VALUES
('Avinash',1),
('Dinesh',2),
('Nikil',4),
('Ravi',5),
('Avinash',8),
('Nikil',9),
('Dinesh',10),
('Nikil',11);

INSERT INTO loan VALUES
(1,'SBI_Chamrajpet',1000),
(2,'SBI_ResidencyRoad',2000),
(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParliamentRoad',4000),
(5,'SBI_Jantarmantar',5000);
select * from loan;
select * from depositor;
select * from branch;
select * from bankaccount;
select * from bankcustomer;

SELECT branch_name, (assets / 100000.0) AS "assets in lakhs"
FROM branch;
SELECT d.customer_name, b.branch_name
FROM depositor d
JOIN bankaccount a ON d.accno = a.accno
JOIN branch b ON a.branch_name = b.branch_name
GROUP BY d.customer_name, b.branch_name
HAVING COUNT(d.accno) >= 2;
CREATE VIEW branch_total_loans AS
SELECT branch_name, SUM(amount) AS total_loan_amount
FROM loan
GROUP BY branch_name;
SELECT * FROM branch_total_loans;
SELECT
    d.customer_name,
    a.branch_name,
    COUNT(d.accno) AS num_accounts
FROM depositor d
JOIN bankaccount a ON d.accno = a.accno
GROUP BY d.customer_name, a.branch_name
HAVING COUNT(d.accno) >= 2;