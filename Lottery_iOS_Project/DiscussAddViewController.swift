//
//  DiscussAddViewController.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/30/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit


class DiscussAddViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var messageTextField: UITextView!
    
    
    let WIDTH = UIScreen.mainScreen().bounds.width
    let HEIGHT = UIScreen.mainScreen().bounds.height
    @IBOutlet weak var navigateBar_bottom: UINavigationBar!
    var wsPeriod_lottery_date: String!
    var discuss_period_date_thaiName: String!
    

    func tap(gesture: UITapGestureRecognizer) {
    
        
        numberTextField.resignFirstResponder()
        messageTextField.resignFirstResponder()
    }
    
    @IBAction func btn_addNew_discuss(sender: AnyObject) {
        var numbers: String = numberTextField.text!
        var message: String = messageTextField.text!
        
        Ws_Discuss.AddNewDiscuss(1, period_lottery_date: wsPeriod_lottery_date, numbers: numbers, message: message) { (responseData, errorMessage) in
            dispatch_async(dispatch_get_main_queue(), {
                
                self.navigationController?.popViewControllerAnimated(true);
                //self.dismissViewControllerAnimated(true, completion: nil)
                
            })
        }
    }

    
    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height+30
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInset
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigateBar_bottom.topItem?.title = self.discuss_period_date_thaiName
        print("wsPeriod_lottery_date : ", wsPeriod_lottery_date)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGesture)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name:UIKeyboardWillHideNotification, object: nil)
        
        messageTextField.layer.borderWidth = 1
        messageTextField.layer.borderColor = UIColor(red: 218/255, green: 226/255, blue: 237/255, alpha: 1.0).CGColor
       
        scrollView.contentSize = CGSize(
            width: WIDTH,
            height: HEIGHT-300)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
