//
//  Reservation.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 08.09.2023.
//

import Foundation

struct Reservation: Decodable {
    let id: Int
    let hotel_name: String
    let hotel_adress: String
    let horating: Int
    let rating_name: String
    let departure: String
    let arrival_country: String
    let tour_date_start: String
    let tour_date_stop: String
    let number_of_nights: Int
    let room: String
    let nutrition: String
    let tour_price: Int
    let fuel_charge: Int
    let service_charge: Int
}
