//
//  SettingsViewController.swift
//  GoalApp
//
//  Created by Simon Alam on 26.04.21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UITableViewController {

    var rows = ["Log out", "Sorted By title"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static var firstOrder = true
    static var filteredByTitle = true
    let index1 = IndexPath(row: 1, section: 0)
     let index2 = IndexPath(row: 2, section: 0)
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = rows[indexPath.row]
        
        cell.textLabel?.font = UIFont(name: "Avenir", size: 17)
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            do {
               try Auth.auth().signOut()
                print("nice")
            } catch {
                print(error)
            }
           
      performSegue(withIdentifier: "backToBlack", sender: self)
            
        } else if indexPath.row == 1 {
            if  tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none {
               
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                SettingsViewController.filteredByTitle = true
                
            
                
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                SettingsViewController.filteredByTitle = false
            }
            
        }

    }
    
    

    

}
