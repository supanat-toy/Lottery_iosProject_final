//
//  Ws_Lottery.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class Ws_Lottery {
    
    // GetLottery
    static func GetLottery(period_lottery_date: String,completion:(responseData:mLotteryPeriod,errorMessage:NSError?)->Void)
    {
        //var funcProvider: FunctionsProvider = FunctionsProvider()
        //var period_lottery_date = funcProvider.GetDateMinus543(period_lottery_date)
        
        var lotteryPeriod:mLotteryPeriod!
        let url = NSURL(string: "http://tskyonline.com:83/WS_Lottery/GetLottery?period_lottery_date=" + period_lottery_date)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                //                print("================================================================")
                //                print("jsonResult : " + String(jsonResult))
                //                print("================================================================")
                if let arrayOfDictionaries = jsonResult as? AnyObject {
                    lotteryPeriod = mLotteryPeriod(dictionary: arrayOfDictionaries as! AnyObject)
                    
                    completion(responseData: lotteryPeriod, errorMessage: error)
                } else {
                    print("Error")
                }
                
            } catch let myJSONError {
                print("Error : ", myJSONError)
            }
            
        }
        task.resume()
    }
    
}
