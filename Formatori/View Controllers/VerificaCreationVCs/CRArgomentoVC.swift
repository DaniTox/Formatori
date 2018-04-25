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
    
    
    let defaultText = "Note aggiuntive: (Opzionali)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }

    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func continueAction() {
        if let text = argomentoTextField.text, !text.isEmpty {
            verificaInCreazione?.titolo = text.encodedString
            
            if let note = noteTextView.text, !note.isEmpty, note != defaultText {
                verificaInCreazione?.note = note.encodedString
            } else {
                verificaInCreazione?.note = nil
            }
            
            let vc = CRDataVerificaVC()
            vc.verificaInCreazione = self.verificaInCreazione
            navigationController?.pushViewController(vc, animated: true)
        }
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
        
        
        
        //TEXTFIELD ARGOMENTO
        argomentoTextField = UITextField()
        argomentoTextField.attributedPlaceholder = NSAttributedString(string: "Argomento", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
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
        
        
        //BUTTON CONTINUE
        let continueButton = UIButton()
        continueButton.setTitle("Continua", for: .normal)
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
        
        
        //TEXTVIEW DELLE NOTE
        noteTextView = UITextView()
        noteTextView.text = defaultText
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.textColor = UIColor.darkGray
        noteTextView.backgroundColor = UIColor.clear
        noteTextView.font = UIFont.preferredFont(forTextStyle: .body).withSize(20)
        noteTextView.layer.cornerRadius = 10
        noteTextView.layer.masksToBounds = true
        noteTextView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        noteTextView.delegate = self
        view.addSubview(noteTextView)
        noteTextView.topAnchor.constraint(equalTo: argomentoTextField.bottomAnchor, constant: 30).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        noteTextView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -30).isActive = true
        
    }
}

extension CRArgomentoVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.darkGray {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .darkGray
            textView.text = defaultText
        }
    }
}
