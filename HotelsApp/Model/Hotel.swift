//
//  Hotel.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 06.09.2023.
//

import Foundation

struct Hotel {
    let name: String
    let adress: String
    let minimalPrice: String
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let image: URL
    let aboutTheHotel: Description
}

struct Description {
    let description: String
    let peculiarities: [String]
}
