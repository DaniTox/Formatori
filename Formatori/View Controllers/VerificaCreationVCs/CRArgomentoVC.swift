//
//  CRArgomentoVC.swift
//  Formatori
//
//  Created by Dani Tox on 15/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class CRArgomentoVC: UIViewController {

    let topOffset : CGFloat = 35
    
    var verificaInCreazione : Verifica?
    
    var argomentoTextField : UITextField!
    var noteTextView : UITextView!
    
    
    let defaultText = """
        Note aggiuntive: (Opzionali)
        Esempio: argomento scritto sul documento nominato “prova.pdf” sul Drive
    """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }

    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

}

extension CRArgomentoVC {
    private func setViews() {
        
        navigationItem.title = "Argomento"
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.darkGray.darker(by: 15)!.cgColor]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
        
        let barButton = UIBarButtonItem(title: "Fine", style: .done, target: self, action: #selector(dismissVC))
        navigationItem.setRightBarButton(barButton, animated: true)
        
        
        let argomentoTitleLabel = UILabel()
        argomentoTitleLabel.text = "Argomento"
        argomentoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(argomentoTitleLabel)
        
        
        
        
        argomentoTextField = UITextField()
        argomentoTextField.placeholder = "Argomento"
        argomentoTextField.textColor = .white
        argomentoTextField.borderStyle = .roundedRect
        argomentoTextField.backgroundColor = UIColor.gray.darker()
        argomentoTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(argomentoTextField)
        if #available(iOS 11.0, *) {
            argomentoTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topOffset).isActive = true
        } else {
            let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)
            argomentoTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: topBarHeight + topOffset).isActive = true
        }
        argomentoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        argomentoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        argomentoTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let continueButton = UIButton()
        continueButton.setTitle("Continua", for: .normal)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.backgroundColor = UIColor.gray.darker(by: 20)
        continueButton.layer.cornerRadius = 10
        continueButton.layer.masksToBounds = true
        view.addSubview(continueButton)
        continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        continueButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
        noteTextView = UITextView()
        noteTextView.text = defaultText
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.textColor = UIColor.white
        noteTextView.backgroundColor = UIColor.clear
        noteTextView.font = UIFont.preferredFont(forTextStyle: .body).withSize(20)
        view.addSubview(noteTextView)
        noteTextView.topAnchor.constraint(equalTo: argomentoTextField.bottomAnchor, constant: 30).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        noteTextView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -30).isActive = true
        
    }
}
