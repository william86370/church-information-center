//
//  notusertable.swift
//  cbcstudent
//
//  Created by william wright on 3/27/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit
import Firebase
class notusertable: UITableViewController {
    //start defineing varibles 
    let name = firebasehelper.retrievedefaults(key: "aname") as? String
    let grade = firebasehelper.retrievedefaults(key: "agrade") as? String
    let leader = firebasehelper.retrievedefaults(key: "aleader") as? Bool
    let shareprayr = firebasehelper.retrievedefaults(key: "ashareprayr") as? Bool
    let shareverse = firebasehelper.retrievedefaults(key: "ashareverse") as? Bool
    //account vars end
    var currentname = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}
