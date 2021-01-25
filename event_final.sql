--Show Events--
set SERVEROUTPUT on;
DECLARE
    V_CITY EVENTS.CITY%TYPE;
    V_LANGUAGE EVENTS.LANGUAGE%TYPE;
BEGIN
    V_CITY := '&CITY';
    V_LANGUAGE := '&LANGUAGE';
    P_SHOW_EVENT_DETAILS(V_CITY, V_LANGUAGE);
END;
/

--Transaction Event--
DECLARE
    user_id user_table.user_id%TYPE;
    quantity TRANSACTION_EVENT.QUANTITY%TYPE;
    EVENT_ID  EVENTS.EVENT_ID%type;
Begin
    user_id:='&user_id';
    quantity:=&quantity;
    EVENT_ID:='&EVENT_ID';
    insert_transaction_event(quantity,user_id,EVENT_ID);
END;
/


select * from TRANSACTION_EVENT;
select * from transaction_movie;

