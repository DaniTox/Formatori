//
//  Formatore.swift
//  Formatori
//
//  Created by Dani Tox on 17/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Formatore : Encodable, Decodable {
    
    var idFormatore : Int
    var nome : String
    var token : String
    
    init(id: Int, nome: String, token: String) {
        self.idFormatore = id
        self.nome = nome
        self.token = token
    }
    
}
