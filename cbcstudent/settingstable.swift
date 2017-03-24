//
//  settingstable.swift
//  cbcstudent
//
//  Created by William Wright on 3/20/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//
import UIKit
class settingstable: UITableViewController {
var leader = Bool()
    @IBOutlet weak var leadersh: UISwitch!
    override func viewDidLoad() {
        if(UserDefaults.standard.value(forKey: "leader") != nil){
             leader = (UserDefaults.standard.bool(forKey: "leader"))
            leadersh.setOn(true, animated: false)
            leader = true
            self.tableView.reloadData()
        }else{
            leadersh.setOn(false, animated: false)
            leader = false
            self.tableView.reloadData()
        }
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    @IBAction func leaderswitch(_ sender: Any) {
        //this runs when the user deauthents themselfs diaableing admin
        if(leadersh.isOn == false){
            UserDefaults.standard.set(nil, forKey: "leader")
            self.leadersh.setOn(false, animated: true)
            self.leader = false
            self.leadersh.setOn(false, animated: true)
            self.tableView.reloadData()
        }else{
        //this runs when the user authenacates themselfs
        //1. Create the alert controller.
        let alert = UIAlertController(title: "enter leader code", message: "Enter code", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "enter acess code"
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if(textField?.text == "2357"){
                UserDefaults.standard.set(true, forKey: "leader")
                self.leadersh.setOn(true, animated: true)
                self.leader = true
                self.tableView.reloadData()
            }else{
                self.leader = false
                self.leadersh.setOn(false, animated: true)
                self.tableView.reloadData()
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //if leader mode is off return only the option to enable leader mode
        if leader == false {
            return 1
        }
        //if leader mode is off return the diffrent things leaders can do
        return 3
    }
       /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
