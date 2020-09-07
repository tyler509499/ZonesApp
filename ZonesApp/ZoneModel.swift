//
//  ZonesData.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 27.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.


import Foundation

public struct ZoneData: Codable {

    var newZones: [NewZones] = []
    var reuseZones: Int = 0
    
    init() {
        
    }
    
  
}

struct NewZones: Codable {
    
    var zoneNumber: Int
    var zoneName: String
    var outletNumber: Int
    
    
}

    
    
    
