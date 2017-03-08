//
//  RedmartImageDetailsVCell.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit

class RedmartImageDetailsVCell: UITableViewCell{

    //MARK: - Outlets
    @IBOutlet weak var iboScrollView: UIScrollView!
    @IBOutlet weak var iboPageControl: UIPageControl!
    
    var allProducts: RedMartAllSalesProducts?
    var imageViewFrame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var imageViews = [UIImageView]()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        iboScrollView.delegate = self
        
    }
    
    //MARK: - Cell Setup
    func setupCellFor(product: RedMartAllSalesProducts) {
        
        self.allProducts = product
        
        configurePageScroll()
        
        for index in 0..<product.images.count {
            
            imageViewFrame.origin.x = self.iboScrollView.frame.size.width * CGFloat(index)
            imageViewFrame.size = self.iboScrollView.frame.size
            self.iboScrollView.isPagingEnabled = true
            
            let productImageView = UIImageView(frame: imageViewFrame)
            productImageView.clipsToBounds = true
            productImageView.contentMode = .scaleAspectFill
            
            self.iboScrollView.addSubview(productImageView)
            imageViews.append(productImageView)
            productImageView.setImageFromURL(product.images[index], placeHolder: "PlaceHolder")
            
        }
        
        self.iboScrollView.contentSize = CGSize(width:self.iboScrollView.frame.size.width * CGFloat(product.images.count), height:self.iboScrollView.frame.size.height)
        iboPageControl.addTarget(self, action: #selector(RedmartImageDetailsVCell.scrollPage(sender:)), for: UIControlEvents.valueChanged)
        
    }
    
    //MARK: - Configure Page
    func configurePageScroll() {
        
        self.iboPageControl.numberOfPages = (allProducts?.images.count).or(0)
        self.iboPageControl.currentPage = 0
        self.iboPageControl.tintColor = UIColor.lightGray
        self.iboPageControl.pageIndicatorTintColor = UIColor.black
        self.iboPageControl.currentPageIndicatorTintColor = UIColor.white
        
        if allProducts?.images.count == 1 {
            
            iboPageControl.isHidden = true
            iboScrollView.isScrollEnabled = false
            
        }
        
    }
    
    //MARK: - Scroll Page
    func scrollPage(sender: AnyObject) -> () {
        
        let x = CGFloat(iboPageControl.currentPage) * iboScrollView.frame.size.width
        iboScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
    }
}


//MARK: - Scroll View Delegate
extension RedmartImageDetailsVCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = Int (round(scrollView.contentOffset.x / scrollView.frame.size.width))
        
        if pageNumber < (allProducts?.images.count).or(0) {
            
            let imageView = imageViews[pageNumber]
            imageViewFrame.origin.x = self.iboScrollView.frame.size.width * CGFloat(pageNumber)
            imageViewFrame.size = self.iboScrollView.frame.size
            imageView.frame = imageViewFrame
            iboPageControl.currentPage = Int(pageNumber)
            
        }
        
    }
}
