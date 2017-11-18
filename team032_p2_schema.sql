-- CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
CREATE USER IF NOT EXISTS admin@localhost IDENTIFIED BY 'admin';

DROP DATABASE IF EXISTS `cs6400_fa17_team032`; 
SET default_storage_engine=InnoDB;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS cs6400_fa17_team032 
    DEFAULT CHARACTER SET utf8mb4 
    DEFAULT COLLATE utf8mb4_unicode_ci;
USE cs6400_fa17_team032 ;

GRANT SELECT, INSERT, UPDATE, DELETE, FILE ON *.* TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON `admin`.* TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON `cs6400_fa17_team032`.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;

-- Tables 

CREATE TABLE Customer (
	customer_id int(16) unsigned NOT NULL AUTO_INCREMENT,
	username varchar(25) NOT NULL,
	email varchar(100) NOT NULL,
	first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	middle_name varchar(100),
	password varchar(60) NOT NULL,
	address varchar(250) NOT NULL,
	primary_number varchar(20) NOT NULL,
	phone_type ENUM('HOME', 'WORK', 'CELL') NOT NULL,
	cc_number varchar(19),
	cc_name varchar(100),
	expire_date datetime,
	cvv int(4),
	PRIMARY KEY (username),
	UNIQUE KEY email (email), 
	UNIQUE KEY customer_id (customer_id)
);

CREATE TABLE PhoneNumber(
	username varchar(25) NOT NULL,
	phone_number varchar(20),
	phone_type varchar(20),
	PRIMARY KEY (username, phone_number),
	UNIQUE KEY (username)
);

CREATE TABLE Clerk (
	employee_id int(16) unsigned NOT NULL AUTO_INCREMENT,
	username varchar(25) NOT NULL,
	email varchar(100) NOT NULL,
	first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	middle_name varchar(100),
	password varchar(60) NOT NULL,
	date_of_hire datetime NOT NULL,
	PRIMARY KEY (username),
	UNIQUE KEY employee_id (employee_id),
	UNIQUE KEY email (email)
);

CREATE TABLE Tool (
	tool_id int(16) unsigned NOT NULL AUTO_INCREMENT,
	original_price DOUBLE(10,2) NOT NULL,
	width_diameter DOUBLE (10,3) NOT NULL,
	short_description varchar(100) NOT NULL,
	length DOUBLE (10,3) NOT NULL,
	power_source ENUM('ELECTRIC', 'CORDLESS', 'GAS', 'MANUAL') NOT NULL,
	material  varchar(100),
	manufacturer  varchar(100) NOT NULL,
	weight DOUBLE(10,3) NOT NULL,
	category ENUM('Hand','Garden', 'Power', 'Ladder') NOT NULL,
	sub_option varchar(60) NOT NULL,
	marked_for_sale_date datetime,
	marked_for_sale_clerk_id int(16) unsigned,
	PRIMARY KEY (tool_id)
);


CREATE TABLE Saw (
	tool_id int(16) unsigned NOT NULL,
	volt_rating DOUBLE(10,3) NOT NULL,
	amp_rating DOUBLE(10,3) NOT NULL,
	battery_type ENUM('LI-ION', 'NiCd', 'NiMH'), 
	min_rpm_rating DOUBLE(10,3) NOT NULL,
	max_rpm_rating DOUBLE(10,3),
	blade_size DOUBLE(10,3) NOT NULL,
	PRIMARY KEY (tool_id)
);

CREATE TABLE Drill (
	tool_id int(16) unsigned NOT NULL,
	volt_rating DOUBLE(10,3) NOT NULL,
	amp_rating DOUBLE(10,3) NOT NULL,
	battery_type ENUM('LI-ION', 'NiCd', 'NiMH'), 
	min_rpm_rating DOUBLE(10,3) NOT NULL,
	Max_rpm_rating DOUBLE(10,3),
	Min_torque_rating DOUBLE(10,3) NOT NULL,
	Max_torque_rating DOUBLE(10,3),
	adjustable_clutch ENUM('True', 'False'),
	PRIMARY KEY (tool_id)
);

CREATE TABLE Sander (
	tool_id int(16) unsigned NOT NULL,
	volt_rating DOUBLE(10,3) NOT NULL,
	amp_rating DOUBLE(10,3) NOT NULL,
	battery_type ENUM('LI-ION', 'NiCd', 'NiMH'), 
	min_rpm_rating DOUBLE(10,3) NOT NULL,
	max_rpm_rating DOUBLE(10,3),
	dust_bag ENUM('True', 'False'),
	PRIMARY KEY (tool_id)
);

CREATE TABLE Air_Compressor (
	tool_id int(16) unsigned NOT NULL,
	volt_rating DOUBLE(10,3) NOT NULL,
	amp_rating DOUBLE(10,3) NOT NULL,
	battery_type ENUM('LI-ION', 'NiCd', 'NiMH'), 
	min_rpm_rating DOUBLE(10,3) NOT NULL,
	max_rpm_rating DOUBLE(10,3),
	pressure_rating DOUBLE(10,3),
	tank_size DOUBLE(10,3) NOT NULL,
	PRIMARY KEY (tool_id)
);

CREATE TABLE Mixer (
	tool_id int(16) unsigned NOT NULL,
	volt_rating DOUBLE(10,3) NOT NULL,
	amp_rating DOUBLE(10,3) NOT NULL,
	battery_type ENUM('LI-ION', 'NiCd', 'NiMH'),
	min_rpm_rating DOUBLE(10,3) NOT NULL,
	max_rpm_rating DOUBLE(10,3),
	motor_rating DOUBLE(10,3) NOT NULL,
	drum_size DOUBLE(10,3),
	PRIMARY KEY (tool_id)
);

CREATE TABLE Generator (
	tool_id int(16) unsigned NOT NULL,
	volt_rating DOUBLE(10,3) NOT NULL,
	amp_rating DOUBLE(10,3) NOT NULL,           
	min_rpm_rating DOUBLE(10,3) NOT NULL,
	max_rpm_rating DOUBLE(10,3),
	power_rating DOUBLE(10,3) NOT NULL,
	PRIMARY KEY (tool_id)
);

CREATE TABLE Straight (
	tool_id int(16) unsigned NOT NULL,
    weight_capacity int(5) unsigned,
    step_count int(2) unsigned,
    pail_shelf ENUM('true', 'false'),
	PRIMARY KEY (tool_id)
);

CREATE TABLE Step (
	tool_id int(16) unsigned NOT NULL,
    weight_capacity int(5) unsigned,
    step_count int(2) unsigned,
    rubber_feet ENUM('true', 'false'),
	PRIMARY KEY (tool_id)
);

CREATE TABLE Hammer (
	tool_id int(16) unsigned NOT NULL,
    anti_vibration ENUM('true', 'false'),
	PRIMARY KEY (tool_id)
);

CREATE TABLE Pliers (
	tool_id int(16) unsigned NOT NULL,
    adjustable ENUM('true', 'false'),
	PRIMARY KEY (tool_id)
);

CREATE TABLE Wrench (
	tool_id int(16) unsigned NOT NULL,
	PRIMARY KEY (tool_id)
);
CREATE TABLE Rachet (
	tool_id int(16) unsigned NOT NULL,
	drive_size DOUBLE(10,3) NOT NULL,
	PRIMARY KEY (tool_id)
);

CREATE TABLE Screwdriver (
	tool_id int(16) unsigned NOT NULL,
	screw_size int(2) unsigned NOT NULL,
	PRIMARY KEY (tool_id)
);

CREATE TABLE Socket(
    tool_id int(16) UNSIGNED ,
    sae_size DOUBLE(10,3) NOT NULL,
    drive_size DOUBLE(10,3) NOT NULL,
    PRIMARY KEY (tool_id)
); 

CREATE TABLE Gun (
    tool_id int(16) unsigned,
    gauge_rating integer(10) NOT NULL,
    capacity integer(10) NOT NULL,
    PRIMARY KEY (tool_id)
); 

CREATE TABLE Digger (
    tool_id int(16) unsigned NOT NULL,
    handle_material varchar(25),
    blade_length DOUBLE(10,3) NOT NULL,
    blade_width DOUBLE(10,3),
    PRIMARY KEY (tool_id)
);

CREATE TABLE Pruner (
    tool_id int(16) unsigned NOT NULL,
    handle_material varchar(25),
    blade_length DOUBLE(10,3) NOT NULL,
    blade_material varchar(25),
    PRIMARY KEY (tool_id)
);

CREATE TABLE Rake (
    tool_id int(16) unsigned NOT NULL,
    handle_material varchar(25),
    tine_count integer(10) NOT NULL,
    PRIMARY KEY (tool_id)
);

CREATE TABLE Wheelbarrow (
    tool_id int(16) unsigned NOT NULL,
    handle_material varchar(25) NOT NULL,
    bin_material varchar(25) NOT NULL,
    bin_volume float(5,2),
    wheel_count int(1) NOT NULL,
	PRIMARY KEY (tool_id)
);

CREATE TABLE Striking (
	tool_id int(16) unsigned NOT NULL,
	handle_material varchar(25) NOT NULL,
	head_weight double (10,3) NOT NULL,
	PRIMARY KEY (tool_id)
);

CREATE TABLE Accessory (
	tool_id int(16) unsigned NOT NULL,
	accessory_id int(16) unsigned NOT NULL AUTO_INCREMENT,
	accessory_description varchar(50) NOT NULL,
	PRIMARY KEY (accessory_id, tool_id)
);

CREATE TABLE RepairRecord (
	repair_id int(16) unsigned NOT NULL AUTO_INCREMENT,
	tool_id int(16) unsigned NOT NULL,
	service_cost DOUBLE(10,2) NOT NULL,
	start_date datetime NOT NULL,
	end_date datetime NOT NULL,
	employee_id int(16) unsigned NOT NULL,
    UNIQUE KEY (repair_id),
    UNIQUE KEY (tool_id),
	PRIMARY KEY (employee_id, repair_id)
);

CREATE TABLE Reservation (
  	reservation_id int(16) unsigned NOT NULL AUTO_INCREMENT,
 	start_date datetime NOT NULL,
 	end_date datetime NOT NULL,
  	pickup_clerk_id int(16) unsigned,
	dropoff_clerk_id int(16) unsigned,
  	customer_username varchar(30) NOT NULL,
  	PRIMARY KEY (reservation_id)
);

CREATE TABLE ReservationContains (
    	reservation_id int(16) unsigned NOT NULL,
    	tool_id int(16) unsigned NOT NULL,
    	PRIMARY KEY(reservation_id, tool_id)
);

CREATE TABLE SaleOrder (
	tool_id int(16) unsigned NOT NULL,
	purchase_transaction_id int(16) NOT NULL,
	purchase_date datetime NOT NULL,
	purchased_by_customer_id int(16) unsigned NOT NULL,
    	PRIMARY KEY(tool_id,purchase_transaction_id)
        );


-- Constraints   Foreign Keys: fk_ChildTable_ParentTable_ParentColumn

ALTER TABLE Saw
	ADD CONSTRAINT fk_saw_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id); 

ALTER TABLE Drill
	ADD CONSTRAINT fk_drill_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id); 

ALTER TABLE Sander
	ADD CONSTRAINT fk_sander_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id); 

ALTER TABLE Air_Compressor
	ADD CONSTRAINT fk_air_compressor_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Mixer
	ADD CONSTRAINT fk_mixer_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id); 

ALTER TABLE Generator
	ADD CONSTRAINT fk_generator_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Straight
	ADD CONSTRAINT fk_straight_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Step
	ADD CONSTRAINT fk_step_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Hammer
	ADD CONSTRAINT fk_hammer_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Pliers
	ADD CONSTRAINT fk_pliers_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Wrench
	ADD CONSTRAINT fk_wrench_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Rachet
	ADD CONSTRAINT fk_rachet_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Screwdriver
	ADD CONSTRAINT fk_screwdriver_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Socket
	ADD CONSTRAINT fk_socket_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Gun
	ADD CONSTRAINT fk_gun_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Digger
	ADD CONSTRAINT fk_digger_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Pruner
	ADD CONSTRAINT fk_pruner_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Rake
	ADD CONSTRAINT fk_rake_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Wheelbarrow
	ADD CONSTRAINT fk_wheelbarrow_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Striking
	ADD CONSTRAINT fk_striking_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE Accessory
	ADD CONSTRAINT fk_accessory_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id);

ALTER TABLE RepairRecord
	ADD CONSTRAINT fk_repairrecord_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id),
	ADD CONSTRAINT fk_repairrecord_employee_id FOREIGN KEY (employee_id) REFERENCES Clerk (employee_id);
    
ALTER TABLE PhoneNumber
	ADD CONSTRAINT fk_phonenumber_customer_username FOREIGN KEY (username) REFERENCES Customer (username);

ALTER TABLE Reservation
	ADD CONSTRAINT fk_reservation_pickup_clerk_employee_id FOREIGN KEY (pickup_clerk_id) REFERENCES Clerk (employee_id),
	ADD CONSTRAINT fk_reservation_dropoff_clerk_employee_id FOREIGN KEY (dropoff_clerk_id) REFERENCES Clerk (employee_id),
	ADD CONSTRAINT fk_reservation_customer_username FOREIGN KEY (customer_username) REFERENCES Customer (username);

ALTER TABLE ReservationContains
	ADD CONSTRAINT fk_reservationcontains_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id),
	ADD CONSTRAINT fk_reservationcontains_reservation_id FOREIGN KEY (reservation_id) REFERENCES Reservation (reservation_id);

ALTER TABLE SaleOrder
	ADD CONSTRAINT fk_saleorder_tool_tool_id FOREIGN KEY (tool_id) REFERENCES Tool (tool_id),
	ADD CONSTRAINT fk_saleorder_customer_customer_id FOREIGN KEY (purchased_by_customer_id) REFERENCES Customer (customer_id);

