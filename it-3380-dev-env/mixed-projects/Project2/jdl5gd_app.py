import mysql.connector


def get_employees_per_country(mycursor):
    all_query = 'SELECT * FROM EmployeesPerCountry WHERE country_name = "United Kingdom";'
    print("Enter country name for specific country or (All) to view all countries: ")
    user_input = (input("Enter Choice: "))
    if(user_input == "All"):
        mycursor.execute(all_query)
    else:
        sql_query = 'SELECT * FROM EmployeesPerCountry WHERE country_name = "{userInput}";'
        mycursor.execute(sql_query)
        
    query_result = mycursor.fetchall()
    print("\n-----------Employees By Country-------------\n")
    for record in query_result:
        print(f"Number of Employees: {record[0]}")
        print(f"Country Name: {record[1]}\n")

    return

def get_all_managers(mycursor):
    sql_query = "SELECT department_name, COUNT(Name) AS 'Number of Managers FROM managers GROUP BY d.department_name ORDER BY COUNT(Name) DESC;"
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    print("\n----------Managers by department--------------\n")
    for record in query_result:
        print(f"Department Name: {record[0]}")
        print(f"Number of Managers: {record[1]}\n")

    return

def get_dependents_by_job_title(mycursor):
    sql_query = "SELECT * FROM DependentsByJobTitle WHERE `Number of Dependents` = (SELECT MAX(`Number of Dependents`) FROM DependentsByJobTitle);"
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    print("\n-----------Dependents By Job Title-------------\n")
    for record in query_result:
        print(f"Job Title: {record[0]}")
        print(f"Number of Dependents: {record[1]}\n")

    return

def get_department_hires_by_year(mycursor):
    sql_query = "SELECT * FROM DepartmentHiresByYear WHERE YEAR = 1998;"
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    print("\n-----------Employees By Country-------------\n")
    for record in query_result:
        print(f"Year: {record[0]}")
        print(f"Department Name: {record[1]}")
        print(f"Employees Hired: {record[2]}\n")

    return

def get_avg_salary_by_job_title(mycursor):
    sql_query = "SELECT * FROM AvgSalaryByJobTitle WHERE job_title = 'Programmer';"
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    print("\n-----------Salary By Job Title-------------\n")
    for record in query_result:
        print(f"Job Title: {record[0]}")
        print(f"Average Salary: {record[1]}")
        print(f"Number Of Employees: {record[2]}\n")

    return

def get_avg_salary_by_department(mycursor):
    sql_query = "SELECT * FROM AvgSalaryByDepartment WHERE department_name = 'Purchasing';"
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    print("\n-----------Salary By Department-------------\n")
    for record in query_result:
        print(f"Department Name: {record[0]}")
        print(f"Average Salary: {record[1]}")
        print(f"Number Of Employees: {record[2]}\n")

    return

def get_employee_dependents(mycursor):
    sql_query = "SELECT * FROM EmployeeDependents WHERE num_dependents = 0;"
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    print("\n-----------Employee Dependents-------------\n")
    for record in query_result:
        print(f"First Name: {record[0]}")
        print(f"Last Name: {record[1]}")
        print(f"Phone Number: {record[2]}")
        print(f"Email: {record[3]}")
        print(f"Number Of Dependents: {record[4]}\n")

    return

def get_location_by_region(mycursor):
    sql_query = "SELECT * FROM CountryLocation"
    mycursor.execute(sql_query)
    query_result = mycursor.fetchall()
    print("\n-----------Region Locations-------------\n")
    for record in query_result:
        print(f"Region Name: {record[0]}")
        print(f"Number Of Locations: {record[1]}\n")

    return

def print_menu():
    print("Choose an option")
    print("------------VIEW DATA -----------")
    print("1. Show Employees Per Country")
    print("2. Show All Managers By Deparment Name")
    print("3. Show Dependents By Job Title")
    print("4. Show Department Hires By Year")
    print("5. Show Average Salary By Job Title")
    print("6. Show Average Salary By Depepartment")
    print("7. Show Employee Dependents")
    print("8. Show Country Location By Region")
    print("17. Exit Application")
    return

def get_user_choice():
    print_menu()
    while(True):
        try:
            the_choice = int(input("Enter Choice: "))
            if(the_choice < 1 or the_choice > 17):
                print(f"Invalid input: Enter a value between 1 and 17.\n")
                continue
            break
        except Exception as err:
            print(f"An error has occured: {err}\n")
            continue

    return the_choice


def main():
#create a connector object
    try:
        mydb = mysql.connector.connect(
            host="mysql-container",
            user="root",
            passwd="root",
            database="project2"
        )
        print("Successfully connected to the database!")
    except Exception as err:
        print(f"Error Occured: {err}\nExiting program...")
        quit()

    #create database cursor
    mycursor = mydb.cursor()

    while(True):
        user_choice = get_user_choice()
        if(user_choice == 1):
            #call the function to query the managers
            get_employees_per_country(mycursor)
        elif(user_choice == 2):
            get_all_managers(mycursor)
        elif(user_choice == 3):
            get_dependents_by_job_title(mycursor)
        elif(user_choice == 4):
            get_department_hires_by_year(mycursor)
        elif(user_choice == 5):
            get_avg_salary_by_job_title(mycursor)
        elif(user_choice == 6):
            get_avg_salary_by_department(mycursor)
        elif(user_choice == 7):
            get_employee_dependents(mycursor)
        elif(user_choice == 8):
            get_location_by_region(mycursor)
        elif(user_choice == 9):
            print("Bye Bye!!!")
            break

main()
    

