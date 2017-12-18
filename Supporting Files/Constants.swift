//
//  Constants.swift
//  Formatori
//
//  Created by Dani Tox on 18/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

var formatore : Formatore? {
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
