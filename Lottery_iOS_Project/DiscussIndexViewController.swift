//
//  DiscussIndexViewController.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 11/26/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit
import iAd

class DiscussIndexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var uiPickerView_dateDiscuss: UIPickerView!
    var yearList: [String] = []
    var monthList: [String] = []
    var dayList: [String] = []
    var selected_dayPicker: Int = 0
    var selected_monthPicker: Int = 0
    var selected_yearPickker: Int = 0
    var isChangePickerDate: Bool = false
    
    var bannerAdView: ADBannerView = ADBannerView()

    var refreshControl: UIRefreshControl = UIRefreshControl()
    var datePicker_lotteryDate = UIDatePicker()
    let WIDTH = UIScreen.mainScreen().bounds.width
    let HEIGHT = UIScreen.mainScreen().bounds.height
    var isAddNewDiscuss: Bool = false
    
    @IBOutlet weak var navigateBar_bottom: UINavigationBar!
    @IBOutlet var tableView_: UITableView!
    
    var wsDiscussPeriod: mDiscussPeriod!
    
    var wsDiscussList: [mDiscuss] = []
    var current_datePicker: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "พูดคุย"
        
        uiPickerView_dateDiscuss.dataSource = self;
        uiPickerView_dateDiscuss.delegate = self;
        
        datePicker_lotteryDate.hidden = true
        refreshControl.addTarget(self, action: "refresh_wsGetDiscuss", forControlEvents: .ValueChanged)
        tableView_.addSubview(refreshControl)
        refreshControl.beginRefreshing()

        tableView_.separatorStyle = UITableViewCellSeparatorStyle.None
        var functions = FunctionsProvider()
        let dateNow:String = (functions.GetDateNow() as? String)!
        current_datePicker = dateNow
        let dateArr = dateNow.characters.split{$0 == "/"}.map(String.init)
        selected_dayPicker = Int(dateArr[0]) > 15 ? 16 : 1
        selected_monthPicker = Int(dateArr[1])!
        selected_yearPickker = Int(dateArr[2])! + 543
        current_datePicker = String(selected_dayPicker) + "/" + String(selected_monthPicker) + "/" + String(selected_yearPickker)
        
        refresh_wsGetDiscuss()
        self.setupPickerView_dateDiscuss()
        self.view.addSubview(functions.loadAds())
    }

    override func viewWillAppear(animated: Bool) {
        if(isAddNewDiscuss){
            refresh_wsGetDiscuss()
            isAddNewDiscuss = false
        }
    }
    
    func setupPickerView_dateDiscuss(){
        uiPickerView_dateDiscuss.hidden = true
        var pickerProvider: PickerViewDateProvider = PickerViewDateProvider()
        pickerProvider.GetPickerViewDate_arr(true)
        yearList = pickerProvider.yearList
        monthList = pickerProvider.monthList
        dayList = pickerProvider.dayList
        uiPickerView_dateDiscuss.reloadAllComponents()
        
        uiPickerView_dateDiscuss.selectRow(selected_dayPicker == 1 ? 0 : 1, inComponent: 0, animated: true)
        uiPickerView_dateDiscuss.selectRow(selected_monthPicker-1, inComponent: 1, animated: true)
        
        var index = yearList.indexOf({$0 == String(selected_yearPickker)})!
        uiPickerView_dateDiscuss.selectRow(index, inComponent: 2, animated: true)
    }
    
    func refresh_wsGetDiscuss(){
        self.refreshControl.endRefreshing()
        self.refreshControl.beginRefreshing()
        self.navigationItem.titleView = DrawNavigationTitleProvider.setTitle("พูดคุย", subtitle: "กำลังโหลดข้อมูลใหม่")
        Ws_Discuss.GetDiscussList(current_datePicker, user_id: 1) { (responseData, errorMessage) in
            dispatch_async(dispatch_get_main_queue(), {
                self.wsDiscussPeriod = responseData
                self.wsDiscussList = responseData.discussList
                self.navigateBar_bottom.topItem?.title = self.wsDiscussPeriod.discuss_period_date_thaiName
                self.tableView_.reloadData()
                self.refreshControl.endRefreshing()
                self.navigationItem.titleView = DrawNavigationTitleProvider.setTitle("พูดคุย", subtitle: "ข้อมูลล่าสุด")
                if (self.isChangePickerDate){
                    var scrollHeight = self.tableView_.contentSize.height
                    self.tableView_.contentSize = CGSize(
                        width: self.WIDTH,
                        height: scrollHeight+207)
                }
            })
        }
    }
    
    @IBAction func btn_datePicker_discuss_date(sender: AnyObject) {
        var scrollHeight = tableView_.bounds.height
        if (uiPickerView_dateDiscuss.hidden == true){
            uiPickerView_dateDiscuss.hidden = false
            
            //tableView_.contentInset = UIEdgeInsetsMake(300, 0.0, 0.0, 0.0)
            tableView_.frame = CGRect(x: 0, y: 250, width: WIDTH, height: HEIGHT)
            
//            var contentInset:UIEdgeInsets = tableView_.contentInset
//            contentInset.top = 200
//            tableView_.contentInset = contentInset
            
        }
        else{
//            tableView_.contentInset = UIEdgeInsetsMake(0, 0.0, 0.0, 0.0)
            tableView_.frame = CGRect(x: 0, y: 107, width: WIDTH, height: HEIGHT)
            
//            let contentInset:UIEdgeInsets = UIEdgeInsetsZero
//            tableView_.contentInset = contentInset
            
            current_datePicker = String(selected_dayPicker) + "/" + String(selected_monthPicker) + "/" + String(selected_yearPickker)
            
            
            isChangePickerDate = true
            uiPickerView_dateDiscuss.hidden = true
            refresh_wsGetDiscuss()
            
            
        }
        
    }
    
    @IBAction func btn_go_AddNewDiscuss_controller(sender: AnyObject) {
        isAddNewDiscuss = true
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DiscussAdd_Storyboard_id") as! DiscussAddViewController
        vc.wsPeriod_lottery_date = wsDiscussPeriod.discuss_period_date
        vc.discuss_period_date_thaiName = wsDiscussPeriod.discuss_period_date_thaiName

        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wsDiscussList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("DiscussIndex_Cell", forIndexPath:  indexPath) as! DiscussTableViewCell
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 218/255, green: 226/255, blue: 237/255, alpha: 1.0).CGColor
        
        var wsDiscuss: mDiscuss = wsDiscussList[indexPath.row]
        
        cell.Time_Label.text = wsDiscuss.create_datetime;
        cell.Numbers_Label.text = wsDiscuss.numbers
        cell.Message_Label.text = wsDiscuss.message
        cell.DiscussName_Label.text = wsDiscuss.user_name
        //cell.DiscussComment_Button.addTarget(self, action: "btn_pushTosee_DiscussReply", forControlEvents: .TouchUpInside)
        cell.DiscussComment_Button.addTarget(self, action: #selector(btn_pushTosee_DiscussReply), forControlEvents: .TouchUpInside)
        cell.DiscussComment_Button.setTitle(String(wsDiscuss.number_comment), forState: .Normal)
        //cell.DiscussLike_Button.addTarget(self, action: "btn_pressLikeDiscuss", forControlEvents: .TouchUpInside)
        cell.DiscussLike_Button.addTarget(self, action: #selector(btn_pressLikeDiscuss), forControlEvents: .TouchUpInside)
        cell.DiscussLike_Button.setTitle(String(wsDiscuss.number_like), forState: .Normal)
        cell.DiscussComment_Button.tag = wsDiscuss.discuss_id
        cell.DiscussLike_Button.tag = wsDiscuss.discuss_id
        
        if (wsDiscuss.isLike == true){
            cell.DiscussLike_Button.setImage(UIImage(named: "icon_like")!, forState: .Normal)
            cell.DiscussLike_Button.setTitleColor(UIColor(red: 238/255, green: 166/255, blue: 52/255, alpha: 1.0), forState: .Normal)
        }
        
        return cell
    }
    
    //Delegate methods for AdBannerView
    
    func btn_pressLikeDiscuss(sender: AnyObject){
        var discussID_tag:Int = (sender.tag)
        var isLike: Bool = false
        var currentNumLike: Int = 0
        var index_arr: Int = 0
        for var i = 0; i < wsDiscussList.count; i += 1 {
            if (wsDiscussList[i].discuss_id == discussID_tag){
                isLike = wsDiscussList[i].isLike
                currentNumLike = wsDiscussList[i].number_like
                wsDiscussList[i].isLike = (isLike ? false : true) // update value
                index_arr = i
                break
            }
        }
        
        if (isLike){ // go to unlike
            currentNumLike -= 1
            wsDiscussList[index_arr].number_like = currentNumLike
            Ws_Discuss.UnLikeDiscuss(0, discuss_id: discussID_tag) { (responseData, errorMessage) in

                dispatch_async(dispatch_get_main_queue(), {
                    //tableView_.cellForRowAtIndexPath(0).setImage
                    sender.setImage(UIImage(named: "icon_unlike")!, forState: .Normal)
                    sender.setTitleColor(UIColor(red: 120/255, green: 127/255, blue: 143/255, alpha: 1.0), forState: .Normal)
                    sender.setTitle(String(currentNumLike), forState: .Normal)
                })
                
            }
        }
        else{ // go to like
            currentNumLike += 1
            wsDiscussList[index_arr].number_like = currentNumLike
            Ws_Discuss.LikeDiscuss(0, discuss_id: discussID_tag) { (responseData, errorMessage) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    sender.setImage(UIImage(named: "icon_like")!, forState: .Normal)
                    sender.setTitleColor(UIColor(red: 238/255, green: 166/255, blue: 52/255, alpha: 1.0), forState: .Normal)
                    sender.setTitle(String(currentNumLike), forState: .Normal)
                })
                
            }
            
        }
        
    }
    
    func btn_pushTosee_DiscussReply(sender: UIButton){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DiscussDetail_Storyboard_id") as! DiscussDetailsViewController
        var discussID_tag:Int = Int(sender.tag)
        vc.discuss_id_tag = discussID_tag
        var index = wsDiscussList.indexOf({$0.discuss_id == discussID_tag})
        vc.wsDiscuss = wsDiscussList[index!]
        vc.discuss_period_date_thaiName = wsDiscussPeriod.discuss_period_date_thaiName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 3
    }
    
    // How many rows are there is each component
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        //return monthList.count
        if (component == 2) {
            return yearList.count
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
        
        if (component == 2) {
            selected_yearPickker = Int(yearList[row])!
        }
        else if (component == 1)  {
            selected_monthPicker = row+1
        }
        else if (component == 0)  {
            selected_dayPicker = Int(dayList[row])!
        }
        
    }
    
}
