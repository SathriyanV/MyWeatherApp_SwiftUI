//
//  DailyWeather.swift
//  MyWeatherApp
//
//  Created by Sathriyan on 06/05/21.
//

import Foundation

struct DailyWeather : Codable, Identifiable {
    
    var dt : Int
    var temp : Temperature
    var weather : [WeatherDetail]
    
    enum CodingKey {
        
        case dt
        case temp
        case weather
        
    }
    
    init() {
        
        dt = 0
        temp = Temperature(max: 0.0, min: 0.0)
        weather = [WeatherDetail(main: "", description: "", icon: "")]
    }
    
}

extension DailyWeather{
    
    var id : UUID {
        return UUID()
    }
}
