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