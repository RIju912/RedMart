//
//  RedMartService.swift
//  RedMart
//
//  Created by Subhodip on 27/02/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import TRON

class Service: NSObject{
    
    private static var sharedService: Service = {
        
        let networkManager = Service()
        return networkManager
        
    }()
    
    class func sharedInstance() -> Service {
        
        return sharedService
        
    }
    
    func fetchProducts(_ completion:@escaping ((RedMartDataSource?, Error?) -> Void)) {
        
        fetchProductsFor(collection: RedMartDataSource(), completion: completion)
        
    }
    
    
    
    func fetchNextPageForProductCollection(_ collection:RedMartDataSource, completion:@escaping ((RedMartDataSource?, Error?) -> Void)) {
        
        collection.redMartAllSalesPagination.pageIndex += 1
        fetchProductsFor(collection: collection, completion: completion)
        
    }
    
    //MARK:Private methods
    
    private func fetchProductsFor(collection:RedMartDataSource, completion:@escaping ((RedMartDataSource?, Error?) -> Void)) {
        
        let allSalesAPI = UrlConstants.productListAPI.appending("pageSize=\(collection.redMartAllSalesPagination.pageSize)&Page=\(collection.redMartAllSalesPagination.pageIndex)")
        Alamofire.request(allSalesAPI).validate().responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                if let data = response.data {
                    
                    let jsonError:NSErrorPointer? = nil
                    let json = JSON(data: data, options:JSONSerialization.ReadingOptions.allowFragments, error: jsonError!)
                    
                    if let jsonError = jsonError {
                        
                        completion(nil, jsonError as? Error)
                        
                    }
                    else {
                        
                        if let productList = json["products"].array {
                            
                            for productJson in productList {
                                
                                let product = RedMartAllSalesProducts(json: productJson)
                                collection.redMartAllSalesProducts.append(product)
                                
                            }
                            
                        }
                        
                        completion(collection, nil)
                        
                    }
                    
                }
                
            case.failure(let error):
                
                completion(nil, error)
                
            }
            
            
        }
        
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
    
}
