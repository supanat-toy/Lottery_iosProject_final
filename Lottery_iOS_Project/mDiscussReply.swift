//
//  mDiscussReply.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class mDiscussReply {
    
    var discussReply_id : Int!
    var discuss_id : Int!
    var user_id : Int64!
    var user_name : String!
    var message : String!
    var create_datetime : String!
    
    
    init(dictionary: AnyObject) {
        self.discussReply_id = dictionary["discussReply_id"] as? Int
        self.discuss_id = dictionary["discuss_id"] as? Int
        self.user_id = dictionary["user_id"] as? Int64
        self.user_name = dictionary["user_name"] as? String
        self.message = dictionary["message"] as? String
        self.create_datetime = dictionary["create_datetime"] as? String
    }
}
