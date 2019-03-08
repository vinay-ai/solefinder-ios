//
//  NoInternet.swift
//  SoleFinder
//
//  Created by Vinay Kolwankar on 06/03/19.
//  Copyright © 2019 Vinay Kolwankar. All rights reserved.
//

import UIKit

class NoInternet: UIViewController {
    
    let reachability =  Reachability()!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
                 self.performSegue(withIdentifier: "whenInternet", sender: self)
            }
            
        }
        
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                
                let Message = ""
                let alert = UIAlertController(title: "Connection Lost", message: Message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
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
                self.performSegue(withIdentifier: "whenInternet", sender: self)
            }
            else{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "whenInternet", sender: self)
                    
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

}
