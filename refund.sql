DECLARE
    V_TRANSACTION_ID TRANSACTION_MOVIE.TRANSACTION_ID%TYPE;
BEGIN
    V_TRANSACTION_ID := '&TRANSACTION_ID';
    P_REFUND(V_TRANSACTION_ID);
END;
/