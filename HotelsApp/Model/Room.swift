//
//  Room.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import Foundation

struct Rooms: Codable {
    let rooms: [Room]
}

struct Room: Codable {
    let id: Int
    let name: String
    let price: Int
    let price_per: String
    let peculiarities: [String]
    let image_urls: [String]
}



