//
//  HomeVC.swift
//  Formatori
//
//  Created by Dani Tox on 19/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(formatore?.nome ?? "No formatore")
        if formatore == nil {
            print("is main thread? \(Thread.isMainThread)")
            
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showLogin", sender: self)
            }
        }
        
        print("Still here")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
