//
//  DataLoader.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 29.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import Foundation


public class DataManager {

    static var `default` = DataManager()
    
    var zoneData: ZoneData{
        get {
           return loadJSON() ?? ZoneData()
        }
        set {
            saveJSON(newValue)
        }
    }
    
    
    private let zoneJSONURL: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
        in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("zone_data.json")
   }()

    
    func loadJSON() -> ZoneData? {
        do {
            let data = try Data(contentsOf: zoneJSONURL)
            let decodedZones = try JSONDecoder().decode(ZoneData.self, from: data)
            return decodedZones
        } catch {
            return nil
        }
    }
    
    func saveJSON(_ zoneData: ZoneData) {
      
        do {
            let data = try JSONEncoder().encode(zoneData)
            try data.write(to: zoneJSONURL)
        } catch {
            print(error)
        }
        
}
}
