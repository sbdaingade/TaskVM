//
//  ViewController.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 13/04/22.
//

import UIKit

class PeopleViewController: UIViewController {
    let peopleViewModel = PeopleViewModel()
    private let cache = NSCache<AnyObject, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    

    @IBOutlet weak var peopleTableView: UITableView!
    private var arrayOfPeople = [Person?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        peopleViewModel.input.action.value = .getPeoples
        peopleViewModel.output.arrayOfPeople.next {[unowned self] persons in
            arrayOfPeople = persons ?? []
            DispatchQueue.main.async {
                self.peopleTableView.reloadData()
            }
        }
      
    }
}
extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, cellType: PeopleTableViewCell.self)
        if let person = arrayOfPeople[indexPath.row] {
            cell.configureCell(withPerson: person)
            
            if let cachedImage = cache.object(forKey: person.id as AnyObject){
                cell.peopleImageView.image = cachedImage
            } else {
                self.loadImage(person.avatar){ [weak self] image in
                    guard let self = self, let image = image else { return }
                    self.cache.setObject(image, forKey: person.id as AnyObject)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    // MARK: - Image Loading
    private func loadImage(_ strUrl: String, completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            let url = URL(string: strUrl)!
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}


