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
    
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        nameField.text = name
        birthdayField.text = birthday
        
        if(gender == "M"){
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
    
    @IBAction func setBday(sender: UITextField) {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        datePicker.calendar = NSCalendar(calendarIdentifier: "buddhist")
        datePicker.locale = NSLocale(localeIdentifier: "th")
        
        sender.inputView = datePicker
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolbar.barStyle = UIBarStyle.Default
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelTapped))
        let emptySpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneTapped))
        
        toolbar.items = [cancelButton, emptySpace, doneButton]
        sender.inputAccessoryView = toolbar
    }
    
    func cancelTapped(sender: UIBarButtonItem!){
        
        birthdayField.resignFirstResponder()
    }
    
    func doneTapped(sender: UIBarButtonItem!){
        
        let dateFormatter = NSDateFormatter()
        //dateFormatter.dateStyle = .MediumStyle
        //dateFormatter.timeStyle = .NoStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "th")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        
        birthdayField.text = dateFormatter.stringFromDate(datePicker.date)
        birthdayField.resignFirstResponder()
    }

    @IBAction func maleBtn(sender: DLRadioButton) {
        gender = "M"
    }

    @IBAction func femaleBtn(sender: DLRadioButton) {
        gender = "F"
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
    }
}
