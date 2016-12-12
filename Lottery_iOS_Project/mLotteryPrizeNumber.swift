//
//  mLotteryPrizeNumber.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class mLotteryPrizeNumber {
    var lottery_prize_number_id : Int!
    var period_lottery_id: Int!
    var prize_name: String!
    var numbers: String!
    var prize_baht: Int!
    var prize_baht_string: String!
    
    
    init() {
        self.lottery_prize_number_id = 0
        self.period_lottery_id = 0
        self.prize_name = ""
        self.numbers = ""
        self.prize_baht = 0
        self.prize_baht_string = ""
    }
    
    init(dictionary: AnyObject) {
        self.lottery_prize_number_id = dictionary["lottery_prize_number_id"] as? Int
        self.period_lottery_id = dictionary["period_lottery_id"] as? Int
        self.prize_name = dictionary["prize_name"] as? String
        self.numbers = dictionary["numbers"] as? String
        self.prize_baht = dictionary["prize_baht"] as? Int
        self.prize_baht_string = dictionary["prize_baht_string"] as? String
    }
}
