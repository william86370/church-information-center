//
//  newstablecontroller.swift
//  cbcstudent
//
//  Created by William Wright on 3/17/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//
import UIKit
import Firebase
import Kingfisher
class newstablecontroller: UITableViewController {
    var name = String()
    var grade = String()
    var count = Int()
    var newstitles = [String]()
    var titles = [String]()
    var bodys = [String]()
    var links = [String]()
    var pictures = [String]()
    var selectedtitle = String()
    var selectedbody = String()
    var selectedlink = String()
    var selectedpic = String()
    let prefs = UserDefaults.standard
    //set firebase database from file
    //let ref = FIRDatabase.database().reference(withPath: "news")
    override func viewDidLoad() {
        if prefs.string(forKey: "aname") != nil{
            name = prefs.string(forKey: "aname")!
            grade = prefs.string(forKey: "agrade")!
            
            
            print(name)
            loadfirebase()
        }else{
            print("nothingstored")
            gotologin()
        }
         self.refreshControl?.addTarget(self, action: #selector(self.refeash), for: UIControlEvents.valueChanged)
        
        super.viewDidLoad()
    }
    func gotologin(){
         self.performSegue(withIdentifier: "go", sender: self)
    }
    func loadfirebase(){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("news").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print("receved snapshot")
            //let news1 = value?["first"] as? NSDictionary
            firebasehelper.printdir(dir: value!)
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
        }) { (error) in
            print(error.localizedDescription)
        }
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
        let url = URL(string: pictures[row])!
        cell.img.kf.setImage(with: url)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print the row that the user selects
        print("Row \(indexPath.row)selected")
        //change the varubles for the selevted items
         selectedtitle = self.titles[indexPath.row]
        selectedbody = self.bodys[indexPath.row]
         selectedlink = self.links[indexPath.row]
         selectedpic = self.pictures[indexPath.row]
        //go and do the segue
        performSegue(withIdentifier: "news", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "news"){
            let vc = segue.destination as! webview
            vc.titl = selectedtitle
            vc.body = selectedbody
            vc.pic = selectedpic
            vc.link = selectedlink
        }
    }
    func refeash(){
         count = 0
         newstitles = [String]()
         titles = [String]()
         bodys = [String]()
         links = [String]()
         pictures = [String]()
        loadfirebase()
        self.refreshControl?.endRefreshing()
    }
}
