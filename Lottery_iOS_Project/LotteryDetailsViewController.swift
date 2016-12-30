//
//  LotteryDetailsViewController.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/30/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class LotteryDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    // datePicker
    var yearList: [String] = []
    var monthList: [String] = []
    var dayList: [String] = []
    var selected_dayPicker: Int = 0
    var selected_monthPicker: Int = 0
    var selected_yearPickker: Int = 0
    
    @IBOutlet weak var scrollView_Lottery1: UIScrollView!
    @IBOutlet weak var uiPickerView_dateLottery: UIPickerView!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    let WIDTH = UIScreen.mainScreen().bounds.width
    let HEIGHT = UIScreen.mainScreen().bounds.height
    var datePicker_lotteryDate = UIDatePicker()
    var view_prize_4th_height:CGFloat!
    var isChangePickerDate: Bool = false
    //var scrollView_Lottery: UIScrollView!
    var current_datePicker: String = ""
    var subTitle_navigationBar: String = ""
    @IBOutlet weak var navigateBar_bottom: UINavigationBar!
    var wsLotteryPeriod: mLotteryPeriod!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scrollView_Lottery = UIScrollView(frame: CGRectMake( 0, 109, WIDTH, HEIGHT)) // y = -64
        uiPickerView_dateLottery.dataSource = self;
        uiPickerView_dateLottery.delegate = self;
        scrollView_Lottery1.addSubview(refreshControl)
        self.navigationItem.titleView = DrawNavigationTitleProvider.setTitle("ลอตเตอรี่", subtitle: subTitle_navigationBar)
        drawViewLottery()
        datePicker_lotteryDate.hidden = true
        self.navigateBar_bottom.topItem?.title = wsLotteryPeriod.lottery_period_date_thaiName
        refreshControl.addTarget(self, action: "refresh_wsGetLottery", forControlEvents: .ValueChanged)
        
        
        
        let dateArr = current_datePicker.characters.split{$0 == "/"}.map(String.init)
        selected_dayPicker = Int(dateArr[0]) > 15 ? 16 : 1
        selected_monthPicker = Int(dateArr[1])!
        selected_yearPickker = Int(dateArr[2])!
        
        self.setupPickerView_dateLottery()
        
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
                
                self.drawViewLottery()
                self.navigateBar_bottom.topItem?.title = responseData.lottery_period_date_thaiName     
                self.refreshControl.endRefreshing()
                self.navigationItem.titleView = DrawNavigationTitleProvider.setTitle("ล็อตเตอรี่", subtitle: "ข้อมูลล่าสุด")
            })
        }
    }
    
    @IBAction func btn_datePicker_lottery_date(sender: AnyObject) {
        //var scrollHeight = scrollView_Lottery1.contentSize.height
        
        if (uiPickerView_dateLottery.hidden == true){
            uiPickerView_dateLottery.hidden = false
            
            //scrollView_Lottery1.contentInset = UIEdgeInsetsMake(150, 0.0, 0.0, 0.0)
            scrollView_Lottery1.frame = CGRect(x: 0, y: 250, width: WIDTH, height: HEIGHT)
        }
        else{
            //scrollView_Lottery1.contentInset = UIEdgeInsetsMake(0, 0.0, 0.0, 0.0)
            scrollView_Lottery1.frame = CGRect(x: 0, y: 110, width: WIDTH, height: HEIGHT)
        
            
            current_datePicker = String(selected_dayPicker) + "/" + String(selected_monthPicker) + "/" + String(selected_yearPickker)
            
            isChangePickerDate = true
            uiPickerView_dateLottery.hidden = true
            refresh_wsGetLottery()
            
            
        }
        
       
        
    }
    @IBAction func btn_push_pdf_controller(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryPDF_StoryBoard_id") as! LotteryPDFViewController
        vc.urlString = self.wsLotteryPeriod.file_url_pdf
        vc.lottery_period_date_thaiName = self.wsLotteryPeriod.lottery_period_date_thaiName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func drawViewLottery(){
        
        scrollView_Lottery1.backgroundColor = UIColor(red: 249/255, green: 251/255, blue: 255/255, alpha: 1.0)
        
        var wsLottery: mLottery = wsLotteryPeriod.lottery
        
        var drawLotteyProvider = DrawLotteryProvider()
        
        let view_prize_1st:UIView = drawLotteyProvider.draw_lottery_prize_1st(wsLottery.prize_1st)
        view_prize_1st.frame = CGRect(x: 10, y: 15, width: WIDTH-20, height: 60)
        
        let view_prize_2rear:UIView = drawLotteyProvider.draw_lottery_prize_2rear(wsLottery.prize_2rear)
        view_prize_2rear.frame = CGRect(x: 10, y: 85, width: WIDTH-20, height: 60)
        
        let view_prize_3front_rear:UIView = drawLotteyProvider.draw_lottery_prize_3front_rear(wsLottery.prize_3front, prize_3rear: wsLottery.prize_3rear)
        view_prize_3front_rear.frame = CGRect(x: 10, y: 155, width: WIDTH-20, height: 117)
        
        
        let view_prize_2nd:UIView = drawLotteyProvider.draw_lottery_prize_2nd(wsLottery.prize_2nd)
        let view_prize_3rd:UIView = drawLotteyProvider.draw_lottery_prize_3rd(wsLottery.prize_3rd)
        let view_prize_4th:UIView = drawLotteyProvider.draw_lottery_prize_4th(wsLottery.prize_4th)
        
        
            self.view_prize_4th_height = view_prize_4th.bounds.height
            let view_prize_5th:UIView = drawLotteyProvider.draw_lottery_prize_5th(wsLottery.prize_5th, view_prize_4th_height: view_prize_4th_height)
            scrollView_Lottery1.addSubview(view_prize_1st)
            scrollView_Lottery1.addSubview(view_prize_2rear)
            scrollView_Lottery1.addSubview(view_prize_3front_rear)
            scrollView_Lottery1.addSubview(view_prize_2nd)
            scrollView_Lottery1.addSubview(view_prize_3rd)
            scrollView_Lottery1.addSubview(view_prize_4th)
            scrollView_Lottery1.addSubview(view_prize_5th)
        
        
            var height_all_view:CGFloat = view_prize_1st.bounds.height + view_prize_2rear.bounds.height + view_prize_3front_rear.bounds.height + view_prize_2nd.bounds.height + view_prize_3rd.bounds.height + view_prize_4th.bounds.height + view_prize_5th.bounds.height
        
        if (isChangePickerDate){
            scrollView_Lottery1.contentSize = CGSize(
                width: self.WIDTH,
                height: height_all_view+250)
        }else{
            scrollView_Lottery1.contentSize = CGSize(
                width: self.WIDTH,
                height: height_all_view+90)
        }
        
        
        
    }
    
    
    
    func lottery_arr()-> [String] {
        var arr:[String] = ["123432","038640", "124114","253356","332818","466185",
            "533774","602068","705313","774142","868134",
            "053966","208006","272358","365636","467728",
            "553324","633244","739096","807824","870190",
            "065711","220308","288442","396239","482319",
            "562671","642311","744470","808930","926836",
            "092407","225962","300793","446083","499345",
            "573093","649356","759498","838930","931329",
            "115729","233464","308217","447326","528828",
            "583070","702530","764768","841544","960288",
            "028424","092381","142658","256195","386035",
            "502973","604498","735020","823846","887227",
            "031348","093720","153002","262187","386274",
            "506977","614282","754962","827108","893837",
            "032557","098994","171875","301038","428578",
            "519868","641756","757223","827366","933070",
            "033396","099519","175640","310496","447822",
            "532514","644404","761575","832870","970012",
            "041645","111823","181703","322856","452262",
            "561545","681601","763462","863809","979162",
            "061810","118177","182438","339855","458581",
            "567774","688401","782068","868565","996119"]
        
        arr = arr.sort(){$0 < $1}
        return arr
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
