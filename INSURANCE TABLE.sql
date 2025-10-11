create database dbms;
use dbms;

create table person (driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));
insert into person values("A01", "Richard","Srinivas nagar"),
("A02", "Pradeep","Rajaji Nagar"),
("A03", "Smith","Ashok Nagar"),
("A04", "Venu","NR colony"),
("A05", "Jhon","Hanumanth Nagar");
select *from person;

create table car(
reg_num varchar(10),
model varchar(10),
year int,
PRIMARY KEY(reg_num)
);
insert into car values("KA052250","Indica",1990),
("KA031181","Lancer",1957),
("KA095447","Toyota",1998),
("KA053408","Honda",2008),
("KA041702","Audi",2005);
select *from car;

create table accident(
report_num int,
accident_date date,
location varchar(20),
primary key(report_num));
insert into accident values(11,"2003-01-23","Mysore Road"),
(12, "2004-02-02","Southend Circle"),
(13,"2003-01-21","Bulltemple Road"),
(14,"2008-02-17","Mysore Road"),
(15,"2005-03-04","Kanakpura Road");
select * from accident;

create table owns(
driver_id varchar(10),
reg_num varchar(10),
foreign key(driver_id) REFERENCES person(driver_id),
foreign key(reg_num) REFERENCES car(reg_num)
);
INSERT INTO owns VALUES("A01", "KA052250"),  
("A02", "KA031181"),
("A03", "KA095447"),  
("A04", "KA053408"),  
("A05", "KA041702");  
select *from owns;

create table participated(driver_id varchar(10), reg_num varchar(10),
report_num int, damage_amount int,
primary key(driver_id, reg_num, report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num)
);
insert into participated values("A01","KA052250",11,10000),
("A02","KA031181",12,12000),
("A03","KA095447",13,13000),
("A04","KA053408",14,15000),
("A05","KA041702",15,16000);
select * from participated;

update participated set damage_amount=25000 where reg_num="KA053408" and report_num=14;
select * from participated;

insert into accident values(16, " 2024-01-12", "DOMLUR");
SELECT * FROM ACCIDENT;

select * from car order by year asc;

select count(report_num)
from car c, participated p
where c.reg_num=p.reg_num and c.model='Lancer';

select count(distinct driver_id) CNT
from participated a, accident b
where a.report_num=b.report_num and b.accident_date like '__08%';

select accident_date, location 
from accident;

select driver_id
from participated
where damage_amount >= 25000;

select count(distinct driver_id) as CNT
from participated  p,accident a
where a.reg_num = p.reg_num and p.report_num = A.report_num and year (a.accident_date) = 2008;

select count(distinct p.report_num) as CNT
from participated p, car c, accident a
where p.reg_num = c.reg_num and p.report_num = a.report_num and
c.model = 'Lancer' and year(a.accident_date) = 2008;
							
select * from participated
order by damage_amount desc;

select avg(damage_amount)
from participated;

delete from participated
where damage_amount < (
   select avg_damage
   from (
        select avg(damage_amount) AS avg_damage
      from participated
    ) AS temp
);
select * from participated;

select name
from person a ,participated b 
where a.driver_id =b.driver_id AND damage_amount>
		(select AVG(damage_amount) FROM participated);

select max(damage_amount)
from participated;