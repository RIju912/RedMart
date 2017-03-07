//
//  RedmartDetailsVCell.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit

class RedmartDetailsVCell: UITableViewCell {

    @IBOutlet weak var iboDeatilsTextView: UITextView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    func setupCellFor(product: RedMartAllSalesProducts) {
        
        iboDeatilsTextView.text = product.details ?? ""
        
    }

}
