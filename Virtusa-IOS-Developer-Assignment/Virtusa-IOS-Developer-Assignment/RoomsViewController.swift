//
//  RoomsViewController.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 13/04/22.
//

import UIKit

class RoomsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}
extension RoomsViewController {
    static func makeViewController(_ room: PeopleViewModel) -> RoomsViewController {
        guard let roomsViewController = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "RoomsViewController") as? RoomsViewController else {
            fatalError("can't initiate")
        }
        return roomsViewController
    }
}
