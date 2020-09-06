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
    
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let zoneJSONURL = documentsDirectory.appendingPathComponent("zone_data").appendingPathExtension("json")

    func loadJSON() -> ZoneData? {
        guard FileManager.default.fileExists(atPath: DataManager.zoneJSONURL.path) else {
        return nil
      }
        if let data = try? Data(contentsOf: DataManager.zoneJSONURL),
        let decodedZones = try? JSONDecoder().decode(ZoneData.self, from: data){
            zoneData = decodedZones
        }
        return zoneData
    }
    
    func saveJSON(_ zoneData: ZoneData) {
      
        do {
            try JSONEncoder().encode(zoneData)
                .write(to: DataManager.zoneJSONURL)
        } catch {
            print(error)
        }
        
}
}
