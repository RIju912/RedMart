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

//MARK: - Extension
extension UIColor {
    
    class func redMartBGColor () -> UIColor {
        return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    }
    
}

extension UIViewController {
    
    //MARK: - default alert/info message with an OK button.
    func showAlertMessage(_ message: String, okButtonTitle: String = "Ok") -> Void {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

//*******************Extension to handle Optional value************************//
extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        if self == nil{
            return defaultValue
        }
        else if self is NSNull{
            return defaultValue
        }else{
            return self!
        }
    }
}
//*******************Extension to handle Optional value************************//

