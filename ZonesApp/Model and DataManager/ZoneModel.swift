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

public class NewZones: Codable {
    
    var zoneNumber: Int?
    var zoneName: String?
    var outletNumber: Int?
    
    init(zoneNumber: Int?, zoneName: String?, outletNumber: Int?){
        self.zoneNumber = zoneNumber
        self.zoneName = zoneName
        self.outletNumber = outletNumber
    }
    
}




