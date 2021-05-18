//
//  Goal.swift
//  GoalApp
//
//  Created by Simon Alam on 25.04.21.
//
import RealmSwift
import UIKit
class Goal: Object {
    
    @objc dynamic static var shared = [Goal]()
    @objc dynamic static var tempGoal = Goal()
    @objc dynamic var symbol: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var deadline: Date? = nil
    @objc dynamic var pic: String? = nil
    
   
    
    
}
