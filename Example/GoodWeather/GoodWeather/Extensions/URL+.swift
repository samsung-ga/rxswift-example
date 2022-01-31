//
//  URL+.swift
//  GoodWeather
//
//  Created by Wody on 2022/01/31.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=72328c427cab7f418866d0f28f787124")
    }
}
