//
//  Hotel.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 06.09.2023.
//

import Foundation

struct Hotel: Codable {
    let id: Int
    let name: String
    let adress: String
    let minimal_price: Int
    let price_for_it: String
    let rating: Int
    let rating_name: String
    let image_urls: [String]
    let about_the_hotel: Description

}

struct Description: Codable {
    let description: String
    let peculiarities: [String]
}
