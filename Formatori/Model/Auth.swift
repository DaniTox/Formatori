//
//  Auth.swift
//  Formatori
//
//  Created by Dani Tox on 17/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Auth {
    
    func login(with nome: String, password: String, completion : ((Bool, String?) -> Void)?) {
        let link = "\(Links.login)?nome=\(nome)&password=\(password)"
        guard let url = URL(string: link) else { return }
        
        print(link)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            print("DATA: \n\(data)\n\nFINE DATA")
            
            do {
                let json = try JSONDecoder().decode(Response.self, from: data)
                
                switch json.code {
                case 0:
                    if let formatore = json.formatore {
                        self.saveFormatoreInMemory(formatore)
                    }
                    completion?(true, nil)
                default:
                    completion?(false, json.message)
                }
                
            } catch {
                completion?(false, error.localizedDescription)
            }
        }.resume()
        
    }

    static func logout() {
        removeFormatoreFromMemory()
    }
    
    static private func removeFormatoreFromMemory() {
        KeychainWrapper.standard.set(Data(), forKey: "formatore")
    }
    
    private func saveFormatoreInMemory(_ formatore : Formatore) {
        guard let data = try? JSONEncoder().encode(formatore) else { return }
        
        KeychainWrapper.standard.set(data, forKey: "formatore")
        
    }
    
    
    
}

