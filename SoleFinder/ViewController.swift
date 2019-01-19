//
//  ViewController.swift
//  SoleFinder
//
//  Created by Vinay Kolwankar on 19/01/19.
//  Copyright © 2019 Vinay Kolwankar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var categoryLabel: UILabel!
    let model = SoleIdentifier()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as? UIImageView
        
        if let imageToAnalyse = imageView?.image {
            if let SoleLabelString = SoleLabel(forImage: imageToAnalyse) {
                categoryLabel.text = SoleLabelString
            }
        }
    }
    
    func SoleLabel (forImage image:UIImage) -> String? {
        if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image.cgImage!) {
            guard let sole = try? model.prediction(image: pixelBuffer) else {fatalError("Unexpected runtime error")}
            return sole.classLabel
            
        }
        
        return nil
    }
    


}

