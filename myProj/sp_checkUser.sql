CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkUser`(
	IN p_username VARCHAR(25),
    IN p_password VARCHAR(200))
BEGIN
	IF (Select exists (Select COUNT(*) from Customer where username=p_username
		and password=p_password)) then
		select 'Logged-In';
	ELSE
		select 'Username or Password is incorrect. If you don\'t have an account, Please Sign Up !';
  END IF;
END