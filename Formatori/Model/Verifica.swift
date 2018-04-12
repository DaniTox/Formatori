//
//  Verifica.swift
//  Formatori
//
//  Created by Dani Tox on 23/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Verifica : Codable {
    
    var idVerifica : Int!
    var materia : String!
    var titolo : String!
    var data : String!
    var classe : String!
    var date : Date?
    
    var argomento : String? {
        return titolo.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed)
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
