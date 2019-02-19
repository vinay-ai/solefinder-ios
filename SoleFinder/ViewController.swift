//
//  ViewController.swift
//  SoleFinder
//
//  Created by Vinay Kolwankar on 19/01/19.
//  Copyright © 2019 Vinay Kolwankar. All rights reserved.
//

import SafariServices
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SFSafariViewControllerDelegate {
    
    let model = SoleIdentifier()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func ChooseImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
           
        }))
        
         actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action: UIAlertAction) in
             imagePickerController.sourceType = .photoLibrary
             self.present(imagePickerController, animated: true, completion: nil)
         }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as? UIImageView
        
        if let imagetoAnalyse = imageView?.image {
            if let soleLabelString = soleLabel(forImage: imagetoAnalyse){
                categoryLabel.text = soleLabelString
            }
            
        }
    }
    
    func soleLabel (forImage image:UIImage)-> String? {
        if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image.cgImage!){
            guard let sole = try? model.prediction(image: pixelBuffer) else {
                fatalError("Unexpected runtime error")
            }
            return sole.classLabel
        }
        return nil
    }
    
    
    @IBAction func OpenSafari(_ sender: Any) {
        let SafariVC = SFSafariViewController(url: NSURL(string: "https://www.amazon.in")! as URL)
        self.present(SafariVC, animated: true, completion: nil)
        SafariVC.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

