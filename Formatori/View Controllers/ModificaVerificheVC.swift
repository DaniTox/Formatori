//
//  ModificaVerificheVC.swift
//  Formatori
//
//  Created by Dani Tox on 24/04/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class ModificaVerificheVC: UIViewController {

    private var gradient : CAGradientLayer!
    private var verifiche : [Verifica] = []
    
    private var verificheTable : [Verifica] = []
    
    private var segment : UISegmentedControl!
    private var tableView : UITableView!
    
    var classeSelezionata : String = "" {
        didSet {
            if classeSelezionata != "" {
                verificheTable = verifiche.filter({ $0.classe == classeSelezionata })
                DispatchQueue.main.async { [weak self] in
                    self?.tableView?.reloadData()
                }
            } else {
                verificheTable = verifiche
                DispatchQueue.main.async { [weak self] in
                    self?.tableView?.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        tableView?.register(VerificaCell.self, forCellReuseIdentifier: "cell")
        
        loadVerifiche(firstTime: true)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient?.frame = view.bounds
    }
    
    private func loadVerifiche(firstTime : Bool? = false) {
        let model = Loader()
        model.loadMyVerifiche { [weak self] (success, errorString, verifiche) in
            if let unwrVerifiche = verifiche, success == true, unwrVerifiche.count > 0 {
                self?.verifiche = unwrVerifiche
                print("\(unwrVerifiche.count) verifiche")
                DispatchQueue.main.async { [weak self] in
                    if firstTime == true {
                        self?.classeSelezionata = ""
                    } else {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func changeClasseVisualizzata(sender: UISegmentedControl) {
        classeSelezionata = classi[segment.selectedSegmentIndex]
    }
    
}

extension ModificaVerificheVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? VerificaCell
        cell?.backgroundColor = .clear
        let verifica = verificheTable[indexPath.row]
        cell?.titleLabel.text = "\(verifica.materia ?? "null"): \(verifica.titolo ?? "null")"
        cell?.dataLabel.text = "\(verifica.data ?? Date().string)"
        cell?.classeLabel.text = "\(verifica.classe ?? "null")"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verificheTable.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ModificaVerificaPopUpVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true, completion: nil)
    }
}


extension ModificaVerificheVC {
    private func setViews() {
        gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.darkGray.darker(by: 15)!.cgColor]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
        
        let barButton = UIBarButtonItem(title: "Fine", style: .done, target: self, action: #selector(dismissVC))
        navigationItem.setRightBarButton(barButton, animated: true)
        
        segment = UISegmentedControl(items: classi)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(changeClasseVisualizzata(sender:)), for: .valueChanged)
        view.addSubview(segment)
        segment.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segment.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segment.heightAnchor.constraint(equalToConstant: 50).isActive = true
        if #available(iOS 11.0, *) {
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        } else {
            let offset = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0) + 25
            segment.topAnchor.constraint(equalTo: view.topAnchor, constant: offset).isActive = true
        }
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 10).isActive = true
        
        
    }
}
