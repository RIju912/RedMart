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
    
    //MARK: - Model Class Variables
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
    
    //MARK: - Init
    init(json: JSON){
        
        super.init()
        
        if let prodID = json["id"].string{
            id = prodID
        }else{
            id = UrlConstants.notApplicable
        }
        
        
        if let prodSku = json["sku"].string{
            sku = prodSku
        }else{
            sku = UrlConstants.notApplicable
        }
        
        
        if let prodStatus = json["details"]["status"].int{
            status = prodStatus
        }else{
            status = UrlConstants.notApplicableInteger
        }
        
        
        if let prodTitle = json["title"].string{
            title = prodTitle
        }else{
            title = UrlConstants.notApplicable
        }
        
        
        if let prodDetails = json["desc"].string{
            details = prodDetails
        }else{
            details = UrlConstants.notApplicable
        }
        
        
        if let prodImage = json["img"]["name"].string{
            coverImage = UrlConstants.productImageAPI.appending(prodImage)
        }else{
            coverImage = UrlConstants.notApplicable
        }
        
        
        if let prodLifeTime = json["product_life"]["time"].int, let prodLifeMetric = json["products"]["product_life"]["metric"].string{
            lifeTime = "\(prodLifeTime)" + prodLifeMetric
        }else{
            lifeTime = UrlConstants.notApplicable
        }
        
        
        if let prodPrice = json["pricing"]["price"].string{
            price = "$"+prodPrice
        }else{
            price = UrlConstants.notApplicable
        }
        
        
        if let prodStockStatus = json["inventory"]["stock_status"].int{
            stockStatus = prodStockStatus
        }else{
            stockStatus = UrlConstants.notApplicableInteger
        }
        
        
        if let prodStockM = json["measure"]["wt_or_vol"].string{
            stockMeasure = prodStockM
        }else {
            stockMeasure = UrlConstants.notApplicable
        }
        
        
        if let imageList = json["images"].array{
            for image in imageList {
                
                images?.append(UrlConstants.productImageAPI.appending(image["name"].stringValue))
            }
        }else{
            images = []
        }
        
    }
    
    //MARK: - Clear Data
    func clear() {
        id = ""
        sku = ""
        status = 0
        title = ""
        details = ""
        coverImage = ""
        images = []
        lifeTime = ""
        price = ""
        stockStatus = 0
        stockMeasure = ""
    }
}
