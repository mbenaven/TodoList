var mongoose = require('mongoose');
var bcrypt = require('bcrypt-nodejs'); //This is for the encrypting
var Schema = mongoose.Schema;

//Uses a regular expression making sure it contains an @ symbol, a ( . ) all surounded by alphanumeric char
var validateEmail = email => (/\S+@\S+.\S+/).test(email);

//the Schema Initializer takes 1 obj as an arg
// the obj will describe the shape of our model and its properties
var userSchema = new Schema({
  email: {
    type: String,
    unique: true,
    lowercase: true,
    required: 'Email adress is required',
    validate: [validateEmail, "Please enter a valid email"]
  },
  password: {type: String}
  todos: [
    id: {type: String}  // MongoDB would automatically generate an id for an array item
    text: {type: String}
  ]
});

//Pre-save hook, function that is called just before a user is created, or updated and saved
//encrypts our password in the DB
userSchema.pre('save', function(next) {
  var user = this;
  if (user.isNew) {  //A: This way the password isn't being re-hashed again every time we save
    //We only want to encrypt the password if this is a new user, otherwise redundency
    bcrypt.genSalt(10, function(err,salt) { //to encrypt password we generate a salt
      if (err) { return next(err) }
      //takes the string we wish to encrypt and the salt object as args
      //3rd argument is a callback for reporting the progress, we are not using so set to null
      bcrypt.hash(user.password, salt, null, function(err, hash) {
        if (err) { return next(err) }
        user.password = hash;
        next();
      });
    });
  } else {
  next ();  //B: When our user model is updated to contain todos, the password doesn't change everytime we add or remove a todo
  }
});

//Compares ecnrypted passwords
userSchema.methods.comparePassword = function(candidatePassword, callback) {
  bcrypt.compare(candidatePassword, this.password, function(err, isMatch){
    callback(null, isMatch);
  });
}

//mongoose.model turns our schema into an actual mongoose obj relational mapper
//first arg is the name of our model, second is the schema
var ModelClass = mongoose.model('user', userSchema);

//exports our model from this module
module.exports = ModelClass;
