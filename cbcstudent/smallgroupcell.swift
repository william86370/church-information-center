//
//  smallgroupcell.swift
//  cbcstudent
//
//  Created by William Wright on 3/20/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit
import JTMaterialSpinner
class smallgroupcell: UITableViewCell {
    
    

    @IBOutlet weak var groupname: UILabel!
    
     var spinner = JTMaterialSpinner()
    
    @IBOutlet weak var numofmembers: UILabel!
    @IBOutlet weak var leadrsingrouplbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.addSubview(spinner)
        spinner.frame = CGRect(x: 335, y: 34, width: 30, height: 30)
        
        spinner.circleLayer.lineWidth = 2.0
        spinner.circleLayer.strokeColor = UIColor.orange.cgColor
        
        spinner.animationDuration = 2
        spinner.beginRefreshing()

       
    }
    
}
