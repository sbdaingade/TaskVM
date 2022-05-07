//
//  PeopleViewModel.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 13/04/22.
//

import Foundation

class PeopleViewModel {
    
    public struct Input {
        public enum InputAction {
            case getPeoples
            case getRooms
            case never
        }
        public var action =  Observer(value: InputAction.never)
    }
    
    public struct Output {
        public let arrayOfPeople = Observer(value: [Person]())
        public let arrayOfRooms = Observer(value: [Room]())
        public let requestState  = Observer(value: APIState.idle)
    }
    
    public let input = Input()
    public let output = Output()
    
    public init() {
        input.action.next { [unowned self] action in
            switch action {
            case .getPeoples:
                self.getAllPeoples()
            case .getRooms:
                self.getAllRooms()
            case .never,.none:
                break
            }
        }
    }
    
    private func getAllPeoples()  {
        output.requestState.value = .progress
        NeworkManager.getAllPeoples {[unowned self] result in
            switch result {
            case .failure(let error):
                output.requestState.value = .failWithError(error)
            case .success(let persons):
                output.arrayOfPeople.value = persons
            }
            output.requestState.value = .finished
        }
    }
    
    private func getAllRooms()  {
        output.requestState.value = .progress
        NeworkManager.getAllRooms {[unowned self] result in
            switch result {
            case .failure(let error):
                output.requestState.value = .failWithError(error)
            case .success(let rooms):
                output.arrayOfRooms.value = rooms
            }
            output.requestState.value = .finished
        }
    }
}
