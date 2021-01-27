-- Drop table statements
drop table slot_selection;
drop table movies;
drop table cinema_hall;
drop table events;
drop table user_table;
drop table transaction_movie;
drop table transaction_event;
DROP TABLE CART;
DROP TABLE FOOD_CART;
DROP TABLE FOOD;
DROP TABLE PRICE_DETAILS;

--Drop procedure statements
drop procedure p_show_movie_details;
drop procedure p_show_event_details;
drop procedure p_show_slot_selection;
drop procedure insert_transaction_movie;

-- DESC statements
desc movies;
desc cinema_hall;
desc slot_selection;
desc events;
desc user_table;
desc transaction_movie;
desc transaction_event;

-- Select all statements
select * from movies;
select * from events;
select * from cinema_hall;
select * from slot_selection;
select * from user_table;
select * from transaction_movie;
select * from transaction_event;
SELECT * FROM CART;
SELECT * FROM FOOD;
SELECT * FROM FOOD_CART;
SELECT * FROM PRICE_DETAILS;

-- Delete statements
delete from movies;
delete from cinema_hall where
delete from slot_selection where
delete from transaction_movie WHERE transaction_id = 'TM00081';
delete from transaction_event where transaction_id = 'TE00021';
delete from user_table where user_id = 'U100';
DELETE FROM CART WHERE CART_ID='C0062';
DELETE FROM FOOD_CART WHERE FOOD_ID='F0001';
DELETE FROM PRICE_DETAILS WHERE USER_ID='U103';


-- Movies Table
create table movies(
        movie_name varchar2(200) PRIMARY KEY,
        genre VARCHAR2(100),
        language VARCHAR2(100),
        release_date DATE,
        rating Number
);

-- Cinema Hall table
create table cinema_hall(
    hall_id varchar2(10) primary key,
    hall_name VARCHAR2(200),
    location varchar2(300),
    city varchar2(100)
);

alter table CINEMA_HALL add(
    constraint cinema_hall_id PRIMARY_KEY(hall_id)
);

-- Slot Selection Table
create table slot_selection(
    selection_id varchar2(10),
    movie_name varchar2(200) REFERENCES movies(movie_name),
    hall_id varchar2(10) REFERENCES cinema_hall(hall_id),
    slot_date date,
    time_slot varchar2(10),
    seat_availability Number,
    price Number
);

alter table slot_selection add(
    CONSTRAINT SLOT_SELECTION_ID PRIMARY KEY(selection_id)
);

-- Events table
create table events(
    event_id varchar2(10),
    event_name varchar2(60),
    location varchar2(100),
    city VARCHAR2(50),
    language VARCHAR2(50),
    event_date VARCHAR2(20),
    seat_availability NUMBER,
    price NUMBER
);

alter table events add(
    CONSTRAINT event_id PRIMARY KEY(event_id)
);

-- Transaction movie table
create table transaction_movie(
    transaction_id VARCHAR2(10) not NULL primary key,
    payment_date DATE,
    quantity numeric (8,2),
    total_price numeric(7,2),
    selection_id VARCHAR2(10)  references slot_selection(selection_id),
    user_id VARCHAR2(10) references user_table(user_id)
);

-- Transaction event table
create table transaction_event(
    transaction_id VARCHAR2(10) not NULL primary key,
    payment_date DATE,
    total_price numeric (7,2),
    quantity number,
    event_id VARCHAR2(30) references events(event_id),
    user_id VARCHAR2(10) references user_table(user_id)
);

-- Cart table
create table cart(
    cart_id varchar2(10) PRIMARY KEY,
    user_id varchar2(10) references user_table(user_id),
    event_id varchar2(10) references events(event_id),
    selection_id varchar2(10) references slot_selection(selection_id),
    quantity number,
    price NUMBER
);

-- Food table
create table food(
    food_id varchar2(10) PRIMARY KEY,
    food_name varchar2(50),
    price NUMBER
);

-- Food cart table
create table food_cart(
    food_cart_id varchar2(10) PRIMARY KEY,
    food_id varchar2(10) references food(food_id),
    cart_id varchar2(10) references cart(cart_id),
    quantity number,
    price number
);

-- Initial Details table
create table price_details(
    user_id varchar2(10) references user_table(user_id),
    total_price number,
    total_ticket_price number,
    total_food_price number,
    cashback varchar2(20)
);

--Insert into Movies table
insert into movies values('The Shawshank Redemption','Romantic','English','21-MAY-2021',9.2);
insert into movies values('The Godfather','Emotional','Hindi','21-JUN-21',9.1);
insert into movies values('The Dark Knight','Drama','English','21-JUL-22',9);
insert into movies values('Borat','Comedy','English','21-AUG-23',7.3);
insert into movies values('Fight Club','Romantic','Japanese','21-SEP-21',8.8);
insert into movies values('Inception','Shounin','Japanese','21-OCT-21',8.7);

--Insert into Cinema hall
insert into cinema_hall(hall_name, location, city) values('PVR Cinemas','Downtown Mall','Kolkata');
insert into cinema_hall(hall_name, location, city) values('INOX Cinemas','Dharmatala','Kolkata');
insert into cinema_hall(hall_name, location, city) values('INOX Cinemas','Quest Mall','Kolkata');
insert into cinema_hall(hall_name, location, city) values('Cinepolis Cinemas','Acropolis Mall','Kolkata');
insert into cinema_hall(hall_name, location, city) values('INOX Cinemas','South City Mall','Kolkata');
insert into cinema_hall(hall_name, location, city) values('PVR Naraina','Naraina','New Delhi');
insert into cinema_hall(hall_name, location, city) values('PVR Saket','Saket','New Delhi');
insert into cinema_hall(hall_name, location, city) values('Q Cinemas','Shahdra','New Delhi');
insert into cinema_hall(hall_name, location, city) values('Satyam Complex Janakpuri','Janakpuri','New Delhi');
insert into cinema_hall(hall_name, location, city) values('Carnival Cinemas','Wadala Link','Mumbai');
insert into cinema_hall(hall_name, location, city) values('PVR Icon Cinemas','Oberoi Mall','Mumbai');
insert into cinema_hall(hall_name, location, city) values('PVR Cinemas','Prime Mall','Mumbai');
insert into cinema_hall(hall_name, location, city) values('INOX Cinemas','Metro Building','Mumbai');
insert into cinema_hall(hall_name, location, city) values('INOX Cinemas','Inorbit Mall','Mumbai');
insert into cinema_hall(hall_name, location, city) values('PVR Cinemas','The Forum Mall','Banglore');
insert into cinema_hall(hall_name, location, city) values('Innovative Multiplex','Outer Ring Road','Banglore');
insert into cinema_hall(hall_name, location, city) values('Urvashi Theatre','Lalbagh Main Road','Banglore');
insert into cinema_hall(hall_name, location, city) values('Cinepolis Cinemas','Royal Meenakshi Mall','Banglore');

--Insert into event table
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('EXHIBITION','Ramgarh','Kolkata','English','22-JAN-2021',90,100);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Meetups','Chittaranjan','Jaipur','Bengali','23-JAN-2021',92,140);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Online Streaming Events','Ramgarh','Gangtok','Hindi','21-JAN-2021',198,120);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Music Show','Jodhpr','Gaya','English','22-JAN-2021',200,500);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Kids','Indirapur','Jaipur','Hindi','25-JAN-2021',53,320);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Celibrity Wishes','Indirapur','Kolkata','Bengali','20-JAN-2021',49,300);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Comedy Show','Raigarh','Gaya','French','23-JAN-2021',322,100);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Award Show','Jodhpr','Kolkata','English','25-JAN-2021',132,200);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Talks','Purvanchal','Delhi','Punjabi','25-JAN-2021',44,150);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Screening','Ramgarh','Surat','Hindi','21-JAN-2021',91,250);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Performing Arts','Jodhpr','Gangtok','English','19-JAN-2021',93,600);
insert into events(event_name, location, city, language, event_date, SEAT_AVAILABILITY, price) values('Workshop','Jodhpr','Surat','Hindi','22-JAN-2021',68,450);

--Insert into Slot Selection
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0001','10:00',200,100);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0001','11:30',150,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0001','13:25',135,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0001','16:00',500,200);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0002','11:00',250,150);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0002','12:00',350,170);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0002','16:30',125,200);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0002','19:45',324,250);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0003','9:00',123,90);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0003','10:00',432,90);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0003','14:00',42,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0006','16:00',213,150);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0008','16:00',213,150);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Shawshank Redemption','H0010','16:00',213,150);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Godfather','H0001','10:00',200,100);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Godfather','H0001','11:30',150,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Godfather','H0001','13:25',135,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Godfather','H0002','11:00',250,150);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Godfather','H0002','12:00',350,170);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Godfather','H0002','16:30',125,200);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Godfather','H0003','14:00',42,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Dark Knight','H0001','10:00',200,100);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Dark Knight','H0001','11:30',150,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Dark Knight','H0001','13:25',135,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Dark Knight','H0002','11:00',250,150);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Dark Knight','H0002','12:00',350,170);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Dark Knight','H0002','16:30',125,200);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Dark Knight','H0003','14:00',42,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('The Dark Knight','H0003','16:00',213,150);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Borat','H0001','11:30',150,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Borat','H0001','13:25',135,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Borat','H0002','11:00',250,150);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Borat','H0003','14:00',42,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Fight Club','H0001','10:00',200,100);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Fight Club','H0001','11:30',150,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Fight Club','H0001','13:25',135,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Fight Club','H0002','12:00',350,170);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Fight Club','H0002','16:30',125,200);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Fight Club','H0003','14:00',42,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Inception','H0001','10:00',200,100);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Inception','H0001','11:30',150,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Inception','H0001','13:25',135,120);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Inception','H0002','12:00',350,170);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Inception','H0002','16:30',125,200);
insert into slot_selection(movie_name, hall_id, time_slot, seat_availability, price) values('Inception','H0003','14:00',42,120);


INSERT INTO FOOD(FOOD_NAME, PRICE) VALUES ('TEST', 100);

select * from events;

