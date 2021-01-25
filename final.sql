set SERVEROUTPUT on;

BEGIN
    DBMS_OUTPUT.PUT_LINE('-----ENTER CITY AND LANGUAGE FOR SORTING MOVIE-------');
END;
/

---Show movies---

DECLARE
    v_city CINEMA_HALL.CITY%TYPE;
    v_language MOVIES.LANGUAGE%TYPE;
BEGIN
    v_city := '&City';
    v_language := '&Language';
    p_show_movie_details( v_city, v_language);
END;
/

--Show Cinema Hall--

BEGIN
    DBMS_OUTPUT.PUT_LINE('----ENTER MOVIE NAME FROM ABOVE LIST AND CITY----');
END;
/

DECLARE
    v_movie_name MOVIES.MOVIE_NAME%TYPE;
    v_city CINEMA_HALL.CITY%TYPE;
BEGIN
    v_movie_name := '&Movie_Name';
    v_city := '&City';
    p_show_cinema_hall_details( v_movie_name, v_city);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('----ENTER MOVIE NAME AND CINEMA HALL ID----');
END;
/
--Show Slot Selection--

DECLARE
    v_movie_name MOVIES.MOVIE_NAME%TYPE;
    v_hall_id CINEMA_HALL.HALL_ID%TYPE;
BEGIN
    v_movie_name := '&Movie_Name';
    v_hall_id := '&Hall_ID';
    p_show_slot_selection(v_movie_name, v_hall_id);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('----FOR TRANSACTION----');
END;
/

--TRANSACTION MOVIE--
set SERVEROUTPUT on;
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



