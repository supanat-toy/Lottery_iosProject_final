//
//  GetPickerViewDate.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 12/10/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit


class PickerViewDateProvider: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let WIDTH = UIScreen.mainScreen().bounds.width
    let HEIGHT = UIScreen.mainScreen().bounds.height
    
    // color and size array
    var yearList: [String]!
    var monthList: [String]!
    var dayList: [String]!

    
    //outlet - picker view
    var pickerView: UIPickerView = UIPickerView()
    
    
    
    // MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        self.pickerView.frame = CGRectMake(0, 108, WIDTH, 180)
        self.pickerView.backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/250, alpha: 0.2)
        self.pickerView.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/250, alpha: 1.0).CGColor
        self.pickerView.layer.borderWidth = 1
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetPickerViewDate_arr(isLottery: Bool){
        self.SetupDate(isLottery)
    }
    
    func GetPickerViewDate(isLottery: Bool) -> UIPickerView{
        dispatch_async(dispatch_get_main_queue(), {
            
        })
        
        self.viewDidLoad()
        self.SetupDate(isLottery)
        self.pickerView.reloadAllComponents()
        return pickerView
    }
    
    func SetupDate(isLottery: Bool){
        if (isLottery){
            yearList = ["2559"]
            monthList = ["มกราคม","กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถุนายน",
                             "กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม"]
            dayList = ["1","16"]
        }
        else {
            yearList = ["2559"]
            monthList = ["มกราคม","กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถุนายน",
                              "กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม"]
            dayList = ["1","16"]
        }
    }
    
     // how many component (i.e. column) to be displayed within picker view
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 3
    }
    
    // How many rows are there is each component
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        //return monthList.count
        if (component == 2) {
            return yearList.count+30
        }
        else if (component == 1)  {
            return monthList.count
        }
        else if (component == 0)  {
            return dayList.count
        }
    
        return 0
    }
    
    // title/content for row in given component
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        //return monthList[row]
        if (component == 2) {
            return yearList[row]
        }
        else if (component == 1)  {
            return monthList[row]
        }
        else if (component == 0)  {
            return dayList[row]
        }
        
        return "No row"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
    
    // MARK: - picker view delegate and data source
    

//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        if component == 0 {
//            // if first row then set --
//            if row == 0 {
//                self.colorLabel.text = "--"
//            }else{
//                self.colorLabel.text = self.colorList[row]
//            }
//        }
//        
//        if component == 1 {
//            // if first row then set --
//            if row == 0 {
//                self.sizeLabel.text = "--"
//            }else {
//                self.sizeLabel.text = self.sizeList[row]
//            }
//        }
//    }
    
    
    
    // MARK: - Utility functions
    
    // function - create data
//    fileprivate func setupData(){
//        
//        // create color list
//        self.colorList = ["(( Select ))", "Black", "Blue", "Brown", "Green", "Orange", "Pink" , "Purple", "Red", "Yellow"]
//        
//        // create size list
//        self.sizeList = ["(( Select ))","S", "M", "L", "XL" ]
//    }
    
    
}
