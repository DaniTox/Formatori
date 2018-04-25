//
//  Constants.swift
//  Formatori
//
//  Created by Dani Tox on 18/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

var development : Bool = false

var formatore : Formatore? {
    
    if let data = KeychainWrapper.standard.data(forKey: "formatore") {
        if let form = try? JSONDecoder().decode(Formatore.self, from: data) {
            return form
        } else {
            return nil
        }
    }
    
    return nil
}

extension UIColor {
    
    func lighter(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage:CGFloat=30.0) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
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

extension String {
    var encodedString : String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
