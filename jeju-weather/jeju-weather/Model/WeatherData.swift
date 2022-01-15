//
//  File.swift
//  jeju-weather
//
//  Created by Young Soo Hwang on 2022/01/13.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let clouds: Clouds
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Wind: Codable {
    let speed: Double
}

struct Clouds: Codable {
    let all:  Int
}
