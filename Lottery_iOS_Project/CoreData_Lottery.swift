//
//  CoreData_Lottery.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 12/14/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreData_Lottery: UIViewController {
    
    // GetLottery
    static func GetLottery(period_lottery_date: String,completion:(responseData:mLotteryPeriod, errorMessage:NSError?)->Void)
    {
        var lotteryPeriod:mLotteryPeriod = mLotteryPeriod()
        
        GetLotteryPeriod(period_lottery_date) { (responseData, errorMessage) in
        
            if (responseData.count != 0){
                do{
                    let lotteryPeriod = try responseData[0]
                }catch let error as NSError {
                    
                }
                GetLotteryPrizeNumber(period_lottery_date) { (responseData, errorMessage) in
                    lotteryPeriod.lottery = responseData.lottery
                    completion(responseData: lotteryPeriod, errorMessage: nil)
                }
            }
            
            
            
            
            
        }
    }
    
    // GetLotteryPrizeNumber
    static func GetLotteryPrizeNumber(period_lottery_date: String,completion:(responseData:mLotteryPeriod, errorMessage:NSError?)->Void)
    {
        var lotteryNumberList_DB = [NSManagedObject]()
        var lotteryPeriod:mLotteryPeriod = mLotteryPeriod()
        
        var lotteryNumberPrizeList = [mLotteryPrizeNumber]()
        var lottery:mLottery!
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "LotteryPrizeNumber")
        
        do {
            
            let result = try managedContext.executeFetchRequest(fetchRequest)
            lotteryNumberList_DB = result as! [NSManagedObject]
            
            if let object = lotteryNumberList_DB as? [NSManagedObject] {
                for object in lotteryNumberList_DB {
                    lotteryNumberPrizeList.append(mLotteryPrizeNumber(object: object))
                }
                lottery = GetConvertToLottery(lotteryNumberPrizeList)
                lotteryPeriod.lottery = lottery
                
                completion(responseData: lotteryPeriod, errorMessage: nil)
            } else {
                print("Error null")
            }
            
        } catch let error as NSError {
            print("Could not fetch from Student. \(error)")
        }
    }
    
    // GetLottery
    static func GetLotteryPeriod(period_lottery_date: String,completion:(responseData:[mLotteryPeriod], errorMessage:NSError?)->Void)
    {
        
        
        var lotteryPeriod_DB = [NSManagedObject]()
        var lotteryPeriod = [mLotteryPeriod]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "LotteryPeriod")
        
        do {
            
            let result = try managedContext.executeFetchRequest(fetchRequest)
            lotteryPeriod_DB = result as! [NSManagedObject]
            
            if let object = lotteryPeriod_DB as? [NSManagedObject] {
                for object in lotteryPeriod_DB {
                    lotteryPeriod.append(mLotteryPeriod(object: object))
                }
                completion(responseData: lotteryPeriod, errorMessage: nil)
            } else {
                print("Error null")
            }
            
        } catch let error as NSError {
            print("Could not fetch from Student. \(error)")
        }
    }
    
    static func GetConvertToLottery(lotteryPrizeNumberList : [mLotteryPrizeNumber]) -> mLottery{
        var lottery: mLottery = mLottery()
        
            for lotteryPrizeNumber in lotteryPrizeNumberList {
                if (lotteryPrizeNumber.prize_name == "รางวัลที่ 1"){  // 1st
                    lottery.prize_1st = lotteryPrizeNumber
                }
                else if (lotteryPrizeNumber.prize_name == "รางวัลข้างเคียงรางวัลที่ 1"){ // near 1st
                    lottery.prize_nearby_1st.append(lotteryPrizeNumber)
                }
                else if (lotteryPrizeNumber.prize_name == "เลขท้าย 2 ตัว"){ // prize_2rear
                    lottery.prize_2rear = lotteryPrizeNumber
                }
                else if (lotteryPrizeNumber.prize_name == "เลขหน้า 3 ตัว"){ // prize_3front
                    lottery.prize_3front.append(lotteryPrizeNumber)
                }
                else if (lotteryPrizeNumber.prize_name == "เลขท้าย 3 ตัว"){ // prize_3rear
                    lottery.prize_3rear.append(lotteryPrizeNumber)
                }
                else if (lotteryPrizeNumber.prize_name == "รางวัลที่ 2"){ // prize_2nd
                    lottery.prize_2nd.append(lotteryPrizeNumber)
                }
                else if (lotteryPrizeNumber.prize_name == "รางวัลที่ 3"){ // prize_3rd
                    lottery.prize_3rd.append(lotteryPrizeNumber)
                }
                else if (lotteryPrizeNumber.prize_name == "รางวัลที่ 4"){ // prize_4th
                    lottery.prize_4th.append(lotteryPrizeNumber)
                }
                else if (lotteryPrizeNumber.prize_name == "รางวัลที่ 5"){ // prize_5th
                    lottery.prize_5th.append(lotteryPrizeNumber)
                }
            }
            return lottery
    }
    
    // Add Lottery
    static func SaveLottery_CoreData(lotteryPeriod: mLotteryPeriod)
    {
        dispatch_async(dispatch_get_main_queue(), {
        ClearLottery_CoreData("LotteryPrizeNumber")
        ClearLottery_CoreData("LotteryPeriod")
            
        var groupLottery = lotteryPeriod.lottery
            
        SaveLotteryPerioid_IntoCoreData(lotteryPeriod)
        SaveLotteryPrizeNumber_IntoCoreData(groupLottery.prize_1st)
        SaveLotteryPrizeNumber_IntoCoreData(groupLottery.prize_2rear)
        for lottery in groupLottery.prize_nearby_1st {
            SaveLotteryPrizeNumber_IntoCoreData(lottery)
        }
        for lottery in groupLottery.prize_2nd {
            SaveLotteryPrizeNumber_IntoCoreData(lottery)
        }
        for lottery in groupLottery.prize_3front {
            SaveLotteryPrizeNumber_IntoCoreData(lottery)
        }
        for lottery in groupLottery.prize_3rd {
            SaveLotteryPrizeNumber_IntoCoreData(lottery)
        }
        for lottery in groupLottery.prize_3rear {
            SaveLotteryPrizeNumber_IntoCoreData(lottery)
        }
        for lottery in groupLottery.prize_4th {
            SaveLotteryPrizeNumber_IntoCoreData(lottery)
        }
        for lottery in groupLottery.prize_5th {
            SaveLotteryPrizeNumber_IntoCoreData(lottery)
        }
        })
    }
    
    
    
    static func ClearLottery_CoreData(entity: String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
        
    }
    
    static func SaveLotteryPerioid_IntoCoreData(lotteryPeriod:mLotteryPeriod){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("LotteryPeriod", inManagedObjectContext: managedContext)
        
        let newLottery = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        newLottery.setValue(lotteryPeriod.file_url_pdf, forKey: "file_url_pdf")
        newLottery.setValue(lotteryPeriod.lottery_period_date, forKey: "lottery_period_date")
        newLottery.setValue(lotteryPeriod.lottery_period_date_thaiName, forKey: "lottery_period_date_thaiName")
        newLottery.setValue(lotteryPeriod.lottery_period_id, forKey: "lottery_period_id")
        
        var functions = FunctionsProvider()
        var dateTimeNow:String = functions.GetDateTimeNow()
        newLottery.setValue(dateTimeNow, forKey: "last_updated_dateTime")
        
        do {
            try managedContext.save()
            //print("insert the new record sucessfully")
        } catch let error as NSError {
            print("Could not insert the new record. \(error)")
        }
    }
    
    static func SaveLotteryPrizeNumber_IntoCoreData(lotteryPrizeNumber:mLotteryPrizeNumber){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("LotteryPrizeNumber", inManagedObjectContext: managedContext)
        
        let newLottery = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        newLottery.setValue(lotteryPrizeNumber.lottery_prize_number_id, forKey: "lottery_prize_number_id")
        newLottery.setValue(lotteryPrizeNumber.numbers, forKey: "numbers")
        newLottery.setValue(lotteryPrizeNumber.period_lottery_id, forKey: "period_lottery_id")
        newLottery.setValue(lotteryPrizeNumber.prize_baht, forKey: "prize_baht")
        newLottery.setValue(lotteryPrizeNumber.prize_baht_string, forKey: "prize_baht_string")
        newLottery.setValue(lotteryPrizeNumber.prize_name, forKey: "prize_name")
        
      
        
        do {
            try managedContext.save()
            print("insert the new record sucessfully")
        } catch let error as NSError {
            print("Could not insert the new record. \(error)")
        }
    }
    
    //User lottery
    
    
    //save the date of the next session that the lottery will commence
    static func SaveNextLotteryDate(nextDate: String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        
        let entity = NSEntityDescription.entityForName("UserLotteryNext", inManagedObjectContext: managedContext)
        let newLotteryNext = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        newLotteryNext.setValue(nextDate, forKey: "next_lottery_date")
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not insert new lottery date. \(error)")
        }
    }
    
    static func SaveLottery(sender: [mUserGroupLottery], userid: Int){
        for i in sender{
            
            for j in i.userLotteryList{
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                let entity = NSEntityDescription.entityForName("UserLottery", inManagedObjectContext: managedContext)
                let newLottery = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                
                newLottery.setValue(userid, forKey: "user_id")
                newLottery.setValue(j.numbers, forKey: "lottery_number")
                newLottery.setValue(j.prize_baht, forKey: "prize_baht")
                newLottery.setValue(j.userLottery_id, forKey: "user_lottery_id")
                newLottery.setValue(j.period_lottery_date, forKey: "lottery_date")
                newLottery.setValue(j.status_result, forKey: "status_result")
                newLottery.setValue(j.create_datetime, forKey: "create_datetime")
                
                do{
                    try managedContext.save()
                    print("Insert user lottery successfully")
                }catch let error as NSError{
                    print("Could not insert user lottery. \(error)")
                }
            }
        }
    }
    
    
}
