//
//  mLotteryPeriod.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation
import CoreData

class mLotteryPeriod {
    var lottery_period_id : Int!
    var lottery_period_date: String!
    var lottery_period_date_thaiName: String!
    var file_url_pdf: String!
    var lottery: mLottery!
    var last_update_dateTime: String!
    
    init() {
        self.lottery_period_id = 0
        self.lottery_period_date = ""
        self.lottery_period_date_thaiName = ""
        self.file_url_pdf = ""
        self.lottery = mLottery()
        self.last_update_dateTime = ""
        
    }
    
    init(object: NSManagedObject) {
        self.lottery_period_id = object.valueForKey("lottery_period_id") as? Int
        self.lottery_period_date = object.valueForKey("lottery_period_date") as? String
        self.lottery_period_date_thaiName = object.valueForKey("lottery_period_date_thaiName") as? String
        self.file_url_pdf = object.valueForKey("file_url_pdf") as? String
        self.lottery = mLottery()
        self.last_update_dateTime = object.valueForKey("last_updated_dateTime") as? String
    }
    
    init(dictionary: AnyObject) {
        self.lottery_period_id = dictionary["lottery_period_id"] as? Int
        self.lottery_period_date = dictionary["lottery_period_date"] as? String
        self.lottery_period_date_thaiName = dictionary["lottery_period_date_thaiName"] as? String
        self.file_url_pdf = dictionary["file_url_pdf"] as? String
        self.lottery = mLottery(dictionary: (dictionary["lottery"] as? [String: AnyObject])!)
    }
}
