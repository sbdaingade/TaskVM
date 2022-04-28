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
            case .never:
                print("Initialized called")
            case .none:
                break
            }
        }
    }
    
    private func getAllPeoples()  {
        NeworkManager.getAllPeoples {[unowned self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let persons):
                output.arrayOfPeople.value = persons
            }
        }
    }
    
    private func getAllRooms()  {
        NeworkManager.getAllRooms {[unowned self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let rooms):
                output.arrayOfRooms.value = rooms
            }
        }
    }
}
