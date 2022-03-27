//
//  BoulderCell.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 25/01/22.
//

import UIKit

class BoulderCell: UITableViewCell {
    
    static let reuseID  = "BoulderCell"
    let titleLabel      = UILabel()
    let gradeImage      = UIImageView()
    let locationImage   = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(boulder: Boulder) {
        titleLabel.text = boulder.name
        let boulderGrade = (boulder.grade ?? "V1") + ".PNG"
        gradeImage.image = UIImage(named: boulderGrade)
        let location = (boulder.location ?? "404") + ".jpg"
        locationImage.image = UIImage(named: location)
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(gradeImage)
        addSubview(locationImage)
        
        gradeImage.translatesAutoresizingMaskIntoConstraints    = false
        titleLabel.translatesAutoresizingMaskIntoConstraints    = false
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        gradeImage.contentMode              = .scaleToFill
        gradeImage.layer.cornerRadius       = 10
        gradeImage.layer.borderWidth        = 1
        gradeImage.layer.borderColor        = UIColor.systemGray2.cgColor
        gradeImage.clipsToBounds            = true
        locationImage.contentMode           = .scaleToFill
        locationImage.layer.cornerRadius    = 10
        locationImage.layer.borderWidth     = 1
        locationImage.layer.borderColor     = UIColor.systemGray2.cgColor
        locationImage.clipsToBounds         = true
        titleLabel.numberOfLines            = 0
        
        accessoryType                       = .disclosureIndicator
        let padding: CGFloat                = 20
        
        NSLayoutConstraint.activate([
            gradeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gradeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            gradeImage.heightAnchor.constraint(equalToConstant: 50),
            gradeImage.widthAnchor.constraint(equalToConstant: 50),
            
            locationImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            locationImage.leadingAnchor.constraint(equalTo: gradeImage.trailingAnchor, constant: padding/2),
            locationImage.heightAnchor.constraint(equalToConstant: 50),
            locationImage.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            titleLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

}
