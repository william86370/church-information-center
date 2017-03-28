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
    let shareprayr = firebasehelper.retrievedefaults(key: "ashareprayr") as? Bool
    let shareverse = firebasehelper.retrievedefaults(key: "ashareverse") as? Bool
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
            print(self.groupnames)
            
            print("printedarray")
            
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        }
            
    }
   
        
    
    @IBAction func addnewuser(_ sender: Any) {
        firebasehelper.addtosmallgroup(groupname: key, name: name!, grade: grade!,leader: leader!,shareprayr: self.shareprayr!,shareverse: self.shareverse!){
            self.refresh(sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return groupnames.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2",for: indexPath) as! ingroupcell
       let row = indexPath.section
        
        cell.isleaderlbl.text = firebasehelper.returnstatus(dir: groupdir)
        cell.namelbl.text = groupnames[row]
        //code to make the cell have a border
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 4
        cell.layer.cornerRadius = 4
        cell.clipsToBounds = true
        //end
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.section
        if groupnames[row] == name {
            print("isuser")
            performSegue(withIdentifier: "isuser", sender: self)
            
        }else{
            print("not user")
            let alert = UIAlertController(title: "Thats not you!!", message: "you can see if\(groupnames[row]) has anyting they have set public", preferredStyle: .actionSheet)
            let DeleteAction = UIAlertAction(title: "Allow", style: .destructive, handler: gotonotuser)
            let CancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(DeleteAction)
            alert.addAction(CancelAction)
            alert.popoverPresentationController?.sourceView = self.view
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func gotonotuser(alertAction: UIAlertAction!) {
        performSegue(withIdentifier: "notuser", sender: self)
    }
}
