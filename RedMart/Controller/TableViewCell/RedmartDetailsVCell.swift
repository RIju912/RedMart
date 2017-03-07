//
//  RedmartDetailsVCell.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit

class RedmartDetailsVCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var iboDeatilsTextView: UITextView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    //MARK: - Cell Setup
    func setupCellFor(product: RedMartAllSalesProducts) {
        
        iboDeatilsTextView.text = product.details ?? UrlConstants.notApplicable
        
    }

}
