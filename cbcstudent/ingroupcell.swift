
//
//  ingroupcell.swift
//  cbcstudent
//
//  Created by Admin on 3/20/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit
import Firebase
class ingroupcell: UITableViewCell {
    @IBOutlet weak var namelbl: UILabel!

    @IBOutlet weak var isleaderlbl: UILabel!
    let name = firebasehelper.retrievedefaults(key: "aname") as? String
    let grade = firebasehelper.retrievedefaults(key: "agrade") as? String
    let leader = firebasehelper.retrievedefaults(key: "aleader") as? Bool
    let shareprayr = firebasehelper.retrievedefaults(key: "ashareprayr") as? Bool
    let shareverse = firebasehelper.retrievedefaults(key: "ashareverse") as? Bool

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
