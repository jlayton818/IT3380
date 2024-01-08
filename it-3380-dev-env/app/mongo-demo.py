# Create a simple app that connects to the mongo database
#import mongo module 
from pydoc import doc
import pymongo

#Connect to the database server
try:
    mongo_client = pymongo.MongoClient(
        host = "mongo-container",
        username = "",
        password = "",
        serverSelectionTimeoutMS = 3000
    )
    print("Successfully connected to the database server")

except Exception as err:
    print(f"Error Occurred : {err} \n Exiting the program")
    quit()

#select the database
classic_db = mongo_client["classicmodels"]

#select a collection 
employee_collection = classic_db["employees"]
customers_collection = classic_db["customers"]
orders_collection = classic_db["orders"]
products_collection = classic_db["products"]

#write and execute a query using the aggregation pipeline
#show total payments (dollar value) made by each customer
aggregation_results = customers_collection.aggregate([
    {"$unwind" : "$payments"},
    {"$group": {"totalPayments": {"$sum": "$payments.amount"}, "_id": "$customerName"}}
])

#print the results
for document in aggregation_results:
    print(f"{document['_id']}: ${round(document['totalPayments'], 2)}")

#query the paymentsByMonth view 
paymentsView = classic_db['paymentsByMonth']

#print the payments for 2004
aggregation_results = paymentsView.aggregate([
    {"$match": {"_id.year": 2004}}
])
monthDict = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
}
print("\nTotal Payments By Month\n---------------")
#print the results
for document in aggregation_results:
    print(f"{document['_id']['month']}: ${document['totalPayments']}")