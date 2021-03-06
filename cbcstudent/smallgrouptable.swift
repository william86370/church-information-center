//
//  smallgrouptable.swift
//  cbcstudent
//
//  Created by William Wright on 3/20/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit
import Firebase
import JTMaterialSpinner
class smallgrouptable: UITableViewController {
    @IBOutlet weak var segment: UISegmentedControl!
    let name = firebasehelper.retrievedefaults(key: "aname") as? String
    let grade = firebasehelper.retrievedefaults(key: "agrade") as? String
    let leader = firebasehelper.retrievedefaults(key: "aleader") as? Bool
    var key = String()
    var smallgroups = [NSDictionary]()
    var groupnames = [String]()
    var groupsnotin = [String]()
    var groupmemebers = [Int]()
    var leadersforgroup = [String]()
    override func viewDidLoad() {
        
        /*
        let ref = FIRDatabase.database().reference().child("smallgroups")
        var value =  NSDictionary()
        //calls firebase useing the ref created earlyer
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            value = (snapshot.value as? NSDictionary)!
            // firebasehelper.printdir(dir: value)
            for (key,values) in value {
        firebasehelper.savedefaults(value: value[key]!, key: key as! String)
                if(firebasehelper.valuexists(valuekey: (key as? String)!)){
                    firebasehelper.printdir(dir: firebasehelper.retrevefirebasedir(valuekey: key as! String))
                }
            self.smallgroups.append(value[key] as! NSDictionary)
                self.groupnames.append(key as! String)
                print(value[key]!)
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
 */
        
        
        refresh(sender: self)
        self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        super.viewDidLoad()
    }
    @IBAction func changegroups(_ sender: Any) {
        //refresh(sender: self)
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func refresh(sender:AnyObject) {
         smallgroups = [NSDictionary]()
         groupnames = [String]()
        groupsnotin = [String]()
        let ref = FIRDatabase.database().reference().child("smallgroups")
        var value =  NSDictionary()
        //calls firebase useing the ref created earlyer
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            value = (snapshot.value as? NSDictionary)!
            // firebasehelper.printdir(dir: value)
            for (key,values) in value {
                if (firebasehelper.containsstiring(dir: value[key] as! NSDictionary, key2: self.name!)){
                    self.groupsnotin.append(key as! String)
                }
                self.groupmemebers.append(WrightFramework.returnnumberingroup(dir: value[key] as! NSDictionary))
                firebasehelper.savedefaults(value: value[key]!, key: key as! String)
                if(firebasehelper.valuexists(valuekey: (key as? String)!)){
                    firebasehelper.printdir(dir: firebasehelper.retrevefirebasedir(valuekey: key as! String))
                }
                self.smallgroups.append(value[key] as! NSDictionary)
                self.groupnames.append(key as! String)
                print(value[key]!)
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
   refreshControl?.endRefreshing()
        // Code to refresh table view
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       // if(segment.selectedSegmentIndex == 1){
         //   return groupsnotin.count
        //}
        return groupnames.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath) as! smallgroupcell
        let row = indexPath.section
        
               
        
        
        //code to make the cell have a border
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 4
        cell.layer.cornerRadius = 4
        cell.clipsToBounds = true
        //end
        cell.spinner.endRefreshing()
        cell.numofmembers.text = ("\(groupmemebers[row]) Currently in Group")
        //if(segment.selectedSegmentIndex == 1){
          // cell.groupname.text = groupsnotin[row]
            //cell.accessoryType = UITableViewCellAccessoryType.none
        //}else{
            if(groupsnotin.contains(groupnames[row])){
             cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }else{
                 cell.accessoryType = UITableViewCellAccessoryType.none
            }
            cell.groupname.text = groupnames[row]
    
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.section
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath) as! smallgroupcell
        cell.spinner.beginRefreshing()
        //print the row that the user selects
        print("Row \(row)selected")
        //change the varubles for the selevted items
        if(segment.selectedSegmentIndex == 1 ){
            key = groupsnotin[row]
        }else{
            if(groupsnotin.contains(groupnames[row])){
                key = groupnames[row]
            }else{
                //user is not in that group must update table first 
                alertjoin(groupname: groupnames[row])
                //refreshcompleation(sender: self){
                 self.key = self.groupnames[row]
               // }
                self.tableView.reloadData()
            }
            
        }
        //go and do the segue
        performSegue(withIdentifier: "group", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "group"){
            let vc = segue.destination as! ingrouptable
            vc.key = key
        }
    }
    func alertjoin(groupname:String){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "your not in this group", message: "join group?", preferredStyle: .alert)
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "yes", style: .default, handler: { [weak alert] (_) in
            firebasehelper.addtosmallgroup(groupname: groupname, name: self.name!, grade: self.grade!,leader:self.leader!){
                self.groupsnotin.append(groupname)
                self.refresh(sender: self)
            }
        }))
        alert.addAction(UIAlertAction(title: "no", style: .default, handler: { [weak alert] (_) in
        }))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    func refreshcompleation(sender:AnyObject, completion: @escaping() -> Void) {
        smallgroups = [NSDictionary]()
        groupnames = [String]()
        groupsnotin = [String]()
        let ref = FIRDatabase.database().reference().child("smallgroups")
        var value =  NSDictionary()
        //calls firebase useing the ref created earlyer
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            value = (snapshot.value as? NSDictionary)!
            // firebasehelper.printdir(dir: value)
            for (key,values) in value {
                if (firebasehelper.containsstiring(dir: value[key] as! NSDictionary, key2: self.name!)){
                    self.groupsnotin.append(key as! String)
                }
                firebasehelper.savedefaults(value: value[key]!, key: key as! String)
                if(firebasehelper.valuexists(valuekey: (key as? String)!)){
                    firebasehelper.printdir(dir: firebasehelper.retrevefirebasedir(valuekey: key as! String))
                }
                self.smallgroups.append(value[key] as! NSDictionary)
                self.groupnames.append(key as! String)
                print(value[key]!)
                self.tableView.reloadData()
                completion()
                
                
            }
        }) { (error) in
            print(error.localizedDescription)
            completion()
        }
       
    }

}
