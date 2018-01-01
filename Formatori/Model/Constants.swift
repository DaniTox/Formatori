//
//  Constants.swift
//  Formatori
//
//  Created by Dani Tox on 18/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

var verifiche : [Verifica] = []

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

extension Date {
    var string : String {
        let c = Calendar.current
        let day = c.component(.day, from: self)
        let month = c.component(.month, from: self)
        let year = c.component(.year, from: self)
        
        let str = "\(day)-\(month)-\(year)"
        return str
    }
}

var classi : [String] = ["1E", "2E", "3E", "4E", "1M", "2M", "3M", "4M"]

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
