-- Auto increment Slot selection id
create SEQUENCE slot_selection_sequence;

CREATE OR REPLACE TRIGGER auto_increment_slot_id
BEFORE INSERT ON slot_selection
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    :NEW.selection_id := 'S' || trim(to_char(slot_selection_sequence.nextval, '0000'));
END;
/

-- Auto increment Cinema Hall id
create SEQUENCE cinema_hall_sequence;

CREATE OR REPLACE TRIGGER auto_increment_hall_id
BEFORE INSERT ON cinema_hall
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    :NEW.hall_id := 'H' || trim(to_char(cinema_hall_sequence.nextval, '0000'));
END;
/

--Auto Increment Event id
CREATE SEQUENCE event_sequence;

CREATE OR REPLACE TRIGGER auto_increment_event_id
BEFORE INSERT ON events
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    :NEW.event_id := 'E' || trim(to_char(slot_selection_sequence.nextval, '0000'));
END;
/


--Auto Increment Transaction event id--
create sequence tran_event_seq;

create or replace trigger auto_increment_trans_event_id
before insert
on transaction_event
REFERENCING new as NEW
for each row
declare x number;
begin
    select tran_event_seq.nextval into x from dual;
    :new.transaction_id:='TE'||'000'||to_char(x);
END;
/

--Auto Increment Transaction movie id--
create sequence tran_movie_seq;

create or replace trigger auto_increment_trans_movie_id
before insert
on transaction_movie
REFERENCING new as NEW
for each row
declare x number;
begin
    select tran_movie_seq.nextval into x from dual;
    :new.transaction_id:='TM'||'000'||to_char(x);
END;
/

--Auto Increment Cart id--
CREATE SEQUENCE cart_seq;

CREATE OR REPLACE TRIGGER AUTO_INCREMENT_CART_ID
BEFORE INSERT ON CART
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    :NEW.cart_id := 'C' || trim(to_char(cart_seq.nextval, '0000'));
END;
/

--AUTO INCREMENT FOOD ID--
CREATE SEQUENCE FOOD_SEQ;

CREATE OR REPLACE TRIGGER AUTO_INCREMENT_FOOD_ID
BEFORE INSERT ON FOOD
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    :NEW.FOOD_ID := 'F' || trim(to_char(FOOD_SEQ.nextval, '0000'));
END;
/

--AUTO INCREMENT FOOD CART ID--
CREATE SEQUENCE FOOD_CART_SEQ;

CREATE OR REPLACE TRIGGER AUTO_INCREMENT_FOOD_CART_ID
BEFORE INSERT ON FOOD_CART
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    :NEW.FOOD_CART_ID := 'FC' || trim(to_char(FOOD_CART_SEQ.nextval, '0000'));
END;
/