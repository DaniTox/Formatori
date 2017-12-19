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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        materiaSelLabel.text = "Materia selezionata: \(materiaSelezionata ?? "ERRORE")"
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
        let date = datePicker.date
        let string = date.description(with: Locale.current)
        print(string)
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
