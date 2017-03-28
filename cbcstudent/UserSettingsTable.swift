//
//  UserSettingsTable.swift
//  cbcstudent
//
//  Created by william wright on 3/27/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit
//importing firebase for acess to WrightFramwork
import Firebase
//importing spinner to add cool spinner animations
import JTMaterialSpinner
//this class is being used for the User Settings page
class UserSettingsTable: UITableViewController {
//Define below
    //Get all the users inforation from the stored values
    let name = firebasehelper.retrievedefaults(key: "aname") as? String
    let grade = firebasehelper.retrievedefaults(key: "agrade") as? String
    let leader = firebasehelper.retrievedefaults(key: "aleader") as? Bool
    let shareprayr = firebasehelper.retrievedefaults(key: "ashareprayr") as? Bool
    let shareverse = firebasehelper.retrievedefaults(key: "ashareverse") as? Bool
    //the switch for shareing your prair requests with everyone
    @IBOutlet weak var shareprayrswitch: UISwitch!
    //the switch for shareing your verses with everyone
    @IBOutlet weak var shareverseswitch: UISwitch!
//end defineing
    override func viewDidLoad() {
        //load the settings from defaults and update them on the table
        if shareprayr == true {
            shareprayrswitch.setOn(true, animated: false)
        }
        if shareverse == true {
            shareverseswitch.setOn(true, animated: false)
        }
        //end sync
        super.viewDidLoad()
    }
    //methods to run when state is changed 
    @IBAction func prayrtoggled(_ sender: Any) {
        //checks the state of the button and save the values to defaults
        if(shareprayrswitch.isOn){
            //create an alert view showing the user that this might become public
            let alert = UIAlertController(title: "Are You Sure", message: "Allowing Shareing allows anyone to see your prayrs", preferredStyle: .actionSheet)
            let DeleteAction = UIAlertAction(title: "Allow", style: .destructive, handler: toggleonprayr)
            let CancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(DeleteAction)
            alert.addAction(CancelAction)
            alert.popoverPresentationController?.sourceView = self.view
            self.present(alert, animated: true, completion: nil)
        }else{
            //saves off
             UserDefaults.standard.set(false, forKey: "ashareprayr")
        }
    }
    func toggleonprayr(alertAction: UIAlertAction!){
        UserDefaults.standard.set(true, forKey: "ashareprayr")
    }
    func toggleonverse(alertAction: UIAlertAction!){
        UserDefaults.standard.set(true, forKey: "ashareverse")
    }
    @IBAction func bibletoggled(_ sender: Any) {
        //checks the state of the button and save the values to defaults
        if (shareverseswitch.isOn){
            let alert = UIAlertController(title: "Are You Sure", message: "Allowing Shareing allows anyone to see your verses", preferredStyle: .actionSheet)
            let DeleteAction = UIAlertAction(title: "Allow", style: .destructive, handler: toggleonverse)
            let CancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(DeleteAction)
            alert.addAction(CancelAction)
            alert.popoverPresentationController?.sourceView = self.view
            self.present(alert, animated: true, completion: nil)
        }else{
            //saves off
              UserDefaults.standard.set(false, forKey: "ashareverse")
        }
    }
    //end toggle methods
   
}
//end class
