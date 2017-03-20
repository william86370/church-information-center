//
//  FirstViewController.swift
//  cbcstudent
//
//  Created by Admin on 3/17/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var acesscode: UITextField!
    @IBOutlet weak var accountname: UITextField!
    @IBOutlet weak var grade: UITextField!

var name = String()
    
    override func viewDidLoad() {
        
        
        
                
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

