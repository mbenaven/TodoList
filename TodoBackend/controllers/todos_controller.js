require User = ('../models/user');
var uuid = require('uuid');

//We directly export a function called Create, taking the usual 3 args

exports.create = function(req, res, next){
  User.findById(req.params.user_id, function(err, user)) {   //Pass in userID from URL and callback function
    if (err) { return next(err) }
    var text = req.body.text; //When we find the user get the todo text from the req body
    user.todos.push({    //Push a new todo
      id: uuid.v4(),
      text: text
    });
    user.save(function(err) {
      if (err) { return next(err) }
      res.json({ text: text });  //Sending back todo text to indiate the successfull save in this callback
    });
 });
}
