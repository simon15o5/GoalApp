//
//  WelcomeViewController.swift
//  GoalApp
//
//  Created by Simon Alam on 26.04.21.
//
import FirebaseAuth
import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser == nil {
            print("Nobody logged in")
        } else {
            print("somebody logged in")
           performSegue(withIdentifier: "directWay", sender: self)
        }
        // Do any additional setup after loading the view.
     
    }
    
    @IBAction func unwindeee( _ seg: UIStoryboardSegue) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
