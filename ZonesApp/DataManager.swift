//
//  DataLoader.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 29.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import Foundation


public class DataManager: ObservableObject {

    static var `default` = DataManager()
    var zoneData: [ZoneData]{
        get{
            loadJSON()
        }
        set {
            saveJSON()
        }
    }
    
    let zoneJSONURL = URL(fileURLWithPath: "ZoneData",
                           relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    
    public init() {
       
    }
   
    private func loadJSON() {
      guard FileManager.default.fileExists(atPath: zoneJSONURL.path) else {
        return
      }
      
      let decoder = JSONDecoder()
      
      do {
        let data = try Data(contentsOf: zoneJSONURL)
        zoneData = try decoder.decode([ZoneData].self, from: data)
      } catch let error {
        print(error)
      }
    }
    
    
    
    private func saveJSON() {
      let encoder = JSONEncoder()
     
      do {
        let data = try! encoder.encode(zoneData)
        
        try data.write(to: zoneJSONURL, options: .atomicWrite)
      } catch let error {
        print(error)
      }
    }
    
}
