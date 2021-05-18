//
//  ChooseBasicsViewController.swift
//  GoalApp
//
//  Created by Simon Alam on 25.04.21.
//

import UIKit

class ChooseBasicsViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var deadlineLabel: UILabel!
    @IBOutlet var datePicked: UIDatePicker!
    @IBOutlet var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        navigationController?.navigationBar.isHidden = true
        buttonOutlet.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
        datePicked.isHidden = false
        deadlineLabel.isHidden = false
    }
    
    @IBAction func stepperChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            datePicked.isHidden = false
            deadlineLabel.isHidden = true
            return
        } else if sender.selectedSegmentIndex == 1 {
            deadlineLabel.isHidden = true
            datePicked.isHidden = true
            return
        }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        guard textField.text != "" else {
            let ac = UIAlertController(title: "Please type a title", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(ac, animated: true, completion: nil)
            return
        }
        
        if datePicked.isHidden == false {
            
            
            Goal.tempGoal.title = textField.text!
            Goal.tempGoal.deadline = datePicked.date
            
            
        } else {
            Goal.tempGoal.title = textField.text!
        }
        
        performSegue(withIdentifier: "pickSymbol", sender: self)
    
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

}
