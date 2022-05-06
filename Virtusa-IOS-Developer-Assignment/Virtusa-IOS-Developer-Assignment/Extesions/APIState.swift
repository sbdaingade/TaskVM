//
//  APIState.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 29/04/22.
//

import Foundation
public enum APIState {
    case progress
    case finished
    case failWithError(Error)
    case idle
}
