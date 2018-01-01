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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if formatore == nil {
            performSegue(withIdentifier: "showLogin", sender: self)
        }
    }
    
    
    @IBAction func logout() {
        if Auth.logout() == 0 {
            performSegue(withIdentifier: "showLogin", sender: self)
        }
        else {
            let al = getAlert(title: "Errore", message: "Non sono riuscito a fare il logout. Contatta il mio creatore Bazzani per chiarimenti")
            present(al, animated: true)
        }
    }
    
}
