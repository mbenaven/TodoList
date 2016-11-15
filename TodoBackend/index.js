/*
Import express library, create our app with the express initializer
wrap our expres app with an HTTP server, require http
This is a part of the node standard library

Mongoose provides object modeling for node.js (similar to data modeling)
  -- Lets us query/access without using SQl

Set a port for our backend to listen on

Benavente$ npm install --save express
Benavente$ node index.js
  -- Will show Cannot GET/ because we haven't set up any routes yet
Benavente$ npm install --save body-parser
Benavente$ npm install --save mongoose
Benavente$ node index.js
Benavente$ npm install jwt-simple --save
  -- this is to generate and send authentication tokens
Benavente$ npm install --save morgan
Benavente$ npm install passport passport-local --save
Benavente$ npm install bcrypt-nodejs --save
Benavente$ npm install uuid --save
*/

var express = require('express');
var http = require('http');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
//Express middleware which generates pretty log of the http requests on our server
var morgan= require('morgan');

var router = require('./router');

mongoose.Promise = global.Promise;
mongoose.connect('mongodb://localhost:todolist/todolist') //mongoose will create an DB locations that don't exist already
var app = express();

//Using the middleware BodyParser.json
//will parse any JSON encoded data sent to our server into the request body property
//we also enable our API to pass URL encoded data, like that from a webform
//body parser middleware takes an options object as an argument
//we pass in extended set to true, allows for decoding of URL encoded objects and arrays
app.use(morgan('combined'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));

//This way if we ever have to update our API we don't have to break any applications
//That use the old version, you can simply add it
app.use('/v1', router)

//we wrap our express app with an http server allowing for networking
var server = http.createServer(app);

//the port which our backend will listen
var port = process.env.PORT || 3000;
var host = process.env.HOST || '127.0.0.1';

console.log("Listening on", host, port);
server.listen(port, host);
