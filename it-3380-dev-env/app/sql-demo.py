#Create a simple app that connects to a mysql database. This is cool
#Import mysql module 
import mysql.connector

#create connection object to the database
mydb = mysql.connector.connect(
    host = "mysql-container",
    user = "root",
    passwd = "root",
    database = "classicmodels"
)
    
#create a cursor to execute queries
my_cursor = mydb.cursor()

#create a query 
sql_query = "SELECT * FROM employees;"

#execute the query
my_cursor.execute(sql_query)

#get the results from the query
query_result = my_cursor.fetchall()

#print results  
for record in query_result:
    print(f"Name: {record[2]} {record[1]}")
    print(f"Email: {record[4]}")
    print(f"Position: {record[7]}")
    print("--------------------------\n")

#Query the customerPayments view
#create the query
sql_query = "SELECT * FROM customerPayments;"

#execute the query
my_cursor.execute(sql_query)

#get the results from the query
query_result = my_cursor.fetchall()

#Print the results
print("\n\n")

for record in query_result:
    print(f"Customer Name: {record[0]}, Check Number: {record[1]}")
    print(f"Payment Amount: {record[3]}, Date: {record[2]}")
    print("-------------------------------------\n")