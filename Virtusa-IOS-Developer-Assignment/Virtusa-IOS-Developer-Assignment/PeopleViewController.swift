//
//  ViewController.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 13/04/22.
//

import UIKit

class PeopleViewController: UIViewController {
    private let cache = NSCache<AnyObject, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    private weak var vm: PeopleViewModel?
    
    @IBOutlet weak var peopleTableView: UITableView!
    //  private var arrayOfPeople = [Person?]()
    
    public struct Input {
        public enum InputAction {
            case getPeople
            case never
        }
        public var action =  Observer(value: InputAction.never)
    }
    
    public struct Output {
        public let arrayOfPeople = Observer(value: [Person]())
    }
    
    private let input = Input()
    public let output = Output()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        input.action.value =  .getPeople
    }
}
extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {
    static func makeViewController(withPeopleViewModel peopleViewModel: PeopleViewModel) -> PeopleViewController {
        guard let peopleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PeopleViewController") as? PeopleViewController else {
            fatalError("can't initiate")
        }
        peopleViewController.title = "People"
        peopleViewController.vm = peopleViewModel
        
        peopleViewController.input.action.next {[unowned peopleViewModel] action in
            switch action {
            case .getPeople:
                peopleViewModel.input.action.value = .getPeoples
            case .never,.none:
                break
            }
        }
        
        peopleViewModel.output.arrayOfPeople.next {[unowned peopleViewController] persons in
            peopleViewController.output.arrayOfPeople.value = persons
            DispatchQueue.main.async {
                peopleViewController.peopleTableView.reloadData()
            }
        }
        return peopleViewController
    }
    // MARK: - TableView

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.arrayOfPeople.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, cellType: PeopleTableViewCell.self)
        if let person = output.arrayOfPeople.value?[indexPath.row] {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let person = output.arrayOfPeople.value?[indexPath.row] {
            let roomViewController = RoomsViewController.makeViewController(withRoomID: person.id, roomViewModel: vm! )
            self.navigationController?.pushViewController(roomViewController, animated: true)
        }
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
