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
    
    var effect:UIVisualEffect!
    
    @IBOutlet weak var blurFxView: UIVisualEffectView!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var customAlert: UIView!
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
        customAlert.layer.cornerRadius = 21
        alertImageView.layer.cornerRadius = 35
        alertImageView.contentMode = .scaleAspectFill
        alertImageView.clipsToBounds = true
        effect = blurFxView.effect
        blurFxView.effect = nil
        
    }
    
    func animateIn(){
        customAlert.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        customAlert.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.blurFxView.effect = self.effect
            self.customAlert.alpha = 1
            self.customAlert.transform = CGAffineTransform.identity
        }
    }
    
    func showAlert(title: String, image: UIImage) {
        self.soleIndexLabel.text = title
        self.alertImageView.image = image
        
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        parentView.removeFromSuperview()
    }

    @IBAction func onClickAmazon(_ sender: Any) {
        mainVC.onClickAmazon()
        
    }
    
    @IBAction func onClickFlipkart(_ sender: Any) {
        mainVC.onClickFlipkart()
 
    }
    
}
