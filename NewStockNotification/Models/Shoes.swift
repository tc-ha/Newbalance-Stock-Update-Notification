//
//  Shoes.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/02.
//

import Foundation

struct Products: Codable, Hashable {
    let products: [Shoes]
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }
    
    static func == (lhs: Products, rhs: Products) -> Bool {
      return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}

struct Shoes: Codable, Hashable {
    let color: String
    let name: String
    let image: String
    let width: Width
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }
    
    static func == (lhs: Shoes, rhs: Shoes) -> Bool {
      return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}

struct Width: Codable {
    let Narrow: Size?
    let Standard: Size?
    let XNarrow: Size?
    let Wide: Size?
    let XWide: Size?
}

struct Size: Codable {
    let size: [String:Bool]
    
}
