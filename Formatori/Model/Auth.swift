//
//  Auth.swift
//  Formatori
//
//  Created by Dani Tox on 17/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Auth {
    
    weak var delegate : responseDelegate!
    
    func login(withUser: String, password: String) {
        
        
        
        
    }
    
}

@objc protocol responseDelegate {
    @objc optional func loginDidFinish(with code: Int, and message : String?)
}
