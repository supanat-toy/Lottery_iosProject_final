//
//  ChangePasswordViewController.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 11/18/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    var currentPassword:String!
    
    var name:String!
    var birthday:String!
    var gender: String!
    var ID:Int!
    var email:String!
    var checkingNotification:Bool!
    var lotteryNotification:Bool!
    
    @IBOutlet weak var currentPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmNewPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPasswordField.text = currentPassword
        self.hideKeyboardWhenTappedAround()

        //self.navigationController?.popViewControllerAnimated(false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updatePasswordBtn(sender: UIButton) {
        let changePassword = newPasswordField.text
        let confirmPassword = confirmNewPasswordField.text
        let oldPassword = currentPasswordField.text
        
        if(changePassword == confirmPassword && changePassword != oldPassword && changePassword != ""){
        
            Ws_User.UpdateUserProfile(ID, password: changePassword!, name: name, birthday: birthday, gender: gender, completion: {(responseData, errorMessage) -> Void in
                
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

        
//        
//        Ws_User.UpdateUserProfile(email, password: password, name: changeUsername!, birthday: changeBirthday!, gender: changeGender, completion: {(responseData, errorMessage) -> Void in
//            
//            let vs = self.storyboard?.instantiateViewControllerWithIdentifier("lotteryUserView") as! LotteryUserViewController
//            
//            vs.userID = responseData.user_id
//            vs.userEmail = responseData.email
//            vs.userPassword = responseData.password
//            vs.userName = responseData.name
//            vs.userBirthday = responseData.birthday
//            vs.userGender = responseData.gender
//            vs.acceptCheckingNotification = responseData.isAccepted_checking_notification
//            vs.acceptLotteryNotification = responseData.isAccepted_lottery_notification
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                
//                self.navigationController?.pushViewController(vs, animated: true)
//            })
//        })
        }
    }
}
