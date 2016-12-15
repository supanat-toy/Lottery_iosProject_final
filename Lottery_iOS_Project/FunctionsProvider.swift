//
//  Functions.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 12/10/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit
import iAd

class FunctionsProvider:UIViewController, ADBannerViewDelegate {
    
    var bannerAdView: ADBannerView = ADBannerView()
    
    func loadAds() -> ADBannerView {
        let screenBounds: CGRect = UIScreen.mainScreen().bounds
        
        var bannerAdView: ADBannerView
        bannerAdView = ADBannerView(frame: CGRect(x: 0, y: screenBounds.height-100, width: screenBounds.width, height: 50))
        bannerAdView.backgroundColor = UIColor.blackColor()
        bannerAdView.delegate = self
        bannerAdView.hidden = false
        //self.canDisplayBannerAds = true
        return bannerAdView
    }
    
    //Delegate methods for AdBannerView
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError
        error: NSError!) {
        print("failed to load ad")
        
        banner.removeFromSuperview() //Remove the banner (No ad)
    }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        print("bannerViewWillLoadAd")
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        print("bannerViewDidLoadAd()")
        return true
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        bannerAdView.hidden = false
        //banner.frame = CGRect(x: 0, y: 400, width: WIDTH, height: 50)
        print("success bannerViewDidLoadAd() ")
        self.view.addSubview(banner) //Add banner to view (Ad loaded)
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

