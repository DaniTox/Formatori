//
//  Verifica.swift
//  Formatori
//
//  Created by Dani Tox on 23/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Verifica : Codable {
    
    var idVerifica : Int?
    var materia : String?
    var titolo : String?
    var data : String?
    var classe : String?
    var date : Date?
    var note : String?
    var dev_mode : Int?
    
    var isEncoded : Bool? = false
    func encodeForServer() {
        note = note?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed)
        materia = materia?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed)
        titolo = titolo?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed)
        
        self.isEncoded = true
    }
    
    
}

extension Array where Element == Verifica {
    mutating func removeVerificaWith(id: Int) {
        for (index, ver) in self.enumerated() {
            if ver.idVerifica == id {
                self.remove(at: index)
            }
        }
    }
}
