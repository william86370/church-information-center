//
//  newstablecontroller.swift
//  cbcstudent
//
//  Created by William Wright on 3/17/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit
import Firebase

class newstablecontroller: UITableViewController {
var name = String()
    var count = Int()
    var newstitles = [String]()
    
    
    
    var titles = [String]()
    var bodys = [String]()
    var links = [String]()
    var pictures = [String]()
    
    
    
    
    
    
    let prefs = UserDefaults.standard
    //set firebase database from file
    //let ref = FIRDatabase.database().reference(withPath: "news")
    
    
    
    
    
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
            
            self.tableView.reloadData()
            
        
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //connect to firebase server
        

        if prefs.string(forKey: "aname") != nil{
            
            print(name)
        }else{
            print("nothingstored")
            performSegue(withIdentifier: "login", sender: nil)
        }
        

        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath) as! newstablecell
        
        let row = indexPath.row
        
        
        
        cell.title.text = titles[row]
        cell.body.text = bodys[row]
        
        
        
        print(titles[row])
        print(bodys[row])
        print("ran")
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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
