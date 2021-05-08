//
//  ApiExtensions.swift
//  MyWeatherApp
//
//  Created by Sathriyan on 06/05/21.
//

import Foundation

extension API {
    
    static let baseUrlString = "https://api.openweathermap.org/data/2.5/"
    
    static func getUrl(lat : Double, lon : Double) -> String {
        
        return "\(baseUrlString)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(apiKey)&units=metric"
    }
    
}
