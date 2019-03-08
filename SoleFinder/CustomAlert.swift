//
//  CustomAlert.swift
//  SoleFinder
//
//  Created by Vinay Kolwankar on 08/03/19.
//  Copyright © 2019 Vinay Kolwankar. All rights reserved.
//

import UIKit
import Foundation

class CustomAlert: UIView{
    
    static let instance = CustomAlert()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var customAlert: UIView!
    @IBOutlet weak var accuracyIndex: UILabel!
    @IBOutlet weak var soleIndexLabel: UILabel!
    @IBOutlet weak var alertImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CustomAlert", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        customAlert.layer.cornerRadius = 15
        alertImageView.layer.cornerRadius = 31
        alertImageView.contentMode = .scaleAspectFill
        alertImageView.clipsToBounds = true
        
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func showAlert(title: String, accuracy: String, image: UIImage) {
        self.soleIndexLabel.text = title
        self.accuracyIndex.text = accuracy
        self.alertImageView.image = image
        
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    
    @IBAction func onClickAmazon(_ sender: Any) {
        
    }
    
    @IBAction func onClickFlipkart(_ sender: Any) {
        
       
    }
    
}
