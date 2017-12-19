//
//  CreateVerificaMateriaVC.swift
//  Formatori
//
//  Created by Dani Tox on 19/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class CreateVerificaMateriaVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var materiaSelezionata : String? {
        didSet {
            print("Materia Selezionata: \(materiaSelezionata ?? "Error")")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "continueCreating" {
            if let vc = segue.destination as? CreateVerificaFinalVC {
                vc.materiaSelezionata = materiaSelezionata
            }
        }
    }
 

}

extension CreateVerificaMateriaVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return materie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VerificheCollCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15
        cell.backgroundColor = UIColor.orange
        cell.titleLabel.text = materie[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        materiaSelezionata = materie[indexPath.row]
        
        if materiaSelezionata != nil {
            self.performSegue(withIdentifier: "continueCreating", sender: self)
        }
    }
    
}
