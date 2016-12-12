//
//  PersonalViewController.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 11/18/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {

    var name:String!
    var birthday:String!
    var gender: String!
    
    var ID:Int!
    var email:String!
    var password:String!
    var checkingNotification:Bool!
    var lotteryNotification:Bool!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!

    @IBOutlet weak var maleBtn: DLRadioButton!
    @IBOutlet weak var femaleBtn: DLRadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        nameField.text = name
        birthdayField.text = birthday
        
        if(gender == "male"){
            maleBtn.selected = true
        }
        else{
            femaleBtn.selected = true
        }
        //self.navigationController?.popViewControllerAnimated(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func maleBtn(sender: DLRadioButton) {
        gender = "male"
    }

    @IBAction func femaleBtn(sender: DLRadioButton) {
        gender = "female"
    }
    
    @IBAction func updatePersonalProfileBtn(sender: UIButton) {
        let changeUsername = nameField.text
        let changeBirthday = birthdayField.text
        let changeGender = gender
        
        Ws_User.UpdateUserProfile(ID, password: password, name: changeUsername!, birthday: changeBirthday!, gender: changeGender, completion: {(responseData, errorMessage) -> Void in
        
            let vs = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryUserView") as! LotteryUserViewController

            vs.userID = responseData.user_id
            vs.userEmail = responseData.email
            vs.userPassword = responseData.password
            vs.userName = responseData.name
            vs.userBirthday = responseData.birthday
            vs.userGender = responseData.gender
            vs.acceptCheckingNotification = responseData.isAccepted_checking_notification
            vs.acceptLotteryNotification = responseData.isAccepted_lottery_notification
            
            dispatch_async(dispatch_get_main_queue(), {
            
                self.navigationController?.pushViewController(vs, animated: true)
            })
        })
        
        
        
        //let globalProperty: mGlobalproperty = responseData
        
        //            if(globalProperty.resultResponse.result == true){
        //                vs.userID = responseData.
        //            }
        
        
        
//        let email:String = emailField.text!
//        let password:String = passwordField.text!
//        
//        if(email != "" && password != "" && email.containsString("@")){
//            Ws_User.GetGlobalProperty(email, password: password, completion: { (responseData, errorMessage) -> Void in
//                
//                //let vc = self.storyboard?.instantiateViewControllerWithIdentifier("userView") as! UserViewController
//                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryUserView") as! LotteryUserViewController
//                let globalProperty: mGlobalproperty = responseData
//                
//                if(globalProperty.resultResponse.result == true){
//                    vc.userID = globalProperty.userProfile.user_id
//                    vc.userEmail = globalProperty.userProfile.email
//                    vc.userPassword = globalProperty.userProfile.password
//                    vc.userName = globalProperty.userProfile.name
//                    vc.userBirthday = globalProperty.userProfile.birthday
//                    vc.userGender = globalProperty.userProfile.gender
//                    vc.acceptCheckingNotification = globalProperty.userProfile.isAccepted_checking_notification
//                    vc.acceptLotteryNotification = globalProperty.userProfile.isAccepted_lottery_notification
//                    
//                    dispatch_async(dispatch_get_main_queue(), {
//                        
//                        //self.presentViewController(vc, animated: true, completion: nil)
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    })
//                }
//                else{
//                    dispatch_async(dispatch_get_main_queue(), {
//                        
//                        let alert = UIAlertController(title: "อีเมลหรือรหัสผ่านไม่ถูกต้อง", message: "กรุณาใส่ใหม่อีกครั้ง", preferredStyle: UIAlertControllerStyle.Alert)
//                        alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
//                        self.presentViewController(alert, animated: true, completion: nil)
//                    })
//                }
//            })
//        }
//        else{
//            let alert = UIAlertController(title: "กรุณาใส่อีเมลและรหัสผ่าน", message: "", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//        }
    }
}
