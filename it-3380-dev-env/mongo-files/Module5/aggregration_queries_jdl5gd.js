//1.  Which states have zip codes with populations greater than (75,000) people?

db.zips.aggregate([
    
])

//2. Which cities have populations greater than 200,000 people?
db.zips.aggregate([
    {$group: {_id : "$pop"}}
])
//3. What is the total population of each city in FL. Sort in ascending order based on total population?
db.zips.aggregate([
    {$match: {"state": "FL"}},
    {$group: {_id: "$city", TotalPopulation:{$sum: "$pop"}}},
    {$sort: {TotalPopulation: 1}}
])
//4.  What are the 10 most populous cities in MO?
db.zips.aggregate([
    {$match: {"state": "MO"}},
    {$group: {_id: "$city", TotalPopulation:{$sum: "$pop"}}},
    {$sort: {TotalPopulation: -1}},
    {$limit: 10}
])

//5. What is the population of New York City, NY?
db.zips.aggregate([
    {$match: {"state": "NY", "city": "NEW YORK"}},
    {$group: {_id: "$city", TotalPopulation: {$sum: "$pop"}}}
])

//6. List the cities in Illinois that have 3 or more zip codes? Sort in descending order by total number of zip codes. Hint: count multiple occurrences of a city’s name.
db.zips.aggregate([
    {$match: {"state": "IL"}},
    {$group: {_id: "$city", NumZips: {$sum: 1}}},
    {$match: {NumZips: {$gte: 3}}},
    {$sort: {NumZips: -1}}
])

//7. Which city has the fewest number of zip codes?
db.zips.aggregate([
    {$group: {_id: "$_id", NumZips: {$sum: "$_id"}}},
    {sort: {NumZips: -1}},
    {limit: 1 }
])
What is the name and total population of the most populous city in the zips database?
What is the name and total population of the least populous city in the zips database?
What is the name and total population for the 15 most populous cities in the zips database?
List the symbol and company name of the companies with the ten (10) highest stock price.
List total earnings (EBITDA) by sector.
List the average earnings by sector
Show the company name and symbol of the top 10 companies in earnings in the Industrials sector?
List the names of the companies in the Information Technology sector that paid dividends to shareholders. You will know this if the “Dividend Yield” field is greater than 0.
What are the top 10 companies in the “Health Care” sector when it comes to “Earnings/Share”?
Calculate the total earnings (EBITDA) for all companies in the Information Technology sector.
Calculate the number of outstanding shares for companies in the Industrials sector. Number of outstanding shares can be calculated by dividing the Market Cap by the Price. Display company name, symbol, and number of outstanding shares in ascending order.

