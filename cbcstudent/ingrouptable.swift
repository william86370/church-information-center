//
//  ingrouptable.swift
//  cbcstudent
//
//  Created by William Wright on 3/20/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//
import UIKit
import Firebase
class ingrouptable: UITableViewController {
    let name = firebasehelper.retrievedefaults(key: "aname") as? String
    let grade = firebasehelper.retrievedefaults(key: "agrade") as? String
    let leader = firebasehelper.retrievedefaults(key: "aleader") as? Bool
    var groupnames = [String]()
    var key = "group1"
    var groupdir = NSDictionary()
    override func viewDidLoad() {
        if(firebasehelper.valuexists(valuekey: key)){
         groupdir = firebasehelper.retrevefirebasedir(valuekey: key)
            groupnames = firebasehelper.returnkeyarrayofdir(dir: groupdir)
            firebasehelper.printdir(dir: groupdir)
        }else{
            print("nvm nothing found")
        }
        self.tableView.reloadData()
        self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
            super.viewDidLoad()
    }
         func refresh(sender:AnyObject) {
        firebasehelper.downloaddata(ref: FIRDatabase.database().reference().child("smallgroups").child(key)){
             (result: NSDictionary) in
        self.groupdir = result
        self.groupnames = firebasehelper.returnkeyarrayofdir(dir: self.groupdir)
            firebasehelper.savedefaults(value: result, key: self.key )
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        }
    }
    @IBAction func addnewuser(_ sender: Any) {
       /*
        //1. Create the alert controller.
        let alert = UIAlertController(title: "create new user", message: "enter info", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "enter full name"
        }
        alert.addTextField { (textField2) in
            textField2.placeholder = "enter grade"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let textfield2 = alert?.textFields![1]
            firebasehelper.addtosmallgroup(groupname: self.key, name: (textField?.text)!, grade: (textfield2?.text)!)
        
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
*/
        firebasehelper.addtosmallgroup(groupname: key, name: name!, grade: grade!,leader: leader!){
            self.refresh(sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupnames.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2",for: indexPath) as! ingroupcell
        let row = indexPath.section
        cell.namelbl.text = groupnames[indexPath.row]
        return cell
    }
}
