//
//  AppDelegate.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 13/04/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let peopleViewModel = PeopleViewModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let peopleViewController = PeopleViewController.makeViewController(withPeopleViewModel: peopleViewModel)
        navigationController.viewControllers = [peopleViewController]
        self.window?.rootViewController = navigationController
        
        self.window?.makeKeyAndVisible()
        
        peopleViewModel.output.requestState.next {[unowned self]  state in
            switch state {
            case .idle,.none:
                break
            case .progress:
                DispatchQueue.main.async {
                    MRActivityIndicator.shared.show()
                }
            case .finished:
                DispatchQueue.main.async {
                    MRActivityIndicator.shared.hide()
                }
            case .failWithError(let error):
                DispatchQueue.main.async {
                    self.commonAlerView("Error", newMessage: error.localizedDescription)
                }
            }
        }
        return true
    }
    
    private func commonAlerView(_ title: String ,newMessage: String) {
        let alert = UIAlertController(title: title, message: newMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        window?.rootViewController?.navigationController?.present(alert, animated: true, completion: nil)
    }
}
