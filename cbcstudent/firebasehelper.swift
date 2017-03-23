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
   class func downloaddata( ref:FIRDatabaseReference, completion: @escaping (_ result: NSDictionary) -> Void) {
        var value =  NSDictionary()
        //calls firebase useing the ref created earlyer
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
           value = (snapshot.value as? NSDictionary)!
            completion(value)
            print("downloaded data from firebasehelkpercalss")
        }) { (error) in
            print(error.localizedDescription)
        }
        }
    func Logout(completionHandler:@escaping (Bool) -> ()) {
                completionHandler(true)
            }
    class func returnkeyarrayofdir(dir:NSDictionary)->[String]{
        var arrayofdirkey = [String]()
        for (key,values) in dir {
            arrayofdirkey.append(key as! String)
        }
            return arrayofdirkey
    }
    class func printdir(dir:NSDictionary){
        
        for (key,values) in dir {
            print("\(key) = \(values)")
        }
    }
    class func getstringfromdir(value:NSDictionary,key:String)-> String{
        let val = value[key]
        return val as! String
    }
    class func containsstiring(dir:NSDictionary,key2:String)-> Bool{
        for (key,values) in dir {
           let info = dir[key] as? NSDictionary
            if info?["name"] as? String == key2 {
                print("here is indoname" + (info?["name"] as? String)!)
                return true
            }
        }
        return false
    }
    class func getstringfromfirebase(ref:FIRDatabaseReference,key:String, completion: @escaping (_ result: String) -> Void){
        var value = NSDictionary()
        downloaddata(ref: ref){
            (result: NSDictionary) in
            value = result
            completion(firebasehelper.getstringfromdir(value: value, key: key))
        }
    }
    class func savefirebasedir(ref:FIRDatabaseReference,valuekey: String){
        firebasehelper.downloaddata(ref: ref){
            (result: NSDictionary) in
            UserDefaults.standard.set(result, forKey: valuekey)
        }
    }
    class func savedefaults(value:Any,key:String){
        UserDefaults.standard.set(value, forKey: key)
    }
    class func retrievedefaults(key:String)-> Any{
        if firebasehelper.valuexists(valuekey: key){
            return UserDefaults.standard.value(forKey: key)!
        }
        return " "
    }
    class func retrevefirebasedir(valuekey:String)->NSDictionary{
        if(firebasehelper.valuexists(valuekey: valuekey)){
            return UserDefaults.standard.value(forKey: valuekey) as! NSDictionary
        }
        print("the dir at " + valuekey + " dosent exist")
        return NSDictionary()
    }
    class func valuexists(valuekey:String)-> Bool{
        if(UserDefaults.standard.value(forKey: valuekey) != nil){
            return true
        }
        return false
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
    class func addtosmallgroup(groupname:String, name:String,grade:String, completion: @escaping() -> Void) {
       let ref = FIRDatabase.database().reference().child("smallgroups").child(groupname).child(name)
        ref.child("name").setValue(name)
        ref.child("grade").setValue(grade)
    }
  class func addnewstofirebase(title:String,Body:String,url:String,Pictureurl:String){
     var ref: FIRDatabaseReference!
    ref = FIRDatabase.database().reference().child("news").child(title)
    ref.child("title").setValue(title)
    ref.child("body").setValue(Body)
    ref.child("link").setValue(url)
    ref.child("pic").setValue(Pictureurl)
    }
    class func removenewsdata(title:String){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference().child("news").child(title)
        ref.removeValue()
    }
}
