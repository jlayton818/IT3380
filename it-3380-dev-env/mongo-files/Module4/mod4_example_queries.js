//returb all the documents in the zups collection
db.zips.findOne()
db.zips.find()

//returb all documents in the zips in a more readable format
db.zips.find().pretty()

//General query format db.collection.find({query filter parameters(WHERE)},{display key values (SELECT)})

//Display the city and zipcodes for the state of Missouri
db.zips.find({ "state": "MO" }, { "_id": 1, "city": 1, "state": 1 })
db.zips.find({ "state": "MO" }, {})

db.collection.find({ "state": "MO" }, {})

//Don't return the ID
db.zips.find({ "state": "MO" }, { "_id": 0, "city": 1, "state": 1 })

//How many zip codes are in the state of New York
db.zips.find({ "state": "NY" }).count()

//list all cities and zip codes in MO, IL, KS
db.zips.find({ $or: [{ "state": "MO" }, { "state": "KS" }, { "state": "IL" }] }, { "_id": 1, "city": 1, "state": 1 })
db.zips.find({ $or: [{ "state": "MO" }, { "state": "KS" }, { "state": "IL" }] }, { "_id": 1, "city": 1, "state": 1 }).count()

//Display zip code,city, where population is less than or equal to 500
db.zips.find({ "pop": { $lte: 500 } }, { "city": 1, "pop": 1, "state": 1 });
db.zips.find({ "pop": { $gte: 100000 } }, { "city": 1, "pop": 1, "state": 1 });

//display stock name, earn
db.stocks.find({ "Price": { $gte: 100 } }, { "Name": 1, "Earnings/Share": 1, "Sector": 1, "_id": 0 })