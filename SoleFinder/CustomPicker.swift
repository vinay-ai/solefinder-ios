//
//  CustomPicker.swift
//  SoleFinder
//
//  Created by Vinay Kolwankar on 08/03/19.
//  Copyright © 2019 Vinay Kolwankar. All rights reserved.
//

import UIKit
import Foundation

class CustomPicker: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    static let instancePicker = CustomPicker()
    
    var effect:UIVisualEffect!
    
    
    @IBOutlet weak var headerPicker: UILabel!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var blurFxEffect: UIVisualEffectView!
    @IBOutlet weak var parentView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CustomPicker", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        pickerView.layer.cornerRadius = 15
        effect = blurFxEffect.effect
        blurFxEffect.effect = nil
        
    }
    
    func showPicker() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        parentView.removeFromSuperview()
    
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        mainVC.onClickCamera()
        
    }
    
    @IBAction func photoLibraryButton(_ sender: Any) {
        mainVC.onClickPhotoLibrary()
    }
    

}
