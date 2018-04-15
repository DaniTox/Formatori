//
//  CRMateriaVC.swift
//  Formatori
//
//  Created by Dani Tox on 15/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class CRMateriaVC: UIViewController {

    var verificaInCreazione : Verifica?
    
    var materiaSelezionata : String?
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }

    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func continueCreation() {
        if let verifica = verificaInCreazione, let materia = materiaSelezionata {
            verifica.materia = materia
            
            let vc = CRArgomentoVC()
            vc.verificaInCreazione = verifica
            navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
}

extension CRMateriaVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = materie[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        if let materia = materiaSelezionata {
            if materia == materie[indexPath.row] {
                cell.backgroundColor = .green
            } else {
                cell.backgroundColor = .clear
            }
        } else {
            cell.backgroundColor = .clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materie.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.materiaSelezionata = materie[indexPath.row]
        tableView.reloadData()
    }
}

extension CRMateriaVC {
    private func setViews() {
        navigationItem.title = "Materia"
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.darkGray.darker(by: 15)!.cgColor]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
        
        let barButton = UIBarButtonItem(title: "Fine", style: .done, target: self, action: #selector(dismissVC))
        navigationItem.setRightBarButton(barButton, animated: true)
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        [ tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
          tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
          tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].forEach({$0.isActive = true})
        
        
        let continueButton = UIBouncyButton()
        continueButton.setTitle("Continua", for: .normal)
        continueButton.layer.cornerRadius = 10
        continueButton.backgroundColor = UIColor.gray.darker(by: 30)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        continueButton.addTarget(self, action: #selector(continueCreation), for: .touchUpInside)
        view.addSubview(continueButton)
        
        [ continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          continueButton.heightAnchor.constraint(equalToConstant: 60),
          continueButton.widthAnchor.constraint(equalToConstant: 120),
          continueButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10)
            ].forEach({$0.isActive = true})
        
    }
}
