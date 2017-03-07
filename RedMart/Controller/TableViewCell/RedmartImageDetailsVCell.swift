//
//  RedmartImageDetailsVCell.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit

class RedmartImageDetailsVCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var iboProductImageView: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.iboProductImageView.clipsToBounds = true
        
    }
    
    //MARK: - Cell Setup
    func setupCellFor(product: RedMartAllSalesProducts) {
        
        iboProductImageView.setImageFromURL(product.coverImage ?? "", placeHolder: nil)
        
    }

}
