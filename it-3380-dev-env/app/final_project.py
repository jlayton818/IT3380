
import mysql.connector

# #1
def get_employees_per_country(mycursor):
    all_query = 'SELECT * FROM EmployeesPerCountry'
    user_input = input("Enter country name for specific country or (All) to view all countries: ")
    specific_query = f'SELECT * FROM EmployeesPerCountry WHERE country_name = "{user_input}";'
    if(user_input == "All"):
        mycursor.execute(all_query)
    else:
        mycursor.execute(specific_query)

    result = mycursor.fetchall()
    print("\n-----------Employees By Country-------------\n")
    if(mycursor.rowcount == 0):
        print(f"There are no employees in {user_input} \n")
    for record in result:
        print(f"Number of Employees: {record[0]} - Country Name: {record[1]}")
    return
# #2
def get_all_managers(mycursor):
    user_input = input("Enter department name for specific department of (All) to view all departments: ")
    all_query = "SELECT department_name, COUNT(Name) AS 'Number of Managers' FROM managers GROUP BY d.department_name ORDER BY COUNT(Name) DESC;"
    specific_query = f'SELECT department_name, COUNT(Name) AS "Number of Managers" FROM managers WHERE department_name = "{user_input}" GROUP BY d.department_name ORDER BY COUNT(Name) DESC;'
    if(user_input == "All"):
        mycursor.execute(all_query)
    else:
        mycursor.execute(specific_query)
    query_result = mycursor.fetchall()
    print("\n----------Managers by department--------------\n")
    if(mycursor.rowcount == 0):
        print(f"There are no managers in the {user_input} department\n")
    for record in query_result:
        print(f"{record[0]} - Number of Managers: {record[1]}")      
    return
# #3
def get_dependents_by_job_title(mycursor):
    user_input = input("Enter job title or (All) to view all job titles: ")
    all_query = "SELECT * FROM DependentsByJobTitle ORDER BY `Number of Dependents` DESC"
    specific_query = f"SELECT * FROM DependentsByJobTitle WHERE job_title = '{user_input}';"
    if(user_input == "All"):
        mycursor.execute(all_query)
    else:
        mycursor.execute(specific_query)
    query_result = mycursor.fetchall()
    print("\n-----------Dependents By Job Title-------------\n")
    if(mycursor.rowcount == 0):
        print(f"There are no job titles with the title : {user_input} \n")
    for record in query_result:
        print(f"{record[0]} - Number of Dependents: {record[1]} ")
    return
#4
def get_department_hires_by_year(mycursor):
    all_query = "SELECT * FROM DepartmentHiresByYear;"
    while(True):
        try:
            user_input = input("Enter year or (All) to view hiring data for all years in departments: ")
            if(user_input == "All"):
                mycursor.execute(all_query)
                break
            else:
                year = int(user_input)
                specific_query = f"SELECT * FROM DepartmentHiresByYear WHERE YEAR = {year};"
                mycursor.execute(specific_query)
                break
        except ValueError:
            print("Please enter a number")
            continue
        else:
            break
    query_result = mycursor.fetchall()
    print("\n-----------Hires Per Year-------------\n")
    if(mycursor.rowcount == 0):
        print(f"There are no entries with the year {user_input} \n")
    for record in query_result:
        print(f"Year: {record[0]} - Department Name: {record[1]} - Employees Hired: {record[2]}")
    return
#5
def get_avg_salary_by_job_title(mycursor):
    user_input = input("Enter job title or (All) to view average salary for all job titles: ")
    all_query = "SELECT * FROM AvgSalaryByJobTitle;"
    specific_query = f"SELECT * FROM AvgSalaryByJobTitle WHERE job_title = '{user_input}';"
    if(user_input == "All"):
        mycursor.execute(all_query)
    else:
        mycursor.execute(specific_query)
    query_result = mycursor.fetchall()
    print("\n-----------Salary By Job Title-------------\n")
    if(mycursor.rowcount == 0):
        print(f"There are no job titles with the title: {user_input} \n")
    for record in query_result:
        print(f"{record[0]} - Average Salary: {record[1]} - Number Of Employees: {record[2]}")
    return
#6 
def get_avg_salary_by_department(mycursor):
    user_input = input("Enter department name or (All) to view average salary for all departments: ")
    all_query = "SELECT * FROM AvgSalaryByDepartment;"
    specific_query = f"SELECT * FROM AvgSalaryByDepartment WHERE department_name = '{user_input}';"
    sql_query = "SELECT * FROM AvgSalaryByDepartment WHERE department_name = 'Purchasing';"
    if(user_input == "All"):
        mycursor.execute(all_query)
    else:
        mycursor.execute(specific_query)
    query_result = mycursor.fetchall()
    print("\n-----------Salary By Department-------------\n")
    if(mycursor.rowcount == 0):
        print(f"There are no job titles with the title: {user_input} \n")
    for record in query_result:
        print(f"{record[0]} - Average Salary: {record[1]}")
    return
#7
def get_employee_dependents(mycursor):
    user_input = input("Enter employee first name and last name or (All) to view number of dependents for all employees: ")
    all_query = "SELECT * FROM EmployeeDependents;"
    specific_query = f"SELECT * FROM EmployeeDependents WHERE `Name` = '{user_input}';"
    if(user_input == "All"):
        mycursor.execute(all_query)
    else:
        mycursor.execute(specific_query)
    query_result = mycursor.fetchall()
    print("\n-----------Employee Dependents-------------\n")
    for record in query_result:
        print(f"{record[0]} - Number Of Dependents: {record[3]}")
    return
#8
def get_location_by_region(mycursor):
    user_input = input("Enter region or (All) to show number of locations per region: ")
    all_query = "SELECT * FROM CountryLocation;"
    specific_query = f"SELECT * FROM CountryLocation WHERE region_name = '{user_input}';"
    if(user_input == "All"):
        mycursor.execute(all_query)
    else:
        mycursor.execute(specific_query)
    query_result = mycursor.fetchall()
    print("\n-----------Region Locations-------------\n")
    for record in query_result:
        print(f"Region Name: {record[0]} Number Of Locations: {record[1]}")
    return
#9
def add_a_dependent(mycursor, mydb):
    while(True):
        first_name = input("Enter dependent first name: ")
        last_name = input("Enter dependent last name: ")
        relationship = input("Enter relationship: ")
        employee_id = input("Enter employee id: ")
        insert_query = f"INSERT INTO dependents(first_name, last_name, relationship, employee_id) VALUES ('{first_name}', '{last_name}', '{relationship}', {employee_id});"
        try: 
            #execute the query
            mycursor.execute(insert_query)
            #commit the changes to the database
            mydb.commit()
            #print a success message
            print(f"\nSuccess: {mycursor.rowcount} dependent added")
            break
        except mysql.connector.Error as error:
            #print the error message that the insert failed
            print(f"\nInsert Failed. \nError: {error.msg}\n")
            continue
    return
#10
def add_a_job(mycursor, mydb):
    while(True):
        new_job_title = input("Enter job title: ")
        min_salary = input("Enter minimum salary: ")
        max_salary = input("Enter maximum salary: ")
        insert_query = f"INSERT INTO jobs(job_title, min_salary, max_salary) VALUES ('{new_job_title}', {min_salary}, {max_salary});"
        try: 
            #execute the query
            mycursor.execute(insert_query)
            #commit the changes to the database
            mydb.commit()
            #print a success message
            print(f"\nSuccess: {mycursor.rowcount} job added")
            break
        except mysql.connector.Error as error:
            #print the error message that the insert failed
            print(f"\nInsert Failed. \nError: {error.msg}")
            continue
            return
    return
#11
def delete_dependent(mycursor, mydb):
    while(True):
        dependent_id = input("Enter dependent ID: ")
        delete_query = f"DELETE FROM dependents where dependent_id = {dependent_id};"
        try: 
            #execute the query
            mycursor.execute(delete_query)
            print("test")
            #commit the changes to the database
            mydb.commit()

            if(mycursor.rowcount == 0):
                print(f"Error : Dependent ID {dependent_id} Does Not Exist\n")
                continue
            #print a success message
            print(f"\nSuccess: {mycursor.rowcount} dependent deleted")
            break
        except mysql.connector.Error as error:
            #print the error message that the insert failed
            print(f"\nDeletion Failed. \nError: {error.msg}")
            return
    return
#12
def delete_job(mycursor, mydb):
    while(True):
        job_id = input("Enter job_id: ")
        delete_query = f"DELETE FROM jobs WHERE job_id = {job_id}"
        try: 
            #execute the query
            mycursor.execute(delete_query)
            #commit the changes to the database
            mydb.commit()
            if(mycursor.rowcount == 0):
                print(f"Error: Job ID {job_id} Does Not Exist\n")
                continue
            #print a success message
            print(f"\nSuccess: {mycursor.rowcount} job deleted")
        except mysql.connector.Error as error:
            #print the error message that the insert failed
            print(f"\nDeletion Failed. \nError: {error.msg}")
            return
        return
#13
def update_employee_first_name(mycursor, mydb):
    while(True):
        employee_id = input("Enter employee ID to be updated: ") 
        first_name = input("Enter employee's new first name: ")
        update_query = f"UPDATE employees SET first_name = '{first_name}' WHERE employee_id = {employee_id};"
        try: 
            #execute the query
            mycursor.execute(update_query)
            #commit the changes to the database
            mydb.commit()
            if(mycursor.rowcount == 0):
                    print(f"Error: Job ID {employee_id} Does Not Exist\n")
                    continue
            #print a success message
            print(f"\nSuccess: {mycursor.rowcount} record was updated")
            print(f"\nEmployee with id {employee_id} first name was updated to {first_name}.")
        except mysql.connector.Error as error:
            #print the error message that the insert failed
            print(f"\nEmployee with id {employee_id} name failed to update. \nError: {error.msg}")
            return
        return

#14
def update_employee_last_name(mycursor, mydb):
    while(True):
        employee_id = input("Enter employee ID to be updated: ") 
        last_name = input("Enter employee's new last name: ")  
        update_query = f"UPDATE employees SET last_name = '{last_name}' WHERE employee_id = {employee_id};"
        try: 
            #execute the query
            mycursor.execute(update_query)
            #commit the changes to the database
            mydb.commit()
            if(mycursor.rowcount == 0):
                print(f"Error: Job ID {employee_id} Does Not Exist\n")
                continue
            #print a success message
            print(f"\nSuccess: {mycursor.rowcount} record was updated")
            print(f"\nEmployee with id {employee_id} last name was updated to {last_name}.")
        except mysql.connector.Error as error:
            #print the error message that the insert failed
            print(f"\nEmployee with id {employee_id} failed to update. \nError: {error.msg}")
            return
        return

#15 
def update_minimum_salary(mycursor, mydb):
    while(True):
        job_id = input("Enter job ID to be updated: ")
        while(True):
            try:
                min_salary = int(input("Enter job's new minimum salary: "))
                if(min_salary < 1):
                    print("Please enter a number greater than 0")
                    continue
            except ValueError:
                print("please enter a number")
                continue
            else:
                break
        update_query = f"UPDATE jobs SET min_salary = {min_salary} WHERE job_id = {job_id};"
        try: 
            #execute the query
            mycursor.execute(update_query)
            #commit the changes to the database
            mydb.commit()
            #print a success message
            print(f"\nSuccess: {mycursor.rowcount} record was updated")
            print(f"\nEmployee with id {job_id} salary was updated.")
        except mysql.connector.Error as error:
            #print the error message that the insert failed
            print(f"\nEmployee with id {job_id} salary failed to update. \nError: {error.msg}")
            return
        return

#16
def update_maximum_salary(mycursor, mydb):
    while(True):
        job_id = input("Enter job ID to be updated: ")
        while(True):
            try:
                max_salary = int(input("Enter job's new maximum salary: "))
                if(max_salary < 1):
                    print("Please enter a number greater than 0")
                    continue
            except ValueError:
                print("please enter a number")
                continue
            else:
                break
        update_query = f"UPDATE jobs SET max_salary = {max_salary} WHERE job_id = {job_id};"
        try: 
            #execute the query
            mycursor.execute(update_query)
            #commit the changes to the database
            mydb.commit()
            #print a success message
            print(f"\nSuccess: {mycursor.rowcount} record was updated")
            print(f"\nEmployee with id {job_id} salary was updated.")
        except mysql.connector.Error as error:
            #print the error message that the insert failed
            print(f"\nEmployee with id {job_id} salary failed was update. \nError: {error.msg}")
            return
        return

def print_menu():
    print("\nChoose an option")
    print("------------ VIEW DATA -----------")
    print("1. Show Employees Per Country")
    print("2. Show All Managers By Deparment Name")
    print("3. Show Dependents By Job Title")
    print("4. Show Department Hires By Year")
    print("5. Show Average Salary By Job Title")
    print("6. Show Average Salary By Depepartment")
    print("7. Show Employee Dependents")
    print("8. Show Country Location By Region")
    print("\n------------ ADD DATA -----------")
    print("9. Add a Dependent")
    print("10. Add a Job")
    print("\n------------ DELETE DATA -----------")
    print("11. Delete a Dependent")
    print("12. Delete a Job")
    print("\n------------ UPDATE DATA -----------")
    print("13. Update Employee First Name")
    print("14. Update Employee Last Name")
    print("15. Update Job Minimum Salary")
    print("16. Update Job Maximum Salary")
    print("\n------------ EXIT -----------")
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
            add_a_dependent(mycursor, mydb)
        elif(user_choice == 10):
            add_a_job(mycursor, mydb)
        elif(user_choice == 11):
            delete_dependent(mycursor, mydb)
        elif(user_choice == 12):
            delete_job(mycursor,mydb)
        elif(user_choice == 13):
            update_employee_first_name(mycursor, mydb)
        elif(user_choice == 14):
            update_employee_last_name(mycursor, mydb)
        elif(user_choice == 15):
            update_minimum_salary(mycursor, mydb)
        elif(user_choice == 16):
            update_maximum_salary(mycursor, mydb)
        elif(user_choice == 17):
            print("Bye Bye!!!")
            break

main()
    

