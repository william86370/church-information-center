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
class smallgrouptable: UITableViewController{
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var leaderadd: UIBarButtonItem!
    
    
    let name = firebasehelper.retrievedefaults(key: "aname") as? String
    let grade = firebasehelper.retrievedefaults(key: "agrade") as? String
    let leader = firebasehelper.retrievedefaults(key: "aleader") as? Bool
    let shareprayr = firebasehelper.retrievedefaults(key: "ashareprayr") as? Bool
    let shareverse = firebasehelper.retrievedefaults(key: "ashareverse") as? Bool
    var key = String()
    
    var smallgroups = [NSDictionary]()
    var groupnames = [String]()
    var groupsnotin = [String]()
    var groupmemebers = [Int]()
    var leadersforgroup = [String]()
    var deletepath: NSIndexPath? = nil
    var currentcelltitle = String()
    
    override func viewDidLoad() {
        if(leader)!{
             leaderadd.accessibilityElementsHidden = false
        }else{
             leaderadd.accessibilityElementsHidden = true
        }
        leaderadd.accessibilityElementsHidden = true
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
                    print(self.groupsnotin)
                }
                self.groupmemebers.append(WrightFramework.returnnumberingroup(dir: value[key] as! NSDictionary))
                firebasehelper.savedefaults(value: value[key]!, key: key as! String)
                if(firebasehelper.valuexists(valuekey: (key as? String)!)){
                   // firebasehelper.printdir(dir: firebasehelper.retrevefirebasedir(valuekey: key as! String))
                }
                self.smallgroups.append(value[key] as! NSDictionary)
                self.groupnames.append(key as! String)
                //print(value[key]!)
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
        cell.leadrsingrouplbl.text = ("Leaders: " + firebasehelper.returnleader(dir:smallgroups[row]))
        cell.spinner.endRefreshing()
        cell.numofmembers.text = ("\(groupmemebers[row]) Currently in Group")
        //if(segment.selectedSegmentIndex == 1){
          // cell.groupname.text = groupsnotin[row]
            //cell.accessoryType = UITableViewCellAccessoryType.none
        //}else{
            if(groupsnotin.contains(groupnames[row] as String)){
                print(groupnames[row] + "contains " )
             cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }else{
                 cell.accessoryType = UITableViewCellAccessoryType.none
            }
            cell.groupname.text = groupnames[row]
        print(cell.groupname.text)
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
            if(groupsnotin.contains(groupnames[row])){
                key = groupnames[row]
            }else{
                //user is not in that group must update table first 
                alertjoin(groupname: groupnames[row])
                //refreshcompleation(sender: self){
                 self.key = self.groupnames[row]
               }
                self.tableView.reloadData()
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
            firebasehelper.addtosmallgroup(groupname: groupname, name: self.name!, grade: self.grade!,leader:self.leader!,shareprayr: self.shareprayr!,shareverse: self.shareverse!){
                self.groupsnotin.append(groupname)
                self.tableView.reloadData()
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
                    print(self.groupsnotin)
                    print("groupin=" + (value[key]! as! String))
                }
                firebasehelper.savedefaults(value: value[key]!, key: key as! String)
                if(firebasehelper.valuexists(valuekey: (key as? String)!)){
                   // firebasehelper.printdir(dir: firebasehelper.retrevefirebasedir(valuekey: key as! String))
                }
                self.smallgroups.append(value[key] as! NSDictionary)
                self.groupnames.append(key as! String)
                self.tableView.reloadData()
                completion()
            }
        }) { (error) in
            print(error.localizedDescription)
            completion()
        }
    }
    // Delete Confirmation and Handling
    func confirmDelete(planet: String) {
        currentcelltitle = planet
        let alert = UIAlertController(title: "Leave Group", message: "are you sure you want to leave \(planet)?", preferredStyle: .actionSheet)
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeletePlanet)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeletePlanet)
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
    }
    func handleDeletePlanet(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deletepath {
           groupsnotin.remove(at: groupsnotin.index(of: groupnames[indexPath.section])!)
            firebasehelper.removefromfirebase(title: currentcelltitle, name: name!)
           print(groupsnotin)
            deletepath = nil
            print("randeleatemethof")
            self.tableView.reloadData()
        }
    }
    func cancelDeletePlanet(alertAction: UIAlertAction!) {
         deletepath = nil
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            print("ran.delte")
            deletepath = indexPath as NSIndexPath?
            if (groupsnotin.index(of: groupnames[indexPath.section] ) != nil){
            let loc = groupsnotin.index(of: groupnames[indexPath.section])
            print(groupnames[indexPath.section])
            confirmDelete(planet: groupsnotin[loc!] )
            }
        }
    }
}
