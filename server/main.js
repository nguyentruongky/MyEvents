var express = require('express')
const mongoClient = require('mongodb').MongoClient

var app = express()

const bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({ extended: true }))

app.listen(3000, function() {

    console.log('App is running on port 3000')
})

app.get('/', function(req, res) {

    res.send('Hi, express is here')
})

app.post('/register', function(req, res) {

    let email = req.body.email 
    let password = req.body.password
    db.collection('users').save({ 'email': email, 'password': password }, function(err, result) {

        if (err) return console.log(err);
        res.send({ 'code': 201, 'message': 'user created' })
    })
})

app.post('/login', function(req, res) {

    let email = req.body.email 
    let password = req.body.password

    db.collection('users').findOne({ 'email': email, 'password': password }, function(err, user) {

        console.log(user)
        if(err || user != null) {
            res.send({ 'code': 200, 'data': user })
        }
        else {
            res.send({ 'code': 401, 'message': 'invalid login' })   
        }
    })
})

app.post('/events', function(req, res) {

    let name = req.body.name
    let startDate = req.body.startDate
    let endDate = req.body.endDate

    db.collection('events').save({ 'name': name, 'startDate': startDate, 'endDate': endDate }, function(err, result) {
        if (err) return console.log(err);
        res.send({ 'code': 201, 'message': 'event created' })
    })
})

app.get('/events', function(req, res) {
    db.collection('events').find().toArray(function(err, events) {

        if (err) { 
            res.send({ 'code': 500, 'message': 'internal server error' })
        }
        else {
            res.send({ 'code': 200, 'events': events })
        }

    })
})

app.get('/filter', function(req, res) {

    let name = req.body.name
    let startDate = req.body.startDate
    let endDate = req.body.endDate

    let foundEvents = []
    db.collection.find({ $text : {$search : name }}).toArray(function(err, events) {

        for (var event in events) {
            if (event.startDate > startDate && event.endDate < endDate) {
                foundEvents.push(event)
            }
        }

        res.send({ 'code': 200, 'events': foundEvents })
    })
})


var db;
mongoClient.connect('mongodb://ky:123456@ds115752.mlab.com:15752/ohmyhome', function(err, database) {

	if (err) return console.log(err);
	db = database

	
})