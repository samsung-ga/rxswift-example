//
//  WeatherResult.swift
//  GoodWeather
//
//  Created by Wody on 2022/01/31.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

extension WeatherResult {
    static var empty: WeatherResult {
        WeatherResult(main: Weather(temp: 0, humidity: 0))
    }
}
struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
