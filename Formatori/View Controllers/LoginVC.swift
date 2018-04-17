//
//  LoginVC.swift
//  Formatori
//
//  Created by Dani Tox on 12/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    var emailTextField : UITextField!
    var passwordTextField : UITextField!
    var loginButton : UIBouncyButton!
    
    var completion : (() -> Void)?
    
    var loadingIndicator : UIActivityIndicatorView!

    var isLoading : Bool = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if self!.isLoading == true {
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.loadingIndicator.stopAnimating()
                }
                
            }
        }
    }
    
    var model = Auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViews()
    }

    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func login() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if !email.isEmpty && !password.isEmpty {
                isLoading = true
                model.login(with: email, password: password) { [weak self] (logged, message) in
                    self?.isLoading = false
                    if logged {
                        DispatchQueue.main.async { [weak self] in
                            self?.dismiss(animated: true, completion: {
                                self?.completion?()
                            })
                        }
                    }
                    if let msg = message, let alert = self?.getAlert(title: "Errore", message: msg) {
                        DispatchQueue.main.async {
                            self?.present(alert, animated: true, completion: nil)
                            print("Errore: \(msg)")
                        }
                        
                    }
                }
                
            }
        }
    }
    
}

extension LoginVC {
    private func loadViews() {
        navigationItem.title = "Accedi"
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.darkGray.darker(by: 15)!.cgColor]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
        
        let barButton = UIBarButtonItem(title: "Fine", style: .done, target: self, action: #selector(dismissVC))
        navigationItem.setRightBarButton(barButton, animated: true)
        
        
        emailTextField = UITextField()
        emailTextField.placeholder = "E-Mail"
        emailTextField.backgroundColor = UIColor.darkGray.lighter(by: 7)
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect
        emailTextField.textColor = .white
        emailTextField.keyboardType = .emailAddress
        
        
        passwordTextField = UITextField()
        passwordTextField.backgroundColor = UIColor.darkGray.lighter(by: 7)
        passwordTextField.placeholder = "Password"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textColor = .white
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        
        let inputStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        inputStackView.alignment = .fill
        inputStackView.axis = .vertical
        inputStackView.distribution = .fillEqually
        inputStackView.spacing = 15
        view.addSubview(inputStackView)
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        inputStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        inputStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        inputStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        
        loginButton = UIBouncyButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.backgroundColor = UIColor.gray.darker(by: 25)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: 30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.leadingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: 20).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
    }
}
