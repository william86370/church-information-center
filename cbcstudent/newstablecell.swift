//
//  newstablecell.swift
//  cbcstudent
//
//  Created by Admin on 3/19/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit

class newstablecell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var body: UITextView!
    
    @IBOutlet weak var img: UIImageView!
   
   
    
    @IBOutlet weak var linkbtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
