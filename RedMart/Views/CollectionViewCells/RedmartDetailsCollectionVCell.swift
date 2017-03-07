//
//  RedmartDetailsCollectionVCell.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit


class RedmartDetailsCollectionVCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var iboCoverImageView: UIImageView!
    @IBOutlet weak var iboProductNameLabel: UILabel!
    @IBOutlet weak var iboPriceLabel: UILabel!
    @IBOutlet weak var iboStockMeasure: UILabel!
    
    //MARK: - Cell Setup
    func setupCellForProduct(product: RedMartAllSalesProducts)  {
        
        iboCoverImageView.setImageFromURL((product.coverImage ?? ""), placeHolder: nil)
        iboCoverImageView.clipsToBounds = true
        iboProductNameLabel.text = product.title ?? UrlConstants.notApplicable
        iboPriceLabel.text = product.price ?? UrlConstants.notApplicable
        iboStockMeasure.text = product.stockMeasure ?? UrlConstants.notApplicable
        
    }
    
    
}
