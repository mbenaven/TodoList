//The router routes the enpoint paths (http://localhost:3000/v1/signup) to the
//actions which are in the auth_controller file
var express = require('express');
var passport = require('passport');

var AuthController = require('./controllers/auth_controller');
var TodosController = require('./controllers/todos_controller');
var passportService = require('./services/passport');

//Reference to our local strategy, passing in options object with session set to false since not using
var requireSignin = passport.authenticate('local', {session: false});

var router = express.Router();

//Chaining a call to the post method which takes the signup path/function as an argument
//See the AuthController signup function
router.route('/signup')
  .post(AuthController.signup);

router.route('/signin')
    .post([requireSignin, AuthController.signin]); //express will run the request through these function in array

router.route('/users/:user_id/todos/new') //Putting a : before user_id makes it a wildcard, making it accessable on req obj
    .post(TodosController.create);

//we export the router object because we will neeed it in index.js
module.exports = router;
