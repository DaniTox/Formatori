//
//  ViewController.swift
//  Formatori
//
//  Created by Dani Tox on 17/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTextF: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var spinner : UIActivityIndicatorView!
    var isLoading : Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.spinner.startAnimating()
                } else {
                    self.spinner.stopAnimating()
                }
            }
        }
    }
    
    var auther : Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginVC loaded")
        auther = Auth()
        auther?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func loginAction(_ sender: UIButton) {
        isLoading = true
        auther?.login(with: usernameTextF.text!, password: passwordTextField.text!)
    }
    

}

extension LoginVC : responseDelegate {
    func loginDidFinish(with code: Int, and message: String?) {
        isLoading = false
        if code == 0 {
            print("LOGGATO COME: \(formatore?.nome ?? "ERROR")")
            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "segueHome", sender: self)
                self.dismiss(animated: true, completion: nil)
            }
        }
        else {
            let alert = getAlert(title: "Errore", message: message!)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
}



