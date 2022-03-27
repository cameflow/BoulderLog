//
//  BoulderDetail.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 22/01/22.
//

import UIKit

class BoulderDetail: UIViewController {
    
    var boulderDescription  = UITextView()
    var boulderPhoto        = UIImageView()
    var gradeImage          = UIImageView()
    var locationImage       = UIImageView()
    let ratingLabel         = UILabel()
    var starRating          = BLStarRatingLabel()
    let attemptsLabel       = UILabel()
    
    var boulder: Boulder!
    
    init (boulder: Boulder) {
        super.init(nibName: nil, bundle: nil)
        self.boulder    = boulder
        self.title      = boulder.name
        self.navigationItem.largeTitleDisplayMode = .never
        starRating.setRating(rating: boulder.rating ?? 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureGradeImage()
        if boulder.location != nil {
            configureLocationImage()
        }
        configureDescriptionLabel()
        configureRating()
        configureAttempts()
        if (boulder.imageName != nil) {
            if boulder.imageName! != "" {
                configureBoulderPhoto()
            }
            
        }
    }
    
    func configureGradeImage() {
        view.addSubview(gradeImage)
        gradeImage.translatesAutoresizingMaskIntoConstraints = false
        gradeImage.image = UIImage(named: boulder.grade! + ".PNG")
        gradeImage.contentMode          = .scaleAspectFit
        gradeImage.layer.cornerRadius   = 10
        gradeImage.layer.borderWidth    = 1
        gradeImage.layer.borderColor    = UIColor.systemGray2.cgColor
        gradeImage.clipsToBounds        = true
        
        if boulder.location != nil {
            NSLayoutConstraint.activate([
                gradeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                gradeImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,constant: -10),
                gradeImage.widthAnchor.constraint(equalToConstant: 100),
                gradeImage.heightAnchor.constraint(equalToConstant: 100)
            ])
        } else {
            NSLayoutConstraint.activate([
                gradeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                gradeImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                gradeImage.widthAnchor.constraint(equalToConstant: 100),
                gradeImage.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
        
        
        
    }
    
    func configureLocationImage() {
        view.addSubview(locationImage)
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        locationImage.image = UIImage(named: boulder.location! + ".jpg")
        locationImage.contentMode          = .scaleToFill
        locationImage.layer.cornerRadius   = 10
        locationImage.layer.borderWidth    = 1
        locationImage.layer.borderColor    = UIColor.systemGray2.cgColor
        locationImage.clipsToBounds        = true
        
        NSLayoutConstraint.activate([
            locationImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            locationImage.leadingAnchor.constraint(equalTo: gradeImage.trailingAnchor, constant: 20),
            locationImage.widthAnchor.constraint(equalToConstant: 100),
            locationImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
        
    
    func configureDescriptionLabel() {
        view.addSubview(boulderDescription)
        boulderDescription.translatesAutoresizingMaskIntoConstraints = false
        boulderDescription.text               = boulder.description
        boulderDescription.layer.borderColor  = UIColor.systemGray2.cgColor
        boulderDescription.layer.borderWidth  = 1
        boulderDescription.layer.cornerRadius = 5
        boulderDescription.textContainer.lineFragmentPadding = 10
        
        NSLayoutConstraint.activate([
            boulderDescription.topAnchor.constraint(equalTo: gradeImage.bottomAnchor, constant: 20),
            boulderDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            boulderDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            boulderDescription.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureRating() {
        view.addSubview(starRating)
        view.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints   = false
        starRating.translatesAutoresizingMaskIntoConstraints    = false
        
        ratingLabel.text = "Rating:"
        ratingLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: boulderDescription.bottomAnchor, constant: 20),
            ratingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            starRating.topAnchor.constraint(equalTo: boulderDescription.bottomAnchor, constant: 20),
            starRating.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5)
        ])
    }
    
    func configureAttempts() {
        view.addSubview(attemptsLabel)
        attemptsLabel.translatesAutoresizingMaskIntoConstraints = false
        attemptsLabel.text = "# of attempts: " + (boulder.attempts ?? "N/A")
        attemptsLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        NSLayoutConstraint.activate([
            attemptsLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 20),
            attemptsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
    }
    
    func configureBoulderPhoto() {
        view.addSubview(boulderPhoto)
        boulderPhoto.translatesAutoresizingMaskIntoConstraints = false
        getImageFromName(fileName: boulder.imageName!)
        boulderPhoto.layer.masksToBounds    = true
        boulderPhoto.layer.borderColor      = UIColor.systemGray2.cgColor
        boulderPhoto.backgroundColor        = .systemFill
        boulderPhoto.contentMode            = .scaleToFill
        boulderPhoto.layer.cornerRadius     = 5
        boulderPhoto.layer.borderWidth      = 1
        
        NSLayoutConstraint.activate([
            boulderPhoto.topAnchor.constraint(equalTo: attemptsLabel.bottomAnchor, constant: 20),
            boulderPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            boulderPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            boulderPhoto.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func getImageFromName(fileName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(fileName)
        if let imageData = try? Data(contentsOf: url) {
            let image = UIImage(data: imageData) // HERE IS YOUR IMAGE! Do what you want with it!
            boulderPhoto.image = image
        } else {
            print("Couldn't get image for \(fileName)")
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
