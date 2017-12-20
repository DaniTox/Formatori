//
//  Loader.swift
//  Formatori
//
//  Created by Dani Tox on 19/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Loader {

    weak var delegate : LoaderDelegate?
    
    func createVerifica(materia: String, argomento: String, classe: String, data: Date) {
      //TODO SOSTITUIRE OR CON IL SIMBOLO DELL'OR
      if materia.isEmpty || argomento.isEmpty || classe.isEmpty { return }
      
      let link = Links.createVerifica
      guard let url = URL(string: link) else { return }
      
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(Response.self, from: data)
            
            if json?.code != String(200) {
                if let msg = json?.message {
                    self?.delegate?.didCreateVerificaWithReturnCode!(1, and: msg)
                }
            }
            else {
                self?.delegate?.didCreateVerificaWithReturnCode!(0, and: nil)
            }
            
        }.resume()
    }
    
}


@objc protocol LoaderDelegate {
    @objc optional func didCreateVerificaWithReturnCode(_ code : Int, and message: String?)
}


