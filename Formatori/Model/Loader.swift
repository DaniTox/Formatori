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
    
    func create(verifica: Verifica) {
        if verifica.checkIntegrityOfData() != 0 { return }
        
        let link = "\(Links.createVerifica)?materia=\(verifica.materia!)&titolo=\(verifica.argomento!)&classe=\(verifica.classe!)&data=\(verifica.date!.string)&token=\(formatore!.token!)"
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
        let link = "\(Links.loadVerifiche)?token=\(formatore!.token!)"
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
                else {
                    self?.delegate?.didFinishLoadVerificheWith!(1, and: "Errore indefinito. loadMyverifiche()")
                }
            }
            
        }.resume()
    }
    
    
    func removeVerifica(id: Int) {
        if formatore?.token == nil { return }
        let link = "\(Links.removeVerifica)?idVerifica=\(id)&token=\(formatore!.token!)"
        guard let url = URL(string: link) else { print("Error link: \(link)"); return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(Response.self, from: data)
            if json?.code != "200" {
                self?.delegate?.didRemoveVerificaWith!(code: 1, andMsg: json?.message)
                print("Delegate send this msg: \(json?.message ?? "nil")")
            }
            else {
                self?.delegate?.didRemoveVerificaWith!(code: 0, andMsg: nil)
            }
        }.resume()
    }
    
    func set_ver_to_done_state(idVerifica: Int) {
        if formatore?.token == nil { return }
        if idVerifica < 0 { return }
        let link = "\(Links.setVerificaCorretta)?token=\(formatore!.token!)&idVerifica=\(idVerifica)"
        guard let url = URL(string: link) else { print("Error link: \(link)"); return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(Response.self, from: data)
            if json?.code != "200" {
                self?.delegate?.set_ver_state_doneDidFinish!(code: 1, andMsg: json?.message ?? "Errore generico")
            }
            else {
                self?.delegate?.set_ver_state_doneDidFinish!(code: 0, andMsg: nil)
            }
            }.resume()
    }
    
}


@objc protocol LoaderDelegate {
    @objc optional func didCreateVerificaWithReturnCode(_ code : Int, and message: String?)
    @objc optional func didFinishLoadVerificheWith(_ code: Int, and message: String?)
    @objc optional func didRemoveVerificaWith(code: Int, andMsg message: String?)
    @objc optional func set_ver_state_doneDidFinish(code: Int, andMsg message : String?)
}


