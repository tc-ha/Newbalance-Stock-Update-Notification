//
//  Shoes.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/02.
//

import Foundation

struct Products: Codable {
    let products: [Shoes]
}

struct Shoes: Codable {
    let color: String
    let name: String
    let image: String?
    let width: Width
}

struct Width: Codable {
    let Narrow: Size?
    let Standard: Size?
    let XNarrow: Size?
    let Wide: Size?
    let XWide: Size?
}

struct Size: Codable {
    let size: [Int:Bool]
    
}
