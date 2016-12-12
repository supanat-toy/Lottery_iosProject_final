//
//  mMessageResponse.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation


class mMessageResponse  {
    var result : Bool!
    var message: String!
    
    
    init(result: Bool, message: String){
        self.result = result
        self.message = message
    }
    
    init(dictionary: AnyObject) {
        var result_int:Int = (dictionary["result"] as? Int)!
        if(result_int == 1){
            self.result  = true
        }else {
            self.result  = false
        }
        self.message = dictionary["message"] as? String
    }
}
