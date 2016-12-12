//
//  LotteryUserViewController.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 11/30/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class RegularViewCell: UITableViewCell{

    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var textTitleLabel: UILabel!
}

class UISwitchViewCell: UITableViewCell{
    
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var textTitleLabel: UILabel!
    @IBOutlet var theSwitch: UISwitch!
}

class LotteryUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    let WIDTH = UIScreen.mainScreen().bounds.width
    let HEIGHT = UIScreen.mainScreen().bounds.height
    
    var userID:Int!
    var userEmail:String!
    var userPassword:String!
    var userName:String!
    var userBirthday:String!
    var userGender:String!
    var acceptCheckingNotification:Bool!
    var acceptLotteryNotification:Bool!
    
    let titleList = ["ข้อมูลสมาชิก","แจ้งเตือน","ระบบ"]
    
    let memberImageList = ["Circled User Male", "Lock 2", "Book Stack"]
    let switchImageList = ["View File", "Appointment Reminders"]
    let otherImageList = ["Rating", "ID Card", "Exit"]
    
    var memberLabelList : [String] = []
    let switchLabelList = ["แจ้งตรวจสอบ", "แจ้งลอตเตอรี่"]
    let otherLabelList = ["ให้ดาว","ติดต่อ","ออกจากระบบ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem .setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
        
        memberLabelList.append(userName)
        memberLabelList.append("เปลี่ยนรหัสผ่าน")
        memberLabelList.append("ลอตเตอรี่ของฉัน")
        
        //self.navigationController?.popViewControllerAnimated(false)
        //self.navigationController?.popToRootViewControllerAnimated(false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return titleList[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var number: Int = 0
        switch(section){
        
        case 0:
            number = 3
            break
        case 1:
            number = 2
            break
        case 2:
            number = 3
            break
        default:
            break
        }
        return number
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        //cell = tableView.dequeueReusableCellWithIdentifier("peanut")
        
        switch(indexPath.section){
        
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("regularCell", forIndexPath: indexPath) as! RegularViewCell
            cell.iconImage.image = UIImage(named: memberImageList[indexPath.row])
            cell.textTitleLabel.text = memberLabelList[indexPath.row]
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("switchCell", forIndexPath: indexPath) as! UISwitchViewCell
            cell.iconImage.image = UIImage(named: switchImageList[indexPath.row])
            cell.textTitleLabel.text = switchLabelList[indexPath.row]
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("regularCell", forIndexPath: indexPath) as! RegularViewCell
            cell.iconImage.image = UIImage(named: otherImageList[indexPath.row])
            cell.textTitleLabel.text = otherLabelList[indexPath.row]
            return cell
            
        default:
            break
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch(indexPath.section){
        case 0:
            //tableView.allowsSelection = true
            if(indexPath.row == 0){
                let vs = self.storyboard?.instantiateViewControllerWithIdentifier("personalInfo") as! PersonalViewController
                
                vs.name = userName
                vs.birthday = userBirthday
                vs.gender = userGender
                
//                vs.checkingNotification = acceptCheckingNotification
//                vs.lotteryNotification = acceptLotteryNotification
                vs.password = userPassword
                vs.ID = userID
                vs.email = userEmail
                
                self.navigationController?.pushViewController(vs, animated: true)
            }
            if(indexPath.row == 1){
                let vs = self.storyboard?.instantiateViewControllerWithIdentifier("changePassword") as! ChangePasswordViewController
                
                vs.currentPassword = userPassword
                
                vs.name = userName
                vs.ID = userID
                vs.email = userEmail
                vs.gender = userGender
                vs.birthday = userBirthday
                
                self.navigationController?.pushViewController(vs, animated: true)
            }
            if(indexPath.row == 2){
                //print("peanut")//go to lottery list of the user
                let vs = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryList") as! LotteryListViewController
                
                vs.userID = userID
                self.navigationController?.pushViewController(vs, animated: true)
            }
            break
            
        case 1:
            //tableView.allowsSelection = false
            
            break
        case 2:
            //tableView.allowsSelection = true
            if(indexPath.row == 0){
            
            }
            if(indexPath.row == 1){
            
            }
            if(indexPath.row == 2){
                self.navigationController?.popViewControllerAnimated(true)
            }
            break
        default:
            //tableView.allowsSelection = true
            break
        }
    }
}
