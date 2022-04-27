//
//  TableViewReusableProtocol.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 26/04/22.
//

import Foundation
import UIKit

public protocol TableViewReusableProtocol: AnyObject {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
}
extension TableViewReusableProtocol {
    static public var reuseIdentifier: String {return String(describing: self)}
    static public var nibName: String {return String(describing: self)}
}

internal extension UITableView {
    
    final func registerReusableCell<T: UITableViewCell>(_  cellType: T.Type) where T: TableViewReusableProtocol {
        let bundle = Bundle.main
        if let _ = bundle.path(forResource: String(cellType.nibName), ofType: "nib") {
            self.register(UINib(nibName:  String(cellType.nibName), bundle: bundle), forCellReuseIdentifier: cellType.reuseIdentifier)
        } else {
            self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    final func dequeueReusableCell<T:UITableViewCell>(indexPath: IndexPath, cellType: T.Type) -> T where T: TableViewReusableProtocol {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Fail to dequeue")
        }
        return cell
    }
}
