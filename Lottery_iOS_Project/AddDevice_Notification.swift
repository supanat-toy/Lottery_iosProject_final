//
//  AddDevice_Notification.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 12/16/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class AddDevice_Notification {
    // AddNewDiscuss
    static func AddNewUUIDDevice_Notification(user_id: Int,completion:(responseData:mMessageResponse,errorMessage:NSError?)->Void)
    {
        
        var device_UUID:String = UIDevice.currentDevice().identifierForVendor!.UUIDString
        var messageResponse:mMessageResponse!

        let url = NSURL(string: "http://tskyonline.com:83/WS_Discuss/AddNewDiscuss?user_id=\(String(user_id))&device_UUID=\(String(device_UUID))")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                print("jsonResult", jsonResult)
                if let arrayOfDictionaries = jsonResult as? AnyObject {
                    
                    messageResponse = mMessageResponse(dictionary: arrayOfDictionaries as! AnyObject)
                    completion(responseData: messageResponse, errorMessage: error)
                    
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
