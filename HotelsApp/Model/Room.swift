//
//  Room.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import Foundation

struct Room: Decodable {
    let id: Int
    let name: String
    let price: String
    let price_per: Int
    let peculiarities: [String]
    let image_urls: [String]
}

struct Rooms: Decodable {
    let rooms: [Room]
}


