//
//  NeworkManager.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 14/04/22.
//

import Foundation

public final class NeworkManager {
    
    class func getAllPeoples(_ complition:@escaping (Result<[Person],AuthenticationError>) -> Void) {
        
        APICommunicator.communicateWithPeopleAPI(Router.people.asURLRequest()!) { result in
            switch result {
            case .failure(let error):
                //  print("\(error)")
                complition(.failure(error))
            case .success(let persons):
                // print("\(persons)")
                complition(.success(persons))
            }
        }
    }
    
     class func getAllRooms(_ complition:@escaping (Result<[Room],AuthenticationError>) -> Void) {
        APICommunicator.communicateWithRommsAPI(Router.rooms.asURLRequest()!) { result in
            switch result {
            case .failure(let error):
                complition(.failure(error))
            case .success(let rooms):
                complition(.success(rooms))
            }
        }
    }
}

