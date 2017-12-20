//
//  Loader.swift
//  Formatori
//
//  Created by Dani Tox on 19/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Loader {
    
    func createVerifica(materia: String, argomento: String, classe: String, data: Date) {
      //TODO SOSTITUIRE OR CON IL SIMBOLO DELL'OR
      if materia.isEmpty OR argomento.isEmpty OR classe.isEmpty OR data.isEmpty { return }
      
      let link = Links.createVerifica
      guard let url = URL(strin: link) else { return }
      
      URLSession.shared.dataTask( { (data, response, error)
        
        guard let data = data else { return }
         if let json = try? JSONDecoder().decode(Response.self) {
          	 
         }
                                  
      }).resume()
    }
    
}
