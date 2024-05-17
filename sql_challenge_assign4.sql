create database crs;
use crs;
create table Vehicle(carID int primary key, make varchar(100),model varchar(100),Year_rent year,daily_Rate int,available int,
passenger_capacity int,engine_capacity int);
insert into Vehicle values(1,"Toyota","Camry",2022,50,1,4,1450);
insert into Vehicle values(2,"Honda","Civic",2023,45,1,7,1500);
insert into Vehicle values(3,"Ford","Focus",2022,48,0,4,1400);
insert into Vehicle values(4,"Nissan","Athima",2023,52,1,7,1200);
insert into Vehicle values(5,"Chevrolet","Malibu",2022,47,1,4,1800);
insert into Vehicle values(6,"Hyundai","Sonata",2023,49,0,7,1400);
insert into Vehicle values(7,"BMW","3 Series",2023,60,1,7,2499);
insert into Vehicle values(8,"Mercedes","C-Class",2022,58,1,8,2599);
insert into Vehicle values(9,"Audi","A4",2022,55,0,4,2500);
insert into Vehicle values(10,"Lexus","ES",2023,54,1,4,2500);
select* from Vehicle;

create table Customer(customer_id int primary key,first_name varchar(20),last_name varchar(20),email varchar(50),
phn varchar(50));
insert into Customer values(1,"John","Doe","johndoe@example.com","555-555-5555");
insert into Customer values(2,"Jane","Smith","janesmith@example.com","555-123-4567");
insert into Customer values(3,"Robert","Johnson","robert@example.com","555-789-1234");
insert into Customer values(4,"Sarah","Brown","sarah@example.com","555-456-7890");
insert into Customer values(5,"David","Lee","david@example.com","555-987-6543");
insert into Customer values(6,"Laura","Hall","laura@example.com","555-234-5678");
insert into Customer values(7,"Michael","Davis","michael@example.com","555-876-5432");
insert into Customer values(8,"Emma","Wilson","emma@example.com","555-432-1098");
insert into Customer values(9,"William","Taylor","william@example.com","555-321-6547");
insert into Customer values(10,"Olivia","Adams","olivia@example.com","555-765-4321");
select* from Customer;

create table Lease(lease_id int primary key,carID int ,foreign key(carId) references Vehicle(carID),
customer_id int, foreign key(customer_id) references Customer(customer_id),start_date date,end_date date,
lease_type varchar(50));
insert into Lease values(1,1,1,"2023-01-01","2023-01-05","Daily");
insert into Lease values(2,2,2,"2023-02-15","2023-02-28","Monthly");
insert into Lease values(3,3,3,"2023-03-10","2023-03-15","Daily");
insert into Lease values(4,4,4,"2023-04-20","2023-04-30","Monthly");
insert into Lease values(5,5,5,"2023-05-05","2023-05-10","Daily");
insert into Lease values(6,4,3,"2023-06-15","2023-06-30","Monthly");
insert into Lease values(7,7,7,"2023-07-01","2023-07-10","Daily");
insert into Lease values(8,8,8,"2023-08-12","2023-08-15","Monthly");
insert into Lease values(9,9,9,"2023-09-07","2023-09-10","Daily");
insert into Lease values(10,10,10,"2023-10,10","2023-10,31","Monthly");
select* from Lease;

create table Payment(payment_id int primary key,lease_id int,foreign key(lease_id) references Lease(lease_id),
payment_date date,amount int);
insert into Payment values(1,1,"2023-01-03",200);
insert into Payment values(2,2,"2023-02-20",1000);
insert into Payment values(3,3,"2023-03-12",75);
insert into Payment values(4,4,"2023-04-25",900);
insert into Payment values(5,5,"2023-05-07",60);
insert into Payment values(6,6,"2023-06-18",1200);
insert into Payment values(7,7,"2023-07-03",40);
insert into Payment values(8,8,"2023-08-14",1100);
insert into Payment values(9,9,"2023-09-09",80);
insert into Payment values(10,10,"2023-10-25",1500);
select *from Payment;


update Vehicle set daily_Rate=68 where make="Mercedes";
select*from Vehicle;

delete from Customer where customer_id=10;
delete  from Lease where lease_id=10;
delete from Payment where lease_id=10;
select * from Customer;
select * from Lease;
select* from Payment;

alter table Payment rename column  payment_date  TO transaction_date; 
select * from Payment;

select first_name,last_name from Customer where email="michael@example.com";

select * from Lease where customer_id=8;

alter table Payment add column customer_id int ;
select * from Payment;
update Payment set customer_id=1 where payment_id=1;
update Payment set customer_id=2 where payment_id=2;
update Payment set customer_id=3 where payment_id=3;
update Payment set customer_id=4 where payment_id=4;
update Payment set customer_id=5 where payment_id=5;
update Payment set customer_id=6 where payment_id=6;
update Payment set customer_id=7 where payment_id=7;
update Payment set customer_id=8 where payment_id=8;
update Payment set customer_id=9 where payment_id=9;
update Payment set customer_id=10 where payment_id=10;
select * from Payment;

select amount from Payment  p join Customer  c on p.customer_id=c.customer_id where c.phn="555-123-4567";

select avg(daily_Rate) from Vehicle where Available=0;

select make from Vehicle where daily_Rate=(select max(daily_Rate) from Vehicle);

select * from Lease where customer_id=2;

select * from Lease where start_date=(select max(start_date ) from Lease);

select amount from Payment where year(transaction_date)=2023;

select c.first_name,c.last_name from Customer c join Lease l on c.customer_id=l.customer_id
join Payment p on l.lease_id=p.lease_id where p.amount is null;

select v.make, v.model, p.amount from Vehicle v join Lease l on v.carID=l.carID join Payment p
on l.lease_id=p.lease_id;

select p.amount,c.first_name,c.last_name from Payment p join Lease l on l.lease_id=p.lease_id join Customer c on
c.customer_id=l.customer_id order by c.customer_id;

select * from Vehicle v join Lease l on v.carID=l.carID order by l.lease_id;

select c.first_name,c.last_name,v.make from Customer c join Lease l on  c.customer_id=l.customer_id join
Vehicle v on v.carID=l.carID where v.Year_rent=2023;

select c.customer_id, c.first_name,c.last_name
from Customer c
join Lease l on c.customer_id = l.customer_id join Payment p on p.lease_id=l.lease_id
group by  c.customer_id, c.first_name,c.last_name
Order by  SUM(p.amount) DESC limit 1;

select * from Lease l join Vehicle v  on l.carID=v.carID;

select v.make,v.model,l.lease_id,l.carID,l.start_date,l.end_date,l.lease_type from Vehicle v join
Lease l on v.carID=l.carID where l.start_date>=current_date();














