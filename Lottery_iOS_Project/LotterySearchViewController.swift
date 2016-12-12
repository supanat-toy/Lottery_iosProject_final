//
//  LotterySearchViewController.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/31/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class LotterySearchViewController: UIViewController {

    let WIDTH = UIScreen.mainScreen().bounds.width
    let HEIGHT = UIScreen.mainScreen().bounds.height
    var textInput = UITextField(frame: CGRect(x: 0, y: 0, width:0, height: 0))
    
    @IBOutlet weak var navigateBar_bottom: UINavigationBar!
    //var isFoundNumbers: Bool!
    //var lotteryPrizeNumber: mLotteryPrizeNumber!
    var numbers_search: String!
    var wsLotteryPeriod: mLotteryPeriod!
    var wsLottery:mLottery!
    func tap(gesture: UITapGestureRecognizer) {
        textInput.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wsLottery = wsLotteryPeriod.lottery
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGesture)
        self.title = "ค้นหา"
        self.navigateBar_bottom.topItem?.title = wsLotteryPeriod.lottery_period_date_thaiName
        drawViewSearchLottery()
        SearchResult_numbers()
        
    }

    func SearchResult_numbers(){
        var correctLottery:mLotteryPrizeNumber = mLotteryPrizeNumber()
        var isFound: Bool!
        if (wsLottery.prize_1st.numbers == numbers_search){
            isFound = true;
            correctLottery = wsLottery.prize_1st
        }
        else if (wsLottery.prize_2nd.indexOf({$0.numbers == numbers_search}) != nil){
            isFound = true;
            var index = wsLottery.prize_2nd.indexOf({$0.numbers == numbers_search})
            correctLottery = wsLottery.prize_2nd[index!]
        }
        else if (wsLottery.prize_nearby_1st.indexOf({$0.numbers == numbers_search}) != nil){
            isFound = true;
            var index = wsLottery.prize_nearby_1st.indexOf({$0.numbers == numbers_search})
            print(index)
            correctLottery = wsLottery.prize_nearby_1st[index!]
        }
        else if (wsLottery.prize_3rd.indexOf({$0.numbers == numbers_search}) != nil){
            isFound = true;
            var index = wsLottery.prize_3rd.indexOf({$0.numbers == numbers_search})
            correctLottery = wsLottery.prize_3rd[index!]
        }
        
        else if (wsLottery.prize_4th.indexOf({$0.numbers == numbers_search}) != nil){
            isFound = true;
            var index = wsLottery.prize_4th.indexOf({$0.numbers == numbers_search})
            correctLottery = wsLottery.prize_4th[index!]
        }
        else if (wsLottery.prize_5th.indexOf({$0.numbers == numbers_search}) != nil){
            isFound = true;
            var index = wsLottery.prize_5th.indexOf({$0.numbers == numbers_search})
            correctLottery = wsLottery.prize_5th[index!]
        }  
        else if (wsLottery.prize_3front.indexOf({$0.numbers == numbers_search}) != nil){
            isFound = true;
            var index = wsLottery.prize_3front.indexOf({$0.numbers == numbers_search})
            correctLottery = wsLottery.prize_3front[index!]
        }
        else if (wsLottery.prize_3rear.indexOf({$0.numbers == numbers_search}) != nil){
            isFound = true;
            var index = wsLottery.prize_3rear.indexOf({$0.numbers == numbers_search})
            correctLottery = wsLottery.prize_3rear[index!]
        }
        else if (wsLottery.prize_2rear.numbers == numbers_search){
            isFound = true;
            correctLottery = wsLottery.prize_2rear
        }
        else {
            isFound = false;
            correctLottery.prize_baht_string = "0"
            correctLottery.prize_name = "ไม่พบ"
        }
        
        var UI_searchResult = drawSearchResult(correctLottery.prize_name, numbers: numbers_search, date: wsLotteryPeriod.lottery_period_date_thaiName, amountPrizeBaht: correctLottery.prize_baht_string)
        
        self.view.addSubview(UI_searchResult)
    }
    
    func drawViewSearchLottery(){
        let view_ = UIView(frame: CGRect(x: 0, y: 120, width: WIDTH-20, height: 60))
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
        
        self.view.addSubview(view_)
    }
    
    func btn_search_lottery_action(){
        numbers_search = textInput.text
        SearchResult_numbers()
    }
    
    func drawSearchResult(namePrize: String, numbers:String, date:String, amountPrizeBaht:String) -> UIView{
        let view = UIView(frame: CGRect(x: 10, y: 175, width: WIDTH-20, height: 180))
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.41).CGColor
        
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        
        let v_WIDTH = view.bounds.width
        //let v_HEIGHT = view.bounds.height
        
        var label = UILabel(frame: CGRect(x: 15, y: 10, width: v_WIDTH-30, height: 30))
        label.textAlignment = .Left
        label.font = UIFont.systemFontOfSize(16)
        label.text = namePrize
        view.addSubview(label)
        
        label = UILabel(frame: CGRect(x: 15, y: 55, width: v_WIDTH-30, height: 60))
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(50)
        label.text = numbers
        view.addSubview(label)
        
        var view_bar_number = UIView(frame: CGRect(x: 15, y: 135, width: v_WIDTH-30, height: 1))
        view_bar_number.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        view.addSubview(view_bar_number)
        
        label = UILabel(frame: CGRect(x: 15, y: 141, width: v_WIDTH/2, height: 30))
        label.textAlignment = .Left
        label.font = UIFont.systemFontOfSize(16)
        label.text = date
        view.addSubview(label)
        
        label = UILabel(frame: CGRect(x: v_WIDTH/2-15, y: 141, width: v_WIDTH/2, height: 30))
        label.textAlignment = .Right
        label.font = UIFont.systemFontOfSize(18)
        label.text = amountPrizeBaht +  " บาท"
        label.textColor = UIColor(red: 86/255, green: 179/255, blue: 93/255, alpha: 1.0)
        view.addSubview(label)
        
        return view
    }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
