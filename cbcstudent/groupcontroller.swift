//
//  groupcontroller.swift
//  cbcstudent
//
//  Created by Admin on 3/20/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit
import Firebase
class groupcontroller: UIViewController {
    var smallgroups = [NSDictionary]()
    var groupnames = [String]()
    
    
  
    override func viewDidLoad() {
        
       let ref = FIRDatabase.database().reference().child("smallgroups")
        var value =  NSDictionary()
        //calls firebase useing the ref created earlyer
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            value = (snapshot.value as? NSDictionary)!
           // firebasehelper.printdir(dir: value)
            for (key,values) in value {
                self.smallgroups.append(value[key] as! NSDictionary)
                self.groupnames.append(key as! String)
                print(value[key]!)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
