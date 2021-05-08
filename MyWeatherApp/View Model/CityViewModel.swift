//
//  CityViewModel.swift
//  MyWeatherApp
//
//  Created by Sathriyan on 06/05/21.
//

import SwiftUI
import CoreLocation

final class CityViewModel : ObservableObject {
    
    @Published var weather = WeatherResponse.empty()
    
    @Published var city = "City Name" {
        
        didSet {
            
            getLocation()
        }
    }
    
    private lazy var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .full
        
        return formatter
    }()
    
    
    private lazy var dayFormatter : DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEE"
        
        return formatter
    }()
    
    
    private lazy var timeFormatter : DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "hh a"
        
        return formatter
    }()
    
    
    init() {
        
        getLocation()
    }
    
    var date : String{
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
        
    }
    
    var weatherIcon : String {
        
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "sun.max.fill"
    }
    
    var temperature : String {
    
        return getTempFor(temp: weather.current.temp)
        
    }
    
    var condition : String {
        
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return "Rain"
    }
    
    var windSpeed : String {
        
        return String(format: "%0.0f", weather.current.wind_speed)
    }
    
    var humidity : String {
        
        return String(format: "%d%%", weather.current.humidity)
    }
    
    
    var rainChances : String {
        
        return String(format: "%0.0f", weather.current.dew_point)
    }
    
    func getTempFor (temp : Double) -> String{
        
//        let convertedTemp = (temp - 30) * 1.8
        return String(format: "%0.0f", temp)
        
        
    }
    
    func getDateFor (timeStamp : Int) -> String{
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }

    func getTimeFor(timeStamp : Int) -> String {
        
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
    
    func getDayFor(dayStamp : Int) -> String {
        
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(dayStamp)))
    }
    
    
    // to convert the City or country name into proper lat and lon coordinates
    
    private func getLocation() {
        
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            if let places = placemark , let place = places.first{
                self.getWeather(coord: place.location?.coordinate)
            }
        }
        
    }
    
    
    // passing the coordinates value complete the url
    
    private func getWeather(coord : CLLocationCoordinate2D?) {
        
        if let coord = coord {
            let urlString = API.getUrl(lat: coord.latitude, lon: coord.longitude)
         getWeatherInternal(city: city, for: urlString)
        } else {
            
            let urlString = API.getUrl(lat: 37.548, lon: -121.9886)
            getWeatherInternal(city: city, for: urlString)
        }
        
    }
    
    
    // with completed url fetch data from API through Network manager class and return the response
    
     func getWeatherInternal(city : String, for url : String) {
        NetworkManager<WeatherResponse>.fetch(for: URL(string: url)!) { (result) in
            switch result {
            case.success(let response) :
                
                DispatchQueue.main.async{
                    self.weather = response
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }

    func getWeatherIcon(icon : String) -> Image {

        switch icon {

        case "01d" :
            return Image(systemName: "sun.max.fill")
        case "01n" :
            return Image(systemName: "moon.fill")
        case "02d" :
            return Image(systemName: "cloud.sun.fill")
        case "02n" :
            return Image(systemName: "cloud.moon.fill")
        case "03d" :
            return Image(systemName: "cloud.fill")
        case "03n" :
            return Image(systemName: "cloud.fill")
        case "04d" :
            return Image(systemName: "cloud.fill")
        case "04n" :
            return Image(systemName: "cloud.fill")
        case "09d" :
            return Image(systemName: "cloud.drizzle.fill")
        case "09n" :
            return Image(systemName: "cloud.drizzle.fill")
        case "10d" :
            return Image(systemName: "cloud.heavyrain.fill")
        case "10n" :
            return Image(systemName: "cloud.heavyrain.fill")
        case "11d" :
            return Image(systemName: "cloud.bolt.fill")
        case "11n" :
            return Image(systemName: "cloud.bolt.fill")
        case "13d" :
            return Image(systemName: "cloud.snow.fill")
        case "13n" :
            return Image(systemName: "cloud.snow.fill")
        case "50d" :
            return Image(systemName: "cloud.fog.fill")
        case "50n" :
            return Image(systemName: "cloud.fog.fill")
        default :
            return Image(systemName: "sun.max.fill")
        }
    }
    
}
    
