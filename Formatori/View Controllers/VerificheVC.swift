//
//  VerificheVC.swift
//  Formatori
//
//  Created by Dani Tox on 23/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class VerificheVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var loader : Loader?
    
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
    }
    

}

extension VerificheVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verifiche.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? VerificaCell
        
        return cell!
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


