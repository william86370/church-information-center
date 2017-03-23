//
//  FirstViewController.swift
//  cbcstudent
//
//  Created by William Wright on 3/17/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var acesscode: UITextField!
    @IBOutlet weak var accountname: UITextField!
    @IBOutlet weak var grade: UITextField!

var name = String()
    
    override func viewDidLoad() {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        
        
                
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        if(acesscode.text == "2357"){
            print(acesscode.text!)
            print(accountname.text!)
            print(grade.text!)
            
            UserDefaults.standard.setValue(accountname.text, forKey: "aname")
            UserDefaults.standard.setValue(grade.text, forKey: "agrade")
            performSegue(withIdentifier: "login", sender: self)
            
        }else{
            let alertController = UIAlertController(title: "whopse", message: "wrong code", preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion:nil)
        }
        
        
    }
    
    
}

