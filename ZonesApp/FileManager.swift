//
//  FileManager.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 01.09.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import Foundation

public extension FileManager {
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
