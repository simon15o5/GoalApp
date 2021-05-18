//
//  DetailViewController.swift
//  GoalApp
//
//  Created by Simon Alam on 25.04.21.
//
import UserNotifications
import RealmSwift
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var symbolView: UIImageView!
    @IBOutlet var goalLabel: UILabel!
    @IBOutlet var pickedImage: UIImageView!
    
    var goalNumber = 0
    let realm = try! Realm()
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
       

        pickedImage.isHidden = true
        backButton.layer.cornerRadius = 15
        deleteButton.layer.cornerRadius = 15
        symbolView.layer.cornerRadius = 15
        
        navigationController?.navigationBar.isHidden = true

        goalLabel.text = DashboardViewController.goals![goalNumber].title
        if let image = DashboardViewController.goals![goalNumber].pic {
            // Place the photo in the imageView
            pickedImage.isHidden = false
            let path = getDocumentDirectory().appendingPathComponent(image)
            pickedImage.image = UIImage(contentsOfFile: path.path)
            pickedImage.layer.cornerRadius = 15
        }
        symbolView.image = UIImage(named: DashboardViewController.goals![goalNumber].symbol)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    @IBAction func deletePressed(_ sender: UIButton) {
        if let removingGoal = DashboardViewController.goals?[goalNumber] {
                      do {
                          try self.realm.write  {
                            
                            let center = UNUserNotificationCenter.current()
                            center.removePendingNotificationRequests(withIdentifiers: ["\(removingGoal.symbol)"])
                            self.realm.delete(removingGoal)
                            print("removed")
                          }
                      } catch {
                          print(error.localizedDescription)
                      }
                  }
        performSegue(withIdentifier: "goBack", sender: self)
      
        
    }
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
}
