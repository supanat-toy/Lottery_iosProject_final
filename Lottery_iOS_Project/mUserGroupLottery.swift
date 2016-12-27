//
//  mUserGroupLottery.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 12/13/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class mUserGroupLottery {
    
    var lottery_period_date : String!
    var userLotteryList = [mUserLotteryNumber]()
    
    init(dictionary: AnyObject) {
        self.lottery_period_date = dictionary["lottery_period_date"] as? String
        //self.userLotteryList = dictionary["userLotteryList"] as? Int
        
        let arrayOfDictionaries = dictionary["userLotteryList"] as? [[String: AnyObject]]
        for dictionary in arrayOfDictionaries! {
            userLotteryList.append(mUserLotteryNumber(dictionary: dictionary))
        }
    }
    
}
