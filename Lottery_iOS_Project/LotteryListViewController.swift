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

    override func viewDidLoad() {
        super.viewDidLoad()

        Ws_User.GetUserLottery(userID) { (responseData, errorMessage) in
            var a:Int = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
