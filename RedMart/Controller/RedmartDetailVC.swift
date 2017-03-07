//
//  RedmartDetailVC.swift
//  RedMart
//
//  Created by Subhodip Banerjee on 07/03/17.
//  Copyright © 2017 Subhodip. All rights reserved.
//

import UIKit

class RedmartDetailVC: UIViewController {

    var allProducts: RedMartAllSalesProducts?
    
    @IBOutlet weak var iboProductDetails: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        iboProductDetails.text = allProducts?.title

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ibaBackButtonPressed(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromBottom
        self.navigationController!.view.layer.add(transition, forKey: nil)
        let storyBoardDetail : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let secondViewController = storyBoardDetail.instantiateViewController(withIdentifier: "RedmartAllSales") as! RedmartAllSalesVC
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }

}

extension RedmartDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedmartImageDetailsVCell", for: indexPath) as! RedmartImageDetailsVCell
            cell.setupCellFor(product: allProducts!)
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedmartInfoTableVCell", for: indexPath) as! RedmartInfoTableVCell
            cell.setupCellFor(product: allProducts!)
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedmartDetailsVCell", for: indexPath) as! RedmartDetailsVCell
            cell.setupCellFor(product: allProducts!)
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedmartInfoTableVCell", for: indexPath) as! RedmartInfoTableVCell
            cell.setupCellFor(product: allProducts!)
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return 250.0
            
        case 1:
            return 30.0
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedmartDetailsVCell") as! RedmartDetailsVCell
            cell.iboDeatilsTextView.text = allProducts?.details
            let fixedWidth = cell.iboDeatilsTextView.frame.size.width
            cell.iboDeatilsTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = cell.iboDeatilsTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = cell.iboDeatilsTextView.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            return newFrame.size.height + 50.0
            
        default:
            return 50.0
            
        }
        
    }
    
}
