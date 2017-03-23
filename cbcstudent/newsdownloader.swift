//
//  newsdownloader.swift
//  cbcstudent
//
//  Created by William Wright on 3/19/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit
import Firebase

class newsdownloader: UIViewController {
    var name = String()
    var count = Int()
    var newstitles = [String]()
    
    
    
    var titles = [String]()
    var bodys = [String]()
    var links = [String]()
    var pictures = [String]()
    
    
    
    
    
    
    let prefs = UserDefaults.standard

    
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        
        
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        
        
        
        
        ref.child("news").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print("hi")
            
            //let news1 = value?["first"] as? NSDictionary
            
            
            
            for (key,values) in value! {
                print("\(key) = \(values)")
                
                let newtitle = value![key] as? NSDictionary
                
                self.titles.append((newtitle!["title"] as? String)!)
                self.bodys.append((newtitle!["body"] as? String)!)
                self.links.append((newtitle!["link"] as? String)!)
                self.pictures.append((newtitle!["pic"] as? String)! )
                self.count += 1
                self.newstitles.append(key as! String)
            }
            print(self.count)
            
            
         
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //connect to firebase server
        
        
        
        
        
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
