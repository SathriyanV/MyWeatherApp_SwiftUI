//
//  CityHeaderView.swift
//  MyWeatherApp
//
//  Created by Sathriyan on 07/05/21.
//

import SwiftUI

struct CityHeaderView: View {
    
    @ObservedObject var cityViewModel : CityViewModel
    
    @State var searchTerm = "City Name"
    
    var body: some View {
        
        ZStack {
            
            Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack{
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .padding(.leading, 20)
                        
                    
                    TextField("", text : $searchTerm)
                        .font(.body)
                        .padding(.leading, 20)
                        .offset(x: -10.0, y: 0)
                    
                    Button {
                        
                        cityViewModel.city = searchTerm} label : {
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(red: 0.22, green: 0.747, blue: 0.97))
                                
                                Image(systemName: "location.fill")
                                    .foregroundColor(.white)
                                
                            }
                            
                        }.frame(width: 50, height: 50)
                        .padding(.all, 10)
                    Spacer()
                    
                }
                .background(Color(red: 0.937, green: 0.937, blue: 0.959))
                .cornerRadius(10)
                .padding()
                .shadow(radius: 10)
                
                ScrollView(.vertical, showsIndicators : false) {
                    
                    VStack{
                        
                        Text(cityViewModel.city)
                            .font(Font.system(size: 40))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        
                        Text(cityViewModel.date)
                            .font(Font.system(size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .padding(.vertical, 2)
                        
                        cityViewModel.getWeatherIcon(icon: cityViewModel.weatherIcon)
                            .resizable()
                            .offset(x: 0, y: 12)
                            
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 125, height: 125, alignment: .center)
                        
                        Text(cityViewModel.condition)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .offset(x: 0, y: 12)
                        
                        
                        Text("\(cityViewModel.temperature)°")
                            .font(Font.system(size: 60))
                            .fontWeight(.bold)
                            .padding()
                        
                        HStack{
                            Spacer()
                            Spacer()
                            HStack{
                                Image(systemName: "wind")
                                Text("\(cityViewModel.windSpeed) km/h")
                            }
                            
                            Spacer()
                            HStack{
                                
                                Image(systemName: "drop")
                                Text(cityViewModel.humidity)
                            }
                            Spacer()
                            Spacer()
                        }
                        
                    }
                    
                    Text("Today")
                        .fontWeight(.semibold)
                        .frame(maxWidth : .infinity, alignment: .leading)
                        .padding(.horizontal,17)
                        .padding(.top, 20)
                        .padding(.bottom, -15)
                    
                    ScrollView(.horizontal, showsIndicators : false) {
                        
                        HStack(spacing : 12){
                            
                            ForEach(cityViewModel.weather.hourly) { weather in
                                
                                VStack{
                                    
                                    Text("\(cityViewModel.getTempFor(temp: weather.temp))°")
                                    
                                    Spacer()
                                    
                                    cityViewModel.getWeatherIcon(icon: cityViewModel.weatherIcon)
                                    
                                    Spacer()
                                    
                                    Text(cityViewModel.getTimeFor(timeStamp: weather.dt))
                                    
                                    
                                }
                                .frame(height : 100)
                                .padding(.all, 25)
                                .background(Color(hue: 0.552, saturation: 0.864, brightness: 0.96, opacity: 0.68))
                                .cornerRadius(15)
                            }
                            
                        }
                    }
                    .padding()
                    .padding(.top, 10)
                    
                    
                    GroupBox(){
                        DisclosureGroup("Next 7 Days") {
                            ForEach(cityViewModel.weather.daily) { weather in
                                
                                Divider()
                                    .padding(.vertical, 10)
                                
                                VStack{
                                    HStack {
                                        Text(cityViewModel.getDayFor(dayStamp: weather.dt))
                                        
                                        Spacer()
                                        
                                        Text("H: \(cityViewModel.getTempFor(temp: weather.temp.max))° /  L: \(cityViewModel.getTempFor(temp: weather.temp.min))°")
                                        
                                        Spacer()
                                        
                                        cityViewModel.getWeatherIcon(icon: cityViewModel.weatherIcon)
                                        
                                    }
                                    
                                }
                            }
                        }
                    }.padding(.horizontal)
                }
                
                
                
            }
            .frame(maxHeight: .infinity , alignment: .top)
        }
        
                .onAppear(perform: {
                    
                    cityViewModel.city = "Salem"
                    let urlString = API.getUrl(lat: 11.6643, lon: 78.1460)
                    cityViewModel.getWeatherInternal(city: "City Name", for: urlString)
                })
        
    }
}

struct CityHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CityHeaderView(cityViewModel: CityViewModel())
    }
}
