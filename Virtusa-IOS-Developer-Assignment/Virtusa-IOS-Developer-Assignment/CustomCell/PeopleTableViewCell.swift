//
//  PeopleTableViewCell.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 26/04/22.
//

import UIKit

class PeopleTableViewCell: UITableViewCell ,TableViewReusableProtocol {
    
    @IBOutlet weak var peopleImageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        peopleImageView.layer.masksToBounds = true
        peopleImageView.layer.cornerRadius = peopleImageView.bounds.width / 2
        peopleImageView.layer.borderWidth = 1.0
        peopleImageView.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - configure Cell
    public func configureCell(withPerson person: Person) {
        self.mainTitle.text = "\(person.id + " " + person.firstName + " " + person.lastName)"
        self.subTitle.text = person.email
    }
}
