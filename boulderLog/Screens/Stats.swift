//
//  Stats.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 26/01/22.
//

import UIKit

class Stats: UIViewController {


    let viewAllButton       = BLButton(backgroundColor: .systemIndigo, title: "View All")
    let locationStatsButton = BLButton(backgroundColor: .systemIndigo, title: "View stats by location")
    let gradeStatsButton    = BLButton(backgroundColor: .systemIndigo, title: "View stats by grade")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Stats"
        navigationController?.navigationBar.prefersLargeTitles = true
        visitedLocations = getLocations()
        configureButtons()

    }
    

    private func configureButtons() {
        view.addSubview(viewAllButton)
        view.addSubview(gradeStatsButton)
        view.addSubview(locationStatsButton)
        
        viewAllButton.addTarget(self, action: #selector(allStats), for: .touchUpInside)
        locationStatsButton.addTarget(self, action: #selector(locationStats), for: .touchUpInside)
        gradeStatsButton.addTarget(self, action: #selector(gradeStats), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            
            locationStatsButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            locationStatsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationStatsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationStatsButton.heightAnchor.constraint(equalToConstant: 50),
            
            viewAllButton.bottomAnchor.constraint(equalTo: locationStatsButton.topAnchor, constant: -20),
            viewAllButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewAllButton.heightAnchor.constraint(equalToConstant: 50),
            
            gradeStatsButton.topAnchor.constraint(equalTo: locationStatsButton.bottomAnchor, constant: 20),
            gradeStatsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gradeStatsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gradeStatsButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    @objc func locationStats() {
        let destVC = LocationStats()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    @objc func gradeStats() {
        let destVC = GradeStats()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    @objc func allStats() {
        getBoulderCount(items: boulders)
        let destVC = SingleStats(items: boulderCount, titleString: "Boulders by Grade", originator: "locations")
        let navController   = UINavigationController(rootViewController: destVC)

        present(navController, animated: true)
    }
    


}




