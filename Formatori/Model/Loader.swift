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
        if materia.isEmpty || argomento.isEmpty || classe.isEmpty || formatore?.token == nil { return }
        let link = "\(Links.createVerifica)?materia=\(materia)&titolo=\(argomento)&classe=\(classe)&data=\(data.string)&token=\(formatore!.token!)"
        guard let url = URL(string: link) else { print("Error link: \(link)"); return }
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
    
    
    func loadMyVerifiche() {
        if formatore?.token == nil { return }
        let link = "\(Links.loadVerifiche)?token=\(formatore!.token)"
        guard let url = URL(string: link) else { print("Error Link: \(link)"); return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(Response.self, from: data)
            
            if json?.code != "200" {
                self?.delegate?.didFinishLoadVerificheWith!(1, and: json?.message)
            }
            else {
                if let tempVer = json?.verifiche {
                    verifiche = tempVer
                    self?.delegate?.didFinishLoadVerificheWith!(0, and: nil)
                }
                self?.delegate?.didFinishLoadVerificheWith!(1, and: "Errore indefinito. loadMyverifiche()")
            }
            
        }.resume()
    }
    
    
}


@objc protocol LoaderDelegate {
    @objc optional func didCreateVerificaWithReturnCode(_ code : Int, and message: String?)
    @objc optional func didFinishLoadVerificheWith(_ code: Int, and message: String?)
}


