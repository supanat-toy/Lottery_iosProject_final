//
//  DrawLottery.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 12/10/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class DrawLotteryProvider: UIViewController {
    
    let WIDTH = UIScreen.mainScreen().bounds.width
    let HEIGHT = UIScreen.mainScreen().bounds.height
    
    func draw_lottery_prize_1st(prize_1st: mLotteryPrizeNumber) -> UIView{
        let view = UIView(frame: CGRect(x: 10, y: 65, width: WIDTH-20, height: 60))
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.41).CGColor
        
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        
        let v_WIDTH = view.bounds.width
        //let v_HEIGHT = view.bounds.height
        
        var title_Label = UILabel(frame: CGRect(x: 15, y: 15, width: v_WIDTH/2, height: 30))
        title_Label.textAlignment = .Left
        title_Label.font = UIFont.systemFontOfSize(16)
        title_Label.text = prize_1st.prize_name
        view.addSubview(title_Label)
        
        title_Label = UILabel(frame: CGRect(x: v_WIDTH/2, y: 15, width: v_WIDTH/2-15, height: 30))
        title_Label.textAlignment = .Right
        title_Label.font = UIFont.systemFontOfSize(34)
        
        title_Label.text = prize_1st.numbers
        view.addSubview(title_Label)
        
        return view
    }
    
    func draw_lottery_prize_2rear(prize_2rear: mLotteryPrizeNumber) -> UIView{
        let view = UIView(frame: CGRect(x: 10, y: 135, width: WIDTH-20, height: 60))
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.41).CGColor
        
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        
        let v_WIDTH = view.bounds.width
        //let v_HEIGHT = view.bounds.height
        
        var title_Label = UILabel(frame: CGRect(x: 15, y: 15, width: v_WIDTH/2, height: 30))
        title_Label.textAlignment = .Left
        title_Label.font = UIFont.systemFontOfSize(16)
        title_Label.text = prize_2rear.prize_name
        view.addSubview(title_Label)
        
        title_Label = UILabel(frame: CGRect(x: v_WIDTH/2, y: 15, width: v_WIDTH/2-15, height: 30))
        title_Label.textAlignment = .Right
        title_Label.font = UIFont.systemFontOfSize(24)
        
        title_Label.text = prize_2rear.numbers
        view.addSubview(title_Label)
        
        return view
    }
    
    func draw_lottery_prize_3front_rear(prize_3front: [mLotteryPrizeNumber], prize_3rear: [mLotteryPrizeNumber]) -> UIView{
        let view = UIView(frame: CGRect(x: 10, y: 205, width: WIDTH-20, height: 117))
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.41).CGColor
        
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        
        let v_WIDTH = view.bounds.width
        //let v_HEIGHT = view.bounds.height
        
        var title_Label = UILabel(frame: CGRect(x: 15, y: 15, width: v_WIDTH/2, height: 30))
        title_Label.textAlignment = .Left
        title_Label.font = UIFont.systemFontOfSize(16)
        title_Label.text = prize_3front[0].prize_name
        view.addSubview(title_Label)
        
        title_Label = UILabel(frame: CGRect(x: v_WIDTH/2, y: 15, width: v_WIDTH/2-15, height: 30))
        title_Label.textAlignment = .Right
        title_Label.font = UIFont.systemFontOfSize(24)
        
        title_Label.text = prize_3front[0].numbers + "  " + prize_3front[1].numbers
        view.addSubview(title_Label)
        
        //----
        
        let view_line = UIView(frame: CGRect(x: 15, y: 58, width: WIDTH-50, height: 2))
        view_line.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        view_line.layer.cornerRadius = 3
        view.addSubview(view_line)
        //----
        
        title_Label = UILabel(frame: CGRect(x: 15, y: 70, width: v_WIDTH/2, height: 30))
        title_Label.textAlignment = .Left
        title_Label.font = UIFont.systemFontOfSize(16)
        title_Label.text = prize_3rear[0].prize_name
        view.addSubview(title_Label)
        
        title_Label = UILabel(frame: CGRect(x: v_WIDTH/2, y: 70, width: v_WIDTH/2-15, height: 30))
        title_Label.textAlignment = .Right
        title_Label.font = UIFont.systemFontOfSize(24)
        
        title_Label.text = prize_3rear[0].numbers + "  " + prize_3rear[1].numbers
        view.addSubview(title_Label)
        
        return view
    }
    
    func draw_lottery_prize_2nd(prize_2nd: [mLotteryPrizeNumber]) -> UIView{
        let view = UIView(frame: CGRect(x: 10, y: 281, width: WIDTH-20, height: 122))
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.41).CGColor
        
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        
        let v_WIDTH = view.bounds.width
        
        var title_Label = UILabel(frame: CGRect(x: 15, y: 12, width: v_WIDTH, height: 30))
        title_Label.textAlignment = .Left
        title_Label.font = UIFont.systemFontOfSize(16)
        title_Label.text = "รางวัลที่ 2"
        view.addSubview(title_Label)
        
        
        var count_x = 0
        for var i = 0; i < prize_2nd.count; i += 1 {
            
            var plus_x = CGFloat(count_x)
            var plus_y = CGFloat(35*(i/4))
            
            var position_x = (v_WIDTH/4)*plus_x+15
            var position_y = 45 + plus_y
            
            title_Label = UILabel(frame: CGRect(x: position_x, y: position_y , width: v_WIDTH/4, height: 30))
            title_Label.textAlignment = .Left
            title_Label.font = UIFont.systemFontOfSize(16)
            title_Label.text = prize_2nd[i].numbers
            view.addSubview(title_Label)
            
            count_x += 1
            if (count_x%4 == 0){
                count_x = 0
            }
        }
        return view
    }
    
    func draw_lottery_prize_3rd(prize_3rd: [mLotteryPrizeNumber]) -> UIView{
        let view = UIView(frame: CGRect(x: 10, y: 414, width: WIDTH-20, height: 153))
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.41).CGColor
        
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        
        let v_WIDTH = view.bounds.width
        
        var title_Label = UILabel(frame: CGRect(x: 15, y: 12, width: v_WIDTH, height: 30))
        title_Label.textAlignment = .Left
        title_Label.font = UIFont.systemFontOfSize(16)
        title_Label.text = "รางวัลที่ 3"
        view.addSubview(title_Label)
        
        
        var count_x = 0
        for var i = 0; i < prize_3rd.count; i += 1 {
            
            var plus_x = CGFloat(count_x)
            var plus_y = CGFloat(35*(i/4))
            
            var position_x = (v_WIDTH/4)*plus_x+15
            var position_y = 45 + plus_y
            
            title_Label = UILabel(frame: CGRect(x: position_x, y: position_y , width: v_WIDTH/4, height: 30))
            title_Label.textAlignment = .Left
            title_Label.font = UIFont.systemFontOfSize(16)
            title_Label.text = prize_3rd[i].numbers
            view.addSubview(title_Label)
            
            count_x += 1
            if (count_x%4 == 0){
                count_x = 0
            }
        }
        return view
    }
    
    
    func draw_lottery_bar_number(view: UIView, number: String) -> UIView{
        //let view = UIView(frame: CGRect(x: 10, y: 578, width: WIDTH-20, height: 503))
        
        
        return view
    }
    
    func draw_lottery_prize_4th(prize_4th: [mLotteryPrizeNumber]) -> UIView{
        var calculate_height_View:CGFloat = CGFloat(0)
        var view = UIView(frame: CGRect(x: 10, y: 578, width: WIDTH-20, height: 503))
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.41).CGColor
        
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        
        let v_WIDTH = view.bounds.width
        
        var title_Label = UILabel(frame: CGRect(x: 15, y: 12, width: v_WIDTH, height: 30))
        title_Label.textAlignment = .Left
        title_Label.font = UIFont.systemFontOfSize(16)
        title_Label.text = prize_4th[0].prize_name
        view.addSubview(title_Label)
        calculate_height_View += title_Label.bounds.height;
        
        var count_x = 0
        //var arr_lottery:[String] = lottery_arr()
        var position_y:CGFloat = CGFloat(45)
        var plus_y:CGFloat = CGFloat(32)
        
        var previous_number_first = "-1"
        for var i = 0; i < prize_4th.count; i += 1 {
            var current_number_first = prize_4th[i].numbers
            current_number_first = String(prize_4th[i].numbers[prize_4th[i].numbers.startIndex.advancedBy(0)])
            
            if (current_number_first != previous_number_first){
                if (previous_number_first != "-1"){
                    position_y += plus_y
                    calculate_height_View += plus_y
                }
                
                var view_bar_number = UIView(frame: CGRect(x: 0, y: position_y, width: WIDTH-20, height: 25))
                
                view_bar_number.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
                var title_Label = UILabel(frame: CGRect(x: 15, y: 0, width: v_WIDTH, height: 25))
                title_Label.textAlignment = .Left
                title_Label.font = UIFont.systemFontOfSize(16)
                title_Label.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                title_Label.text = current_number_first
                view_bar_number.addSubview(title_Label)
                view.addSubview(view_bar_number)
                
                count_x = 0
                position_y += plus_y
                calculate_height_View += plus_y
            }
            
            
            var plus_x = CGFloat(count_x)
            var position_x = (v_WIDTH/4)*plus_x+15
            
            
            
            
            title_Label = UILabel(frame: CGRect(x: position_x, y: position_y , width: v_WIDTH/4, height: 30))
            title_Label.textAlignment = .Left
            title_Label.font = UIFont.systemFontOfSize(16)
            title_Label.text = prize_4th[i].numbers
            view.addSubview(title_Label)
            
            count_x += 1
            
            
            if (count_x%4 == 0){
                count_x = 0
                position_y += plus_y
                calculate_height_View += plus_y
            }
            
            previous_number_first = current_number_first
        }
        view.frame = CGRect(x: 10, y: 578, width: WIDTH-20, height: calculate_height_View+57)
        return view
    }
    
    func draw_lottery_prize_5th(prize_5th: [mLotteryPrizeNumber], view_prize_4th_height: CGFloat) -> UIView{
        var calculate_height_View:CGFloat = CGFloat(0)
        var view = UIView(frame: CGRect(x: 10,
            y: (1000),
            width: WIDTH-20,
            height: 503))
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.41).CGColor
        
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        
        let v_WIDTH = view.bounds.width
        
        var title_Label = UILabel(frame: CGRect(x: 15, y: 12, width: v_WIDTH, height: 30))
        title_Label.textAlignment = .Left
        title_Label.font = UIFont.systemFontOfSize(16)
        title_Label.text = prize_5th[0].prize_name
        view.addSubview(title_Label)
        calculate_height_View += title_Label.bounds.height;
        
        var count_x = 0
        //var arr_lottery:[String] = lottery_arr()
        var position_y:CGFloat = CGFloat(45)
        var plus_y:CGFloat = CGFloat(32)
        
        var previous_number_first = "-1"
        for var i = 0; i < prize_5th.count; i += 1 {
            var current_number_first = prize_5th[i].numbers
            current_number_first = String(prize_5th[i].numbers[prize_5th[i].numbers.startIndex.advancedBy(0)])
            
            if (current_number_first != previous_number_first){
                if (previous_number_first != "-1"){
                    position_y += plus_y
                    calculate_height_View += plus_y
                }
                
                var view_bar_number = UIView(frame: CGRect(x: 0, y: position_y, width: WIDTH-20, height: 25))
                
                view_bar_number.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
                var title_Label = UILabel(frame: CGRect(x: 15, y: 0, width: v_WIDTH, height: 25))
                title_Label.textAlignment = .Left
                title_Label.font = UIFont.systemFontOfSize(16)
                title_Label.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                title_Label.text = current_number_first
                view_bar_number.addSubview(title_Label)
                view.addSubview(view_bar_number)
                
                count_x = 0
                position_y += plus_y
                calculate_height_View += plus_y
            }
            
            
            var plus_x = CGFloat(count_x)
            var position_x = (v_WIDTH/4)*plus_x+15
            
            
            
            
            title_Label = UILabel(frame: CGRect(x: position_x, y: position_y , width: v_WIDTH/4, height: 30))
            title_Label.textAlignment = .Left
            title_Label.font = UIFont.systemFontOfSize(16)
            title_Label.text = prize_5th[i].numbers
            view.addSubview(title_Label)
            
            count_x += 1
            
            
            if (count_x%4 == 0 && count_x != 1){
                count_x = 0
                position_y += plus_y
                calculate_height_View += plus_y
            }
            
            previous_number_first = current_number_first
        }
        view.frame = CGRect(x: 10,
                            y: 578 + view_prize_4th_height + 10,
                            width: WIDTH-20,
                            height: calculate_height_View+57)
        return view
    }
}
