//
//  DataLoader.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 29.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import Foundation

public class DataLoader {
     
    @Published var zoneData = [newZones]()
    
    init() {
        load()
//        sort()
    }
    
    func load() {
        
        if let fileLocation = Bundle.main.url(forResource: "ZoneData", withExtension: "json") {
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let jsonDecoder = JSONDecoder()
            let dataFromJson = try jsonDecoder.decode([newZones].self, from: data)
            
            self.zoneData = dataFromJson
            
            
        } catch {
            print(error)
        }
    }
}
    
}
