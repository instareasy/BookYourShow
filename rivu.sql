insert into user_table values ('U100',2000);
insert into user_table values ('U101',2000);
insert into user_table values ('U102',2000);
insert into user_table values ('U103',2000);
insert into user_table values ('U104',2000);
insert into user_table values ('U105',2000);
insert into user_table values ('U106',2000);
insert into user_table values ('U107',2000);
insert into user_table values ('U108',2000);
insert into user_table values ('U109',2000);
insert into user_table values ('U110',2000);
insert into user_table values ('U111',2000);

delete from user_table where user_id = 'P001';
delete from user_table where user_id = 'P002';
delete from user_table where user_id = 'P003';
delete from user_table where user_id = 'P004';
delete from user_table where user_id = 'P005';
select * from user_table;


drop table TRANSACTION_movie;




create table transaction_table(transaction_id varchar(10) primary key,payment_date date,show_id varchar(5),total_price number,total_ticket_price number,user_id varchar2(10) references user_table(user_id),no_of_tickets number);



create sequence tran_seq;
create or replace trigger auto_increment_trans_id
before insert
on transaction_table
REFERENCING new as NEW
for each row
declare x number;
begin
 select tran_seq.nextval into x from dual;
:new.transaction_id:='T'||'000'||to_char(x);
END;
/


create or replace procedure discount_price_details(user_id user_table.user_id%type
,coupon_code user_table.user_id%type )
is
qty cart.quantity%type;
t_price price_details.total_price%type;
    t_food_price price_details.total_food_price%type;
    t_ticket_price price_details.total_ticket_price%type;
begin
    select sum(quantity) into qty from cart where cart.user_id=user_id;
    select total_ticket_price into t_ticket_price from price_details where price_details.user_id=user_id;
    if coupon_code = 'BYS30' then
        if t_ticket_price>450 then
        select total_ticket_price into t_ticket_price from price_details;
        if .3*t_ticket_price<250 then
        update price_details set total_price=t_price-.3*t_ticket_price where price_details.user_id=user_id;
        update price_details set total_ticket_price=.7*t_ticket_price where price_details.user_id=user_id;
        else
        update price_details set total_price=t_price-250 where price_details.user_id=user_id;
        update price_details set total_ticket_price=t_ticket_price-250 where price_details.user_id=user_id;
        end if;
        ELSE
        DBMS_output.Put_line('coupon code is applicable for above Rs 450 whereas your is'|| t_ticket_price);
        end if;
    end if;
    if coupon_code = 'BYS20' then
        if qty>3 then
        update price_details set cashback=.2*t_ticket_price where price_details.user_id=user_id;
    end if;
    end if;
   end;
/

create or replace procedure transaction(user_id user_table.user_id%type)
    is
    d date;
    t_food_price price_details.total_food_price%type;
    t_price price_details.total_price%type;
    t_ticket_price price_details.total_ticket_price%type;
    c_back price_details.cashback%type;
    qty cart.quantity%type;
    e_id cart.event_id%type;
begin
    select sysdate into d from dual;
    select total_price into t_price from price_details where price_details.user_id=user_id;
    select total_ticket_price into t_ticket_price from price_details where price_details.user_id=user_id;
    select total_food_price into t_food_price from price_details where price_details.user_id=user_id;
    select cashback into c_back from price_details where price_details.user_id=user_id;
    select sum(quantity) into qty from cart;
    select event_id into e_id from cart where selection_id is null;
    insert into transaction_table(payment_date,show_id,total_price,total_ticket_price,user_id,no_of_tickets)
    values (d,e_id,t_price,t_ticket_price,user_id
    ,qty);
    update event set event.seat_availability=event.seat_availability-qty where event.event_id=e_id;
    delete from price_details where price_details.user_id=user_id;
  end;
/


