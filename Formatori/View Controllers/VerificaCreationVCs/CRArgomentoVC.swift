//
//  CRArgomentoVC.swift
//  Formatori
//
//  Created by Dani Tox on 15/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class CRArgomentoVC: UIViewController {

    var verificaInCreazione : Verifica?
    
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
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.darkGray.darker(by: 15)!.cgColor]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
        
        let barButton = UIBarButtonItem(title: "Fine", style: .done, target: self, action: #selector(dismissVC))
        navigationItem.setRightBarButton(barButton, animated: true)
        
        
    }
}
