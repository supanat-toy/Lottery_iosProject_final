//
//  Functions.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 12/10/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FunctionsProvider:UIViewController, GADBannerViewDelegate {
    
    var bannerAdView: GADBannerView = GADBannerView()
    
    func loadAds() -> GADBannerView {
        let screenBounds: CGRect = UIScreen.mainScreen().bounds
        let size = 320
        let screenWidth = self.view.frame.size.width
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        var bannerAdView: GADBannerView
        bannerAdView = GADBannerView(frame: CGRect(x: (screenWidth / 2) - CGFloat(size / 2), y: screenBounds.height-100, width: 320, height: 50))
        bannerAdView.delegate = self
        bannerAdView.adUnitID = "ca-app-pub-2249744611088216/6482569886"
        bannerAdView.rootViewController = self
        bannerAdView.loadRequest(request)
        //self.canDisplayBannerAds = true
        return bannerAdView
    }
    //------------------------------------------------------------------
    
    func GetDateNow() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  String(components.year)
        let month = String(components.month)
        let day = String(components.day)
        
        return day + "/" + month + "/" + year
    }
    
    func GetDateTimeNow() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year, .Hour, .Minute], fromDate: date)
        
        let year =  String(components.year+543)
        let month = String(components.month)
        let day = String(components.day)
        let hour = String(components.hour)
        let minute = String(components.minute)
        
        return "\(day)/\(month)/\(year) \(hour):\(minute)"
    }
    
    func GetDateMinus543(date:String) -> String{
        let dateArr = date.characters.split{$0 == "/"}.map(String.init)
        var day = dateArr[0]
        var month = dateArr[1]
        var year = String(Int(dateArr[2])!)
        
        return day + "/" + month + "/" + year
    }
    
}

