//
//  ViewController.swift
//  TodoList
//
//  Created by Matt Benavente on 10/19/16.
//  Copyright © 2016 Matt Benavente. All rights reserved.
//

import Alamofire
import UIKit
import SwiftyJSON // To pick apart the JSON response, so we can save the Auth token and User ID on the Phone for future API calls and persistant sessions


class LoginViewController: UIViewController {

   
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func signInButtonPress(sender: AnyObject) {
        postCredentials(endpoint: APIEndpoints.signinURL)
    }
    
    @IBAction func signUpButtonPress(sender: AnyObject) {
        postCredentials(endpoint: APIEndpoints.signupURL) //just uses the logic from post credentials function below, passing in the relevent endpoints (signin / signup)
    }
    
    //passes in the endpoint string  APIEndpoints signin/signup and then uses that as a parameter for the Alamofire request, see APIEndpoints.swift doc for full address localhost
    func postCredentials(endpoint: String) {
        let loader = SwiftLoading()
        loader.showLoading()
        if let email = emailTextField.text, let password = passwordTextField.text {
            let parameters: Parameters = [
                "email": email,
                "password": password
            ]
            /*Alamofire.request(https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
             print(response) */
            
            //Creating or signing in user with a POST request to our API (node.js server on our local machine)
            // The URL endpoint for our APIs action to be taken wwww.  or http://localhost:3000/v1/signup http://localhost:3000/v1/signin
            // We passs in values for our post parameters from above , email and pw from the parameters obj dictionary
            
            //Alamofire.request(.POST, endpoint, parameters: parameters, encoding: .JSON).responseJSON { response in
            Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                
                switch response.result {
                case.success:    //Status code 200
                    if let value = response.result.value {
                        //let defaults = NSUserDefaults.standardUserDefaults() //2.3
                        let defaults = UserDefaults.standard //3.0
                        let json = JSON(value) // Passing result to SwiftyJSONs JSON function to parse it
                        defaults.setValue(json["token"].string, forKey: "jwtToken") //Getting the token from the JSON obj and storing it for the key jwtToken
                        defaults.setValue(json["userId"].string, forKey: "userId") //getting the ID from the JSON obj and storing it for the key userId  the .string is how we unwrap optionals with swiftyJSON
                        
                        print(defaults.value(forKey: "jwtToken"))  // to check that the jwtToken was properly populated with the authentication token
                        self.navigationController!.performSegue(withIdentifier: "showTodosViewController", sender: nil)
                    }
                case.failure(let error):
                    print(error)
                }
                //print(response)
            }
            loader.hideLoading()
        }
        
    }
    //By default it would show a back bar button but were gonna hide it
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
    }
}

//Optionals: Mean that there is a value and it is some number, or there isn't a value at all (nil)
//  https://www.youtube.com/watch?v=6yJwBU1TYoQ

