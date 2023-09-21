//List the 10 most expensive stockes in the stocks collection
//sort by price in descending order
db.stocks.aggregate([
    {$sort: {"Price": -1}},
    {$limit: 10},
    {$project: {"Symbol": 1, "Name": 1, "Price": 1, "_id": 0}}
])

//show the population of the 10 least populous cities in MO
db.zips.find({"state": "MO", "city": "COLUMBIA"}).pretty()

//only look at documents where state = "MO" - $match
//group documents based on the city field, and sum the populations - $group, $sum
//sort by total population in ascending order - $sort
//limit to the first 10 - $limit
db.zips.aggregate([
    {$match: {"state": "MO"}},
    {$group: {_id: "$city", TotalPopulation:{$sum: "$pop"}}},
    {$sort: {TotalPopulation: -1}},
    {$limit: 10}
])

//show cities in MO with population >= 50000
db.zips.aggregate([
    {$match: {"state": "MO"}},
    {$group: {_id: "$city", TotalPopulation:{$sum: "$pop"}}},
    {$match: {TotalPopulation: {$gte: 50000}}},
    {$sort: {TotalPopulation: -1}}
])

//How many zip codes in the state of FL?
db.zips.aggregate([
    {$match: {"state": "FL"}},
    {$count: "Total Zips in FL"}
])

db.zips.find({"state": "FL"}).count()

//difference between $sum and $count
//display the total population of Columbia MO
db.zips.aggregate([
    {$match: {"state": "MO", "city": "COLUMBIA"}},
    {$group: {_id: "city", TotalPopulation: {$sum: "$pop"}}}
])

//display the nimber of zip codes in Columbia
db.zips.aggregate([
    {$match: {"state": "MO", "city": "COLUMBIA"}},
    {$group: {_id: "$city", NumZips: {$sum: 1}}}
])

//Display the number of zip codes for each city in the state  of MO
db.zips.aggregate([
    {$match: {"state": "MO"}},
    {$group: {_id: "$city", NumZips: {$sum: 1}}},
    {$sort: {NumZips: -1}}
])

//List the cities in Illinois that have 3 or more zip codes
//sort in descending order based on the number of zip codes
//Count the occurence omn the city name in the documents in the pipeline
//match state = IL
//group by city and count the number of documents in each group (document = 1 zip code)
//match total zips >= 3
//sort -1
db.zips.aggregate([
    {$match: {"state": "IL"}},
    {$group: {_id: "$city", NumZips: {$sum: 1}}},
    {$match: {NumZips: {$gte: 3}}},
    {$sort: {NumZips: -1}}
])