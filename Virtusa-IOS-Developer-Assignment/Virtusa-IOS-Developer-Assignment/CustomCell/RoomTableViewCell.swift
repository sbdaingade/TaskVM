//
//  RoomTableViewCell.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 28/04/22.
//

import UIKit

class RoomTableViewCell: UITableViewCell,TableViewReusableProtocol {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clipsToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
    }

    @IBOutlet weak var roomID: UILabel!
    @IBOutlet weak var roomStatus: UILabel!
    @IBOutlet weak var maxCapacity: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(withRoom room: Room) {
        roomID.text = "Room ID : \(room.id)"
        maxCapacity.text = "Max Capacity :  \(room.maxOccupancy)"

        if room.isOccupied {
            roomStatus.text = "Room is not available"
            roomStatus.textColor = .red
        } else {
            roomStatus.text = "Room is available"
            roomStatus.textColor = .blue
        }
    }
}
