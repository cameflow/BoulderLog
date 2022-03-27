//
//  SingleStats.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 30/01/22.
//

import Charts
import UIKit



class SingleStats: UIViewController,UINavigationControllerDelegate {
    
    var count               = 0
    let barChart            = BarChartView()
    var chartData: [Int]!
    var originator:String!
    var delegate: ModalHandler?

    
    
    init(items: [Int], titleString: String, originator: String) {
        super.init(nibName: nil, bundle: nil)
        self.chartData  = items
        self.title      = titleString
        self.originator = originator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeModal))
        createChart()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        var entries = [BarChartDataEntry]()
        count = 0
        for amt in chartData {

            entries.append(BarChartDataEntry(x: Double(count), y: Double(amt)))
            count += 1
        }
        let set = BarChartDataSet(entries: entries, label: title)
        set.colors = [NSUIColor(cgColor: UIColor.systemIndigo.cgColor)]
        let data = BarChartData(dataSet: set)

        barChart.data = data
    }
    
    private func createChart() {
        
        view.addSubview(barChart)
        
        let padding:CGFloat = 20
        
        barChart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - padding, height: view.frame.size.width - padding)
        barChart.center = view.center
        
        barChart.layer.borderWidth  = 3
        barChart.layer.cornerRadius = 5
        barChart.layer.borderColor  = UIColor.systemGray2.cgColor
        barChart.clipsToBounds      = true
        
       
        let rightAxis = barChart.rightAxis
        rightAxis.drawLabelsEnabled = false
        
        configureXAxis()
        setChartData()
    }
    
    private func setChartData() {
        
        var entries = [BarChartDataEntry]()
        count = 0
        for amt in chartData {
            
            entries.append(BarChartDataEntry(x: Double(count), y: Double(amt)))
            count += 1
        }
        
        let set = BarChartDataSet(entries: entries, label: title)
        set.colors = [NSUIColor(cgColor: UIColor.systemIndigo.cgColor)]
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
    }
    
    private func configureXAxis() {
        let xAxis = barChart.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.labelPosition = .bottomInside
        xAxis.labelCount = chartData.count
        let xAxisFormater = MyXAxisFormatter(type: originator)
        xAxis.valueFormatter = xAxisFormater
    }
    
    @objc func closeModal() {
        dismiss(animated: true) {
            if let del = self.delegate {
                del.modalDismissed()
            }
        }
    }



}

class MyXAxisFormatter: IndexAxisValueFormatter {
    
    
    let grades = ["V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12", "V13", "V14", "V15", "V16", "V17"]
    var locations:[String] = []
    var type:String = ""
    
    init(type: String) {
        super.init()
        self.type = type
    }
    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if type == "locations" {
            return grades[Int(value)]
        }
        else {
            for location in visitedLocations {
                locations.append(location.name)
            }
            return locations[Int(value)]
        }
        
    }
}
