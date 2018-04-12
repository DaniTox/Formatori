//
//  Loader.swift
//  Formatori
//
//  Created by Dani Tox on 19/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Loader {

    
    func create(verifica: Verifica, completion: ((Bool, String?) -> Void)?) {
        
        let link = "\(Links.createVerifica)?materia=\(verifica.materia)&titolo=\(verifica.argomento)&classe=\(verifica.classe)&data=\(verifica.date?.string)&token=\(formatore?.token)"
        guard let url = URL(string: link) else { print("Error link: \(link)"); return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(Response.self, from: data)
                if json.code == 0 {
                    completion?(true, nil)
                }
                else {
                    completion?(false, "Errore")
                }
            } catch {
                completion?(false, error.localizedDescription)
            }
                
            
            
            
            
            }.resume()
        
    }
    
    
    func loadMyVerifiche() {
        guard let token = formatore?.token else { return }
        let link = "\(Links.loadVerifiche)?token=\(token)"
        
        guard let url = URL(string: link) else { print("Error Link: \(link)"); return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(Response.self, from: data)
            
            
            
        }.resume()
    }
    
    
    func removeVerifica(id: Int) {
        guard let token = formatore?.token else { return }
        let link = "\(Links.removeVerifica)?idVerifica=\(id)&token=\(token)"
        guard let url = URL(string: link) else { print("Error link: \(link)"); return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(Response.self, from: data)
            
        }.resume()
    }
    
    func set_ver_to_done_state(idVerifica: Int) {
        guard let token = formatore?.token else { return }
        if idVerifica < 0 { return }
        let link = "\(Links.setVerificaCorretta)?token=\(token)&idVerifica=\(idVerifica)"
        guard let url = URL(string: link) else { print("Error link: \(link)"); return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(Response.self, from: data)
            
            
            }.resume()
    }
    
}



