//1a. Write a query to create a view named "custByCity" to get a count of how many customers there are in each city.
db.createView(
    "custByCity",
    "customers", [
        { $group: { _id: "$city", TotalPopulation: { $sum: 1 } } },
        { $project: { _id: 1, TotalPopulation: 1 } },
        { $sort: { TotalPopulation: -1 } }
    ]
)
db.customers.aggregate([
    { $group: { _id: "$city", TotalPopulation: { $sum: 1 } } },
    { $project: { _id: 1, TotalPopulation: 1 } },
    { $sort: { TotalPopulation: -1 } }
])

//1b. Query the custByCity view to show the number of customers in Singapore.
db.custByCity.aggregate([
    { $match: { _id: "Singapore" } }
])

//2a. Write a query to create a view named "paymentsByMonth" that calculates payments per month. You will have to group by multiple columns for this query: 
//month and year because payments from January 2004 and January 2005 should not be grouped together. Remember the SQL month() and year() functions.

db.createView(
    "paymentsByMonth",
    "customers", [
        { $unwind: "$payments" },
        { $group: { _id: { year: { $year: "$payments.paymentDate" }, month: { $month: "$payments.paymentDate" } }, totalPayments: { $sum: "$payments.amount" } } },
        { $project: { _id: 1, totalPayments: 1 } },
        { $sort: { _id: 1 } }
    ]
)
db.customers.aggregate([
    { $unwind: "$payments" },
    { $group: { _id: { year: { $year: "$payments.paymentDate" }, month: { $month: "$payments.paymentDate" } }, totalPayments: { $sum: "$payments.amount" } } },
    { $project: { _id: 1, totalPayments: 1 } },
    { $sort: { _id: 1 } }
])

//2b. Query the paymentsByMonth view to show payments in November 2004
db.paymentsByMonth.aggregate([
    { $match: { _id: { year: 2004, month: 11 } } }
])

//3a. Write a query to create a view named "orderTotalsByMonth" to calculate order totals (in dollars) per month.
db.createView(
    "orderTotalsByMonth",
    "orders", [
        { $unwind: "$orderDetails" },
        { $group: { _id: { year: { $year: "$orderDate" }, month: { $month: "$orderDate" } }, orderTotal: { $sum: { $multiply: ["$orderDetails.quantityOrdered", "$orderDetails.priceEach"] } } } },
        { $project: { _id: 1, orderTotal: 1 } },
        { $sort: { _id: 1 } }
    ]
)
db.orders.aggregate([
    { $unwind: "$orderDetails" },
    { $group: { _id: { year: { $year: "$orderDate" }, month: { $month: "$orderDate" } }, orderTotal: { $sum: { $multiply: ["$orderDetails.quantityOrdered", "$orderDetails.priceEach"] } } } },
    { $project: { _id: 1, orderTotal: 1 } },
    { $sort: { _id: 1 } }
])

//3b. Query the orderTotalsByMonth view to show the order total in August 2004.

db.orderTotalsByMonth.aggregate([
    { $match: { _id: { year: 2004, month: 8 } } }
])

//4a. Write a query to create a view named "productSalesYear" that calculates sales per product per year. Include the product name, sales total, and year.
db.createView(
    "productSalesYear",
    "orders", [
        { $unwind: "$orderDetails" },
        { $group: { _id: { productName: "$orderDetails.productName", year: { $year: "$orderDate" } }, orderTotal: { $sum: { $multiply: ["$orderDetails.quantityOrdered", "$orderDetails.priceEach"] } } } },
        { $sort: { _id: 1 } }
    ]
)


db.orders.aggregate([
    { $unwind: "$orderDetails" },
    { $group: { _id: { productName: "$orderDetails.productName", year: { $year: "$orderDate" } }, orderTotal: { $sum: { $multiply: ["$orderDetails.quantityOrdered", "$orderDetails.priceEach"] } } } },
    { $sort: { _id: 1 } }
])

//4b. Query the productSalesYear view to show the sales per year for the "2001 Ferrari Enzo"
db.productSalesYear.aggregate([
    { $match: { "_id.productName": "2001 Ferrari Enzo" } }
])

//5a. Write a query to create a view named "orderTotals" that displays the order total for each order. Include order number, customer name, and total.
db.createView(
    "orderTotals",
    "orders", [
        { $unwind: "$orderDetails" },
        { $addFields: { orderNumber: "$_id" } },
        { $group: { _id: "$customerName", orderNumber: { $addToSet: "$orderNumber" }, orderTotal: { $sum: { $multiply: ["$orderDetails.quantityOrdered", "$orderDetails.priceEach"] } } } },
        { $project: { _id: 1, orderNumber: 1, orderTotal: 1 } }
    ]
)

db.orders.aggregate([
    { $unwind: "$orderDetails" },
    { $addFields: { orderNumber: "$_id" } },
    { $group: { _id: "$customerName", orderNumber: { $addToSet: "$orderNumber" }, orderTotal: { $sum: { $multiply: ["$orderDetails.quantityOrdered", "$orderDetails.priceEach"] } } } },
    { $project: { _id: 1, orderNumber: 1, orderTotal: 1 } }
])

//5b Query the orderTotals view to select the top 15 orders.

db.orderTotals.aggregate([
    { $sort: { orderTotal: -1 } },
    { $limit: 15 }
])