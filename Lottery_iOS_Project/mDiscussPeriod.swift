//
//  mDiscussPeriod.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class mDiscussPeriod {
    
    var discuss_period_id : Int!
    var discuss_period_date : String!
    var discuss_period_date_thaiName : String!
    var discussList = [mDiscuss]()
    var message : String!
    var create_datetime : String!
    
    
    init(dictionary: AnyObject) {
        self.discuss_period_id = dictionary["discuss_period_id"] as? Int
        self.discuss_period_date = dictionary["discuss_period_date"] as? String
        self.discuss_period_date_thaiName = dictionary["discuss_period_date_thaiName"] as? String
        //var discussList = dictionary["discussList"] as? [String: AnyObject]
        //self.discussList = mDiscuss(dictionary: discussList!)
        
        let arrayOfDictionaries = dictionary["discussList"] as? [[String: AnyObject]]
        for dictionary in arrayOfDictionaries! {
            discussList.append(mDiscuss(dictionary: dictionary))
        }
        
        self.message = dictionary["message"] as? String
        self.create_datetime = dictionary["create_datetime"] as? String
    }
}
