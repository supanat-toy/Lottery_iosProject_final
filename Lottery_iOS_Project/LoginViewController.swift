//
//  LoginViewController.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 11/17/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var user_id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        emailField.text = ""
        passwordField.text = ""
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }

    override func viewWillAppear(animated: Bool) {
        if(checkIsLogined()){
            
            CoreData_UserProfile.GetUserProfile({ (responseData, errorMessage) in
                
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryUserView") as! LotteryUserViewController
                if (responseData.count != 0){
                    let userProfile: mUser = responseData[0]
                    
                    vc.userID = userProfile.user_id
                    vc.userEmail = userProfile.email
                    vc.userPassword = userProfile.password
                    vc.userName = userProfile.name
                    vc.userBirthday = userProfile.birthday
                    vc.userGender = userProfile.gender
                    vc.acceptCheckingNotification = userProfile.isAccepted_checking_notification
                    vc.acceptLotteryNotification = userProfile.isAccepted_lottery_notification
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //self.presentViewController(vc, animated: true, completion: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                }
                
            })
            
//            Ws_User.GetUserProfile(user_id, completion: { (responseData, errorMessage) in
//                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryUserView") as! LotteryUserViewController
//                let userProfile: mUser = responseData
//                
//                vc.userID = userProfile.user_id
//                vc.userEmail = userProfile.email
//                vc.userPassword = userProfile.password
//                vc.userName = userProfile.name
//                vc.userBirthday = userProfile.birthday
//                vc.userGender = userProfile.gender
//                vc.acceptCheckingNotification = userProfile.isAccepted_checking_notification
//                vc.acceptLotteryNotification = userProfile.isAccepted_lottery_notification
//                
//                dispatch_async(dispatch_get_main_queue(), {
//                    //self.presentViewController(vc, animated: true, completion: nil)
//                    self.navigationController?.pushViewController(vc, animated: true)
//                })
//                
//            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forgetPassword(sender: UIButton) {
        let alert = UIAlertController(title: "UNDER CONSTRUCTION", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    func checkIsLogined() -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        var login_userID = defaults.objectForKey("login_user") as? Int
        
        if (login_userID != nil){
            user_id = login_userID!
            return true
        }else {
            return false
        }
    }
    
    @IBAction func connect(sender: UIButton) {
        let email:String = emailField.text!
        let password:String = passwordField.text!
        
        if(email != "" && password != "" && email.containsString("@")){
            Ws_User.GetGlobalProperty(email, password: password, completion: { (responseData, errorMessage) -> Void in
            
                //let vc = self.storyboard?.instantiateViewControllerWithIdentifier("userView") as! UserViewController
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryUserView") as! LotteryUserViewController
                let globalProperty: mGlobalproperty = responseData
                
                if(globalProperty.resultResponse.result == true){
                    
                    CoreData_UserProfile.SaveUserProfile(globalProperty.userProfile)
                    
                    vc.userID = globalProperty.userProfile.user_id
                    vc.userEmail = globalProperty.userProfile.email
                    vc.userPassword = globalProperty.userProfile.password
                    vc.userName = globalProperty.userProfile.name
                    vc.userBirthday = globalProperty.userProfile.birthday
                    vc.userGender = globalProperty.userProfile.gender
                    vc.acceptCheckingNotification = globalProperty.userProfile.isAccepted_checking_notification
                    vc.acceptLotteryNotification = globalProperty.userProfile.isAccepted_lottery_notification
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        
                        let defaults = NSUserDefaults.standardUserDefaults()
                        //var favoriteList = defaults.objectForKey("login_user") as? Int
                        var login_userID = globalProperty.userProfile.user_id
                        defaults.setObject(login_userID, forKey: "login_user")
                        self.user_id = login_userID
                        
                        //self.presentViewController(vc, animated: true, completion: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        let alert = UIAlertController(title: "อีเมลหรือรหัสผ่านไม่ถูกต้อง", message: "กรุณาใส่ใหม่อีกครั้ง", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    })
                }
            })
        }
        else{
            let alert = UIAlertController(title: "กรุณาใส่อีเมลและรหัสผ่าน", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
