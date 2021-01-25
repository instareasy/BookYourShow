
------------------------------------------------------------------------------------------------------------------------
--Show filtered Movies

create or replace procedure p_show_movie_details(v_city CINEMA_HALL.city%type, v_language movies.language%type) IS
    cursor c_movie_detail is select DISTINCT SLOT_SELECTION.MOVIE_NAME,genre,RELEASE_DATE,RATING from slot_selection
                inner join cinema_hall on cinema_hall.hall_id = slot_selection.hall_id and city = v_city
                inner join MOVIES on movies.MOVIE_NAME = SLOT_SELECTION.MOVIE_NAME and language = v_language;
    temp NUMBER;
BEGIN
    temp := 0;
    DBMS_OUTPUT.PUT_LINE('City Selected: '||v_city);
    DBMS_OUTPUT.PUT_LINE('Language Selected: '||v_language||chr(13)||chr(10));
    DBMS_OUTPUT.put_line('----------------- Movies -----------------'||chr(13)||chr(10));
    for movie in c_movie_detail LOOP
        temp := 1;
        DBMS_OUTPUT.put_line('Movie name: '|| movie.movie_name);
        DBMS_OUTPUT.put_line('Genre: '|| movie.genre);
        DBMS_OUTPUT.put_line('Release Date: '|| movie.RELEASE_DATE);
        DBMS_OUTPUT.PUT_LINE('Rating: '|| movie.rating||chr(13)||chr(10));
        dbms_output.put_line('-----------------------------'||chr(13)||chr(10));
    END LOOP;
    if temp = 0 THEN
        DBMS_OUTPUT.put_line('No Data found!! 😢');

    end if;
END;
/

BEGIN
    p_show_movie_details('Kolkata', 'English');
END;
/
------------------------------------------------------------------------------------------------------------------------------------

--Show filtered cinema hall

create or replace procedure p_show_cinema_hall_details(v_movie MOVIES.MOVIE_NAME%type, v_city CINEMA_HALL.CITY%type) IS
    cursor c_hall_detail is select DISTINCT SLOT_SELECTION.HALL_ID,HALL_NAME,location from slot_selection
                inner join cinema_hall on cinema_hall.hall_id = slot_selection.hall_id and city = v_city
                inner join MOVIES on movies.MOVIE_NAME = SLOT_SELECTION.MOVIE_NAME and slot_selection.MOVIE_NAME = v_movie;

    temp number;
BEGIN
    DBMS_OUTPUT.put_line('----------------- Cinema Hall -----------------'||chr(13)||chr(10));
    temp := 0;
    for hall in c_hall_detail LOOP
        DBMS_OUTPUT.put_line('Hall id: '|| hall.hall_id);
        DBMS_OUTPUT.put_line('Hall name: '|| hall.hall_name);
        DBMS_OUTPUT.put_line('Location: '|| hall.location);
        DBMS_OUTPUT.put_line('-----------------------------'||chr(13)||chr(10));
        temp := 1;
    END LOOP;
    if temp = 0 THEN
        DBMS_OUTPUT.put_line('No data found!! 😢');
    end if;
END;
/

---------------------------------------------------------------------------------------------------

--Show Slot selection
create or replace PROCEDURE p_show_slot_selection(v_movie_name movies.movie_name%type, v_hall_id CINEMA_HALL.HALL_ID%type) IS
    type arr is table of SLOT_SELECTION%rowtype index by SLOT_SELECTION.SELECTION_ID%type;
    cursor c_hall is select hall_name,location from CINEMA_HALL where hall_id = v_hall_id;
    r_hall c_hall%rowtype;
    r_slot arr;
    idx SLOT_SELECTION.SELECTION_ID%type;
    i number;
BEGIN
    open c_hall;
    fetch c_hall into r_hall;
    for x in (select SELECTION_ID from SLOT_SELECTION where MOVIE_NAME = v_movie_name and HALL_ID = v_hall_id) LOOP
        select * into r_slot(x.SELECTION_ID) from SLOT_SELECTION where SELECTION_ID = x.SELECTION_ID;
    end LOOP;
    idx := r_slot.first;
    DBMS_OUTPUT.put_line('Movie Selected: '||v_movie_name);
    DBMS_OUTPUT.put_line('Hall Selected: '||r_hall.hall_name);
    DBMS_OUTPUT.put_line('Location: '||r_hall.location||chr(13)||chr(10));
    close c_hall;
    if r_slot.exists(r_slot.first) THEN
        i := 1;
        while idx is not null LOOP
            dbms_output.put_line('***  Slot: '||i||'  ***');
            dbms_output.put_line('Selection id: '||r_slot(idx).selection_id);
            dbms_output.put_line('Time: '||r_slot(idx).time_slot);
            dbms_output.put_line('Seat Availability: '||r_slot(idx).seat_availability);
            dbms_output.put_line('Price: '||r_slot(idx).price||chr(13)||chr(10));
            i := i+1;
            idx := r_slot.next(idx);
        END LOOP;
    ELSE
        DBMS_OUTPUT.put_line('Data not found!! 😢');
    END IF;
END p_show_slot_selection;
/


----------------------------------------------------------------------------------------------------------------------------------------

--Show all the events
create or replace procedure p_show_event_details(v_city events.CITY%type, v_language events.language%type) IS
    CURSOR c_event_detail is select event_id, EVENT_NAME, LOCATION, EVENT_DATE, SEAT_AVAILABILITY, PRICE
                                    FROM EVENTS
                                    WHERE CITY = v_city and LANGUAGE = v_language;
    temp NUMBER;
BEGIN
    temp := 0;
    DBMS_OUTPUT.PUT_LINE('City Selected: '||v_city);
    DBMS_OUTPUT.PUT_LINE('Language Selected: '||v_language||chr(13)||chr(10));
    DBMS_OUTPUT.PUT_LINE('----------------- Events -----------------'||chr(13)||chr(10));
    FOR event IN c_event_detail LOOP
        temp := 1;
        DBMS_OUTPUT.PUT_LINE('Event ID: '|| event.EVENT_ID);
        DBMS_OUTPUT.PUT_LINE('Event Name: '|| event.EVENT_NAME);
        DBMS_OUTPUT.PUT_LINE('Location: '|| event.LOCATION);
        DBMS_OUTPUT.PUT_LINE('Date: '|| event.EVENT_DATE);
        DBMS_OUTPUT.PUT_LINE('Seat Available: '|| event.SEAT_AVAILABILITY);
        DBMS_OUTPUT.PUT_LINE('Price: '|| event.PRICE);
        DBMS_OUTPUT.PUT_LINE('-----------------------------'||chr(13)||chr(10));
    END LOOP;
    IF temp = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No Data found!! 😢');
    END IF;
END;
/


---------------------------------------------------------------------------------------------------

-- Show all the movies
create or replace procedure p_show_all_movie IS
    type arr is table of MOVIES%ROWTYPE index by MOVIES.MOVIE_NAME%type;
    r_movie arr;
    idx MOVIES.MOVIE_NAME%type;
BEGIN
    for x in (select MOVIE_NAME from MOVIES) LOOP
        select * into r_movie(x.MOVIE_NAME) from MOVIES where MOVIE_NAME = x.MOVIE_NAME;
    end loop;
    idx := r_movie.first;
    while idx is not null LOOP
        dbms_output.put_line('Name: '||idx);
        dbms_output.put_line('Genre: '||r_movie(idx).GENRE);
        dbms_output.put_line('Language: '||r_movie(idx).LANGUAGE);
        dbms_output.put_line('Release date: '||r_movie(idx).RELEASE_DATE);
        dbms_output.put_line('Rating: '||r_movie(idx).RATING);
        idx := r_movie.next(idx);
        dbms_output.put_line('----------------------------------------------');
    end loop;
END;
/

---------------------------------------------------------------------------------------------------

--Show all cinema hall
create or replace procedure p_cinema_hall_details IS
    type arr is table of CINEMA_HALL%ROWTYPE index by CINEMA_HALL.HALL_NAME%type;
    r_hall arr;
    idx CINEMA_HALL.HALL_NAME%type;
BEGIN
    for x in (select hall_name from CINEMA_HALL) LOOP
        select * into r_hall(x.hall_name) from CINEMA_HALL where HALL_NAME = x.hall_name;
    end LOOP;
    idx := r_hall.first;
    while idx is not null LOOP
        dbms_output.put_line('Hall name: '||r_hall(idx).hall_name);
        dbms_output.put_line('Location: '||r_hall(idx).location);
        dbms_output.put_line('City: '||r_hall(idx).city);
        idx := r_hall.next(idx);
        DBMS_OUTPUT.put_line('---------------------------------------------');
    end LOOP;
END p_cinema_hall_details;
/

-------------------------------------------------------------------------------------------------------

--Show transaction--

create or replace procedure show_transaction(v_user_id in user_table.user_id%type)
is
    cursor c_trans_movie is select * from transaction_movie natural join slot_selection where  transaction_movie.user_id=v_user_id;
    cursor c_trans_event is select * from transaction_event natural join events where transaction_event.user_id=v_user_id;
    temp number;
    r_slot SLOT_SELECTION%ROWTYPE;
    r_hall CINEMA_HALL%ROWTYPE;
    r_event EVENTS%ROWTYPE;
begin
    DBMS_OUTPUT.put_line('Transaction of User: '||v_user_id||chr(13)||chr(10));
    temp := 0;
    DBMS_OUTPUT.PUT_LINE('--MOVIE TRNASACTIONS--'||chr(13)||chr(10));
    for trans_movie in c_trans_movie LOOP
        SELECT * INTO r_slot FROM SLOT_SELECTION WHERE SELECTION_ID = trans_movie.selection_id;
        SELECT * INTO r_hall FROM CINEMA_HALL WHERE HALL_ID = r_slot.hall_id;
        temp := 1;
        DBMS_OUTPUT.PUT_LINE('----------------------------'||chr(13)||chr(10));
        DBMS_OUTPUT.PUT_LINE('Transaction ID: '||trans_movie.transaction_id);
        DBMS_OUTPUT.PUT_LINE('Date: '||trans_movie.payment_date);
        DBMS_OUTPUT.PUT_LINE('Selection ID: '||trans_movie.selection_id);
        DBMS_OUTPUT.PUT_LINE('Quantity: '||trans_movie.quantity);
        DBMS_OUTPUT.PUT_LINE('Total Price: '||trans_movie.total_price);
        DBMS_OUTPUT.PUT_LINE('Hall Name: '||r_hall.hall_name);
        DBMS_OUTPUT.PUT_LINE('Movie Name: '||r_slot.movie_name);
        DBMS_OUTPUT.PUT_LINE('Time: '||r_slot.time_slot);
    END LOOP;
    IF temp = 0 THEN
        DBMS_OUTPUT.PUT_LINE('NO MOVIE TRANSACTIONS YET');
    END IF;
    DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'--EVENT TRNASACTIONS--'||chr(13)||chr(10));
    for trans_event in c_trans_event LOOP
        SELECT * INTO r_event FROM EVENTS WHERE event_id = trans_event.event_id;
        temp := 2;
        DBMS_OUTPUT.PUT_LINE('----------------------------'||chr(13)||chr(10));
        DBMS_OUTPUT.PUT_LINE('Transaction ID: '||trans_event.transaction_id);
        DBMS_OUTPUT.PUT_LINE('Date: '||trans_event.payment_date);
        DBMS_OUTPUT.PUT_LINE('Event Name: '||r_event.event_name);
        DBMS_OUTPUT.PUT_LINE('Quantity: '||trans_event.quantity);
        DBMS_OUTPUT.PUT_LINE('Total Price: '||trans_event.total_price);
    END LOOP;
    IF temp = 1 THEN
        DBMS_OUTPUT.PUT_LINE('NO EVENT TRANSACTIONS YET');
    END IF;
    if temp = 0 THEN
        dbms_output.PUT_LINE('No Transaction found!! 😢');
    end if;
end;
/

------------------------------------------------------------------------------------------------------------------------
--Insert Transaction Movie--

create or replace procedure insert_transaction_movie(v_quantity in transaction_movie.quantity%type,v_user_id in user_table.user_id%type,v_selection_id in slot_selection.selection_id%type) is
    cursor c_insert_trans is select * from slot_selection where slot_selection.selection_id=v_selection_id;
    v_wallet_balance user_table.wallet_balance%type;
    v_date date;
    r_insert_trans c_insert_trans%rowtype;
BEGIN
    open c_insert_trans;
    fetch c_insert_trans into r_insert_trans;
    IF c_insert_trans%found=TRUE then
        select wallet_balance into v_wallet_balance from user_table where user_table.user_id=v_user_id ;
        IF(v_quantity<r_insert_trans.seat_availability) THEN
            If(r_insert_trans.price*v_quantity<v_wallet_balance) THEN
                select sysdate into v_date from dual ;
                insert into transaction_movie(
                    payment_date,
                    quantity,
                    total_price,
                    selection_id,
                    user_id
                    ) VALUES(
                        v_date,
                        v_quantity,
                        r_insert_trans.price*v_quantity,
                        v_selection_id,
                        v_user_id
                    );
                update user_table  set wallet_balance=wallet_balance-r_insert_trans.price*v_quantity where user_id=v_user_id;
                update slot_selection set seat_availability=seat_availability-v_quantity where SELECTION_ID=v_selection_id;
                DBMS_OUTPUT.put_line('Ticket Booked!!');
            ELSE
                dbms_output.put_line('less than required balance!!!!');
            end if;
        ELSE
            dbms_output.put_line('less or no seat available!!!!');
        end if;
    ELSE
        dbms_output.put_line('transaction not possible !!!!');
    end if;
    close c_insert_trans;
END;
/

------------------------------------------------------------------------------------------------------------------------

--Insert transaction event--

create or replace procedure insert_transaction_event(v_quantity in transaction_event.quantity%type,v_user_id in user_table.user_id%type,v_event_id in events.event_id%type) is
    cursor c_insert_trans is select * from events where events.event_id=v_event_id;
    v_wallet_balance user_table.wallet_balance%type;
    v_date date;
    r_insert_trans c_insert_trans%rowtype;
BEGIN
    open c_insert_trans;
    fetch c_insert_trans into r_insert_trans;
    IF c_insert_trans%found=TRUE then
        select wallet_balance into v_wallet_balance from user_table where user_table.user_id=v_user_id ;
        IF(v_quantity<r_insert_trans.seat_availability) THEN
            If(r_insert_trans.price*v_quantity<v_wallet_balance) THEN
                select sysdate into v_date from dual ;
                insert into transaction_event(
                    payment_date,
                    quantity,
                    total_price,
                    event_id,
                    user_id
                    ) VALUES(
                        v_date,
                        v_quantity,
                        r_insert_trans.price*v_quantity,
                        v_event_id,
                        v_user_id
                    );
                update user_table set wallet_balance=wallet_balance-r_insert_trans.price*v_quantity where user_id=v_user_id;
                update events set seat_availability=seat_availability-v_quantity where event_id=v_event_id;

                DBMS_OUTPUT.put_line('Ticket Booked!!');
            ELSE
                dbms_output.put_line('less than required balance!!!!');
            end if;
        ELSE
            dbms_output.put_line('less or no seat available!!!!');
        end if;
    ELSE
        dbms_output.put_line('transaction not possible !!!!');
    end if;
    close c_insert_trans;
END;
/

-------------------------------------------------------------------------------------------------------

--- REFUND ----

CREATE OR REPLACE PROCEDURE P_REFUND(V_TRANSACTION_ID TRANSACTION_MOVIE.TRANSACTION_ID%TYPE) IS
    CURSOR C_USER_TRANS_EVENT IS SELECT * FROM TRANSACTION_EVENT NATURAL JOIN USER_TABLE WHERE TRANSACTION_EVENT.TRANSACTION_ID = V_TRANSACTION_ID;
    CURSOR C_USER_TRANS_MOVIE IS SELECT * FROM TRANSACTION_MOVIE NATURAL JOIN USER_TABLE WHERE TRANSACTION_MOVIE.TRANSACTION_ID = V_TRANSACTION_ID;
    R_USER_TRANS_MOVIE C_USER_TRANS_MOVIE%ROWTYPE;
    R_USER_TRANS_EVENT C_USER_TRANS_EVENT%ROWtYPE;
    R_USER USER_TABLE%ROWTYPE;
    R_EVENT EVENTS%ROWTYPE;
    R_SLOT SLOT_SELECTION%ROWTYPE;
BEGIN
    OPEN C_USER_TRANS_EVENT;
    OPEN C_USER_TRANS_MOVIE;
    FETCH C_USER_TRANS_MOVIE INTO R_USER_TRANS_MOVIE;
    FETCH C_USER_TRANS_EVENT INTO R_USER_TRANS_EVENT;

    IF C_USER_TRANS_MOVIE%FOUND=TRUE THEN
        dbms_output.put_line('Transaction ID: '||r_user_trans_movie.transaction_id);
        dbms_output.put_line('User ID: '||r_user_trans_movie.user_id);
        dbms_output.put_line('Selection ID: '||r_user_trans_movie.selection_id);
        dbms_output.put_line('Quantity: '||r_user_trans_movie.quantity);
        dbms_output.put_line('Total Price: '||r_user_trans_movie.total_price);

        update slot_selection set SEAT_AVAILABILITY = SEAT_AVAILABILITY + r_user_trans_movie.quantity where SELECTION_ID = r_user_trans_movie.selection_id;
        update user_table set WALLET_BALANCE = WALLET_BALANCE + r_user_trans_movie.total_price - r_user_trans_movie.total_price * 0.2 where user_id = r_user_trans_movie.user_id;

        delete from transaction_movie where transaction_id = r_user_trans_movie.transaction_id;

        select * into r_user from user_table where user_id = r_user_trans_movie.user_id;
        select * into r_slot from SLOT_SELECTION where selection_id = r_user_trans_movie.selection_id;
        dbms_output.put_line('---------------------------------------------');
        dbms_output.put_line('Price Refunded: '||(r_user_trans_movie.total_price - r_user_trans_movie.total_price * 0.2));
        dbms_output.put_line('New Balance: '|| r_user.wallet_balance);
        dbms_output.put_line('New Seat availability: '|| r_slot.seat_availability);

    ELSIF C_USER_TRANS_EVENT%FOUND=TRUE THEN
        DBMS_OUTPUT.PUT_LINE('TRANSACTION ID: '||v_transaction_id);
        DBMS_OUTPUT.PUT_LINE('Event ID: '||r_user_trans_event.EVENT_ID);
        DBMS_OUTPUT.PUT_LINE('Quantity: '||r_user_trans_event.QUANTITY);
        DBMS_OUTPUT.PUT_LINE('Total Price: '||r_user_trans_event.TOTAL_PRICE);

        UPDATE EVENTS SET SEAT_AVAILABILITY = SEAT_AVAILABILITY + r_user_trans_event.QUANTITY WHERE EVENT_ID = r_user_trans_event.EVENT_ID;
        UPDATE USER_TABLE SET WALLET_BALANCE = WALLET_BALANCE + r_user_trans_event.TOTAL_PRICE - r_user_trans_event.TOTAL_PRICE * 0.2 WHERE USER_ID = r_user_trans_event.USER_ID;

        DELETE FROM TRANSACTION_EVENT WHERE TRANSACTION_ID = v_transaction_id;

        SELECT * INTO r_user FROM USER_TABLE WHERE USER_ID = r_user_trans_event.USER_ID;
        SELECT * INTO r_event FROM EVENTS WHERE EVENT_ID = r_user_trans_event.EVENT_ID;

        DBMS_OUTPUT.PUT_LINE('---------------------------------');
        DBMS_OUTPUT.PUT_LINE('PRICE REFUNDED: '||(r_user_trans_event.TOTAL_PRICE - r_user_trans_event.TOTAL_PRICE*0.2));
        DBMS_OUTPUT.PUT_LINE('NEW BALANCE: '|| r_user.WALLET_BALANCE);
        DBMS_OUTPUT.PUT_LINE('NEW SEAT AVAILABILITY: '|| r_event.SEAT_AVAILABILITY);

    ELSE
        DBMS_OUTPUT.PUT_LINE('TRANSACTION NOT FOUND!! 😢');
    END IF;
    CLOSE C_USER_TRANS_EVENT;
    CLOSE C_USER_TRANS_MOVIE;
END;
/

----------------------------------------------------------------------------------------------------------------------
--Wallet balance--

create or replace procedure p_wallet(v_user_id user_table.USER_ID%type) IS
    v_wallet user_table.WALLET_BALANCE%type;
BEGIN
    select WALLET_BALANCE into v_wallet from user_table where user_id = v_user_id;
    if sql%found=True then
        DBMS_OUTPUT.put_line('User Id: '||v_user_id);
        DBMS_OUTPUT.put_line('Wallet balance: '||v_wallet);
    ELSE
        dbms_output.put_line('User not found!! 😢');
    end if;
END;
/

DECLARE
    v_user_id user_table.user_id%type;
BEGIN
    v_user_id := '&user_id';
    p_wallet(v_user_id);
END;
/