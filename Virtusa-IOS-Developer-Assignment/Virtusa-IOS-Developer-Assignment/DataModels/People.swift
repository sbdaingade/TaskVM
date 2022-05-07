//
//  People.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 13/04/22.
//

import Foundation
// sepearate
// MARK: - Person
struct Person: Codable {
    let createdAt: String
    let firstName: String
    let avatar: String
    let lastName: String
    let email: String
    let jobtitle: String
    let favouriteColor: String
    let id: String
    let data: AdditionalData?
    let to: String?
    let fromName: String?
}

// MARK: - DataClass
struct AdditionalData: Codable {
    let title: String
    let body: String
    let id: String
    let toID: String
    let fromID: String
    let meetingid: String
    
    enum CodingKeys: String, CodingKey {
        case title, body, id
        case toID = "toId"
        case fromID = "fromId"
        case meetingid
    }
}
