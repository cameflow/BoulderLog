//
//  BLStarRating.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 01/02/22.
//

import UIKit

class BLStarRating: UIView {
    
    let star1 = UIButton()
    let star2 = UIButton()
    let star3 = UIButton()
    let star4 = UIButton()
    let star5 = UIButton()
    
    var rating = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 155, height: 25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(star1)
        addSubview(star2)
        addSubview(star3)
        addSubview(star4)
        addSubview(star5)
        
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin, scale: .default)
        let starImg = UIImage(systemName: "star", withConfiguration: config)
        
        star1.translatesAutoresizingMaskIntoConstraints = false
        star2.translatesAutoresizingMaskIntoConstraints = false
        star3.translatesAutoresizingMaskIntoConstraints = false
        star4.translatesAutoresizingMaskIntoConstraints = false
        star5.translatesAutoresizingMaskIntoConstraints = false
        
        
        star1.setImage(starImg, for: .normal)
        star2.setImage(starImg, for: .normal)
        star3.setImage(starImg, for: .normal)
        star4.setImage(starImg, for: .normal)
        star5.setImage(starImg, for: .normal)
        
        star1.tag = 1
        star2.tag = 2
        star3.tag = 3
        star4.tag = 4
        star5.tag = 5
        
        star1.addTarget(self, action: #selector(starclicked), for: .touchUpInside)
        star2.addTarget(self, action: #selector(starclicked), for: .touchUpInside)
        star3.addTarget(self, action: #selector(starclicked), for: .touchUpInside)
        star4.addTarget(self, action: #selector(starclicked), for: .touchUpInside)
        star5.addTarget(self, action: #selector(starclicked), for: .touchUpInside)
        
        star1.tintColor = .systemYellow
        star2.tintColor = .systemYellow
        star3.tintColor = .systemYellow
        star4.tintColor = .systemYellow
        star5.tintColor = .systemYellow
        
        NSLayoutConstraint.activate([
            
            star1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            star1.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            star2.leadingAnchor.constraint(equalTo: star1.trailingAnchor),
            star2.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            star3.leadingAnchor.constraint(equalTo: star2.trailingAnchor),
            star3.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            star4.leadingAnchor.constraint(equalTo: star3.trailingAnchor),
            star4.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            star5.leadingAnchor.constraint(equalTo: star4.trailingAnchor),
            star5.centerYAnchor.constraint(equalTo: self.centerYAnchor)

            
        ])
    }
    
    @objc func starclicked(sender: UIButton) {
        let buttons = [star1,star2,star3,star4,star5]
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin, scale: .default)
        let starImg = UIImage(systemName: "star", withConfiguration: config)
        let starFillImg = UIImage(systemName: "star.fill", withConfiguration: config)
        for button in buttons {
            button.setImage(starImg, for: .normal)
        }
        for i in 0 ..< Int(sender.tag) {
            buttons[i].setImage(starFillImg, for: .normal)
        }
        rating = sender.tag
    }
    
}
