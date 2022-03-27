//
//  DataManager.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 17/01/22.
//

import Foundation

var boulders:[Boulder] = loadJSONData("boulder_data.json")
var visitedLocations:[Location] = getLocations()
var gradesClimbed:[String] = getGrades()
var boulderCount = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

func loadJSONData<T:Decodable>(_ filename:String, as type:T.Type = T.self) -> T {

    do {
        let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("boulder_data.json")
        
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print(error.localizedDescription)
        return [] as! T
    }
    
}

func writeJSON(items: [Boulder]) {
    do {
        let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("boulder_data.json")
        let encoder = JSONEncoder()
        try encoder.encode(items).write(to: fileURL)
    } catch {
        print(error.localizedDescription)
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func removePhoto(_ PhotoName:String) {
    if PhotoName != "" {
        do {
            let fileMng = FileManager()
            let photURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(PhotoName)
            try fileMng.removeItem(at: photURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

func getBoulderCount(items: [Boulder]) {
    boulderCount = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    for item in items {
        switch (item.grade!){
        case "V0":
            boulderCount[0] += 1
        case "V1":
            boulderCount[1] += 1
        case "V2":
            boulderCount[2] += 1
        case "V3":
            boulderCount[3] += 1
        case "V4":
            boulderCount[4] += 1
        case "V5":
            boulderCount[5] += 1
        case "V6":
            boulderCount[6] += 1
        case "V7":
            boulderCount[7] += 1
        case "V8":
            boulderCount[8] += 1
        case "V9":
            boulderCount[9] += 1
        case "V10":
            boulderCount[10] += 1
        case "V11":
            boulderCount[11] += 1
        case "V12":
            boulderCount[12] += 1
        case "V13":
            boulderCount[13] += 1
        case "V14":
            boulderCount[14] += 1
        case "V15":
            boulderCount[15] += 1
        case "V16":
            boulderCount[16] += 1
        case "V17":
            boulderCount[17] += 1
        default:
            print("defaultcase")
        }
    }
}

func getLocations() -> [Location]{
    var vL:[Location] = []
    for boulder in boulders {
        let loc = Location(name: boulder.location ?? "Sin nombre")
        if (vL.contains(loc)) {
            //print("Locatino already added")
        } else {
            vL.append(loc)
        }
    }
    return vL
                
}

func getGrades() -> [String]{
    var gC:[String] = []
    for boulder in boulders {
        let grade = boulder.grade ?? "No Grade"
        if (gC.contains(grade)) {
            //print("Locatino already added")
        } else {
            gC.append(grade)
        }
    }
    return gC
    
}

func getBouldersByLocation(location: Location) -> [Int] {
    var bouldersByLocation = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    for boulder in boulders {
        if boulder.location == location.name {
            switch (boulder.grade!){
            case "V0":
                bouldersByLocation[0] += 1
            case "V1":
                bouldersByLocation[1] += 1
            case "V2":
                bouldersByLocation[2] += 1
            case "V3":
                bouldersByLocation[3] += 1
            case "V4":
                bouldersByLocation[4] += 1
            case "V5":
                bouldersByLocation[5] += 1
            case "V6":
                bouldersByLocation[6] += 1
            case "V7":
                bouldersByLocation[7] += 1
            case "V8":
                bouldersByLocation[8] += 1
            case "V9":
                bouldersByLocation[9] += 1
            case "V10":
                bouldersByLocation[10] += 1
            case "V11":
                bouldersByLocation[11] += 1
            case "V12":
                bouldersByLocation[12] += 1
            case "V13":
                bouldersByLocation[13] += 1
            case "V14":
                bouldersByLocation[14] += 1
            case "V15":
                bouldersByLocation[15] += 1
            case "V16":
                bouldersByLocation[16] += 1
            case "V17":
                bouldersByLocation[17] += 1
            default:
                print("defaultcase")
            }
        }
    }
    return bouldersByLocation
}

func getLocationsOfGrade(grade: String) -> [Int] {
    var locationOfGrades:[Int] = []
    var i = 0
    for location in visitedLocations {
        locationOfGrades.append(0)
        for boulder in boulders {
            if ((boulder.location == location.name) && (boulder.grade == grade) ){
                locationOfGrades[i] += 1
            }
        }
        i += 1
    }
    return locationOfGrades
}
