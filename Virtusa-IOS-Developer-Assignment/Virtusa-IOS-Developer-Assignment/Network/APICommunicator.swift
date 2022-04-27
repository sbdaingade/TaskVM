//
//  APICommunicator.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 14/04/22.
//

import Foundation

public struct APICommunicator {
    
    static func communicateWithPeopleAPI(_ request: URLRequest, complition:@escaping (Result<[Person],AuthenticationError>) -> Void){
      
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                complition(.failure(AuthenticationError.customError("\(error.debugDescription)")))
            }
            
            guard let data = data else {
                return complition(.failure(AuthenticationError.customError("\(error.debugDescription)")))
            }
            do {
                let persons = try JSONDecoder().decode([Person].self, from: data)
                complition(.success(persons))
            } catch(let error) {
                complition(.failure(AuthenticationError.customError("\(error)")))
            }
        }.resume()
    }
    
    static func communicateWithRommsAPI(_ request: URLRequest, complition:@escaping (Result<[Room],AuthenticationError>) -> Void){
      
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                complition(.failure(AuthenticationError.customError("\(error.debugDescription)")))
            }
            
            guard let data = data else {
                return   complition(.failure(AuthenticationError.customError("\(error.debugDescription)")))
            }
            do {
                let rooms = try JSONDecoder().decode([Room].self, from: data)
                complition(.success(rooms))
            } catch(let error) {
                complition(.failure(AuthenticationError.customError("\(error)")))
            }
        }.resume()
    }

}
