//
//  Ws_User.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class Ws_User {
    
    // GetGlobalProperty
    static func GetGlobalProperty(email: String,password: String,completion:(responseData:mGlobalproperty,errorMessage:NSError?)->Void)
    {
        var globalProperty:mGlobalproperty!
        let url = NSURL(string: "http://tskyonline.com:83/Ws_User/Authentication?email=" + email + "&password=" + password)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//                print("================================================================")
//                print("jsonResult : " + String(jsonResult))
//                print("================================================================")
                if let arrayOfDictionaries = jsonResult as? AnyObject {
                    globalProperty = mGlobalproperty(dictionary: arrayOfDictionaries as! AnyObject)
                    
                    completion(responseData: globalProperty, errorMessage: error)
                } else {
                    print("Error")
                }
                
            } catch let myJSONError {
                print("Error : ", myJSONError)
            }
            
        }
        task.resume()
    }
    
    // GetUserProfile
    static func GetUserProfile(email: String,completion:(responseData:mUser,errorMessage:NSError?)->Void)
    {
        var userProfile:mUser!
        let url = NSURL(string: "http://tskyonline.com:83/Ws_User/GetUserProfile?email=" + email)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                //                print("================================================================")
                //                print("jsonResult : " + String(jsonResult))
                //                print("================================================================")
                if let arrayOfDictionaries = jsonResult as? AnyObject {
                    userProfile = mUser(dictionary: arrayOfDictionaries as! AnyObject)
                    
                    completion(responseData: userProfile, errorMessage: error)
                } else {
                    print("Error")
                }
                
            } catch let myJSONError {
                print("Error : ", myJSONError)
            }
            
        }
        task.resume()
    }
    
    // Register
    static func Register(email: String,password: String,name: String,birthday: String,gender: String,
                         completion:(responseData:mGlobalproperty,errorMessage:NSError?)->Void)
    {
        var globalProperty:mGlobalproperty!
        let url = NSURL(string: "http://tskyonline.com:83/Ws_User/Register?email=" + email + "&password=" + password + "&name=" + name + "&birthday=" + birthday + "&gender=" + gender)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                //                print("================================================================")
                //                print("jsonResult : " + String(jsonResult))
                //                print("================================================================")
                if let arrayOfDictionaries = jsonResult as? AnyObject {
                    globalProperty = mGlobalproperty(dictionary: arrayOfDictionaries as! AnyObject)
                    
                    completion(responseData: globalProperty, errorMessage: error)
                } else {
                    print("Error")
                }
                
            } catch let myJSONError {
                print("Error : ", myJSONError)
            }
            
        }
        task.resume()
    }
    
    // UpdateUserProfile
    static func UpdateUserProfile(user_id: Int,password: String, name: String,birthday: String,gender: String,
                         completion:(responseData:mUser,errorMessage:NSError?)->Void)
    {
        var userProfile:mUser!
        let url = NSURL(string: "http://tskyonline.com:83/Ws_User/UpdateUserProfile?user_id=" + String(user_id) + "&password=" + password + "&name=" + name + "&birthday=" + birthday + "&gender" + gender)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                //                print("================================================================")
                //                print("jsonResult : " + String(jsonResult))
                //                print("================================================================")
                if let arrayOfDictionaries = jsonResult as? AnyObject {
                    userProfile = mUser(dictionary: arrayOfDictionaries as! AnyObject)
                    
                    completion(responseData: userProfile, errorMessage: error)
                } else {
                    print("Error")
                }
                
            } catch let myJSONError {
                print("Error : ", myJSONError)
            }
            
        }
        task.resume()
    }
    
    // GetUserLottery
    static func GetUserLottery(user_id: Int, completion:(responseData:mUserLottery,errorMessage:NSError?)->Void)
    {
        var userLottery:mUserLottery!
        let url = NSURL(string: "http://tskyonline.com:83/Ws_User/GetUserLottery?user_id=" + String(user_id))
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                //                print("================================================================")
                //                print("jsonResult : " + String(jsonResult))
                //                print("================================================================")
                if let arrayOfDictionaries = jsonResult as? AnyObject {
//                    for dictionary in arrayOfDictionaries {
//                        userLottery.append(mUserLottery(dictionary: dictionary))
//                    }
                    userLottery = mUserLottery(dictionary: arrayOfDictionaries as! AnyObject)
                    
                    completion(responseData: userLottery, errorMessage: error)
                } else {
                    print("Error")
                }
                
            } catch let myJSONError {
                print("Error : ", myJSONError)
            }
            
        }
        task.resume()
    }
    
    // AddUserLottery
    static func AddUserLottery(user_id: Int,numbers: String,period_lottery_date: String,
                               completion:(responseData:mMessageResponse,errorMessage:NSError?)->Void)
    {
        var funcProvider: FunctionsProvider = FunctionsProvider()
        var period_lottery_date = funcProvider.GetDateMinus543(period_lottery_date)
        
        //var userLottery = [mUserLottery]()
        var messageResponse:mMessageResponse!
        let url = NSURL(string: "http://tskyonline.com:83/Ws_User/AddUserLottery?user_id=" + String(user_id) + "&numbers=" + numbers + "&period_lottery_date=" + period_lottery_date)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                //                print("================================================================")
                //                print("jsonResult : " + String(jsonResult))
                //                print("================================================================")
                if let arrayOfDictionaries = jsonResult as? [[String: AnyObject]] {
//                    for dictionary in arrayOfDictionaries {
//                        userLottery.append(mUserLottery(dictionary: dictionary))
//                    }
//                    completion(responseData: userLottery, errorMessage: error)
                    
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
    
    // DeleteUserLottery
    static func DeleteUserLottery(user_id: Int,userLottery_id: Int,
                               completion:(responseData:mMessageResponse,errorMessage:NSError?)->Void)
    {
        //var userLottery = [mUserLottery]()
        var messageResponse:mMessageResponse!
        let url = NSURL(string: "http://tskyonline.com:83/Ws_User/DeleteUserLottery?user_id=" + String(user_id) + "&userLottery_id=" + String(userLottery_id))
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                //                print("================================================================")
                //                print("jsonResult : " + String(jsonResult))
                //                print("================================================================")
                if let arrayOfDictionaries = jsonResult as? [[String: AnyObject]] {
//                    for dictionary in arrayOfDictionaries {
//                        userLottery.append(mUserLottery(dictionary: dictionary))
//                    }
//                    completion(responseData: userLottery, errorMessage: error)
                    
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
    
    // UpdateCheckingNotification
    static func UpdateCheckingNotification(user_id: Int,isAccepted: Bool,completion:(responseData:mMessageResponse,errorMessage:NSError?)->Void)
    {
        var messageResponse:mMessageResponse!
        let url = NSURL(string: "http://tskyonline.com:83/Ws_User/UpdateCheckingNotification?user_id=" + String(user_id) + "&isAccepted=" + String(isAccepted))
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                //                print("================================================================")
                //                print("jsonResult : " + String(jsonResult))
                //                print("================================================================")
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
    
    // UpdateCheckingNotification
    static func UpdateGetNewLotteryNotification(user_id: Int,isAccepted: Bool,completion:(responseData:mMessageResponse,errorMessage:NSError?)->Void)
    {
        var messageResponse:mMessageResponse!
        let url = NSURL(string: "http://tskyonline.com:83/Ws_User/UpdateGetNewLotteryNotification?user_id=" + String(user_id) + "&isAccepted=" + String(isAccepted))
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                //                print("================================================================")
                //                print("jsonResult : " + String(jsonResult))
                //                print("================================================================")
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
