//
//  mUser.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation
import CoreData

class mUser {
    
    var user_id : Int!
    var email : String!
    var password : String!
    var name : String!
    var birthday : String!
    var gender : String!
    var message : String!
    var isAccepted_checking_notification : Bool!
    var isAccepted_lottery_notification : Bool!
    
    
    init(object: NSManagedObject) {
        
        self.user_id = object.valueForKey("user_id") as? Int
        self.email = object.valueForKey("email") as? String
        self.password = object.valueForKey("password") as? String
        self.name = object.valueForKey("name") as? String
        self.birthday = object.valueForKey("birthday") as? String
        self.gender = object.valueForKey("gender") as? String
        self.message = object.valueForKey("message") as? String
        
        var isAccepted_checking_notification:Int = (object.valueForKey("isAccepted_checking_notification") as? Int)!
        if(isAccepted_checking_notification == 1){
            self.isAccepted_checking_notification  = true
        }else {
            self.isAccepted_checking_notification  = false
        }
        
        var isAccepted_lottery_notification:Int = (object.valueForKey("isAccepted_lottery_notification") as? Int)!
        if(isAccepted_lottery_notification == 1){
            self.isAccepted_lottery_notification  = true
        }else {
            self.isAccepted_lottery_notification  = false
        }
    }
    
    init(dictionary: AnyObject) {
        self.user_id = dictionary["user_id"] as? Int
        self.email = dictionary["email"] as? String
        self.password = dictionary["password"] as? String
        self.name = dictionary["name"] as? String
        self.birthday = dictionary["birthday"] as? String
        self.gender = dictionary["gender"] as? String
        self.message = dictionary["message"] as? String
        
        var isAccepted_checking_notification:Int = (dictionary["isAccepted_checking_notification"] as? Int)!
        if(isAccepted_checking_notification == 1){
            self.isAccepted_checking_notification  = true
        }else {
            self.isAccepted_checking_notification  = false
        }
        
        var isAccepted_lottery_notification:Int = (dictionary["isAccepted_lottery_notification"] as? Int)!
        if(isAccepted_lottery_notification == 1){
            self.isAccepted_lottery_notification  = true
        }else {
            self.isAccepted_lottery_notification  = false
        }
    }
}
