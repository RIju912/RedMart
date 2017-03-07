//
//  UIImageView+LazyLoader.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import Foundation
import UIKit

//TO-DO,Removal of cached responses on demand.Whenever app requests for purge memory
//Or on every fresh launch of App
//Cache policy?
public extension UIImageView {
    fileprivate func setImageData(_ cachedResponse:CachedURLResponse?,placeHolder:String?) {
        //UI operation,Should be over main thread.
        if let data = cachedResponse?.data {
            if let img = UIImage(data: data) {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.image = img
                })
            } else {
                if let hlder = placeHolder {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.image = UIImage(named: hlder)
                    })
                }
            }
        } else {
            if let hlder = placeHolder {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.image = UIImage(named: hlder)
                })
            }
        }
    }
    
    func setImageFromURL(_ urlString:String,placeHolder:String?) {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: { () -> Void in
            if let url =  URL(string: urlString) {
                let request = URLRequest(url: url)
                
                if let cachedUrlResponse = URLCache.shared.cachedResponse(for: request) {
                    self.setImageData(cachedUrlResponse,placeHolder: placeHolder)
                } else {
                    //Set place holder
                    if let placeHolder = placeHolder {
                        self.setImageData(nil, placeHolder: placeHolder)
                    }
                    //Fetch remote image
                    let urlInstance = URL(string: urlString)
                    let request = URLRequest(url: urlInstance!, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30)
                    var response:URLResponse?
                    //var error:NSError?
                    let data: Data?
                    do {
                        data = try NSURLConnection.sendSynchronousRequest(request, returning: &response)
                    } catch _ as NSError {
                        //error = error1
                        data = nil
                    } catch {
                        fatalError()
                    }
                    if let response = response ,let data = data {
                        let cachedResponse = CachedURLResponse(response: response, data: data)
                        URLCache.shared.storeCachedResponse(cachedResponse , for: request)
                        self.setImageData(cachedResponse, placeHolder: placeHolder)
                    }
                }
            } else {
                if let placeHolder = placeHolder {
                    self.setImageData(nil, placeHolder: placeHolder)
                }
            }
        })
    }
}
