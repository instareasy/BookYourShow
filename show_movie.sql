set SERVEROUTPUT on;

BEGIN
    DBMS_OUTPUT.PUT_LINE('-----ENTER CITY AND LANGUAGE FOR Filter MOVIE-------');
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