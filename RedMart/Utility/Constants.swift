//
//  Constants.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 06/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Constants
struct UrlConstants {
    
    static var productListAPI = "https://api.redmart.com/v1.5.7/catalog/search?theme=all-sales&"
    static var productImageAPI = "http://media.redmart.com/newmedia/200p"
    static var notApplicable = "N/A"
    static var notApplicableInteger = 0
    
}

extension UIColor {
    
    class func redMartBGColor () -> UIColor {
        return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    }
    
}

