//
//  RedMartAllSalesProducts.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 05/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit
import SwiftyJSON

class RedMartAllSalesProducts: NSObject{
    
    var id: String?
    var sku: String?
    var status: Int?
    var title: String?
    var details: String?
    var coverImage:String?
    var images: [String]?
    var lifeTime: String?
    var price: String?
    var stockStatus: Int?
    var stockMeasure: String?
    
    init (json: JSON) {
        
        super.init()
        
        id = json["id"].stringValue
        sku = json["sku"].stringValue
        status = json["details"]["status"].int
        title = json["title"].stringValue
        details = json["desc"].stringValue
        coverImage = UrlConstants.productImageAPI.appending(json["img"]["name"].stringValue)
        lifeTime = "\(json["product_life"]["time"].int)" + json["products"]["product_life"]["metric"].stringValue
        price = "$"+json["pricing"]["price"].stringValue
        stockStatus = json["inventory"]["stock_status"].int
        stockMeasure = json["measure"]["wt_or_vol"].stringValue
        
        let imageList = json["images"].array
        
        for image in imageList! {
            
            images?.append(UrlConstants.productImageAPI.appending(image["name"].stringValue))
        }
        
    }
}
