//
//  ViewController.swift
//  RedMart
//
//  Created by Subhodip on 27/02/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Service.sharedInstance().fetchProducts {(collection:RedMartDataSource?, error:Error?) -> Void in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

