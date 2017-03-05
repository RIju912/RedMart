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


class Service: NSObject{
    
    //MARK: - Shared Instance
    private static var sharedService: Service = {
        
        let networkManager = Service()
        return networkManager
        
    }()
    
    class func sharedInstance() -> Service {
        
        return sharedService
        
    }
    
    //MARK: - Main API Call
    func getAllSaleProducts(_ completion:@escaping ((RedMartDataSource?, Error?) -> Void)) {
        
        getAllSaleProductsService(collection: RedMartDataSource(), completion: completion)
        
    }
    
    
    //MARK: - Pagination API Call
    func getAllSaleProductsServicePagination(_ collection:RedMartDataSource, completion:@escaping ((RedMartDataSource?, Error?) -> Void)) {
        
        collection.redMartAllSalesPagination.pageIndex += 1
        getAllSaleProductsService(collection: collection, completion: completion)
        
    }
    
    //MARK: - Main API Skeleton
    private func getAllSaleProductsService(collection:RedMartDataSource, completion:@escaping ((RedMartDataSource?, Error?) -> Void)) {
        
        let allSalesAPI = UrlConstants.productListAPI.appending("pageSize=\(collection.redMartAllSalesPagination.pageSize)&Page=\(collection.redMartAllSalesPagination.pageIndex)")
        Alamofire.request(allSalesAPI).validate().responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                if let data = response.data {
                    
                    let jsonError:NSErrorPointer? = nil
                    let json = JSON(data: data, options:JSONSerialization.ReadingOptions.allowFragments, error: nil)
                    
                    if let jsonError = jsonError {
                        
                        completion(nil, jsonError as? Error)
                        
                    }
                    else {
                        
                        guard let productList = json["products"].array else{
                            return
                        }
                        
                        for productJson in productList {
                            
                            let product = RedMartAllSalesProducts(json: productJson)
                            collection.redMartAllSalesProducts.append(product)
                            
                        }
                        
                        completion(collection, nil)
                        
                    }
                    
                }
                
            case.failure(let error):
                
                completion(nil, error)
                
            }
            
            
        }
        
    }
    
}
