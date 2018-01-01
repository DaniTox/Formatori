//
//  VerificaMenu.swift
//  Formatori
//
//  Created by Dani Tox on 31/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class VerificaMenu: UIViewController {

    var verificaSelezionata : Verifica?
    var loader : Loader?
    override func viewDidLoad() {
        super.viewDidLoad()
        loader = Loader()
        loader?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func setDoneStateAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Attenzione", message: "Vuoi veramente impostare questa verifica come corretta?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Annulla", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Imposta", style: .destructive, handler: { [weak self] (action) in
            if let ver = self?.verificaSelezionata, let id = ver.idVerifica {
                self?.loader?.set_ver_to_done_state(idVerifica: id)
            }
        }))
        present(alert, animated: true)
    }
    
    @IBAction func eliminaAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Attenzione", message: "Vuoi veramente eliminare questa verifica? Questa operazione non può essere annullata.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Annulla", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Elimina", style: .destructive, handler: { [weak self] (action) in
            if let verifica = self?.verificaSelezionata, let id = verifica.idVerifica {
                self?.loader?.removeVerifica(id: id)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    

}

extension VerificaMenu : LoaderDelegate {
    
    func didRemoveVerificaWith(code: Int, andMsg message: String?) {
        if code == 0 {
            DispatchQueue.main.async {
                if let ver = self.verificaSelezionata, let id = ver.idVerifica {
                    verifiche.removeVerificaWith(id: id)
                }
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            DispatchQueue.main.async {
                let alert = self.getAlert(title: "Errore", message: message!)
                self.present(alert, animated: true)
            }
        }
    }
    
    func set_ver_state_doneDidFinish(code: Int, andMsg message: String?) {
        if code == 0 {
            if let ver = self.verificaSelezionata, let id = ver.idVerifica {
                verifiche.removeVerificaWith(id: id)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                if let alert = self?.getAlert(title: "Errore", message: message!) {
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
}







