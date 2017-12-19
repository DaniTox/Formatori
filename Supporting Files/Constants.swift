//
//  Constants.swift
//  Formatori
//
//  Created by Dani Tox on 18/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

var formatore : Formatore? {
    print("Getting formatore... is in Main Thread? \(Thread.isMainThread)")
    if let data = UserDefaults.standard.data(forKey: "formatore") {
        if let temp = try? JSONDecoder().decode(Formatore.self, from: data) {
            return temp
        }
    }
    
    return nil
}


extension UIViewController {
    func getAlert(title: String, message : String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }
}


let materie : [String] = [
    "Italiano",
    "Matematica",
    "Inglese",
    "Informatica",
    "Scienze",
    "IRC",
    "Diritto",
    "Att. Motoria",
    "Economia",
    "Disegno Elettrico",
    "Narrativa",
    "Elettrotecnica",
    "Lab. Elettrico",
    "Tecnologia Elettrica",
    "Sicurezza",
    "Impianti",
    "Automazione",
    "Meccanica",
    "PLC",
    "Elettronica",
    "Sistemi",
    "CAD CAM",
    "Comunicazione",
    "Disegno Meccanico",
    "Tecnologia Motoristica"
]
