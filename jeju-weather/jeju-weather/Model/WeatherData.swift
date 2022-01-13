//
//  File.swift
//  jeju-weather
//
//  Created by Young Soo Hwang on 2022/01/13.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
