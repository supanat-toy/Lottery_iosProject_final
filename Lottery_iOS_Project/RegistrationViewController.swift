//
//  RegistrationViewController.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 11/18/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    
    var userGender:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        birthdayField.enabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func maleRadioBtn(sender: DLRadioButton) {
        userGender = "male"
    }
    @IBAction func femaleRadioBtn(sender: DLRadioButton) {
        userGender = "female"
    }

    @IBAction func getBirthday(sender: AnyObject) {
        print("select birthday button")
        
    }
    @IBAction func registerBtn(sender: UIButton) {
        if(emailField.text == "" || passwordField.text == ""){
            print("peanut")
            let alert = UIAlertController(title: "กรุณาใส่อีเมลและรหัสผ่าน", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        if(passwordField.text != confirmPasswordField.text){
            print("butter")
            let alert = UIAlertController(title: "ยืนยันรหัสผ่านไม่ผ่าน", message: "กรุณาใส่รหัสผ่านใหม่อีกครั้ง", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            }
        if(nameField.text == ""){
            print("jelly")
            let alert = UIAlertController(title: "กรุณาใส่ชื่อ", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        if(birthdayField.text == ""){
            print("time")
            let alert = UIAlertController(title: "กรุณาวัน เดือน ปีเกิด", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        if(userGender == ""){
            print("no sexxx?")
            let alert = UIAlertController(title: "กรุณาระบุเพศ", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            let email:String = emailField.text!
            let password:String = passwordField.text!
            let name:String = nameField.text!
            let birthday:String = birthdayField.text!
            let gender:String = userGender
            Ws_User.Register(email, password: password, name: name, birthday: birthday, gender: gender, completion: {(responseData, errorMessage) ->Void in
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("userView") as! UserViewController
                let globalProperty:mGlobalproperty = responseData
                if(globalProperty.resultResponse.result == true){
                    vc.userID = globalProperty.userProfile.user_id
                    vc.userEmail = globalProperty.userProfile.email
                    vc.userName = globalProperty.userProfile.name
                    vc.userPassword = globalProperty.userProfile.password
                    vc.userBirthday = globalProperty.userProfile.birthday
                    vc.userGender = globalProperty.userProfile.gender
                    vc.acceptCheckingNotification = globalProperty.userProfile.isAccepted_checking_notification
                    vc.acceptLotteryNotification = globalProperty.userProfile.isAccepted_lottery_notification
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        let alert = UIAlertController(title: "สมัครล้มเหลว", message: "ลองใหม่อีกครั้ง", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "ตกลง", style: .Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    })
                }
            })
        }
    }
}
