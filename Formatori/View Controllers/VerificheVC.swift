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
    @IBOutlet weak var spinner : UIActivityIndicatorView!
    
    var loader : Loader?
    
    var isLoading : Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.refreshCtrl?.beginRefreshing()
                    self.spinner.startAnimating()
                } else {
                    self.refreshCtrl?.endRefreshing()
                    self.spinner.stopAnimating()
                }
            }
        }
    }
    
    var selectedVerifica : Verifica?
    var selectedIndexPath : IndexPath?
    var filterMode : ((Verifica) -> Bool)?
    
    var refreshCtrl : UIRefreshControl?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        loader = Loader()
        loader?.delegate = self
        loadVerifiche()
        
        refreshCtrl = UIRefreshControl()
        refreshCtrl?.addTarget(self, action: #selector(loadVerifiche), for: .valueChanged)
        tableView.refreshControl = refreshCtrl
        
        
    }

    @objc private func loadVerifiche() {
        isLoading = true
        loader?.loadMyVerifiche()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func segmentTouched(_ sender: UISegmentedControl) {
        filterMode = { return $0.classe == sender.titleForSegment(at: sender.selectedSegmentIndex) }
        tableView.reloadData()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addVerifica(_ sender: UIButton) {
        performSegue(withIdentifier: "createVerFromVerVC", sender: self)
    }
    
}

extension VerificheVC : UITableViewDataSource, UITableViewDelegate {
    
    var correctVerifiche : [Verifica] {
        return verifiche.filter(filterMode ?? { return $0.idVerifica != 0 }) //SE FILTERMODE IS NIL, RITORNALE TUTTE
    }
    
    func getCorrectVer() -> [Verifica] {
        
        return []
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let ver = correctVerifiche[indexPath.row]
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Attenzione", message: "Vuoi veramente eliminare questa verifica? Questa operazione non è annullabile.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annulla", style: .default))
            alert.addAction(UIAlertAction(title: "Elimina", style: .destructive, handler: { (action) in
                self.isLoading = true
                self.loader?.removeVerifica(id: ver.idVerifica)
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedVerifica = correctVerifiche[indexPath.row]
        self.performSegue(withIdentifier: "showVerificaMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.async {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            if let ver = self.selectedVerifica, let vc = segue.destination as? VerificaMenu {
                vc.verificaSelezionata = ver
            }
        }
    }
}

extension VerificheVC : LoaderDelegate {
    
    func didFinishLoadVerificheWith(_ code: Int, and message: String?) {
        self.isLoading = false
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
    
    func didRemoveVerificaWith(code: Int, andMsg message: String?) {
        self.isLoading = false
        if code == 0 {
            let alert = getAlert(title: "Successo", message: "La verifica è stata completata con successo!")
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                if let indexPath = self.selectedIndexPath {
                    let ver = self.correctVerifiche[indexPath.row]
                    if let id = ver.idVerifica {
                        verifiche.removeVerificaWith(id: id)
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
                self.tableView.reloadData()
            }
        }
        else {
            if let msg = message {
                let alert = getAlert(title: "Errore", message: msg)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                let alert = getAlert(title: "Errore", message: "Errore generico. Nessun messaggio dal server. delegate.didRemoveVerificaWith()")
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}


