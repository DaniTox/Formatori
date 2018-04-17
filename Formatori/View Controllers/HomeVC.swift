//
//  HomeVC.swift
//  Formatori
//
//  Created by Dani Tox on 12/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    var logoutButton : UIButton!
    var loginButton : UIBouncyButton!
    
    var createVerificaButton : UIBouncyButton!
    var modificaVerButton : UIBouncyButton!

    var formatoreLoggedLabel : UILabel!
    
    private var isLoggedin : Bool {
        return formatore != nil ? true : false
    }
    
    var verificheActionsStack : UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    
    private func showViews() {
        if isLoggedin {
            loginButton?.isHidden = true
            logoutButton?.isHidden = false
            formatoreLoggedLabel?.isHidden = false
            if let nome = formatore?.nome {
                formatoreLoggedLabel?.text = "[ Formatore: \(nome) ]"
            }
            
            verificheActionsStack?.isHidden = false
            
        } else {
            loginButton?.isHidden = false
            logoutButton?.isHidden = true
            formatoreLoggedLabel?.isHidden = true
           
            verificheActionsStack?.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showViews()
    }
    
    @objc private func logout() {
        Auth.logout()
        showViews()
    }
    
    @objc private func openLoginVC() {
        let vc = LoginVC()
        vc.completion = {
            DispatchQueue.main.async { [weak self] in
                self?.showViews()
            }
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        
        present(nav, animated: true, completion: nil)
        
        
    }
    
    
    @objc private func openCreateVerificaVC() {
        let vc = CRClasseVC()
        let nav = UINavigationController(rootViewController: vc)
        vc.navigationItem.title = "Creazione Verifica"
        present(nav, animated: true, completion: nil)
    }

}


extension HomeVC {
    fileprivate func setViews() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.darkGray.darker(by: 15)!.cgColor]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
        
        
        navigationItem.title = "Home"
        
        loginButton = UIBouncyButton()
        loginButton.setTitle("Accedi", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.backgroundColor = UIColor.gray.darker(by: 25)
        loginButton.layer.cornerRadius = 10
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(openLoginVC), for: .touchUpInside)
        view.addSubview(loginButton)
        
        [ loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          loginButton.widthAnchor.constraint(equalToConstant: 100),
          loginButton.heightAnchor.constraint(equalToConstant: 50) ].forEach( { $0.isActive = true } )
        
        logoutButton = UIButton()
        logoutButton.setTitle("Esegui il logout", for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(logoutButton)
        
        [ logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
          logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          logoutButton.widthAnchor.constraint(equalToConstant: 200),
          logoutButton.heightAnchor.constraint(equalToConstant: 50) ].forEach({ $0.isActive = true })
        
        
        formatoreLoggedLabel = UILabel()
        formatoreLoggedLabel.font = UIFont.boldSystemFont(ofSize: 17)
        formatoreLoggedLabel.textAlignment = .center
        formatoreLoggedLabel.textColor = .white
        formatoreLoggedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formatoreLoggedLabel)
        [ formatoreLoggedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
          formatoreLoggedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          formatoreLoggedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          formatoreLoggedLabel.heightAnchor.constraint(equalToConstant: 60)].forEach({ $0.isActive = true })
        
        
        
        createVerificaButton = UIBouncyButton()
        createVerificaButton.setTitle("Crea Verifica", for: .normal)
        createVerificaButton.layer.cornerRadius = 10
        createVerificaButton.backgroundColor = UIColor.gray.darker(by: 30)
        createVerificaButton.addTarget(self, action: #selector(openCreateVerificaVC), for: .touchUpInside)
        view.addSubview(createVerificaButton)
        
        modificaVerButton = UIBouncyButton()
        modificaVerButton.setTitle("Modifica verifiche", for: .normal)
        modificaVerButton.layer.cornerRadius = 10
        modificaVerButton.backgroundColor = UIColor.gray.darker(by: 30)
        
        
        verificheActionsStack = UIStackView(arrangedSubviews: [createVerificaButton, modificaVerButton])
        verificheActionsStack.alignment = .fill
        verificheActionsStack.axis = .vertical
        verificheActionsStack.spacing = 20
        verificheActionsStack.distribution = .fillEqually
        verificheActionsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verificheActionsStack)
        [ verificheActionsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          verificheActionsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          verificheActionsStack.widthAnchor.constraint(equalToConstant: 200),
          verificheActionsStack.heightAnchor.constraint(equalToConstant: 120)].forEach({$0.isActive = true})
        
        
        
       
        
    }
}
