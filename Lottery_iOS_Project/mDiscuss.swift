//
//  mDiscuss.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class mDiscuss{
    
    var discuss_id : Int!
    var user_id : Int!
    var user_name : String!
    var numbers : String!
    var message : String!
    var create_datetime : String!
    var number_like : Int!
    var number_comment : Int!
    var isLike: Bool!
    
    init(dictionary: AnyObject) {
        self.discuss_id = dictionary["discuss_id"] as? Int
        self.user_id = dictionary["user_id"] as? Int
        self.user_name = dictionary["user_name"] as? String
        self.numbers = dictionary["numbers"] as? String
        self.message = dictionary["message"] as? String
        self.create_datetime = dictionary["create_datetime"] as? String
        self.number_like = dictionary["number_like"] as? Int
        self.number_comment = dictionary["number_comment"] as? Int
        
        
        var isLike:Int = (dictionary["isLike"] as? Int)!
        if(isLike == 1){
            self.isLike  = true
        }else {
            self.isLike  = false
        }
    }
}
