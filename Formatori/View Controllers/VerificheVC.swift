//
//  VerificheVC.swift
//  Formatori
//
//  Created by Dani Tox on 23/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class VerificheVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            filterMode = { return $0.classe == self.segmentedControl.titleForSegment(at: self.segmentedControl.selectedSegmentIndex) }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var loader : Loader?
    
    var filterMode : ((Verifica) -> Bool)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        loader = Loader()
        loader?.delegate = self
        loader?.loadMyVerifiche()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentTouched(_ sender: UISegmentedControl) {
        filterMode = { return $0.classe == sender.titleForSegment(at: sender.selectedSegmentIndex) }
        tableView.reloadData()
    }
    

}

extension VerificheVC : UITableViewDataSource, UITableViewDelegate {
    
    var correctVerifiche : [Verifica] {
        return verifiche.filter(filterMode ?? { return $0.idVerifica != 0 }) //SE FILTERMODE IS NIL, RITORNALE TUTTE
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return correctVerifiche.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? VerificaCell
        let ver = correctVerifiche[indexPath.row]
        cell?.argomentoLabel.text = ver.titolo
        cell?.dataLabel.text = ver.data
        cell?.materiaLabel.text = ver.materia
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}

extension VerificheVC : LoaderDelegate {
    
    func didFinishLoadVerificheWith(_ code: Int, and message: String?) {
        if code == 1 {
            if let msg = message {
                let alert = getAlert(title: "Errore", message: msg)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                let alert = getAlert(title: "Errore", message: "Errore generico... didFinish..Delegate with: 1 and nil")
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Verifiche ricevute dal delegate")
            }
        }
    }
    
    
}


