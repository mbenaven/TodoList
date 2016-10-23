//
//  TableViewController.swift
//  TodoList
//
//  Created by Matt Benavente on 10/22/16.
//  Copyright © 2016 Matt Benavente. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let falseData = ["Test 1", "Test 2", "Test 3"]

    @IBAction func logoutButtonPress(_ sender: AnyObject) {
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    //force cast table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell

        cell.label.text = self.falseData[0]
        return cell
    }
 
}
