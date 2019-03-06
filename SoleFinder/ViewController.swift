//
//  ViewController.swift
//  SoleFinder
//
//  Created by Vinay Kolwankar on 19/01/19.
//  Copyright © 2019 Vinay Kolwankar. All rights reserved.
//

import SafariServices
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SFSafariViewControllerDelegate{
    
    let model = SoleIdentifier()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var categoryLabel: UILabel!
    var variable = ""
    let reachability =  Reachability()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
                let Message = ""
                let alert = UIAlertController(title: "Welcome Back!", message: Message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Get started", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

        }
        
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                
               self.performSegue(withIdentifier: "noInternet", sender: self)
                
                
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged , object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            print("Could not strat notifier")
        }
    }
    
    @objc  func internetChanged(note:Notification)  {
        let reachability  =  note.object as! Reachability
        if reachability.connection == .none{
            if reachability.connection == .wifi{
                
                 self.performSegue(withIdentifier: "noInternet", sender: self)
                
            }
            else{
                DispatchQueue.main.async {
                    let Message = ""
                    let alert = UIAlertController(title: "Welcome Back!", message: Message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Get started", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else{
            DispatchQueue.main.async {
                let Message = ""
                let alert = UIAlertController(title: "Connection Lost", message: Message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
                }
            }
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
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
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
    
    @IBAction func BuyProduct(_ sender: Any) {
        
        let BuyimagePickerController = UIImagePickerController()
        BuyimagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Purchase From", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Amazon", style: .default, handler: {(action: UIAlertAction) in
            
            let SafariVCA = SFSafariViewController(url: NSURL(string: "https://www.amazon.in/s?i=shoes&field-keywords=\(self.variable)")! as URL)
            self.present(SafariVCA, animated: true, completion: nil)
            SafariVCA.delegate = self
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Flipkart", style: .default, handler: {(action: UIAlertAction) in
            
            let SafariVCF = SFSafariViewController(url: NSURL(string: "https://www.flipkart.com/search?q=\(self.variable)")! as URL)
            self.present(SafariVCF, animated: true, completion: nil)
            SafariVCF.delegate = self
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func BuyimagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func BuyimagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as? UIImageView
        
        if let imagetoAnalyse = imageView?.image {
            if let soleLabelString = soleLabel(forImage: imagetoAnalyse){
                categoryLabel.text = soleLabelString
                variable = soleLabelString
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

    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    

}
