//
//  RegisterViewController.swift
//  GoalApp
//
//  Created by Simon Alam on 26.04.21.
//
import FirebaseAuth
import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "registerToApp", sender: self)
                }
            }
        }
    }
    
    

}
