//
//  PhotoPickerViewController.swift
//  GoalApp
//
//  Created by Simon Alam on 27.04.21.
//
import RealmSwift
import UIKit

class PhotoPickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let realm = try! Realm()
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isHidden = false
        button.setTitle("Select image", for: .normal)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            imageView.isHidden = true
            button.setTitle("Ok", for: .normal)
        } else {
            imageView.isHidden = false
            button.setTitle("Select image", for: .normal)
        }
    }
    
    @IBAction func okPressed(_ sender: UIButton) {
        if sender.currentTitle == "Select image" {
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true, completion: nil)
            
            
        } else if sender.currentTitle == "Ok" {
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
            Goal.tempGoal = Goal()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        dismiss(animated: true, completion: nil)
        
        if let image = info[.editedImage] as? UIImage {
            
            let imageName = UUID().uuidString
            let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
            
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imagePath)
            }
            
            imageView.image = image
            button.setTitle("Ok", for: .normal)
            
            do {
                try realm.write {
                    Goal.tempGoal.pic = imageName
                }
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
      
        
       
        
        
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    

}
