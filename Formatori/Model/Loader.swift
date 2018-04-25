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
        guard   let materia = verifica.materia,
                let titolo = verifica.titolo,
                let classe = verifica.classe,
                let dateString = verifica.date?.string,
                let token = formatore?.token
        else {
            completion?(false, "Trovato qualche valore della verifica = nil")
            return
        }
        
        let note = verifica.note
        
        let link = "\(Links.createVerifica)?materia=\(materia)&titolo=\(titolo)&classe=\(classe)&data=\(dateString)&token=\(token)&note=\(note ?? "")"
        guard let url = URL(string: link) else { print("Error link: \(link)"); completion?(false, "Errore link: \(link)"); return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(Response.self, from: data)
                if json.code == 0 {
                    completion?(true, nil)
                }
                else {
                    completion?(false, json.message)
                }
            } catch {
                completion?(false, error.localizedDescription)
            }
                
            
            
            
            
            }.resume()
        
    }
    
    
    func loadMyVerifiche(completion: ((Bool, String?, [Verifica]?) -> Void )? = nil) {
        guard let token = formatore?.token else {
            completion?(false, "Formatore non loggato. Prova a riavviare l'app", nil)
            return
        }
        
        let link = "\(Links.loadVerifiche)?token=\(token)"
        guard let url = URL(string: link) else {
            completion?(false, "ERRORE NELL'URL: \(link)", nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(Response.self, from: data)
                if json.code == 0 {
                    let verifiche = json.verifiche
                    completion?(true, nil, verifiche)
                } else {
                    completion?(false, json.message, nil)
                }
            }
            catch {
                print("Errore: \(error)")
                completion?(false, error.localizedDescription, nil)
            }
            
            
            
            
            
        }.resume()
        
        
    }
    
    
    func removeVerifica(_ verifica: Verifica, completion: ((Bool, String?) -> Void)? = nil) {
        guard let token = formatore?.token else {
            completion?(false, "Token == nil. Prova a fare il logout e a rientrare")
            return
        }
        
        guard let idVerifica = verifica.idVerifica else {
            completion?(false, "idVerifica ==  nil. Prova a fare il logout e a rientrare")
            return
        }
        
        let link = "\(Links.removeVerifica)?token=\(token)&idVerifica=\(idVerifica)"
        guard let url = URL(string: link) else {
            completion?(false, "Link errato: \(link)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion?(false, "Nessun byte ricevuto dal server. Riprova più tardi")
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Response.self, from: data)
                
                if json.code == 0 {
                    completion?(true, nil)
                } else {
                    completion?(false, json.message)
                }
                
            } catch {
                completion?(false, error.localizedDescription)
            }
            
            
            
        }.resume()
    }
    
    
    
    
    func setVerificaAsCorrect(_ verifica: Verifica, completion: ((Bool, String?) -> Void)? = nil) {
        guard let token = formatore?.token else {
            completion?(false, "Token == nil. Prova a fare il logout e a rientrare")
            return
        }
        guard let idVerifica = verifica.idVerifica else {
            completion?(false, "idVerifica ==  nil. Prova a fare il logout e a rientrare")
            return
        }
        
        let link = "\(Links.setVerificaCorretta)?token=\(token)&idVerifica=\(idVerifica)"
        guard let url = URL(string: link) else {
            completion?(false, "Link errato: \(link)")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion?(false, "Nessun byte ricevuto dal server. Riprova più tardi")
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Response.self, from: data)
                
                if json.code == 0 {
                    completion?(true, nil)
                } else {
                    completion?(false, json.message)
                }
                
            } catch {
                completion?(false, error.localizedDescription)
            }
            
            
        }.resume()
        
        
    }
    
}



