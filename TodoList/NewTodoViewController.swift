//
//  NewTodoViewController.swift
//  TodoList
//
//  Created by Matt Benavente on 10/23/16.
//  Copyright © 2016 Matt Benavente. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


//Alamofire.request(.POST, APIEndpoints.newTodoURL(userId), parameters: parameters ,encoding: .JSON).responseJSON { response in


// Alamofire.request(APIEndpoints.signupURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
//Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in

class NewTodoViewController: UITableViewController {
    
    @IBOutlet weak var newTodoTextField: UITextField!
    
    @IBAction func addButtonPress(sender: AnyObject) {
        let loader = SwiftLoading()
        loader.showLoading()
        if let text = newTodoTextField.text {
            let defaults = UserDefaults.standard
            let userId = defaults.value(forKey: "userId") as! String
            // Parameters object to post to the server. Its a dictionary with one property: the todo text entered
            let parameters = [ "text":text ]
 
            Alamofire.request(APIEndpoints.newTodoURL(userId), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            //Alamofire.request(.POST, APIEndpoints.newTodoURL(userId), parameters: parameters ,encoding: .JSON).responseJSON { response in
                
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        let defaults = NSUserDefaults.standardUserDefaults() //UserDefaults.standard
                        let json = JSON(value)
                        
                        if let todosArray = defaults.value(forKey: "todosArray"){   // Attempt to grab object todosArray from our Defaults
                            let todosArray = NSMutableArray(array: todosArray as! [AnyObject]) // If it exists will pass it to NSMutableArray initializer
                            
                            if let todoText = json["text"].string {   //To grab todoText from our JSON object which will send back from server when todo is successfully created
                                todosArray.add(todoText)  //If it exists will addd it to todos array
                                defaults.setValue(todosArray, forKey: "todosArray")  //and then save the updated array in our defaults
                            } else {
                                print("Could not get text from JSON")
                            }
                        } else {
                            if let todoText = json["text"].string {
                                defaults.setValue(NSMutableArray(array: [todoText]), forKey: "todosArray")
                            } else {
                                print("Could not get text from JSON")
                            }
                        }
                        self.navigationController!.performSegue(withIdentifier: "showTodosViewController", sender: nil)
                    }
                case .failure (let error):
                    print("ERR \(response) \(error)")
                }
                loader.hideLoading()
            }
        } else {
            print("No text!")
            loader.hideLoading()
        }
    }
    
}
