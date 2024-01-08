#Create a simple app that connects to a mysql database. This is cool
#Import mysql module 
import mysql.connector

#create connection object to the database
mydb = mysql.connector.connect(
    host = "mysql-container",
    user = "root",
    passwd = "root",
    database = "module2"
)
    
#create a cursor to execute queries
my_cursor = mydb.cursor()

#create a query 
sql_query = "SELECT * FROM agents;"

#execute the query
my_cursor.execute(sql_query)

#get the results from the query
query_result = my_cursor.fetchall()

for record in query_result:
    print(f"Name: {record[1]} - Code: {record[0]} ")
    print(f"Working Area: {record[2]} - Phone : {record[4]}")
    print("--------------------------\n")

print("\n ----------------Insert Query----------------\n")
insert_query = "INSERT INTO agents VALUES ('A014', 'Test Agent2', 'Mizzou', '0.15', '573-555-5555', 'USA')"

try: 
    #execute the query
    my_cursor.execute(insert_query)
    #commit the changes to the database
    mydb.commit()
    #print a success message
    print(f"\nSuccess: {my_cursor.rowcount} agent added")
    
except mysql.connector.Error as error:
    #print the error message that the insert failed
    print(f"\nInsert Failed. \nError: {error.msg}")

print("\n ----------------Delete Query----------------\n")
delete_query = "DELETE FROM agents WHERE AGENT_CODE = 'A013';"

try:
    #execute the query
    my_cursor.execute(delete_query)
    #commit the changes to the database
    mydb.commit()
    #print a success message
    print(f"\nSuccess: {my_cursor.rowcount} agent deleted")
except mysql.connector.Error as error:
    print(f"\nFailed to delete agent from table agents. \nError: {error.msg}")