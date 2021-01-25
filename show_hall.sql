set SERVEROUTPUT on;

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