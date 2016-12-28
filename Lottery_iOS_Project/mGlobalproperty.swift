//
//  mGlobalproperty.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import Foundation

class mGlobalproperty {
    
    var resultResponse: mMessageResponse!
    var userProfile: mUser!
    
    
    init(dictionary: AnyObject) {
        var resultResponse = dictionary["resultResponse"] as? [String: AnyObject]
        self.resultResponse = mMessageResponse(dictionary: resultResponse!) // as? [String: AnyObject] or [AnyObject]
        var user = dictionary["userProfile"] as? [String: AnyObject]
        
        if (self.resultResponse.result == true){
            self.userProfile = mUser(dictionary: user!)
        }
        
        
    }
}
