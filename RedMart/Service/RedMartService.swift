//
//  RedMartService.swift
//  RedMart
//
//  Created by Subhodip on 27/02/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    
    let tron = TRON(baseURL: "https://api.redmart.com/v1.5.7/catalog/")
    
    static let sharedInstance = Service()
    
    func fetchHomeFeed(completion: @escaping (RedMartDataSource?, Error?) -> ()) {
        
        let request: APIRequest<RedMartDataSource, JSONError> = tron.request("search?theme=all-sales&pageSize=30&page=0")
        
        request.perform(withSuccess: { (homeDatasource) in
            completion(homeDatasource, nil)
        }) { (err) in
            
            completion(nil, err)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
    
}
