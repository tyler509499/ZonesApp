//
//  DataLoader.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 29.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import Foundation


public class DataLoader {
    
    
     
    @Published var zoneData = [NewZones]()
    
    init() {
    
        load()
         
    }
      
    
    
    //get document Directory
        func getDocumentDirectory() -> URL {
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                return url
            } else {
                fatalError("Unable to access document directory")
            }
        }
    
    
    
    
    
        func load() {
            
        let url = getDocumentDirectory().appendingPathComponent("ZoneData.json", isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([NewZones].self, from: data)
                self.zoneData = dataFromJson
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Data unavalible at path \(url.path)")
        }
    }

}










//    func load() {
//
//        if let fileLocation = Bundle.main.url(forResource: "ZoneData", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: fileLocation)
//                let jsonDecoder = JSONDecoder()
//                let dataFromJson = try jsonDecoder.decode([NewZones].self, from: data)
//                self.zoneData = dataFromJson
//            } catch {
//                print(error.localizedDescription)
//            }
//            }
//    }
//
//
//}
