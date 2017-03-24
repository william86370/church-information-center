
//
//  webview.swift
//  cbcstudent
//
//  Created by Admin on 3/20/17.
//  Copyright © 2017 A.R.C software and enggering. All rights reserved.
//

import UIKit

class webview: UIViewController , UIWebViewDelegate{
var link = String()
    @IBOutlet weak var webviewv: UIWebView!
var titl = String()
var body = String()
var pic = String()
    override func viewDidLoad() {
        navigationItem.title = titl
        webviewv.delegate = self
       
           webviewv.loadRequest(URLRequest(url: URL(string: link)!))
            print(pic)
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
