//
//  Restaurant.swift
//  Restaurant App
//
//  Created by Iman Faizal on 29/05/21.
//

import Foundation

struct Restaurant: Decodable {
    let id : String
    let name : String
    let description : String
    let pictureId : String
    let city : String
    let rating : Double
}

struct Restaurants: Decodable {
    let error: Bool
    let message: String
    let count: Int
    let restaurants: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case message = "message"
        case count = "count"
        case restaurants
    }
    
}

struct Categories : Decodable {
    let name : String
}

struct Foods : Decodable {
    let name : String
}

struct Drinks : Decodable {
    let name : String
}

struct Menus : Decodable {
    let foods : [Foods]
    let drinks : [Drinks]
}

struct Reviews : Decodable {
    let name : String
    let review : String
    let date : String
}

struct DetailRestaurant: Decodable {
    let id : String
    let name : String
    let description : String
    let city : String
    let address : String
    let pictureId : String
    let categories : [Categories]
    let menus : Menus
    let rating : Double
    let customerReviews : [Reviews]
}

struct DetailRestaurants: Decodable {
    let error: Bool
    let message: String
    let restaurant: DetailRestaurant
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case message = "message"
        case restaurant
    }
}
