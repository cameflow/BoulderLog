//
//  ViewController.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 17/01/22.
//

import UIKit

class ViewController: UIViewController {
    

    let tableView           = UITableView()
    let searchController    = UISearchController()
    var filteredBoulders    = [Boulder]()
    let easyGrades          = ["V0","V1","V2","V3"]
    let mediumGrades        = ["V4","V5","V6"]
    let hardGrades          = ["V7","V8","V9","V10"]
    let proGrades           = ["V11","V12","V13","V14","V15","V16","V17"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        configureSearchController()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    

    // MARK: - Configure Views
    
    private func configureVC() {
        view.backgroundColor    = .systemBackground
        title                   = "Boulder Log"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(AddBoulder))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 70
        tableView.delegate      = self
        tableView.dataSource    = self
                
        tableView.register(BoulderCell.self,forCellReuseIdentifier: BoulderCell.reuseID)
    }
    
    private func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater                       = self
        searchController.obscuresBackgroundDuringPresentation       = false
        searchController.searchBar.enablesReturnKeyAutomatically    = false
        searchController.searchBar.returnKeyType                    = UIReturnKeyType.done
        definesPresentationContext                                  = true
        
        navigationItem.searchController                 = searchController
        navigationItem.hidesSearchBarWhenScrolling      = false
        searchController.searchBar.scopeButtonTitles    = ["All","V0-V3","V4-V6","V7-V10","V11+"]
        searchController.searchBar.delegate             = self
    }
    
    // MARK: - Button functions
    
    @objc func AddBoulder() {
        let destVC          = AddBeta()
        destVC.delegate     = self
        let navController   = UINavigationController(rootViewController: destVC)

        present(navController, animated: true)
    }
    
    
    // MARK: - ViewController Functions
    
    func getData(){
        boulders.removeAll()
        boulders = loadJSONData("boulder_data.json")
        self.tableView.reloadData()
    }
    
}


// MARK: - ViewController Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchController.isActive){
            return filteredBoulders.count
        } else {
            return boulders.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoulderCell.reuseID) as! BoulderCell
        
        var boulder:Boulder
        
        if(searchController.isActive) {
            boulder = filteredBoulders[indexPath.row]
        } else {
            boulder = boulders[indexPath.row]
        }
        
        cell.set(boulder: boulder)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var boulder:Boulder
        
        if(searchController.isActive) {
            boulder = filteredBoulders[indexPath.row]
        } else {
            boulder = boulders[indexPath.row]
        }
        
        let destVc = BoulderDetail(boulder: boulder)
        navigationController?.pushViewController(destVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var photoName:String
            if(searchController.isActive) {
                photoName = filteredBoulders[indexPath.row].imageName!
                boulders.removeAll { boulder in
                    boulder.name == filteredBoulders[indexPath.row].name
                }
            } else {
                photoName = boulders[indexPath.row].imageName!
                boulders.remove(at: indexPath.row)
            }
            removePhoto(photoName)
            tableView.deleteRows(at: [indexPath], with: .right)
            writeJSON(items: boulders)
            getData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar   = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText  = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
        
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All") {
        filteredBoulders = boulders.filter({ boulder in
            let scopeMatch = (scopeButton == "All" || ((scopeButton == "V0-V3" && (easyGrades.contains(boulder.grade!)) || (scopeButton == "V4-V6" && (mediumGrades.contains(boulder.grade!))) || (scopeButton == "V7-V10" && (hardGrades.contains(boulder.grade!))) || (scopeButton == "V11+" && (proGrades.contains(boulder.grade!))))))
            if (searchController.searchBar.text != "") {
                let searchTextMatch = (boulder.name.lowercased().contains(searchText.lowercased()) || boulder.description.lowercased().contains(searchText.lowercased()))
                
                return scopeMatch && searchTextMatch
            } else {
                return scopeMatch
            }
        })
        tableView.reloadData()
    }
}

extension ViewController: ModalHandler {
    func modalDismissed() {
        getData()
    }
}
