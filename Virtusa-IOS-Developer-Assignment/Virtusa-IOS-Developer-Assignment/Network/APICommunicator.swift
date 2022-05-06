//
//  APICommunicator.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 14/04/22.
//

import Foundation

public struct APICommunicator {
    
    static func communicateWithPeopleAPI(_ request: URLRequest, complition:@escaping (Result<[Person],Error>) -> Void){
      
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                complition(.failure(error!))
            }
            
            guard let data = data else {
                return complition(.failure(error!))
            }
            do {
                let persons = try JSONDecoder().decode([Person].self, from: data)
                complition(.success(persons))
            } catch(let error) {
                complition(.failure(error))
            }
        }.resume()
    }
    
    static func communicateWithRommsAPI(_ request: URLRequest, complition:@escaping (Result<[Room],Error>) -> Void){
      
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                complition(.failure(error!))
            }
            
            guard let data = data else {
                return   complition(.failure(error!))
            }
            do {
                let rooms = try JSONDecoder().decode([Room].self, from: data)
                complition(.success(rooms))
            } catch(let error) {
                complition(.failure(error))
            }
        }.resume()
    }

}
