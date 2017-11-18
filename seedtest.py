from flask import Flask, render_template, json, request
from flaskext.mysql import MySQL
import random

num_clerks = 5
num_customers = 20
num_tools = 15
num_res = 5

app = Flask(__name__)
mysql = MySQL()
 
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'admin'
app.config['MYSQL_DATABASE_PASSWORD'] = 'admin'
app.config['MYSQL_DATABASE_DB'] = 'cs6400_fa17_team032'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

conn = mysql.connect()
cur =conn.cursor()


try:
	error_str = ''

	sql_fd = open('team032_p2_schema.sql', 'r')
	sql_file = sql_fd.read()
	sql_cmds = sql_file.split(';')

	for command in sql_cmds:
		try:
			if command.strip() != '':
				command = command +';'
				cur.execute(command)
		except:
			error_str += "\nFailed inserting: {}".format(command)
			print error_str
	conn.commit()
	sql_fd.close()
except:
	print("Failed connecting to database:")


def phn():
	# return 555555555
	n = '0000000000'
	while '9' in n[3:6] or n[3:6]=='000':
		n = str(random.randint(10**9, 10**10-1))
	return  '(' + n[:3] + ') ' + n[3:6] + '-' + n[6:]

def cc():
	# return 1234567
	return str(random.randint(10**11,10**12-1))

def cvv():
	# return 123
	return random.randint(10**2,10**3-1)

def phone_t():
	return random.choice(['HOME', 'WORK', 'CELL'])


clerk_insert = "INSERT INTO Clerk (username, email, first_name, last_name, middle_name, password, date_of_hire) "
clerks = ''
for i in range(1,num_clerks+1):
	clerks += clerk_insert + "VALUES ('clerk{}', 'cerk_email{}', 'clerk_first{}', 'clerk_last{}', 'clerk_middle{}', 'pass{}', '2017-02-06 23:59:59');".format(i,i,i,i,i,i)

customer_insert = "INSERT INTO Customer (username,password,email,address,primary_number,first_name,middle_name,last_name,phone_type,cc_number,cc_name,expire_date,cvv)"
customers = ''
for i in range(1,num_customers+1):
	customers += customer_insert + "VALUES('customer{}','password{}','email{}','address{}','{}','f_name{}','m_name{}','l_name{}','{}','{}','cc_name{}','2017-02-06 23:59:59','{}');".format(i,i,i,i,phn(),i,i,i,phone_t(),cc(),i,cvv())

cur.execute(clerks + customers)
conn.commit()


# Required for all Tools
# original_price
width_diameter = [2,2.5,3,8.5,9,13,22.25]
length = [4,4.375,6.25,8,9,10,11,12,15,20]
weight = [1,2,3,6.6,8.5,10,15,20]
manufacturer = ['DeWalt','Milwaukee', 'Ryobi', 'Makita', 'BOSCH', 'Stanley']


def Screwdriver():
	global category
	global sub_option
	screw_size = random.randint(1,10)
	sub_option = random.choice(["phillips","hex","torx","slotted"])
	category = "'Hand'"
	return ('screw_size', str(screw_size))

def Socket():
	global category
	global sub_option
	drive_size = random.choice([.5,.375,.625])
	sae_size = random.choice([.25,.5])
	sub_option = random.choice(["deep","standard"])
	category = "'Hand'"
	return ('drive_size,sae_size',str(drive_size) +',' + str(sae_size))

def Rachet():
	global category
	global sub_option
	drive_size = random.choice([.5,.375,.625])
	sub_option = random.choice(["adjustable","fixed"])
	category = "'Hand'"
	return ('drive_size',str(drive_size))

def Wrench():
	global category
	global sub_option
	sub_option = random.choice(["crescent","torque","pipe"])
	category = "'Hand'"
#how do we put something in a table that has nothing to put in?

def Pliers():
	global category
	global sub_option
	adjustable = random.choice(["'True'","'False'"])
	category = "'Hand'"
	sub_option = random.choice(["needle nose","cutting","crimper"])
	return ('adjustable', adjustable)

def Gun():
	global category
	global sub_option
	gauge_rating = random.choice([18,20,22,24])
	capacity = random.choice([20,1000,1000])
	category = "'Hand'"
	sub_option = random.choice(["nail","staple"])
	return ('gauge_rating,capacity', str(gauge_rating) + ',' + str(capacity))

def Hammer():
	global category
	global sub_option
	anti_vibration = random.choice(["'True'","'False'"])
	category = "'Hand'"
	sub_option = random.choice(["claw","sledge","framming"])
	return ('anti_vibration',anti_vibration)


# tools = [Screwdriver,Socket,Rachet,Wrench,Pliers,Gun,Hammer]
tools = [Screwdriver,Socket,Rachet,Pliers,Gun,Hammer]


tool_query = ''
sp_tool_query = ''

sub_option = ''
category = ''

def price():
	return str(random.randint(1,101))+".00"

for i in range(0,num_tools):
	tool = random.choice(tools)
	# print tool.__name__
	attr_names, attr_values= tool()

	tool_query = "INSERT INTO Tool(width_diameter,length,weight,manufacturer,original_price,short_description,power_source,category,sub_option) " 
	tool_query += "VALUES("+str(random.choice(width_diameter))+","+str(random.choice(length))+","+str(random.choice(weight))+",'"+random.choice(manufacturer)+"',"+price()+",'" + sub_option +" " + tool.__name__ + "','manual'," + category + ",'" + sub_option + "');"
	# print tool_query 

	cur.execute(tool_query)
	conn.commit()

	cur.execute("SELECT max(tool_id) FROM Tool")
	tool_id = cur.fetchone()

	# print tool_id[0]

	sp_tool_query = "INSERT INTO "
	sp_tool_query += tool.__name__
	attr_names, attr_values= tool()
	sp_tool_query += "(tool_id,"+ attr_names +") VALUES(" + str(tool_id[0]) + "," + attr_values + ");"
	
	# print sp_tool_query

	cur.execute(sp_tool_query)
	conn.commit()
	# print sp_tool_query


#make Reservations
def rand_clerk():
	return random.randint(1,num_clerks)
def rand_cust():
	return random.randint(1,num_customers)

res_dates = ["'2017-9-3 23:59:59','2017-9-5 23:59:59'", "'2017-9-4 23:59:59','2017-9-7 23:59:59'", "'2017-9-8 23:59:59','2017-9-9 23:59:59'", "'2017-10-1 23:59:59','2017-10-3 23:59:59'", "'2017-10-5 23:59:59','2017-10-6 23:59:59'"]
tool_in_res = [[2,3],[7,9,11],[3,10,12],[9,11,3],[1,4,5,6,8]]



for i in range(1,num_res+1):
	res_query = "INSERT INTO Reservation(start_date,end_date,pickup_clerk_id,dropoff_clerk_id,customer_username) "
	res_query += "VALUES(" + res_dates[i-1] + "," + str(rand_clerk()) + "," + str(rand_clerk()) + ",'customer{}".format(rand_cust()) + "')"
	cur.execute(res_query)
	conn.commit()

	for x in tool_in_res[i-1]:
		res_c_query = "INSERT INTO ReservationContains(reservation_id, tool_id)"
		res_c_query += "VALUES(" + str(i) + "," + str(x) + ")"
		cur.execute(res_c_query)
		conn.commit()


