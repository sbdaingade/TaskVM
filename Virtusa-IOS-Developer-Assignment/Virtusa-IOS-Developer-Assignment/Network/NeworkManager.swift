//
//  NeworkManager.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 14/04/22.
//

import Foundation

public final class NeworkManager {
    
    class func getAllPeoples(_ complition:@escaping (Result<[Person],Error>) -> Void) {
        APICommunicator.communicateWithAPI(Router.people.asURLRequest()!, model: Person.self) { result in
            switch result {
            case .failure(let error):
                //  print("\(error)")
                complition(.failure(error))
            case .success(let persons):
                // print("\(persons)")
                complition(.success(persons ?? []))
            }
        }
    }
    
    class func getAllRooms(_ complition:@escaping (Result<[Room],Error>) -> Void) {
        APICommunicator.communicateWithAPI(Router.rooms.asURLRequest()!, model: Room.self) { result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let rooms):
                complition(.success(rooms ?? []))
            }
        }
    }
}
