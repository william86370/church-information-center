//
//  WrightFramework.swift
//  cbcstudent
//
//  Created by william wright on 3/24/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import Foundation
import Firebase
import JTMaterialSpinner
import Kingfisher
class WrightFramework {
    class func setdefauts(val:Any,key:String){
        //@info takes in a value and key to save it as and saves it to defaults
        UserDefaults.standard.set(val, forKey: key)
        //@return none
    }
    class func getdefaults(key:String)->Any{
        //@info takes in 
        if UserDefaults.standard.value(forKey: key) != nil{
        return UserDefaults.standard.value(forKey: key)!
        }
        return false
    }
    class func returnleaderingroup(dir:NSDictionary)->String{
        for (key,values) in dir {
            let info = dir[key] as? NSDictionary
            if info?["leader"] as? Bool == true {
             return ("Leader: " + (info?["name"] as? String)!)
            }
        }
        return ("Leader: None")
    }
    class func removefromgroup(group:String,name:String){
       var ref = FIRDatabase.database().reference().child("smallgroups").child(group).child(name)
        ref.removeValue()
    }
    class func returnnumberingroup(dir:NSDictionary)->Int{
        var students = 0
        for (key,values) in dir {
            let info = dir[key] as? NSDictionary
           students = students + 1
            }
        return students
    }
    class func getbtnstate(btn:UIButton)-> UIControlState{
     //@info this class takes in a button and detemrnas what the selected state is
     //@return this class returns the state of the button given 
        if(btn.isSelected){
            return UIControlState.selected
        }
        return UIControlState.normal
    }
    //for my news class getting the status of the like
    class func getlikestatus(key:String)->Bool{
        //@info takes in the title of the news post
        //@return returns if the post has been liked by the current user or not
        if UserDefaults.standard.value(forKey: key) != nil{
            return UserDefaults.standard.bool(forKey: key)
        }else{
        UserDefaults.standard.set(false, forKey: key)
        }
        return false
    }
    
}
