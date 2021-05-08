//
//  NetworkManager.swift
//  MyWeatherApp
//
//  Created by Sathriyan on 06/05/21.
//

import Foundation

final class NetworkManager<T : Codable> {
    
    // function for passing actual url
    
    static func fetch(for url : URL, completion : @escaping (Result<T, NetworkError>) -> Void) {
        
        // starting url sesion to reciver data from api
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // to check for error statement in url session
            
            guard error == nil else {
                
                print(error!)
                completion(.failure(.error(err: error!.localizedDescription)))
                return
                
            }
            
            // to check for http response for url load request
            
            guard let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode == 200 else {
                
                completion(.failure(.invalidResponse))
                return
                
            }
            
            // to check for any data from url response
            
            guard let data = data else {
                
                completion(.failure(.invalidData))
                return
                
            }
            
            // Decoding json data into localised value for usage
            
            do {
                
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            }
            
            // to check for decoded error
            
            catch let err {
                print(err)
                completion(.failure(.decodedError(err: err.localizedDescription)))
            }
            
            // dont forget to resume the session
            
        }.resume()
        
    }
    
    enum NetworkError : Error {
        
        case invalidResponse
        case invalidData
        case error(err : String)
        case decodedError(err : String)
    }
    
}
