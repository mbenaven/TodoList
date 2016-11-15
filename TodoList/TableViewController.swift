//
//  TableViewController.swift
//  TodoList
//
//  Created by Matt Benavente on 10/22/16.
//  Copyright © 2016 Matt Benavente. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

// let falseData = ["Test 1", "Test 2", "Test 3"]
    let todoData = UserDefaults.standard.array(forKey: "todosArray")
    //let todoData = UserDefaults.standard.value(forKey: "todosArray") //Get value from key todosArray and call that value todoData

    @IBAction func logoutButtonPress(sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jwtToken") //To clear our token on logout
        
    self.navigationController!.performSegue(withIdentifier: "showLoginViewController", sender: nil) //Segue back to login screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 68.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   /* override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let todoData = todoData {
            return (todoData as AnyObject).count  // return todoData.count
        } else {
            return 0
        }
    }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let todoData = todoData as? [String] {
            return todoData.count
        } else {
            return 0
        }
    }

    //force cast table view cell 
    
    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell

        if let todoData = todoData {
            if let text = todoData[indexPath.row] {
                cell.label.text = text as? String
            }
        }
        return cell
    } */
    
    override func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        cell.label.text = todoData?[indexPath.row] as? String
        return cell
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        
        if let todoData = todoData as? [String] {
            if let text = todoData[indexPath.row] {
                cell.label.text = text
            }
        }
        return cell
    } */
 
}
