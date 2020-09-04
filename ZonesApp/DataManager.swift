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
    
    var zoneData: ZoneData {
        get {
           return loadJSON() ?? ZoneData()
        }
        set {
            saveJSON(newValue)
        }
    }
    
    let zoneJSONURL = URL(fileURLWithPath: "ZoneData",
                          relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    
    public init() {
       
    }
   
    private func loadJSON() -> ZoneData? {
      guard FileManager.default.fileExists(atPath: zoneJSONURL.path) else {
        return nil
      }
      
      let decoder = JSONDecoder()
      
      do {
        let data = try Data(contentsOf: zoneJSONURL)
        zoneData = try decoder.decode(ZoneData.self, from: data)
      } catch let error {
        print(error)
      }
        return zoneData
    }
    
    
    
    private func saveJSON(_ zoneData: ZoneData) {
      let encoder = JSONEncoder()
     
      do {
        let data = try! encoder.encode(zoneData)
        
        try data.write(to: zoneJSONURL, options: .atomicWrite)
      } catch let error {
        print(error)
      }
    }
    
}
