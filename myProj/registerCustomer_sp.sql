CREATE DEFINER=`root`@`localhost` PROCEDURE `registerCustomer`(
IN username varchar(25),
IN email varchar(100),
IN first_name varchar(100),
IN last_name varchar(100),
IN middle_name varchar(100),
IN password varchar(256),
IN address varchar(250),
IN primary_number int(16),
IN phone_type varchar(20),
IN cc_number int(19),
IN cc_name varchar(100),
IN expire_date datetime,
IN cvv int(4)
)
BEGIN
	INSERT into `cs6400_fa17_team032`.`Customer`
    (username,email,first_name,last_name,middle_name,
    password,address,primary_number,phone_type,cc_number,
    cc_name,expire_date,cvv) 
    values 
    (username,email,first_name,last_name,middle_name,
    password,address,primary_number,phone_type,cc_number,
    cc_name,expire_date,cvv);
END