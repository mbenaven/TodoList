//This is for signing in:
//Passport will give us access to the req.user object and check the credentials
//Passport is middleware for user authentification
//there are multiple mains for user Auth, refered to as Strategies
//We need to configure a strategy for signing in, called a Local strategy
var passport = require('passport');

//Import our user model
var User = require('../models/user');
//Import our passport package
var LocalStrategy = require('passport-local');

//The initializer for our passport stategy takes an options object, we call loginOptions
var loginOptions = {
  usernameField: 'email'
}

var localLogin = new LocalStrategy(loginOptions, function(email, password, done) {
  User.findOne({email:email}, function(err, user){
    if(err) { return done(err) }
    if (!user) { return done(null, false) } //No error but user still isn't authenticated (null, done)
    user.comparePassword(password, function(err, isMatch) {  //To check if password is correct
      if (err) { return done(err) }
      if (!isMatch) { return done(null, false) }
      return done(null, user);
    });
  })
})

//registers our strategy
passport.use(localLogin);
