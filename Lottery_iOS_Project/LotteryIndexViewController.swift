//
//  LotteryIndexViewController.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/30/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit
import iAd

class LotteryIndexViewController: UIViewController, ADBannerViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    // day month year
    @IBOutlet weak var uiPickerView_dateLottery: UIPickerView!
    var yearList: [String] = []
    var monthList: [String] = []
    var dayList: [String] = []
    var selected_dayPicker: Int = 0
    var selected_monthPicker: Int = 0
    var selected_yearPickker: Int = 0
    
    
    @IBOutlet weak var scrollView_Lottery1: UIScrollView!
    
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    let WIDTH = UIScreen.mainScreen().bounds.width
    let HEIGHT = UIScreen.mainScreen().bounds.height
    //var datePicker_lotteryDate = UIPickerView()
    @IBOutlet weak var navigateBar_bottom: UINavigationBar!
    //var scrollView_Lottery: UIScrollView!
    let alertMessage = UIAlertView()
    var textInput = UITextField(frame: CGRect(x: 0, y: 0, width:0, height: 0))
    var isFirstPerioid_SaveLottery_CoreData = true
    var current_datePicker: String = ""
    var subTitle_navigationBar: String = ""
    
    func tap(gesture: UITapGestureRecognizer) {
        textInput.resignFirstResponder()
    }
    
    var wsLotteryPeriod: mLotteryPeriod!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl.beginRefreshing()
        
        
        
        uiPickerView_dateLottery.dataSource = self;
        uiPickerView_dateLottery.delegate = self;
        
        //scrollView_Lottery = UIScrollView(frame: CGRectMake( 0, 110, WIDTH, HEIGHT-210))
        //scrollView_Lottery1.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: "refresh_wsGetLottery", forControlEvents: .ValueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGesture)
        
        scrollView_Lottery1.addSubview(refreshControl)
        
        refreshControl.beginRefreshing()
        
        var functions = FunctionsProvider()
        let dateNow:String = (functions.GetDateNow() as? String)!
        
        let dateArr = dateNow.characters.split{$0 == "/"}.map(String.init)
        selected_dayPicker = Int(dateArr[0]) > 15 ? 16 : 1
        selected_monthPicker = Int(dateArr[1])!
        selected_yearPickker = Int(dateArr[2])! + 543
        current_datePicker = String(selected_dayPicker) + "/" + String(selected_monthPicker) + "/" + String(selected_yearPickker)
        
        
        self.setupPickerView_dateLottery()
        self.view.addSubview(functions.loadAds())
        
        var ip:InternetProvider = InternetProvider()
        if (InternetProvider.isInternetAvailable()){
            refresh_wsGetLottery()
        }
        else {
            CoreData_Lottery.GetLottery("") { (responseData, errorMessage) in
                self.wsLotteryPeriod = responseData
                self.navigationItem.titleView = DrawNavigationTitleProvider.setTitle("ล็อตเตอรี่", subtitle: responseData.last_update_dateTime)
                self.subTitle_navigationBar = responseData.last_update_dateTime
            }
        }
        
        
        
    }

    
    func setupPickerView_dateLottery(){
        uiPickerView_dateLottery.hidden = true
        var pickerProvider: PickerViewDateProvider = PickerViewDateProvider()
        pickerProvider.GetPickerViewDate_arr(true)
        yearList = pickerProvider.yearList
        monthList = pickerProvider.monthList
        dayList = pickerProvider.dayList
        uiPickerView_dateLottery.reloadAllComponents()
        
        uiPickerView_dateLottery.selectRow(selected_dayPicker == 1 ? 0 : 1, inComponent: 0, animated: true)
        uiPickerView_dateLottery.selectRow(selected_monthPicker-1, inComponent: 1, animated: true)
        
        var index = yearList.indexOf({$0 == String(selected_yearPickker)})!
        uiPickerView_dateLottery.selectRow(index, inComponent: 2, animated: true)
        
        
        self.isFirstPerioid_SaveLottery_CoreData = false
    }
    
    
    func refresh_wsGetLottery(){
        self.refreshControl.endRefreshing()
        self.refreshControl.beginRefreshing()
        
        self.navigationItem.titleView = DrawNavigationTitleProvider.setTitle("ล็อตเตอรี่", subtitle: "กำลังโหลดข้อมูลใหม่")
        Ws_Lottery.GetLottery(current_datePicker) { (responseData, errorMessage) in
            dispatch_async(dispatch_get_main_queue(), {
                for view in self.scrollView_Lottery1.subviews {
                    view.removeFromSuperview()
                }
                self.scrollView_Lottery1.addSubview(self.refreshControl)
                self.wsLotteryPeriod = responseData
                
                self.drawViewLottery(self.wsLotteryPeriod.lottery)
                self.navigateBar_bottom.topItem?.title = self.wsLotteryPeriod.lottery_period_date_thaiName
                self.refreshControl.endRefreshing()
                self.navigationItem.titleView = DrawNavigationTitleProvider.setTitle("ล็อตเตอรี่", subtitle: "ข้อมูลล่าสุด")
                self.subTitle_navigationBar = "ข้อมูลล่าสุด"
                
                if (self.isFirstPerioid_SaveLottery_CoreData){
                    CoreData_Lottery.SaveLottery_CoreData(responseData)
                }
            })
        }
    }
    
    
    @IBAction func btn_datePicker_lottery_date(sender: AnyObject) {
        var scrollHeight = scrollView_Lottery1.bounds.height
        if (uiPickerView_dateLottery.hidden == true){
            uiPickerView_dateLottery.hidden = false
            
            //scrollView_Lottery1.contentInset = UIEdgeInsetsMake(165, 0.0, 0.0, 0.0)
            scrollView_Lottery1.frame = CGRect(x: 0, y: 250, width: WIDTH, height: scrollHeight+175)
        }
        else{
            //scrollView_Lottery1.contentInset = UIEdgeInsetsMake(0, 0.0, 0.0, 0.0)
            scrollView_Lottery1.frame = CGRect(x: 0, y: 110, width: WIDTH, height: scrollHeight)
            
            current_datePicker = String(selected_dayPicker) + "/" + String(selected_monthPicker) + "/" + String(selected_yearPickker)
            refresh_wsGetLottery()

            uiPickerView_dateLottery.hidden = true
        }
    }
    
    
    @IBAction func btn_push_pdfController(sender: AnyObject) {
        if (self.wsLotteryPeriod == nil || self.wsLotteryPeriod.file_url_pdf == ""){
            self.alertMessage.title = "ไม่พบ pdf ไฟล์"
            self.alertMessage.message = "โปรดรอสักครู่"
            self.alertMessage.addButtonWithTitle("OK")
            self.alertMessage.show()
        }
        else
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryPDF_StoryBoard_id") as! LotteryPDFViewController
            vc.urlString = self.wsLotteryPeriod.file_url_pdf
            vc.lottery_period_date_thaiName = self.wsLotteryPeriod.lottery_period_date_thaiName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func drawViewSearchLottery() -> UIView{
        let view_ = UIView(frame: CGRect(x: 0, y: 15, width: WIDTH-20, height: 60))
        view_.backgroundColor = UIColor(red: 249/255, green: 251/255, blue: 255/255, alpha: 1.0)
        
        let v_WIDTH = view.bounds.width
        textInput = UITextField(frame: CGRect(x: 10, y: 0, width: v_WIDTH-20, height: 40))
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, 40))
        textInput.leftView = paddingView
        textInput.leftViewMode = UITextFieldViewMode.Always
        textInput.textAlignment = .Left
        textInput.font = UIFont.systemFontOfSize(16)
        textInput.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        textInput.layer.borderWidth = 1
        textInput.layer.borderColor = UIColor(red: 218/255, green: 226/255, blue: 237/255, alpha: 1.0).CGColor
        
        textInput.keyboardType = UIKeyboardType.NumberPad
        textInput.placeholder = "เลขลอตเตอรี่ 6 ตัว"
        view_.addSubview(textInput)
        
        var btn_search = UIButton(frame: CGRect(x: WIDTH-60, y: 0, width: 50, height: 40))
        btn_search.backgroundColor = UIColor(red: 255/255, green: 198/255, blue: 34/255, alpha: 1.0)
        btn_search.addTarget(self, action: #selector(btn_search_lottery_action), forControlEvents: .TouchUpInside)
        btn_search.setImage(UIImage(named: "icon_search"), forState: UIControlState.Normal)
        btn_search.imageEdgeInsets = UIEdgeInsetsMake(10,15,10,15)
        view_.addSubview(btn_search)
        
        //self.view.addSubview(view_)
        return view_
    }
    
    func btn_search_lottery_action(){
        var textSearch: String = textInput.text!
        if (textSearch == ""){
            self.alertMessage.title = "ค้นหาผิดพลาด"
            self.alertMessage.message = "โปรดตรวจสอบเลขค้นหาอีกครั้ง"
            self.alertMessage.addButtonWithTitle("OK")
            self.alertMessage.show()
        }
        else {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LotterySearch_Storyboard_id") as! LotterySearchViewController
            
            vc.numbers_search = textSearch
            vc.wsLotteryPeriod = wsLotteryPeriod
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func drawViewLottery(wsLottery: mLottery){
        //scrollView_Lottery = UIScrollView(frame: CGRectMake( 0, 110, WIDTH, HEIGHT+200)) // y = -64
        scrollView_Lottery1.backgroundColor = UIColor(red: 249/255, green: 251/255, blue: 255/255, alpha: 1.0)
        var scrollHeight = scrollView_Lottery1.bounds.height
        

        var drawLotteyProvider = DrawLotteryProvider()
        
        let view_prize_1st:UIView = drawLotteyProvider.draw_lottery_prize_1st(wsLottery.prize_1st)
        let view_prize_2rear:UIView = drawLotteyProvider.draw_lottery_prize_2rear(wsLottery.prize_2rear)
        let view_prize_3front_rear:UIView = drawLotteyProvider.draw_lottery_prize_3front_rear(wsLottery.prize_3front, prize_3rear: wsLottery.prize_3rear)
        let button_see_more:UIView = draw_button_see_more()
        var view_search:UIView = drawViewSearchLottery()
        scrollView_Lottery1.addSubview(view_search)
        scrollView_Lottery1.addSubview(view_prize_1st)
        scrollView_Lottery1.addSubview(view_prize_2rear)
        scrollView_Lottery1.addSubview(view_prize_3front_rear)
        scrollView_Lottery1.addSubview(button_see_more)
        
        scrollView_Lottery1.contentSize = CGSize(
            width: WIDTH,
            height: HEIGHT)
        scrollView_Lottery1.frame = CGRect(x: 0, y: 110, width: WIDTH, height: scrollHeight)
    }
    
    func draw_button_see_more() -> UIButton{
        let button = UIButton(frame: CGRect(x: 10, y: 330, width: WIDTH-20, height: 45))
        button.backgroundColor = UIColor(red: 255/255, green: 198/255, blue: 34/255, alpha: 1.0)
        button.layer.cornerRadius = 3
        
        button.addTarget(self, action: #selector(btn_changeTo_seeMore), forControlEvents: .TouchUpInside)
        button.setTitle("ดูเพิ่มเติม", forState: .Normal)
        button.tintColor = UIColor.whiteColor()
    
        return button
    }
    
    func btn_changeTo_seeMore(sender: UIButton){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryDetail_StoryBoard_id") as! LotteryDetailsViewController
        vc.wsLotteryPeriod = wsLotteryPeriod
        vc.current_datePicker = current_datePicker
        vc.isFirstPerioid_SaveLottery_CoreData = isFirstPerioid_SaveLottery_CoreData
        vc.subTitle_navigationBar = subTitle_navigationBar
        //vc.faculty_details = foodList[sender.tag] as! NSDictionary
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //------
    
    
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
    
    
    //------
    
    
}
