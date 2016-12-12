//
//  UserViewController.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 11/18/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class MyCustomUISwitchTableViewCellModel{
    var title:String!
    var switchVal:Bool!
    var image:UIImage!
}

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    
    @IBOutlet weak var memberTable: UITableView!
    @IBOutlet weak var notificationTable: UITableView!
    @IBOutlet weak var otherTable: UITableView!
    
    var notiArray = [MyCustomUISwitchTableViewCellModel]()
    
    struct memberCellElement{
        let icon: String
        let str: String
        let arrow: String
    }
    
    struct notificationCellElement{
        let icon: String
        let str: String
        let choice: Bool
        //let roller: UISwitch
    }
    
    let memberSample = [
        memberCellElement(icon : "Circled User Male", str : "เฟี้ยวฟ้าว มะเขือเปาะ", arrow : "right_arrow"),
        memberCellElement(icon : "Lock 2", str : "เปลี่ยนรหัสผ่าน", arrow : "right_arrow"),
        memberCellElement(icon : "Book Stack", str : "ลอตเตอรี่ของฉัน", arrow : "right_arrow")
    ]
    
    let notificationSample = [
        notificationCellElement(icon: "View File", str: "แจ้งตรวจสอบ", choice: true),
        notificationCellElement(icon: "Appointment Reminders", str: "แจ้งลอตเตอรี่", choice: true)
    ]
    
    let otherSample = [
        memberCellElement(icon: "Rating", str: "ให้ดาว", arrow: "right_arrow"),
        memberCellElement(icon: "ID Card", str: "ติดต่อ", arrow: "right_arrow"),
        memberCellElement(icon: "Exit", str: "ออกจากระบบ", arrow: "right_arrow")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem .setHidesBackButton(true, animated: true)
        
        memberTable.dataSource = self
        memberTable.delegate = self
        memberTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "memberCell")
        
        notificationTable.dataSource = self
        notificationTable.delegate = self
        notificationTable.registerNib(UINib(nibName: "CustomUISwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "myCustomCell")
        
        otherTable.dataSource = self
        otherTable.delegate = self
        otherTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "otherCell")
        
        for index in 0..<notificationSample.count{
            let peanut =  MyCustomUISwitchTableViewCellModel()
            peanut.image = UIImage(named: notificationSample[index].icon)
            peanut.title = notificationSample[index].str
            peanut.switchVal = notificationSample[index].choice
            notiArray.append(peanut)
        }
        
        self.navigationController?.popViewControllerAnimated(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var count:Int?
        
        if tableView == self.memberTable{
            //count = 3
            count = memberSample.count
        }
        
        if tableView == self.notificationTable{
            //count = 2
            count = notificationSample.count
        }
        
        if tableView == self.otherTable{
            //count = 3
            count = otherSample.count
        }
        
        return count!
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if tableView == self.memberTable{
            cell = tableView.dequeueReusableCellWithIdentifier("memberCell", forIndexPath: indexPath)
            let detail = memberSample[indexPath.row]
            cell!.imageView?.image = UIImage(named: detail.icon)
            cell!.textLabel?.text = detail.str
        }
        if tableView == self.notificationTable{
            let cell = tableView.dequeueReusableCellWithIdentifier("myCustomCell", forIndexPath: indexPath) as! CustomUISwitchTableViewCell
            cell.setUpWithModel(notiArray[indexPath.row])
            return cell
        }
        if tableView == self.otherTable{
            cell = tableView.dequeueReusableCellWithIdentifier("otherCell", forIndexPath: indexPath)
            let detail = otherSample[indexPath.row]
            cell!.imageView?.image = UIImage(named: detail.icon)
            cell!.textLabel?.text = detail.str
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if tableView == self.memberTable{
            print("did select member table:   \(indexPath.row)")
            //make switch case according to the indexPath.row and link to appropriate ViewController
            switch(indexPath.row){
            case 0:
                print("peanut butter")
                
                let vs = self.storyboard?.instantiateViewControllerWithIdentifier("personalInfo") as! PersonalViewController
                
                vs.name = memberSample[0].str
                vs.birthday = "20/10/2000"
                
                self.navigationController?.pushViewController(vs, animated: true)
                
                
                break
            case 1:
                print("jelly time")
                
                let vs = self.storyboard?.instantiateViewControllerWithIdentifier("changePassword") as! ChangePasswordViewController
                
                vs.currentPassword = "1212312121"
                
                self.navigationController?.pushViewController(vs, animated: true)
                
                break
            case 2:
                print("where at")
                break
            default:
                print("god damn default")
                break
            }
        }
        if tableView == self.notificationTable{
            print("did select notification table:   \(indexPath.row)")
            //make switch case according to the indexPath.row and link to appropriate ViewController
        }
        if tableView == self.otherTable{
            print("did select other table:    \(indexPath.row)")
            //make switch case according to the indexPath.row and link to appropriate ViewController
        }
    }
}
