//
//  GradeStats.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 30/01/22.
//

import UIKit

class GradeStats: UIViewController {
    
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Grade Stats"
        configureCollectionView()
        gradesClimbed = getGrades()
        visitedLocations = getLocations()
        collectionView.reloadData()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.frame            = view.bounds
        collectionView.delegate         = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.dataSource       = self
        collectionView.register(GradeCell.self, forCellWithReuseIdentifier: GradeCell.resuseID)
        
    }


}

extension GradeStats: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let grade        = gradesClimbed[indexPath.item]
        
        let destVC          = SingleStats(items: getLocationsOfGrade(grade: grade), titleString: "Stats of " + grade, originator: "grades")
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gradesClimbed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GradeCell.resuseID, for: indexPath) as! GradeCell
        
        var grade:String
        grade = gradesClimbed[indexPath.row]
        cell.set(grade: grade)
        return cell
    }
    
}
