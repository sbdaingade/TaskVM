//
//  APICommunicator.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 14/04/22.
//

import Foundation

public struct APICommunicator {
    static func communicateWithAPI<T:Codable>(_ request: URLRequest, model: T.Type , complition:@escaping (Result<[T]?,Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
            }
            guard let data = data else {
                let error = NSError.init(domain: "No record found", code: 404, userInfo: ["Empty": "No record found"])
                return complition(.failure(error))
            }
            do {
                let responseModel = try JSONDecoder().decode([T].self, from: data)
                complition(.success(responseModel))
            } catch(let error) {
                complition(.failure(error))
            }
        }.resume()
    }
}
