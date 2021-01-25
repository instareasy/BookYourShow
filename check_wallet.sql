DECLARE
    v_user_id user_table.user_id%type;
BEGIN
    v_user_id := '&user_id';
    p_wallet(v_user_id);
END;
/