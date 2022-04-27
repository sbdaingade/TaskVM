//
//  Observer.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 13/04/22.
//

import Foundation

public class Observer<T> {
    
    var value:T? {
        didSet {
            observerBlock?(value)
        }
    }
    private var observerBlock: ((T?) -> Void)?
    
    init(value: T?) {
        self.value = value
    }
    
    public func next(_ observer:@escaping(T?) -> Void) {
        self.observerBlock = observer
    }
    
    deinit {
    }
}
