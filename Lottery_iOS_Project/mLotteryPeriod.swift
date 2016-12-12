//
//  mLotteryPeriod.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class mLotteryPeriod {
    var lottery_period_id : Int!
    var lottery_period_date: String!
    var lottery_period_date_thaiName: String!
    var file_url_pdf: String!
    var lottery: mLottery!
    
    
    init(dictionary: AnyObject) {
        self.lottery_period_id = dictionary["lottery_period_id"] as? Int
        self.lottery_period_date = dictionary["lottery_period_date"] as? String
        self.lottery_period_date_thaiName = dictionary["lottery_period_date_thaiName"] as? String
        self.file_url_pdf = dictionary["file_url_pdf"] as? String
        self.lottery = mLottery(dictionary: (dictionary["lottery"] as? [String: AnyObject])!)
    }
}
