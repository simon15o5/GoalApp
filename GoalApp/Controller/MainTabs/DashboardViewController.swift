//
//  DashboardViewController.swift
//  GoalApp
//
//  Created by Simon Alam on 25.04.21.
//
import FirebaseAuth
import RealmSwift
import UIKit

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    @IBOutlet var collectionView: UICollectionView!
    
  var inddexx = 0
   static var goals : Results<Goal>?
    let realm = try! Realm()
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("I appear")
        loadRealm()
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        
        
        
     
       // navigationItem.hidesBackButton = true
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let goals = DashboardViewController.goals else {
            return 0
        }
        return goals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SeconCollectionViewCell, let goal = DashboardViewController.goals?[indexPath.item] {
            cell.imageView.image = UIImage(named: goal.symbol)!
            cell.goalLabel.text = goal.title
            cell.layer.cornerRadius = 10
            return cell
        }
        
        return UICollectionViewCell()
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        inddexx = indexPath.item
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let dest = segue.destination as? DetailViewController {
                dest.goalNumber = inddexx
            }
        }
    }
    
      func loadRealm() {
        print("Called")
        DashboardViewController.goals = realm.objects(Goal.self)
        if SettingsViewController.filteredByTitle {
            DashboardViewController.goals = realm.objects(Goal.self).sorted(byKeyPath: "title", ascending: true)
        }
        collectionView.reloadData()
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        loadRealm()
        print("I got called")
    }
    
    
    
    @objc func settingsTapped() {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    @IBAction func settingsActed(_ sender: Any) {
        settingsTapped()
    }
    
}
