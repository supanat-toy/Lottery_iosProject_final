//
//  mUserLottery.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation


class mUserLottery {
    
    var next_lottery_period_date : String!
    var userGroupLottery = [mUserGroupLottery]()
    

    init(dictionary: AnyObject) {
        self.next_lottery_period_date = dictionary["next_lottery_period_date"] as? String
        //self.userGroupLottery = dictionary["userGroupLottery"] as? Int
        
        let arrayOfDictionaries = dictionary["userGroupLottery"] as? [[String: AnyObject]]
        for dictionary in arrayOfDictionaries! {
            userGroupLottery.append(mUserGroupLottery(dictionary: dictionary))
        }
        
    }
    
}
