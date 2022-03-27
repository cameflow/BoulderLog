//
//  AddBeta.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 18/01/22.
//

import UIKit

protocol ModalHandler {
  func modalDismissed()
}

class AddBeta: UIViewController, UINavigationControllerDelegate{

    let boulderName             = UITextField()
    let boulderDescriptionLabel = UILabel()
    let boulderDescription      = UITextView()
    let addPhotoButton          = UIButton()
    var imagePicker             = UIImagePickerController()
    let gradePicker             = UIPickerView()
    let locationPicker          = UIPickerView()
    var betaphoto               = UIImageView()
    let starRating              = BLStarRating()
    var scrollView              = UIScrollView()
    let ratingLabel             = UILabel()
    var attemptsSelector        = UISegmentedControl()
    let attemptsSelectorLabel   = UILabel()
    
    let alert = UIAlertController(title: "Can't add boulder", message: "Add Boulder name", preferredStyle: UIAlertController.Style.alert)

    var imageName           = ""
    var imagePath           = URL(string: "")
    var selectedImage       = false
    
    var delegate: ModalHandler?
    
    let grades              = ["V0","V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15","V16","V17"]
    let locations           = ["Amanecer", "Adamanta", "Rock Solid", "Onix", "V+", "Levita", "Beta", "Bloc-E"]
    let attempts            = ["Flash", "2", "3", "4", "5+"]
    var selectedGrade       = "V0"
    var selectedLocation    = "Amanecer"
    var boulderGrade        = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureScrollView()
        configureboulderName()
        configureBoulderDescriptionLabel()
        configureBoulderDescription()
        configureGradePicker()
        configureLocationPicker()
        configureStarRating()
        configureAttemptSelector()
        configureImageView()
        configureAddPhotoButton()
    }
    
    // MARK: - Views configurations
    
    private func configureVC() {
        view.backgroundColor                = .systemBackground
        title                               = "Add Boulder"
        navigationItem.rightBarButtonItem   = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBoulder))
        navigationController?.navigationBar.prefersLargeTitles = true
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

    }
        
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor      = .systemBackground
        scrollView.isScrollEnabled      = true
        scrollView.contentSize          = CGSize(width: view.bounds.size.width, height: 1500)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 300)
        ])
    }
    
    private func configureboulderName() {
        scrollView.addSubview(boulderName)
        boulderName.translatesAutoresizingMaskIntoConstraints = false
        boulderName.layer.cornerRadius          = 5
        boulderName.layer.borderWidth           = 1
        boulderName.layer.borderColor           = UIColor.systemGray.cgColor
        
        boulderName.textColor                   = .label
        boulderName.tintColor                   = .label
        boulderName.textAlignment               = .center
        boulderName.font                        = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        boulderName.adjustsFontSizeToFitWidth   = true
        boulderName.backgroundColor             = .tertiarySystemBackground
        boulderName.autocorrectionType          = .no
        boulderName.returnKeyType               = .go
        boulderName.clearButtonMode             = .whileEditing
        boulderName.placeholder                 = "Boulder Name"
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        boulderName.inputAccessoryView = doneToolbar
        
    
        
        NSLayoutConstraint.activate([
            boulderName.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            boulderName.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            boulderName.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            boulderName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureBoulderDescriptionLabel() {
        scrollView.addSubview(boulderDescriptionLabel)
        boulderDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        boulderDescriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        boulderDescriptionLabel.text = "Boulder Description:"
        
        NSLayoutConstraint.activate([
            boulderDescriptionLabel.topAnchor.constraint(equalTo: boulderName.bottomAnchor, constant: 30),
            boulderDescriptionLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            boulderDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
    }
    
    private func configureBoulderDescription() {
        scrollView.addSubview(boulderDescription)
        boulderDescription.translatesAutoresizingMaskIntoConstraints = false
        boulderDescription.layer.cornerRadius   = 5
        boulderDescription.layer.borderWidth    = 1
        boulderDescription.layer.borderColor    = UIColor.systemGray.cgColor
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        boulderDescription.inputAccessoryView = doneToolbar
        
        boulderDescription.textColor            = .label
        boulderDescription.tintColor            = .label
        boulderDescription.textAlignment        = .left
        boulderDescription.font                 = UIFont.systemFont(ofSize: 15, weight: .thin)
        
        boulderDescription.backgroundColor      = .tertiarySystemBackground
        
        NSLayoutConstraint.activate([
            boulderDescription.topAnchor.constraint(equalTo: boulderDescriptionLabel.bottomAnchor, constant: 10),
            boulderDescription.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            boulderDescription.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            boulderDescription.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        
    }
    
    private func configureGradePicker() {
        scrollView.addSubview(gradePicker)
        gradePicker.translatesAutoresizingMaskIntoConstraints = false
        
        gradePicker.delegate            = self
        gradePicker.dataSource          = self
        gradePicker.layer.borderWidth   = 1
        gradePicker.layer.borderColor   = UIColor.systemGray.cgColor
        gradePicker.layer.cornerRadius  = 5
        
        NSLayoutConstraint.activate([
            gradePicker.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            gradePicker.topAnchor.constraint(equalTo: boulderDescription.bottomAnchor, constant: 20),
            gradePicker.widthAnchor.constraint(equalToConstant: 100),
            gradePicker.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
    private func configureLocationPicker() {
        scrollView.addSubview(locationPicker)
        locationPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        locationPicker.delegate             = self
        locationPicker.dataSource           = self
        locationPicker.layer.borderWidth    = 1
        locationPicker.layer.borderColor    = UIColor.systemGray.cgColor
        locationPicker.layer.cornerRadius   = 5
        
        NSLayoutConstraint.activate([
            locationPicker.leadingAnchor.constraint(equalTo: gradePicker.trailingAnchor, constant: 20),
            locationPicker.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            locationPicker.topAnchor.constraint(equalTo: gradePicker.topAnchor),
            locationPicker.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
    private func configureStarRating() {
        scrollView.addSubview(starRating)
        scrollView.addSubview(ratingLabel)
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints   = false
        starRating.translatesAutoresizingMaskIntoConstraints    = false
        
        ratingLabel.text = "Rating:"
        ratingLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            ratingLabel.topAnchor.constraint(equalTo: gradePicker.bottomAnchor, constant: 20),
            starRating.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 10),
            starRating.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor)
        ])
    }
    
    private func configureAttemptSelector() {
        attemptsSelector = UISegmentedControl(items: attempts)
        
        scrollView.addSubview(attemptsSelectorLabel)
        scrollView.addSubview(attemptsSelector)
        
        attemptsSelectorLabel.translatesAutoresizingMaskIntoConstraints = false
        attemptsSelector.translatesAutoresizingMaskIntoConstraints      = false
        
        attemptsSelectorLabel.text = "How many attempts?"
        attemptsSelectorLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        
        attemptsSelector.selectedSegmentIndex   = 0
        
        NSLayoutConstraint.activate([
            attemptsSelectorLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            attemptsSelectorLabel.topAnchor.constraint(equalTo: starRating.bottomAnchor, constant: 20),
            attemptsSelector.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            attemptsSelector.topAnchor.constraint(equalTo: attemptsSelectorLabel.bottomAnchor, constant: 10),
            attemptsSelector.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            attemptsSelector.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
    
    private func configureImageView() {
        scrollView.addSubview(betaphoto)
        betaphoto.translatesAutoresizingMaskIntoConstraints = false
        betaphoto.layer.cornerRadius    = 5
        betaphoto.layer.borderWidth     = 1
        betaphoto.layer.masksToBounds   = true
        betaphoto.layer.borderColor     = UIColor.systemGray.cgColor
        betaphoto.backgroundColor       = .systemFill
        let imageConfig                 = UIImage.SymbolConfiguration(pointSize: 10, weight: .light, scale: .default)
        betaphoto.image                 = UIImage(systemName: "photo.on.rectangle.angled", withConfiguration: imageConfig)
        betaphoto.contentMode           = .scaleToFill
        
        
        NSLayoutConstraint.activate([
            betaphoto.topAnchor.constraint(equalTo: attemptsSelector.bottomAnchor, constant: 20),
            betaphoto.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            betaphoto.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            betaphoto.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    private func configureAddPhotoButton() {
        scrollView.addSubview(addPhotoButton)
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addPhotoButton.setTitleColor(.black, for: .normal)
        addPhotoButton.addTarget(self, action: #selector(addphoto), for: .touchUpInside)
        addPhotoButton.backgroundColor      = .systemGreen
        addPhotoButton.layer.zPosition      = 1
        addPhotoButton.layer.cornerRadius   = 25
        
        NSLayoutConstraint.activate([
            addPhotoButton.topAnchor.constraint(equalTo: betaphoto.bottomAnchor, constant: -60),
            addPhotoButton.trailingAnchor.constraint(equalTo: betaphoto.trailingAnchor, constant: -20),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 50),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    // MARK: - Button Functions
    
    @objc func addBoulder() {
        
        guard boulderName.text          != "" else {
            alert.message = "Please add boulder name"
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard boulderDescription.text   != "" else {
            alert.message = "Please add description"
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var newboulder          = Boulder(name: boulderName.text!, description: boulderDescription.text)
        newboulder.imageName    = imageName
        newboulder.grade        = selectedGrade
        newboulder.location     = selectedLocation
        newboulder.rating       = starRating.rating
        newboulder.attempts     = attempts[attemptsSelector.selectedSegmentIndex]
        boulders.append(newboulder)
        
        if selectedImage {
            if let jpegData = betaphoto.image?.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imagePath!)
            }
        }
        
        writeJSON(items: boulders)
        
        
        dismiss(animated: true) {
            if let del = self.delegate {
                del.modalDismissed()
            }
        }
    }
    
    @objc func addphoto() {
        imagePicker.delegate        = self
        imagePicker.allowsEditing   = true
        imagePicker.mediaTypes      = ["public.image", "public.movie"]
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func doneButtonAction(){
            boulderDescription.resignFirstResponder()
            boulderName.resignFirstResponder()
    }

}

// MARK: - Extensions

extension AddBeta: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == locationPicker {
            return locations.count
        } else {
            return grades.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == locationPicker {
            return locations[row]
        } else {
            return grades[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        if pickerView == locationPicker {
            label.text =  locations[row]
        } else {
            label.text = grades[row]
        }
        
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == locationPicker {
            selectedLocation = locations[row]
        } else {
            selectedGrade = grades[row]
        }
    }
}

extension AddBeta: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        imageName = UUID().uuidString + ".jpeg"
        imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        betaphoto.image = image
        selectedImage = true
        
        dismiss(animated: true)
    }
}





