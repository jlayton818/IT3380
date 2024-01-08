//use unwind function to unwind on the payment field for a customer 
db.customers.aggregate([
    { $match: { "customerName": "Toys4GrownUps.com" } }
]).pretty()

db.customers.aggregate([
    { $unwind: "$payments" },
    { $match: { "customerName": "Toys4GrownUps.com" } }
]).pretty()

//Count the numbers of payments from Toys4GrownUps.com
db.customers.aggregate([
        { $unwind: "$payments" },
        { $match: { "customerName": "Toys4GrownUps.com" } },
        { $count: "Number of Payments" }
    ])
    //Count the number of payments for all customers
db.customers.aggregate([
    { $unwind: "$payments" },
    { $count: "Number of Payments (All customers)" }
])

//Calculate the dollar value of payments made by Toys4GrownUps.com
db.customers.aggregate([
    { $unwind: "$payments" },
    { $match: { "customerName": "Toys4GrownUps.com" } },
    { $group: { _id: "$customerName", totalPayments: { $sum: "$payments.amount" } } }
])

//Calculate the dollar value of payments made by each customer
db.customers.aggregate([
    { $unwind: "$payments" },
    { $group: { _id: "$customerName", totalPayments: { $sum: "$payments.amount" } } }
])

//Calculate the dollar value of payments, number of payments and average payment for each customer
//Return all values in the same document
db.customers.aggregate([
    { $unwind: "$payments" },
    {
        $group: {
            _id: "$customerName",
            totalPayments: { $sum: "$payments.amount" },
            numberOfPayments: { $sum: 1 },
            averagePayment: { $avg: "$payments.amount" }
        }
    }
]).pretty()

//Calculate the dollar value of payments, number of payments and average payment for each customer
//Return all values in the same document. Include the sales rep name.
db.customers.aggregate([
    { $unwind: "$payments" },
    {
        $group: {
            _id: "$customerName",
            totalPayments: { $sum: "$payments.amount" },
            numberOfPayments: { $sum: 1 },
            averagePayment: { $avg: "$payments.amount" },
            salesRep: {
                $addToSet: "$salesRep"
            }
        }
    }
]).pretty()

//same as above but only return customers who have made 5 or more payments
db.customers.aggregate([
    { $unwind: "$payments" },
    {
        $group: {
            _id: "$customerName",
            totalPayments: { $sum: "$payments.amount" },
            numberOfPayments: { $sum: 1 },
            averagePayment: { $avg: "$payments.amount" },
            salesRep: { $addToSet: "$salesRep" }
        }
    },
    { $match: { numberOfPayments: { $gte: 5 } } }
]).pretty()

//count the numbers of employees in the USA
db.employees.aggregate([
    { $match: { "office.country": "USA" } },
    { $count: "Number of USA Employees" }
])

//Date Functions
//get orders made in 2003
db.orders.aggregate([
    { $addFields: { "year": { $year: "$orderDate" }, "month": { $month: "$orderDate" }, "day": { $dayOfMonth: "$orderDate" } } },
    { $match: { "year": 2003 } }
]).pretty()

//How many orders were placed in 2003
db.orders.aggregate([
    { $addFields: { "year": { $year: "$orderDate" }, "month": { $month: "$orderDate" }, "day": { $dayOfMonth: "$orderDate" } } },
    { $match: { "year": 2003 } },
    { $count: "Number of Orders In 2003" }
]).pretty()

//How many orders were placed in November 2003
db.orders.aggregate([
    { $addFields: { "year": { $year: "$orderDate" }, "month": { $month: "$orderDate" }, "day": { $dayOfMonth: "$orderDate" } } },
    { $match: { "year": 2003, "month": 11 }, },
    { $count: "Number of Orders In November 2003" }
]).pretty()