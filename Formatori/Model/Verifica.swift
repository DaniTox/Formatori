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
