//
//  VerificheCollCell.swift
//  Formatori
//
//  Created by Dani Tox on 19/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class VerificheCollCell: UICollectionViewCell {
    
    var materiaLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        materiaLabel = UILabel()
        materiaLabel.font = UIFont.boldSystemFont(ofSize: 17)
        materiaLabel.textAlignment = .center
        materiaLabel.textColor = .white
        materiaLabel.adjustsFontSizeToFitWidth = true
        materiaLabel.minimumScaleFactor = 0.6
        materiaLabel.translatesAutoresizingMaskIntoConstraints = false
        materiaLabel.backgroundColor = .green
        addSubview(materiaLabel)
        materiaLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        materiaLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        materiaLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        materiaLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
