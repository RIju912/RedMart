//
//  RedmartAllSalesVC.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit
import SystemConfiguration
import NVActivityIndicatorView

var reachability = Reachability()

class RedmartAllSalesVC: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var iboCollectionview: UICollectionView!
    
    var productCollectionRedmart: RedMartDataSource?
    let productCellID = "RedmartProductCell"
    let footerHeight: CGFloat = 44.0
    let collectionViewTopSpaceInset: CGFloat = 16.0
    let refreshControl = UIRefreshControl()
    let size = CGSize(width: 30, height: 30)
    
    var collectionFooterView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(RedmartAllSalesVC.pullToRefresh), for: .valueChanged)
        iboCollectionview.addSubview(refreshControl)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityStatusChanged(_:)), name: .reachabilityChanged, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Check for Internet
        startAnimating(size, message: "Please wait...", type: NVActivityIndicatorType(rawValue: 30)!)
        
        updateInterfaceWithCurrent(networkStatus: reachability.currentReachabilityStatus())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    //MARK: - Pull to Refresh
    func pullToRefresh() {
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 30)!)
        updateInterfaceWithCurrent(networkStatus: reachability.currentReachabilityStatus())
        refreshControl.endRefreshing()
        return
    }
    
    func updateInterfaceWithCurrent(networkStatus: NetworkStatus) {
        switch networkStatus {
        case NotReachable:
            view.backgroundColor = .red
            print("No Internet")
        case ReachableViaWiFi:
            self.loadAllSalesData()
        case ReachableViaWWAN:
            self.loadAllSalesData()
        default:
            return
        }
        
    }
    
    func reachabilityStatusChanged(_ sender: NSNotification) {
        guard let networkStatus = (sender.object as? Reachability)?.currentReachabilityStatus() else { return }
        updateInterfaceWithCurrent(networkStatus: networkStatus)
    }
    
    func loadAllSalesData(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Processing data...")
        }
        Service.sharedInstance().getAllSaleProducts {(collection:RedMartDataSource?, error:Error?) -> Void in
            
            if nil != collection {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
                    self.stopAnimating()
                }
                self.productCollectionRedmart = collection
                self.iboCollectionview.reloadData()
                
            }
            
        }
    }
    
    func shouldLoadNewPage(_ indexPath : IndexPath) -> Bool {
        
        if (indexPath.row + 1 ==  productCollectionRedmart?.redMartAllSalesProducts.count) {
            
            return true
            
        }
        
        return false
        
    }
    
    func setCollectionViewFooterLoadingIndicatorView(_ activityIndicator: Bool) -> () {
        
        if activityIndicator {
            
            let footerView = UIView(frame: CGRect(x: 0, y: iboCollectionview.contentSize.height, width: iboCollectionview.bounds.width, height: footerHeight))
            footerView.backgroundColor = UIColor.clear
            iboCollectionview.addSubview(footerView)
            
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            activityIndicator.tintColor = UIColor.gray
            activityIndicator.center = CGPoint(x:footerView.frame.size.width/2.0, y:footerView.frame.size.height/2.0)
            activityIndicator.startAnimating()
            footerView.addSubview(activityIndicator)
            
            iboCollectionview.contentInset = UIEdgeInsets(top: collectionViewTopSpaceInset, left: 0, bottom: footerHeight, right: 0)
            collectionFooterView = footerView
            
            
        } else {
            
            if let _ = collectionFooterView?.superview {
                
                collectionFooterView?.removeFromSuperview()
                collectionFooterView = nil
                iboCollectionview.contentInset = UIEdgeInsets(top: collectionViewTopSpaceInset, left: 0, bottom: 0, right: 0)
                
            }
            
        }
        
    }


}

extension RedmartAllSalesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK:Collectionview datasources
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (productCollectionRedmart?.redMartAllSalesProducts.count) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellID, for: indexPath) as! RedmartDetailsCollectionVCell
        cell.setupCellForProduct(product: (productCollectionRedmart?.redMartAllSalesProducts[indexPath.row])!)
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.borderWidth = 1.0
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
        
    }
    
    //MARK:Collectionview delegates
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromBottom
        self.navigationController!.view.layer.add(transition, forKey: nil)
        let storyBoardDetail : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let secondViewController = storyBoardDetail.instantiateViewController(withIdentifier: "RedmartDetail") as! RedmartDetailVC
        secondViewController.allProducts = productCollectionRedmart?.redMartAllSalesProducts[indexPath.row]
        self.navigationController?.pushViewController(secondViewController, animated: false)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if shouldLoadNewPage(indexPath) {
            
            setCollectionViewFooterLoadingIndicatorView(true)
            Service.sharedInstance().getAllSaleProductsServicePagination(productCollectionRedmart!) {(collection, error) in
                
                self.setCollectionViewFooterLoadingIndicatorView(false)
                
                if nil != collection {
                    
                    self.productCollectionRedmart = collection
                    self.iboCollectionview.reloadData()
                    
                }
                
                
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let numberOfCell: CGFloat = 3
        let cellWidth = ((iboCollectionview.bounds.size.width) / numberOfCell) - 8.0
        return CGSize(width:cellWidth, height:cellWidth + (0.5 * cellWidth))
        
        
    }
    
    
}
