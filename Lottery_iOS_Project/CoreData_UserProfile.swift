//
//  CoreData_UserProfile.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 12/30/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreData_UserProfile {
    
    static func SaveUserProfile(user:mUser){CoreData_Lottery.ClearLottery_CoreData("UserProfile")
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        
        let entity = NSEntityDescription.entityForName("UserProfile", inManagedObjectContext: managedContext)
        
        let newLottery = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        newLottery.setValue(user.birthday, forKey: "birthday")
        newLottery.setValue(user.email, forKey: "email")
        newLottery.setValue(user.gender, forKey: "gender")
        newLottery.setValue(user.isAccepted_checking_notification, forKey: "isAccepted_checking_notification")
        newLottery.setValue(user.isAccepted_lottery_notification, forKey: "isAccepted_lottery_notification")
        newLottery.setValue(user.message, forKey: "message")
        newLottery.setValue(user.name, forKey: "name")
        newLottery.setValue(user.password, forKey: "password")
        newLottery.setValue(user.user_id, forKey: "user_id")
        
        
        
        do {
            try managedContext.save()
            print("insert the new record sucessfully SaveUserProfile()")
        } catch let error as NSError {
            print("Could not insert the new record. \(error)")
        }
    }
    
    static func GetUserProfile(completion:(responseData:[mUser], errorMessage:NSError?)->Void)
    {
        
        
        var user_DB = [NSManagedObject]()
        var user = [mUser]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "UserProfile")
        
        do {
            
            let result = try managedContext.executeFetchRequest(fetchRequest)
            user_DB = result as! [NSManagedObject]
            
            if let object = user_DB as? [NSManagedObject] {
                for object in user_DB {
                    //lotteryPeriod.append(mLotteryPeriod(object: object))
                    user.append(mUser(object: object))
                }
//                if (user.count == 0){
//                    completion(responseData: mUser, errorMessage: nil)
//                }
//                else {
                    completion(responseData: user, errorMessage: nil)
//                }
                
            } else {
                print("Error null")
            }
            
        } catch let error as NSError {
            print("Could not fetch from Student. \(error)")
        }
    }
    
}
