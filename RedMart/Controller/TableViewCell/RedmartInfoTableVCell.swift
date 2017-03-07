//
//  RedmartInfoTableVCell.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit

class RedmartInfoTableVCell: UITableViewCell {

    @IBOutlet weak var iboPriceLabel: UILabel!
    @IBOutlet weak var iboLifeTimeLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    func setupCellFor(product: RedMartAllSalesProducts) {
        
        iboPriceLabel.text = product.price ?? ""
        iboLifeTimeLabel.text = product.stockMeasure ?? ""
        
    }

}
