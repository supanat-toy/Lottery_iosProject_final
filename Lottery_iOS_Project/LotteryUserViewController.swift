//
//  LotteryUserViewController.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 11/30/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit
import MessageUI

class RegularViewCell: UITableViewCell{

    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var textTitleLabel: UILabel!
}

class UISwitchViewCell: UITableViewCell{
    
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var textTitleLabel: UILabel!
    @IBOutlet var theSwitch: UISwitch!
}

class LotteryUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

    
    
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
    let otherLabelList = ["ให้ดาว","ติดต่อ","ออกจากระบบ"] //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem .setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
        self.title = userName
        memberLabelList.append(userName)
        memberLabelList.append("เปลี่ยนรหัสผ่าน")
        memberLabelList.append("ลอตเตอรี่ของฉัน")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchTrigger(sender: UISwitch){
        
        if(sender.tag == 0){
            Ws_User.UpdateCheckingNotification(userID, isAccepted: sender.on, completion: {(reponseData, errorMessage) -> Void in })
        }
        if(sender.tag == 1){
            Ws_User.UpdateGetNewLotteryNotification(userID, isAccepted: sender.on, completion: {(responseData,errorMessage) -> Void in})
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        mailComposeVC.setToRecipients(["ratversion2@msn.com"])
        mailComposeVC.setSubject("App Feedback")
        mailComposeVC.setMessageBody("Hi there!\n\nI would like to share the following feedback....", isHTML: false)
        
        return mailComposeVC
    }
    
    func showMailErrorAlert(){
        let sendMailErrorAlert = UIAlertView(title: "Could not send email", message: "Your device could not send email. Please check email configuration and then try again", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        //switch result.value {
        switch result.rawValue {
        
        //case MFMailComposeResultCancelled.value:
        case MFMailComposeResult.Cancelled.rawValue:
            print("Cancelled mail")
        //case MFMailComposeResultSent.value:
        case MFMailComposeResult.Sent.rawValue:
            print("Mail Sent")
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
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
            
            cell.theSwitch.tag = indexPath.row
            
            if(indexPath.row == 0){
                cell.theSwitch.setOn(acceptCheckingNotification, animated: false)
            }
            if(indexPath.row == 1){
                cell.theSwitch.setOn(acceptLotteryNotification, animated: false)
            }
            
            cell.theSwitch.addTarget(self, action: "switchTrigger:", forControlEvents: .ValueChanged)
            print ("the switch indexpath.row is" + String(indexPath.row))
            
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
            
            if(indexPath.row == 0){
                //go to personal view, change name, gender, birthday
                let vs = self.storyboard?.instantiateViewControllerWithIdentifier("personalInfo") as! PersonalViewController
                
                vs.name = userName
                vs.birthday = userBirthday
                vs.gender = userGender

                vs.password = userPassword
                vs.ID = userID
                vs.email = userEmail
                
                self.navigationController?.pushViewController(vs, animated: true)
            }
            if(indexPath.row == 1){
                //go to change password
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
                //go to lottery list of the user
                let vs = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryList") as! LotteryListViewController
                
                vs.userID = userID
                self.navigationController?.pushViewController(vs, animated: true)
            }
            break
            
        case 1:
            //notification
            if(indexPath.row==0){}
            if(indexPath.row==1){}
            
            break
            
        case 2:
            if(indexPath.row == 0){
                let alert = UIAlertController(title: "During Development", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)

            }
            if(indexPath.row == 1){
                
                let mailComposeViewController = configuredMailComposeViewController()
                if MFMailComposeViewController.canSendMail(){
                    self.presentViewController(mailComposeViewController, animated: true, completion: nil)
                }else{
                    self.showMailErrorAlert()
                }
            }
            if(indexPath.row == 2){
                let defaults = NSUserDefaults.standardUserDefaults()
                //defaults.setObject(0, forKey: "login_user")
                defaults.removeObjectForKey("login_user")
                defaults.synchronize()
                
                //self.navigationController?.popViewControllerAnimated(true)
//                let vs = self.storyboard?.instantiateViewControllerWithIdentifier("loginView") as! LoginViewController
//                self.navigationController?.pushViewController(vs, animated: true)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            break
            
        default:
            
            break
        }
    }
}
