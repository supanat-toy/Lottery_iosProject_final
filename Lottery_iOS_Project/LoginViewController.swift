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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connect(sender: UIButton) {
        let email:String = emailField.text!
        let password:String = passwordField.text!
        
        if(email != "" && password != "" && email.containsString("@")){
            Ws_User.GetGlobalProperty(email, password: password, completion: { (responseData, errorMessage) -> Void in
            
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("userView") as! UserViewController
                let globalProperty: mGlobalproperty = responseData
                
                if(globalProperty.resultResponse.result == true){
                    vc.userID = globalProperty.userProfile.user_id
                    vc.userEmail = globalProperty.userProfile.email
                    vc.userPassword = globalProperty.userProfile.password
                    vc.userName = globalProperty.userProfile.name
                    vc.userBirthday = globalProperty.userProfile.birthday
                    vc.userGender = globalProperty.userProfile.gender
                    vc.acceptCheckingNotification = globalProperty.userProfile.isAccepted_checking_notification
                    vc.acceptLotteryNotification = globalProperty.userProfile.isAccepted_lottery_notification
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
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
