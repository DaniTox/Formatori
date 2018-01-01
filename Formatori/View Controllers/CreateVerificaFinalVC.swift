//
//  CreateVerificaFinalVC.swift
//  Formatori
//
//  Created by Dani Tox on 19/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class CreateVerificaFinalVC: UIViewController {

    var materiaSelezionata : String?
    var classeSelezionata : String?
    var argomentoScritto : String?
    private var date : Date { return datePicker.date }
    
    @IBOutlet weak var materiaSelLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
 
    var loader : Loader?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //materiaSelLabel.text = "Materia selezionata: \(materiaSelezionata ?? "ERRORE")"
        loader = Loader()
        loader?.delegate = self
        
        print("FINALVC: mat: \(materiaSelezionata ?? "Error")\tclass: \(classeSelezionata ?? "Error")\targ:\(argomentoScritto ?? "Error")")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    
    @IBAction func createVerifica(_ sender: UIButton) {
        if checkInput() != 0 { return }
        
        print("Creo verifica...")
        let ver = Verifica()
        ver.materia = materiaSelezionata!
        ver.titolo = argomentoScritto!
        ver.classe = classeSelezionata!
        ver.date = date
        
        loader?.create(verifica: ver)
    }
    
    private func checkInput() -> Int {
        guard
            let _ = materiaSelezionata,
            let _ = argomentoScritto,
            let _ = classeSelezionata
        else { return 1 }
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) { return 0 }
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
            let alert = UIAlertController(title: "Completato", message: "La verifica è stata creata con successo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action) in
                DispatchQueue.main.async {
                    self?.dismiss(animated: true, completion: nil)
                }
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

