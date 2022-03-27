//
//  BLTabBarController.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 26/01/22.
//

import UIKit

class BLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemIndigo
        viewControllers                 = [createMainScreenNC(), createRandomMovieNC()]
    }
    

    func createMainScreenNC() -> UINavigationController {
        let mainScreen          = ViewController()
        mainScreen.tabBarItem   = UITabBarItem(title: "Logs", image: UIImage(systemName: "note.text"), tag: 0)
        
        return UINavigationController(rootViewController: mainScreen)
    }
    
    func createRandomMovieNC() -> UINavigationController {
        let stats         = Stats()
        stats.tabBarItem  = UITabBarItem(title: "Stats", image: UIImage(systemName: "chart.bar.xaxis"), tag: 1)
        
        return UINavigationController(rootViewController: stats)
    }
    

}


