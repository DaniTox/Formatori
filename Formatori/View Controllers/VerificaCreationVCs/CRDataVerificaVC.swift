//
//  CRDataVerificaVC.swift
//  Formatori
//
//  Created by Dani Tox on 22/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class CRDataVerificaVC: UIViewController {

    var verificaInCreazione : Verifica?
    
    var datePicker : UIDatePicker!
    
    var loadingIndicator : UIActivityIndicatorView!
    
    var isLoading : Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading == true {
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func continueAction() {
        if let date = datePicker?.date {
            self.verificaInCreazione?.date = date
            
            if let verifica = self.verificaInCreazione {
                let loader = Loader()
                isLoading = true
                loader.create(verifica: verifica, completion: { [weak self] (success, errorString) in
                    self?.isLoading = false
                    if success {
                        DispatchQueue.main.async { [weak self] in
                            self?.dismissVC()
                        }
                    }
                    else {
                        if let alert = self?.getAlert(title: "Errore", message: errorString ?? "errore generico") {
                            DispatchQueue.main.async { [weak self] in
                                self?.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                })
            }
            
        }
    }
    
}

extension CRDataVerificaVC {
    private func setViews() {
        navigationItem.title = "Data"
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.darkGray.darker(by: 15)!.cgColor]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
        
        let barButton = UIBarButtonItem(title: "Fine", style: .done, target: self, action: #selector(dismissVC))
        navigationItem.setRightBarButton(barButton, animated: true)
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        
        let continueButton = UIButton()
        continueButton.setTitle("Crea", for: .normal)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.backgroundColor = UIColor.gray.darker(by: 20)
        continueButton.layer.cornerRadius = 10
        continueButton.layer.masksToBounds = true
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        continueButton.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        view.addSubview(continueButton)
        continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        continueButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .whiteLarge
        view.addSubview(loadingIndicator)
        loadingIndicator.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor).isActive = true
        loadingIndicator.leadingAnchor.constraint(equalTo: continueButton.trailingAnchor, constant: 25).isActive = true
        
        
    }
}
