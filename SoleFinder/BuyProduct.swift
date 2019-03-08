//
//  BuyProduct.swift
//  SoleFinder
//
//  Created by Vinay Kolwankar on 08/03/19.
//  Copyright © 2019 Vinay Kolwankar. All rights reserved.
//

import UIKit
import SafariServices

var mainVC = BuyProduct()

class BuyProduct: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @objc func onClickAmazon() {
        let SafariVCA = SFSafariViewController(url: NSURL(string: "https://www.amazon.in/s?i=shoes&field-keywords=\(SoleIndexString)")! as URL)
        let vc: UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "BuyProduct"))!
        vc.present(SafariVCA, animated: true, completion: nil)
        
        
    }
    
    @objc func onClickFlipkart() {
        let SafariVCF = SFSafariViewController(url: NSURL(string: "https://www.flipkart.com/search?q=\(SoleIndexString)")! as URL)
        let vc: UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "BuyProduct"))!
        vc.present(SafariVCF, animated: true, completion: nil)
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

}
