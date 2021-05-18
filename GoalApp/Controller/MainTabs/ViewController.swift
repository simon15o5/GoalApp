//
//  ViewController.swift
//  GoalApp
//
//  Created by Simon Alam on 25.04.21.
//
import FirebaseAuth
import UIKit

class ViewController: UIViewController {

    @IBOutlet var addImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
      
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        addImage.isUserInteractionEnabled = true
        addImage.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        

        performSegue(withIdentifier: "newGoal", sender: self)
        // Your action
    }
}

