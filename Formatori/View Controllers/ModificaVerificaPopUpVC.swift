//
//  ModificaVerificaPopUpVC.swift
//  Formatori
//
//  Created by Dani Tox on 25/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class ModificaVerificaPopUpVC: UIViewController {

    var gradient : CAGradientLayer!
    
    var setCorrettaButton = UIButton()
    var eliminaVerificaButton = UIButton()
    var modificaVerifcicaButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
    }

    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ModificaVerificaPopUpVC {
    private func setViews() {
        gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.darkGray.darker(by: 15)!.cgColor]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
        
        let barButton = UIBarButtonItem(title: "Fine", style: .done, target: self, action: #selector(dismissVC))
        navigationItem.setRightBarButton(barButton, animated: true)
        
        
        setCorrettaButton.backgroundColor = .green
        setCorrettaButton.layer.cornerRadius = 10
        setCorrettaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setCorrettaButton.setTitle("Imposta come corretta", for: .normal)
        setCorrettaButton.titleLabel?.adjustsFontSizeToFitWidth = true
        setCorrettaButton.titleLabel?.minimumScaleFactor = 0.6
        setCorrettaButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(setCorrettaButton)
        
        eliminaVerificaButton.backgroundColor = .red
        eliminaVerificaButton.layer.cornerRadius = 10
        eliminaVerificaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        eliminaVerificaButton.setTitle("Elimina", for: .normal)
        eliminaVerificaButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eliminaVerificaButton)
        
        modificaVerifcicaButton.backgroundColor = .gray
        modificaVerifcicaButton.layer.cornerRadius = 10
        modificaVerifcicaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        modificaVerifcicaButton.setTitle("Modifica", for: .normal)
        modificaVerifcicaButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(modificaVerifcicaButton)
        
        
        
        let stackView = UIStackView(arrangedSubviews: [setCorrettaButton, eliminaVerificaButton, modificaVerifcicaButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
    }
}
