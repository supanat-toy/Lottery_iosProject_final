//
//  LotteryListViewController.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 12/9/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit
import CoreData

class LotteryListCell: UITableViewCell{
    @IBOutlet weak var rewardType: UILabel!
    @IBOutlet weak var rewardAmount: UILabel!
    @IBOutlet weak var lotteryNum: UILabel!

}

class LotteryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userID:Int!

    var theList = [mUserGroupLottery]()
    var nextLottery: String!
    
    @IBOutlet weak var theTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ลอตเตอรี่ของฉัน"
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "buttonTapped:")
        self.navigationItem.rightBarButtonItem = button
        getLottery()

    }
    
    override func viewDidAppear(animated: Bool) {
        self.theTable.reloadData()
    }
    
    func getLottery(){
        if(InternetProvider.isInternetAvailable() == true){
            Ws_User.GetUserLottery(userID, completion: {(responseData, errorMessage) -> Void in
        
                self.nextLottery = responseData.next_lottery_period_date
                self.theList = responseData.userGroupLottery
        
                CoreData_Lottery.ClearLottery_CoreData("UserLotteryNext")
                CoreData_Lottery.SaveNextLotteryDate(self.nextLottery)
                
                CoreData_Lottery.ClearLottery_CoreData("UserLottery")
                CoreData_Lottery.SaveLottery(self.theList, userid: self.userID)

                self.theTable.reloadData()
            
            })
        }
        
        else{
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            let request = NSFetchRequest(entityName: "UserLottery")
            request.returnsObjectsAsFaults = false
            
            var lotteryDate = [String]()
            var list = [mUserLotteryNumber]()
            
            do{
                let results = try managedContext.executeFetchRequest(request)
                if (results.count > 0 ){
                    
                    for date in results as! [NSManagedObject]{
                        let stringDate = date.valueForKey("lottery_date") as? String
                        if(lotteryDate.count < 1){
                            lotteryDate.append(stringDate!)
                        }
                        else{
                            for i in 0..<lotteryDate.count{
                                if lotteryDate[i] != stringDate && (i+1)==lotteryDate.count{
                                    lotteryDate.append(stringDate!)
                                }
                            }
                        }
                    }
                    
                    for result in results as! [NSManagedObject]{
                        let id = result.valueForKey("user_id") as? Int
                        if ( id == self.userID){
                            
                            let prize = result.valueForKey("prize_baht") as? Int
                            let number = result.valueForKey("lottery_number") as? String
                            let lotteryId = result.valueForKey("user_lottery_id") as? Int
                            let date = result.valueForKey("lottery_date") as? String
                            let statusResult = result.valueForKey("status_result") as? String
                            
                            let lotteryNumber = mUserLotteryNumber.init(userLotteryId: lotteryId!, userId: id!, number: number!, prize: prize!, date: date!, result: statusResult!)
                            list.append(lotteryNumber)
                        }
                    }
                    
                    for i in lotteryDate{
                        var groupLottery = [mUserLotteryNumber]()
                        for j in list{
                            if (i == j.period_lottery_date){
                                groupLottery.append(j)
                            }
                        }
                        let mUserGroup = mUserGroupLottery.init(date: i, list: groupLottery)
                        self.theList.append(mUserGroup)
                    }
                }
            }
            catch let error as NSError{
                print("Failed to retrieve data \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonTapped(sender: UIBarButtonItem){
        
        let alert = UIAlertController(title: "ใส่เลขลอตเตอรี่", message: self.nextLottery, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler{
            (textField) -> Void in
        }
        
        alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: {(action) -> Void in
            
            let textField = alert.textFields![0] as UITextField
            print(textField.text)
            
            Ws_User.AddUserLottery(self.userID, numbers: textField.text!, period_lottery_date: self.nextLottery, completion: {(responseData, errorMessage) -> Void in
                self.getLottery()
            })
        }))
        
        alert.addAction(UIAlertAction(title: "ยกเลิก", style: .Default, handler: {(action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.theList.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.theList[section].lottery_period_date
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.theList[section].userLotteryList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("lotteryListCell", forIndexPath: indexPath) as! LotteryListCell
        
        cell.lotteryNum.text = self.theList[indexPath.section].userLotteryList[indexPath.row].numbers
        
        let prize = self.theList[indexPath.section].userLotteryList[indexPath.row].prize_baht
        
        
        if(prize > 999){
            cell.rewardAmount.textColor = UIColor.init(red: 0/255, green: 153/255, blue: 0/255, alpha: 1.0)
        }else{
            cell.rewardAmount.textColor = UIColor.blackColor()
        }
        cell.rewardAmount.text = String(self.theList[indexPath.section].userLotteryList[indexPath.row].prize_baht)
        
        switch(prize){
        
        case 3000000:
            cell.rewardType.text = "รางวัลที่หนึ่ง"
            break
        case 100000:
            cell.rewardType.text = "รางวัลที่สอง"
            break
        case 40000:
            cell.rewardType.text = "รางวัลที่สาม"
            break
        case 20000:
            cell.rewardType.text = "รางวัลที่สี่"
            break
        case 10000:
            cell.rewardType.text = "รางวัลที่ห้า"
            break
        case 50000:
            cell.rewardType.text = "รางวัลข้างเคียง"
            break
        case 2000:
            cell.rewardType.text = "รางวัลสามตัว"
            break
        case 1000:
            cell.rewardType.text = "รางวัลสองตัว"
         
        default:
            cell.rewardType.text = "  "
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
