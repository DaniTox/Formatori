//
//  Verifica.swift
//  Formatori
//
//  Created by Dani Tox on 23/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Verifica : Encodable, Decodable {
    
    var idVerifica : Int!
    var materia : String!
    var titolo : String!
    var data : String!
    var classe : String!
    var date : Date!
    
    var argomento : String? {
        return titolo.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed)
    }
    
    
    
    func checkIntegrityOfData() -> Int {
        
        if self.materia == nil || self.materia.isEmpty { return 1 }
        if self.date == nil  { return 1 }
        if self.classe == nil || self.classe.isEmpty { return 1 }
        if self.argomento == nil || self.argomento!.isEmpty { return 1 }
        
        return 0
    }
    
}

extension Array where Element == Verifica {
    mutating func removeVerificaWith(id: Int) {
        for (index, ver) in self.enumerated() {
            if ver.idVerifica! == id {
                self.remove(at: index)
            }
        }
    }
}
