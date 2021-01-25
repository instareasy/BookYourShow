set SERVEROUTPUT on;

BEGIN
    DBMS_OUTPUT.PUT_LINE('----FOR TRANSACTION----');
END;
/

--TRANSACTION MOVIE--
DECLARE
    user_id user_table.user_id%TYPE;
    quantity transaction_movie.quantity%type;
    selection_id  slot_selection.selection_id%type;
Begin
    user_id:='&user_id';
    quantity:=&quantity;
    selection_id:='&selection_id';
    insert_transaction_movie(quantity,user_id,selection_id);
END;
/