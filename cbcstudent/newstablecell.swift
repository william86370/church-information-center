//
//  newstablecell.swift
//  cbcstudent
//
//  Created by Admin on 3/19/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit
import JTMaterialSpinner
import Firebase
import AudioToolbox
class newstablecell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var linkbtn: UIButton!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var sharebtn: UIButton!
    @IBOutlet weak var likebtn: UIButton!
    @IBOutlet weak var linklbl: UILabel!
    @IBOutlet weak var moreinfobtn: UIButton!
    var likestate = false
    var likedlosts = [String]()
    
    
    
   var spinner = JTMaterialSpinner()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func liketapped(_ sender: Any) {
        if likestate == true{
            likebtn.setImage(UIImage(named: "Like-50"), for: WrightFramework.getbtnstate(btn: likebtn))
            
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            likestate = false
            UserDefaults.standard.set(false, forKey: title.text! + "like")
            print(title.text! + "like")
            var inde = likedlosts.index(of: title.text! + "like")
            likedlosts.remove(at: inde!)
            firebasehelper.savedefaults(value: likedlosts, key: "likedtitles")
        }else{
            likebtn.setImage(UIImage(named: "Like Filled-50"), for: WrightFramework.getbtnstate(btn: likebtn))
          
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            likestate = true
            UserDefaults.standard.set(true, forKey: title.text! + "like")
             print(title.text! + "like")
            likedlosts.append(title.text! + "like")
            firebasehelper.savedefaults(value: likedlosts, key: "likedtitles")
            
        }
    }
    @IBAction func sharetapped(_ sender: Any) {
    }
    @IBAction func moreinfotapped(_ sender: Any) {
    }
    

    
    
    
}
