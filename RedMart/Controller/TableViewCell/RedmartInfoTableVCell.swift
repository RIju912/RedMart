//
//  RedmartInfoTableVCell.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit

class RedmartInfoTableVCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var iboPriceLabel: UILabel!
    @IBOutlet weak var iboLifeTimeLabel: UILabel!
    @IBOutlet weak var iboMerchantName: UILabel!
    @IBOutlet weak var iboMerchantLogo: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    //MARK: - Cell Setup
    func setupCellFor(product: RedMartAllSalesProducts) {
        
        iboPriceLabel.text = product.price ?? UrlConstants.notApplicable
        iboLifeTimeLabel.text = product.stockMeasure ?? UrlConstants.notApplicable
        if product.merchantName != ""{
        iboMerchantName.text = product.merchantName ?? UrlConstants.notApplicable
        }else{
          iboMerchantName.text = UrlConstants.notApplicable  
        }
        iboMerchantLogo.setImageFromURL(product.merchantLogo ?? "", placeHolder: nil)
        
    }

}
