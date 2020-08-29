//
//  DataManager.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 27.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

//import Foundation
//
//public class DataManager {
//    
//    
//    
//    //get document Directory
//    static fileprivate func getDocumentDirectory() -> URL {
//        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            return url
//        } else {
//            fatalError("Unable to access document directory")
//        }
//    }
//    
//    //Save any kind ofcodable objects
//    static func save <T: Encodable> (_ object: T, with fileName: String) {
//        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
//        
//        let encoder = JSONEncoder()
//        
//        do {
//            let data = try encoder.encode(object)
//            if FileManager.default.fileExists(atPath: url.path) {
//                try FileManager.default.removeItem(at: url)
//            }
//            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
//        } catch {
//            fatalError(error.localizedDescription)
//        }
//    }
//    //Load any kind of codable objects
//    static func load <T: Decodable> (_ fileName: String, with type: T.Type) -> T {
//        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
//        if !FileManager.default.fileExists(atPath: url.path) {
//            fatalError("File not found at path \(url.path)")
//        }
//        if let data = FileManager.default.contents(atPath: url.path) {
//            do {
//                let model = try JSONDecoder().decode(type, from: data)
//                return model
//            } catch {
//                fatalError(error.localizedDescription)
//            }
//        } else {
//            fatalError("Data unavalible at path \(url.path)")
//        }
//    }
//    
//    //Load data from a file
//    static func loadData (_ fileName: String) -> Data? {
//        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
//        if !FileManager.default.fileExists(atPath: url.path) {
//            fatalError("File not found at path \(url.path)")
//        }
//        if let data = FileManager.default.contents(atPath: url.path) {
//            return data
//        } else {
//            fatalError("Data unavalible at path \(url.path)")
//        }
//    }
//}
