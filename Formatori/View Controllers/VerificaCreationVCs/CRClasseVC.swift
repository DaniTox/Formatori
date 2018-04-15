//
//  CRClasseVC.swift
//  Formatori
//
//  Created by Dani Tox on 15/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class CRClasseVC: UIViewController {

    var tableView : UITableView!
    
    var classeSelezionata : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }


    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func continueCreation() {
        if let classe = classeSelezionata {
            let verificaInCreazione = Verifica()
            verificaInCreazione.classe = classe
            
            let vc = CRMateriaVC()
            vc.verificaInCreazione = verificaInCreazione
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}

extension CRClasseVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if let classe = classeSelezionata {
            if classi[indexPath.row] == classe {
                cell.backgroundColor = UIColor.green.darker()
            }
            else {
                cell.backgroundColor = .clear
            }
        } else {
            cell.backgroundColor = .clear
        }
        
        cell.textLabel?.text = classi[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classi.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.classeSelezionata = classi[indexPath.row]
        tableView.reloadData()
    }
    
}

extension CRClasseVC {
    private func setViews() {
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
        tableView.isScrollEnabled = false
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        [ tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          tableView.heightAnchor.constraint(equalToConstant: 350)].forEach({$0.isActive = true})
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Seleziona una classe"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 23)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        [ titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
          titleLabel.heightAnchor.constraint(equalToConstant: 70),
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
          continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ].forEach({$0.isActive = true})
        
    }
}
