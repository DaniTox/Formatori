//
//  HomeVC.swift
//  Formatori
//
//  Created by Dani Tox on 19/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(formatore?.nome ?? "ERRORe")
        if formatore == nil {
            self.performSegue(withIdentifier: "showLogin", sender: self)
        }
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
