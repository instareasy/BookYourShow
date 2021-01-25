DECLARE
    user_id user_table.user_id%TYPE;
Begin
    user_id:='&user_id';
    test(user_id);
END;
/
