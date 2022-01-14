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
    let wind: Wind
    let clouds: Clouds
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Weather: Decodable {
    let description: String
    let id: Int
}

struct Wind: Decodable {
    let speed: Double
}

struct Clouds: Decodable {
    let all:  Int
}
