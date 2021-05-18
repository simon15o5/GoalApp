//
//  ChooseSymbolViewController.swift
//  GoalApp
//
//  Created by Simon Alam on 25.04.21.
//
import RealmSwift
import UIKit
import UserNotifications

class ChooseSymbolViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var buttonOutlet: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    let realm = try! Realm()
    var images = [UIImage]()
    var selectedImage: String?
    var imageNames = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlet.layer.cornerRadius = 15
        
        images.append(UIImage(named: "sport")!)
        images.append(UIImage(named: "book")!)
        images.append(UIImage(named: "brain")!)
        images.append(UIImage(named: "healthy")!)
        images.append(UIImage(named: "job")!)
        images.append(UIImage(named: "money")!)
        images.append(UIImage(named: "work")!)
        
        
        imageNames.append("sport")
        imageNames.append("book")
        imageNames.append("brain")
        imageNames.append("healthy")
        imageNames.append("job")
        imageNames.append("money")
        imageNames.append("work")
        


        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
    }

    @IBAction func finishPressed(_ sender: Any) {
        guard  let image = selectedImage  else {
            let ac = UIAlertController(title: "Please select a symbol", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(ac, animated: true, completion: nil)
            return
        }
        Goal.tempGoal.symbol = image
        save(goal: Goal.tempGoal)
        
        if Goal.tempGoal.deadline != nil {
            print("now")
           
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted {
                    print("YAYY")
                } else {
                    print("F*ck")
                }
            }
        } else if Goal.tempGoal.deadline != nil {
            scheduleNotefication(date: Goal.tempGoal.deadline!, title: Goal.tempGoal.title, id: Goal.tempGoal.symbol)
        }
        
        if selectedImage == "sport" {
            performSegue(withIdentifier: "didPickSport", sender: self)
            return
        }
        
        Goal.tempGoal = Goal()
        
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CellCollectionViewCell {
            cell.imageView.image = images[indexPath.item]
            cell.layer.cornerRadius = 10
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            collectionView.cellForItem(at: indexPath)?.layer.borderWidth = 3
            collectionView.cellForItem(at: indexPath)?.layer.borderColor = UIColor.blue.cgColor
        
     
        selectedImage = imageNames[indexPath.item]
       
        
    }
    
    func save(goal: Goal) {
        do {
            try realm.write {
                realm.add(goal)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    
    func scheduleNotefication(date: Date, title: String, id: String) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Did you reached your goal?"
        content.body = "You have set the goal: \(title)"
        content.categoryIdentifier = "\(id)"
        content.userInfo = ["iComeBack": "goal"]
        content.sound = .default
        
       
        
        let components = Calendar.current.dateComponents([.day, .month, .hour, .minute], from: date)
      
      
        
        print(components)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        
     
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }
    
}
