//
//  HomeVC.swift
//  Formatori
//
//  Created by Dani Tox on 12/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    var loginButton : UIButton!
    var createVerificaButton : UIButton!
    var modificaVerButton : UIButton!
    
    var logoutButton : UIButton!
    
    //TODO: SE LOGGATO, MOSTRARE STACKVIEW CON BOTTONI VERIFICHE. ALTRIMENTI, MOSTARE TASTO LOGIN E NASCONDERE STACK.
    //TODO: INSERIRE UN LABEL DOVE VIENE MOSTATO CON QUALE FORMATORE SI è LOGGATI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.darkGray.darker(by: 15)!.cgColor]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
        
        
        navigationItem.title = "Home"
        
        loginButton = UIButton()
        loginButton.setTitle("Accedi", for: .normal)
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
        
        print(formatore?.nome)
    }
    
    @objc private func logout() {
        Auth.logout()
    }
    
    @objc private func openLoginVC() {
        let vc = LoginVC()
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        
        present(nav, animated: true, completion: nil)
        
        
    }

}
