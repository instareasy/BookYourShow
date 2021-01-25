set SERVEROUTPUT on;

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