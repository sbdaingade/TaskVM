//
//  RoomsViewController.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 13/04/22.
//

import UIKit

class RoomsViewController: UIViewController {
    
    public struct Input {
        public enum InputAction {
            case getRooms
            case never
        }
        public var action =  Observer(value: InputAction.never)
    }
    
    public struct Output {
        public let arrayOfRooms = Observer(value: [Room]())
    }
    
    private let input = Input()
    public let output = Output()
    
    @IBOutlet weak var roomTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        input.action.value = .getRooms
    }
}

extension RoomsViewController: UITableViewDataSource, UITableViewDelegate {
    static func makeViewController(withRoomID roomID: String, roomViewModel: PeopleViewModel) -> RoomsViewController {
        guard let roomsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoomsViewController") as? RoomsViewController else {
            fatalError("can't initiate")
        }
        roomsViewController.title = "Room"
        
        roomsViewController.input.action.next {[unowned roomViewModel] action in
            switch action {
            case .getRooms:
                roomViewModel.input.action.value = .getRooms
            case .never,.none:
                break
            }
        }
        
        roomViewModel.output.arrayOfRooms.next { [unowned roomsViewController] rooms in
            roomsViewController.output.arrayOfRooms.value = rooms
            DispatchQueue.main.async {
                roomsViewController.roomTableView.reloadData()
            }
        }
        return roomsViewController
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.arrayOfRooms.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, cellType: RoomTableViewCell.self)
        if let room = output.arrayOfRooms.value?[indexPath.row] {
            cell.configureCell(withRoom: room)
        }
        return cell
    }
}
