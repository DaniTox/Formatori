//
//  VerificaCell.swift
//  Formatori
//
//  Created by Dani Tox on 23/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import UIKit

class VerificaCell: UITableViewCell {

    var titleLabel : UILabel = UILabel()
    var dataLabel : UILabel = UILabel()
    var classeLabel : UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


extension VerificaCell {
    private func setViews() {
        
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.6
        addSubview(titleLabel)
        
        
        dataLabel.textColor = .white
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.textAlignment = .right
        dataLabel.adjustsFontSizeToFitWidth = true
        addSubview(dataLabel)
        
        classeLabel.textColor = .white
        classeLabel.translatesAutoresizingMaskIntoConstraints = false
        classeLabel.textAlignment = .right
        classeLabel.adjustsFontSizeToFitWidth = true
        addSubview(classeLabel)
        
        
        let stackView = UIStackView(arrangedSubviews: [classeLabel, dataLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        
        if #available(iOS 11, *) {
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10).isActive = true
        } else {
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10).isActive = true
        }
        
        
        
    }
}

