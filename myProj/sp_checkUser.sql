CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkUser`(
	IN p_username VARCHAR(25),
    IN p_password VARCHAR(200))
BEGIN
	declare C INT;
	Select COUNT(*) INTO C from Customer where username=p_username
		and password=p_password;
    IF(C != 1) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Username or Password is Wrong! If you are a new user, Please Sign Up.';
	END IF;
END