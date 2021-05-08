//
//  ContentView.swift
//  MyWeatherApp
//
//  Created by Sathriyan on 05/05/21.
//

import SwiftUI

struct FinalWeatherView: View {
    var body: some View {
        
        VStack{
            
            CityHeaderView(cityViewModel: CityViewModel())
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top , 45)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FinalWeatherView()
    }
}
