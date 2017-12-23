//
//  CreateVerificaFinalVC.swift
//  Formatori
//
//  Created by Dani Tox on 19/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class CreateVerificaFinalVC: UIViewController {

    var materiaSelezionata : String? {
        didSet {
            print("FINALVC: materiaSelezionata settata su: \(materiaSelezionata ?? "Null")")
        }
    }
    
    private var classeSelezionata : String? {
        didSet {
            print("Classe selezionata: \(classeSelezionata ?? "null")")
        }
    }
    
    @IBOutlet weak var materiaSelLabel: UILabel!
    @IBOutlet var classiOutlets: [UIButton]!
    @IBOutlet weak var argomentoTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var materia : String? {
        return materiaSelezionata
    }
    var classe : String? {
        return classeSelezionata
    }
    var argomento : String? {
        return argomentoTextField.text
    }
    var date : Date {
        return datePicker.date
    }
    
    var loader : Loader?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        materiaSelLabel.text = "Materia selezionata: \(materiaSelezionata ?? "ERRORE")"
        loader = Loader()
        loader?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func classeBtnTouched(_ sender: UIButton) {
        classiOutlets.forEach({ $0.backgroundColor = UIColor.clear })
        sender.backgroundColor = UIColor.orange
        classeSelezionata = sender.currentTitle
    }
    
    
    
    @IBAction func createVerifica(_ sender: UIButton) {
        if checkInput() != 0 { return }
        print("Creo verifica...")
        loader?.createVerifica(materia: materia!, argomento: argomento!, classe: classe!, data: date)
    }
    
    private func checkInput() -> Int {
        let calendar = Calendar.current
        if materia == nil || classe == nil || (argomento == nil || (argomento?.isEmpty)! ) { return 1 }
        if calendar.isDateInYesterday(date) || Date() > date { return 1 }
        return 0
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateVerificaFinalVC : LoaderDelegate {
    func didCreateVerificaWithReturnCode(_ code: Int, and message: String?) {
        if code == 1 {
            let alert = getAlert(title: "Errore", message: message ?? "NO RETURN VALUE ERRORE")
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            print("Verifica creata con successo")
        }
    }
}

