//
//  BLStarRating.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 01/02/22.
//

import UIKit

class BLStarRatingLabel: UIView {
    
    let star1 = UIImageView()
    let star2 = UIImageView()
    let star3 = UIImageView()
    let star4 = UIImageView()
    let star5 = UIImageView()
    
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
    
    func setRating(rating: Int) {
        self.rating = rating
        let ratings = [star1,star2,star3,star4,star5]
        
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin, scale: .default)
        let starImg = UIImage(systemName: "star", withConfiguration: config)
        let starFillImg = UIImage(systemName: "star.fill", withConfiguration: config)
        
        for i in 0..<5 {
            if i < rating {
                ratings[i].image = starFillImg
            } else {
                ratings[i].image = starImg
            }
        }
    }
    
    func configure() {
        addSubview(star1)
        addSubview(star2)
        addSubview(star3)
        addSubview(star4)
        addSubview(star5)
        
        
        star1.translatesAutoresizingMaskIntoConstraints = false
        star2.translatesAutoresizingMaskIntoConstraints = false
        star3.translatesAutoresizingMaskIntoConstraints = false
        star4.translatesAutoresizingMaskIntoConstraints = false
        star5.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
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
    
    
}
