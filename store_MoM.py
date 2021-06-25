import os
import mysql.connector

mydb=mysql.connector.connect(
  host="localhost",
  user="dhanush",
  password="password",
  database="store_MoMs"
)
mycursor=mydb.cursor()

#Checking whether already databse exit or not, else creating a databse named store_MoMs
mycursor.execute("CREATE DATABASE IF NOT EXISTS store_MoMs")

#Checking whether Table names store_MoMs exits or not, else creating one
mycursor.execute("SHOW TABLES")
if "store_MoMs" not in mycursor:
  mycursor.execute("CREATE TABLE store_MoMs (name VARCHAR(255), dates VARCHAR(255), content TEXT)")


os.chdir('/home')
files=os.listdir('/home')

#Inserting values into the table
for f in files:
	dir='/home/'+str(f)
	os.chdir(dir)
	text_files=os.listdir(dir)
	for i in text_files:
		if "_mom.txt" in i:
			uname=str(f)
			date=i[:10]
			with open(i) as mom_file:
				contents=mom_file.read().split('\n')
			sql="INSERT INTO store_MoMs (name, dates, content) VALUES (%s, %s, %s)"
			val=(uname, date, contents[0])
			mycursor.execute(sql, val)
			mydb.commit()
	os.chdir('/home')


mydb.close()

