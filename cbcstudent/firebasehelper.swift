//
//  firebasehelper.swift
//  Wrightframework
//
//  Created by William Wright on 3/20/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import Foundation
import Firebase
class firebasehelper {
   class func downloaddata( ref:FIRDatabaseReference) -> NSDictionary {
        var value =  NSDictionary()
        //calls firebase useing the ref created earlyer
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
           value = (snapshot.value as? NSDictionary)!
        }) { (error) in
            print(error.localizedDescription)
        }
      return value
        }
    class func printdir(dir:NSDictionary){
        
        for (key,values) in dir {
            print("\(key) = \(values)")
        }
    }
    class func createnewgroup(groupname:String)-> Bool {
        if addtofirebase(ref: FIRDatabase.database().reference().child("smallgroups"), data: groupname) {
         return true
        }else{
            return false
        }
    }
    class func addtofirebase(ref:FIRDatabaseReference ,data:String)-> Bool{
        ref.setValue([data:""])
        return true
    }
    class func addtosmallgroup(groupname:String, name:String,grade:String)-> Bool {
       let ref = FIRDatabase.database().reference().child("smallgroups").child(groupname).child(name)
        ref.child("name").setValue(name)
        ref.child("grade").setValue(grade)
        return true
    }
  class func addnewstofirebase(title:String,Body:String,url:String,Pictureurl:String){
     var ref: FIRDatabaseReference!
    ref = FIRDatabase.database().reference().child("news").child(title)
    ref.child("title").setValue(title)
    ref.child("body").setValue(body)
    ref.child("link").setValue(url)
    ref.child("pic").setValue(Pictureurl)
    }
    class func removenewsdata(title:String){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference().child("news").child(title)
        ref.removeValue()
    }
}
