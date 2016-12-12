//
//  mLottery.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class mLottery {
    var prize_1st : mLotteryPrizeNumber
    var prize_nearby_1st = [mLotteryPrizeNumber]()
    var prize_2rear : mLotteryPrizeNumber
    var prize_3front = [mLotteryPrizeNumber]()
    var prize_3rear = [mLotteryPrizeNumber]()
    var prize_2nd = [mLotteryPrizeNumber]()
    var prize_3rd = [mLotteryPrizeNumber]()
    var prize_4th = [mLotteryPrizeNumber]()
    var prize_5th = [mLotteryPrizeNumber]()
    
    
    init(dictionary: AnyObject) {
        self.prize_1st = mLotteryPrizeNumber(dictionary: (dictionary["prize_1st"] as? [String: AnyObject])!)
        
        var arrayOfDictionaries = dictionary["prize_nearby_1st"] as? [[String: AnyObject]]
        print(arrayOfDictionaries)
        for dictionary in arrayOfDictionaries! {
            prize_nearby_1st.append(mLotteryPrizeNumber(dictionary: dictionary))
        }
        self.prize_2rear = mLotteryPrizeNumber(dictionary: (dictionary["prize_2rear"] as? [String: AnyObject])!)
        
        arrayOfDictionaries = dictionary["prize_3front"] as? [[String: AnyObject]]
        for dictionary in arrayOfDictionaries! {
            prize_3front.append(mLotteryPrizeNumber(dictionary: dictionary))
        }
        
        arrayOfDictionaries = dictionary["prize_3rear"] as? [[String: AnyObject]]
        for dictionary in arrayOfDictionaries! {
            prize_3rear.append(mLotteryPrizeNumber(dictionary: dictionary))
        }
        
        arrayOfDictionaries = dictionary["prize_2nd"] as? [[String: AnyObject]]
        for dictionary in arrayOfDictionaries! {
            prize_2nd.append(mLotteryPrizeNumber(dictionary: dictionary))
        }
        
        arrayOfDictionaries = dictionary["prize_3rd"] as? [[String: AnyObject]]
        for dictionary in arrayOfDictionaries! {
            prize_3rd.append(mLotteryPrizeNumber(dictionary: dictionary))
        }
        
        arrayOfDictionaries = dictionary["prize_4th"] as? [[String: AnyObject]]
        for dictionary in arrayOfDictionaries! {
            prize_4th.append(mLotteryPrizeNumber(dictionary: dictionary))
        }
        
        arrayOfDictionaries = dictionary["prize_5th"] as? [[String: AnyObject]]
        for dictionary in arrayOfDictionaries! {
            prize_5th.append(mLotteryPrizeNumber(dictionary: dictionary))
        }
    }
}
