set SERVEROUTPUT on;

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