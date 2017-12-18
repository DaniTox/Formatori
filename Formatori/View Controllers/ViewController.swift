//
//  ViewController.swift
//  Formatori
//
//  Created by Dani Tox on 17/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextF: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var auther : Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auther = Auth()
        auther?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func loginAction(_ sender: UIButton) {
        auther?.login(with: usernameTextF.text!, password: passwordTextField.text!)
    }
    

}

extension ViewController : responseDelegate {
    func loginDidFinish(with code: Int, and message: String?) {
        if code == 0 {
            print("LOGGATO COME: \(formatore?.nome ?? "ERROR")")
        }
        else {
            let alert = getAlert(title: "Errore", message: message!)
            self.present(alert, animated: true, completion: nil)
        }
    }
}



