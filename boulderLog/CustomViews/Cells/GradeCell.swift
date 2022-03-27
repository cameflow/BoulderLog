//
//  GradeCell.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 29/01/22.
//

import UIKit

class GradeCell: UICollectionViewCell {
    
    static let resuseID = "GradeCell"
    let avatarImageView = UIImageView()
    let usernameLabel   = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(grade: String){
        usernameLabel.text = grade
        if grade != "No Grade" {
            avatarImageView.image = UIImage(named: grade + ".PNG")
        }
        
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        avatarImageView.translatesAutoresizingMaskIntoConstraints   = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints     = false
        avatarImageView.contentMode          = .scaleToFill
        avatarImageView.layer.cornerRadius   = 10
        avatarImageView.layer.borderWidth    = 1
        avatarImageView.layer.borderColor    = UIColor.systemGray2.cgColor
        avatarImageView.clipsToBounds        = true
        
        let padding: CGFloat = 15

        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width),
            avatarImageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.width),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            usernameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
