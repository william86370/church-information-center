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
import JTMaterialSpinner
class newstablecontroller: UITableViewController {
    //values for the user
    var name = String()
    var grade = String()
    //value for the total amout of news articles
    var count = Int()
    //array of the news titles
    var newstitles = [String]()
    //info about each post
    var titles = [String]()
    var bodys = [String]()
    var links = [String]()
    var pictures = [String]()
    var dates = [String]()
    //vars about what each item is when the user clicks on them
    var selecteddate = String()
    var selectedtitle = String()
    var selectedbody = String()
    var selectedlink = String()
    var selectedpic = String()
    //var for storeing values
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
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func gotologin(){
        //if user isnt logged in we send them dirextly to the login page insted of loading firebase becuase it will crash
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
                self.dates.append((newtitle!["date"] as? String)!)
                self.count += 1
                self.newstitles.append(key as! String)
            }
            print(self.count)
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
            print("something went wrong with loading firebase from the server some value is messed up")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath) as! newstablecell
        //see how wea re seing it to indexpath.section becuase we are not doing rows of cells we are doing it by sections allowing for the border of each cell
        let row = indexPath.section
        //code to make the cell have a border
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 10
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        //end
        //here we are seting the values of each cell
        cell.title.text = titles[row]
        cell.body.text = bodys[row]
        let index = links[row].index(links[row].startIndex, offsetBy: 7)
        cell.datelbl.text = dates[row]
        cell.linklbl.text = links[row].substring(from: index)
        let url = URL(string: pictures[row])!
        //here is when we load the photo from the cell
        cell.img.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            cell.spinner.endRefreshing()
        })
                return cell
    }
   // override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     //   return 40
    //}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print the row that the user selects
        print("Row \(indexPath.section)selected")
        //change the varubles for the selevted items
        let row = indexPath.section
         selectedtitle = self.titles[row]
        selectedbody = self.bodys[row]
         selectedlink = self.links[row]
         selectedpic = self.pictures[row]
        selecteddate = self.dates[row]
        //after we set all of the values for the row the user selcted we goto the webview
        performSegue(withIdentifier: "news", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "news"){
            //set the destanation view controller
            let vc = segue.destination as! webview
            vc.titl = selectedtitle
            vc.body = selectedbody
            vc.pic = selectedpic
            vc.link = selectedlink
            //vc.date = selecteddate
        }
    }
    func refeash(){
         count = 0
         newstitles = [String]()
         titles = [String]()
         bodys = [String]()
         links = [String]()
         pictures = [String]()
        dates = [String]()
        //reset all of the values and run firebase to load all the new values
        loadfirebase()
        //then we stop the view from updateing
        self.refreshControl?.endRefreshing()
    }
}
