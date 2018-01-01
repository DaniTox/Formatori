//
//  CreateVerificaMediumVC.swift
//  Formatori
//
//  Created by Dani Tox on 01/01/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class CreateVerificaMediumVC: UIViewController {

    var materiaSelezionata: String?
    var classeSelezionata : String?
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var argomentoTextField : UITextField!
    
    private var argomento : String? {
        if argomentoTextField.text != nil, !argomentoTextField.text!.isEmpty {
            return argomentoTextField.text
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func continueCreating() {
        if checkInput() != 0 { return }
        
        self.performSegue(withIdentifier: "finalCreationVC", sender: self)
    }

    private func checkInput() -> Int {
        guard
            let _ = classeSelezionata,
            let _ = materiaSelezionata,
            let _ = argomento
        else { return 1 }
        
        if argomento!.isEmpty { return 1 }
        if classeSelezionata!.isEmpty { return 1 }
        if materiaSelezionata!.isEmpty { return 1 }
        
        return 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CreateVerificaFinalVC {
            if let mat = self.materiaSelezionata, let classe = classeSelezionata, let arg = argomento {
                vc.argomentoScritto = arg
                vc.classeSelezionata = classe
                vc.materiaSelezionata = mat
            }
        }
    }
 

}

extension CreateVerificaMediumVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = classi[indexPath.row]
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.textColor = UIColor.white
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.visibleCells.forEach( { $0.backgroundColor = UIColor.clear } )
        self.classeSelezionata = classi[indexPath.row]
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.green
    }
    
}
