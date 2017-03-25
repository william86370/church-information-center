//
//  admin.swift
//  cbcstudent
//
//  Created by William Wright on 3/20/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit

class admin: UIViewController {

    @IBOutlet weak var added: UILabel!
    @IBOutlet weak var groupname: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var grade: UITextField!
    let leader = firebasehelper.retrievedefaults(key: "aleader") as? Bool
    override func viewDidLoad() {
       
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func add(_ sender: Any) {
        
        firebasehelper.addtosmallgroup(groupname: groupname.text!, name: name.text!, grade: grade.text!,leader:leader!){
            self.added.text = "done"
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
