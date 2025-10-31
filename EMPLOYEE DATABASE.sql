create database employeedatabase;
use employeedatabase;
create table employee
(empno int primary key,
ename varchar(50),
mgr_no int,
hiredate date,
sal decimal(10,2),
deptno int,
foreign key(deptno) references dept(deptno)
);
create table dept
(deptno int primary key,
dname varchar(60),
dloc varchar(60)
);
create table project
(
pno int primary key,
pname varchar(60),
ploc varchar(100)
);
create table assignedto
(empno int,
pno int,
jobrole varchar(50),
foreign key(empno) references employee(empno),
foreign key(pno) references project(pno)
);
create table incentives
(empno int,
incentive_date date primary key,
incentive_amount decimal(10,2),
foreign key(empno) references employee(empno)
);
INSERT INTO DEPT VALUES (10, 'HR', 'Bengaluru');
INSERT INTO DEPT VALUES (20, 'Engineering', 'Hyderabad');
INSERT INTO DEPT VALUES (30, 'Sales', 'Mysuru');
INSERT INTO DEPT VALUES(40, 'Design', 'Mumbai');
INSERT INTO DEPT VALUES(50, 'IT', 'Jaipur');

INSERT INTO EMPLOYEE VALUES (101, 'Aisha', NULL, '2016-03-10', 90000.00, 20);
INSERT INTO EMPLOYEE VALUES(102, 'Bilal', 101, '2017-07-15', 60000.00, 20);
INSERT INTO EMPLOYEE VALUES (103, 'Cathy', 101, '2018-01-20', 55000.00, 20);
INSERT INTO EMPLOYEE VALUES (104, 'Dina', 101, '2019-05-01', 50000.00, 30);
INSERT INTO EMPLOYEE VALUES (105, 'Ehsan', 104, '2019-06-10', 32000.00, 30);

INSERT INTO PROJECT VALUES (1001, 'Alpha System', 'Bengaluru');
INSERT INTO PROJECT VALUES (1002, 'Beta Platform', 'Hyderabad');
INSERT INTO PROJECT VALUES (1003, 'Gamma App', 'Mysuru');
INSERT INTO PROJECT VALUES (1004, 'Delta Tool', 'Chennai');
INSERT INTO PROJECT VALUES (1005, 'Mobile App', 'Çhennai');

INSERT INTO ASSIGNEDTO VALUES (101, 1002, 'Project Manager');
INSERT INTO ASSIGNEDTO VALUES (102, 1002, 'Developer');
INSERT INTO ASSIGNEDTO VALUES (103, 1002, 'Tester');
INSERT INTO ASSIGNEDTO VALUES (105, 1003, 'Sales Rep');
INSERT INTO ASSIGNEDTO VALUES (104, 1003, 'Junior Sales');

INSERT INTO INCENTIVES VALUES (101, '2019-01-05', 5000.00);
INSERT INTO INCENTIVES VALUES (102, '2019-01-10', 3000.00);
INSERT INTO INCENTIVES VALUES (103, '2019-01-12', 2500.00);
INSERT INTO INCENTIVES VALUES (104, '2019-01-08', 2000.00);
INSERT INTO INCENTIVES VALUES (101, '2019-02-20', 4000.00);

SELECT * FROM DEPT;
SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM ASSIGNEDTO;
SELECT * FROM INCENTIVES;

SELECT a.empno
FROM ASSIGNEDTO a
JOIN PROJECT p ON a.pno = p.pno
WHERE p.ploc IN ('Bengaluru', 'Hyderabad', 'Mysuru');

SELECT e.empno
FROM EMPLOYEE e
LEFT JOIN INCENTIVES i ON e.empno = i.empno
WHERE i.empno IS NULL;



SELECT e.ename, e.empno, e.deptno, a.jobrole, d.dloc AS dept_location, p.ploc AS project_location
FROM EMPLOYEE e
JOIN DEPT d ON e.deptno = d.deptno
JOIN ASSIGNEDTO a ON e.empno = a.empno
JOIN PROJECT p ON a.pno = p.pno
WHERE d.dloc = p.ploc;

