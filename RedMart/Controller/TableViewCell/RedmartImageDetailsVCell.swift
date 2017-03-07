//
//  RedmartImageDetailsVCell.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit

class RedmartImageDetailsVCell: UITableViewCell {

    @IBOutlet weak var iboProductImageView: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.iboProductImageView.clipsToBounds = true
        
    }
    
    func setupCellFor(product: RedMartAllSalesProducts) {
        
        iboProductImageView.setImageFromURL(product.coverImage ?? "", placeHolder: nil)
        
    }

}
