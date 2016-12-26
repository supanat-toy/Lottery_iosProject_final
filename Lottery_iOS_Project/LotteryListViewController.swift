//
//  LotteryListViewController.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 12/9/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class LotteryListCell: UITableViewCell{
    @IBOutlet weak var rewardType: UILabel!
    @IBOutlet weak var rewardAmount: UILabel!
    @IBOutlet weak var lotteryNum: UILabel!

}

class LotteryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userID:Int!

    var theList: mUserLottery!
    var nextLottery: String!
    
    @IBOutlet weak var theTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "buttonTapped:")
        self.navigationItem.rightBarButtonItem = button
        // Do any additional setup after loading the view.
       
        //getLottery()
    }
    
    func getLottery(){
        Ws_User.GetUserLottery(userID, completion: {(responseData, errorMessage) -> Void in
        //Ws_User.GetUserLottery(1, completion: {(responseData, errorMessage) -> Void in
        
            self.nextLottery = responseData.next_lottery_period_date
            
            self.theList = responseData
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonTapped(sender: UIBarButtonItem){
        print("right bar button tapped")
        
        //let alert = UIAlertController(title: "ใส่เลขลอตเตอรี่", message: nextLottery, preferredStyle: UIAlertControllerStyle.Alert)
        let alert = UIAlertController(title: "ใส่เลขลอตเตอรี่", message: "peanut", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler{
            (textField) -> Void in
        }
        
        alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: {(action) -> Void in
            
            let textField = alert.textFields![0] as UITextField
            print(textField.text)
            
            //Ws_User.AddUserLottery(self.userID, numbers: textField.text!, period_lottery_date: self.nextLottery, completion: {(responseData, errorMessage) -> Void in
            Ws_User.AddUserLottery(1, numbers: textField.text!, period_lottery_date: "1/10/2559", completion: {(responseData, errorMessage) -> Void in
                //
            })
            
            //self.getLottery()
            self.theTable.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "ยกเลิก", style: .Default, handler: {(action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "blahBlah"
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("lotteryListCell", forIndexPath: indexPath) as! LotteryListCell
        
        cell.lotteryNum.text = "123456"
        cell.rewardAmount.text = "200000"
        cell.rewardType.text = "รางวัลที่หนึ่ง"
        
        return cell
    }

    
}
