//
//  WeatherData.swift
//  Clima
//
//  Created by Immanuel Yohansen on 21/11/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
}

struct Weather : Decodable {
    let description: String
    let id: Int
}
