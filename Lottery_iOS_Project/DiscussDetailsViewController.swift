//
//  DiscussDetailsViewController.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 11/26/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class DiscussDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var refreshControl: UIRefreshControl = UIRefreshControl()
    let WIDTH = UIScreen.mainScreen().bounds.width
    let HEIGHT = UIScreen.mainScreen().bounds.height
    
    @IBOutlet var tableView_: UITableView!
    @IBOutlet weak var navigateBar_bottom: UINavigationBar!
    var textFieldKeyboard: UITextField = UITextField()
    let alertMessage = UIAlertView()
    var discuss_id_tag: Int!
    var wsDiscuss_reply_list :[mDiscussReply] = []
    var wsDiscuss: mDiscuss!
    var discuss_period_date_thaiName: String!
    var toolBarKeyboardView: UIView = UIView()
    var isScrollToLastCell: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.hidden = false
        refreshControl.addTarget(self, action: "refresh_wsGetDiscussReply", forControlEvents: .ValueChanged)
        
        tableView_.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        tableView_.separatorStyle = UITableViewCellSeparatorStyle.None
        self.title = self.wsDiscuss.numbers
        self.navigateBar_bottom.topItem?.title = self.discuss_period_date_thaiName
        isScrollToLastCell = false
        refresh_wsGetDiscussReply()
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGesture)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name:UIKeyboardWillHideNotification, object: nil)
        
        toolBarKeyboardView = drawToolbarKeyboard()
        //toolBarKeyboardView.hidden = true
        self.view.addSubview(toolBarKeyboardView)
    }

    override func viewWillAppear(animated: Bool) {
        textFieldKeyboard.text = ""
        textFieldKeyboard.becomeFirstResponder()
    }
    
    func getUserID() -> Int{
        let defaults = NSUserDefaults.standardUserDefaults()
        var login_userID = defaults.objectForKey("login_user") as? Int
        
        if (login_userID != nil){
            return login_userID!
        }else {
            return 0
        }
    }
    
    func refresh_wsGetDiscussReply(){
        self.refreshControl.endRefreshing()
        self.refreshControl.beginRefreshing()
        self.navigationItem.titleView = DrawNavigationTitleProvider.setTitle(self.wsDiscuss.numbers, subtitle: "กำลังโหลดข้อมูลใหม่")
        Ws_Discuss.GetDiscussReplyList(discuss_id_tag) { (responseData, errorMessage) in
            dispatch_async(dispatch_get_main_queue(), {
                self.wsDiscuss_reply_list = responseData
                
                self.tableView_.reloadData()
                self.refreshControl.endRefreshing()
                self.navigationItem.titleView = DrawNavigationTitleProvider.setTitle(self.wsDiscuss.numbers, subtitle: "ข้อมูลล่าสุด")
                if (self.isScrollToLastCell == true){
                    self.textFieldKeyboard.resignFirstResponder()
                    self.scrollToLastRow()
                    self.isScrollToLastCell = false
                }
            })
        }
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        textFieldKeyboard.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.None

        return wsDiscuss_reply_list.count+1;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        var index = indexPath.row
        if (index == 0){
            return 155;
        }else{
            return 58;
        }
        //Choose your custom row height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var index = indexPath.row
        
        if (index == 0){
            let cell = tableView_.dequeueReusableCellWithIdentifier("DiscussIndex_Cell_Reply", forIndexPath:  indexPath) as! DiscussTableViewCell
            
            cell.Time_Label.text = wsDiscuss.create_datetime;
            cell.Numbers_Label.text = wsDiscuss.numbers
            cell.Message_Label.text = wsDiscuss.message
            cell.DiscussName_Label.text = wsDiscuss.user_name
            cell.DiscussComment_Button.addTarget(self, action: "btn_discussComment", forControlEvents: .TouchUpInside)
            cell.DiscussComment_Button.setTitle(String(wsDiscuss.number_comment), forState: .Normal)
            cell.DiscussLike_Button.addTarget(self, action: "btn_pressLikeDiscuss_inReply", forControlEvents: .TouchUpInside)
            cell.DiscussLike_Button.setTitle(String(wsDiscuss.number_like), forState: .Normal)
            cell.DiscussComment_Button.tag = wsDiscuss.discuss_id
            cell.DiscussLike_Button.tag = wsDiscuss.discuss_id
            
            if (wsDiscuss.isLike == true){
                cell.DiscussLike_Button.setImage(UIImage(named: "icon_like")!, forState: .Normal)
                cell.DiscussLike_Button.setTitleColor(UIColor(red: 238/255, green: 166/255, blue: 52/255, alpha: 1.0), forState: .Normal)
            }
            else {
                cell.DiscussLike_Button.setImage(UIImage(named: "icon_unlike")!, forState: .Normal)
                cell.DiscussLike_Button.setTitleColor(UIColor(red: 120/255, green: 127/255, blue: 143/255, alpha: 1.0), forState: .Normal)
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("DiscussReply_Cell", forIndexPath:  indexPath) as! DiscussReplyTableViewCell
            var wsDiscuss_reply: mDiscussReply = wsDiscuss_reply_list[index-1]
            cell.DiscussReplyName_Label.text = wsDiscuss_reply.user_name
            cell.MessageReply_Label.text = wsDiscuss_reply.message
            
            return cell
        }
    }
    
    func btn_pressLikeDiscuss_inReply(){
        if (getUserID() == 0){
            self.alertMessage.title = "คุณไม่สามารถเข้าถึงได้"
            self.alertMessage.message = "โปรดลงชื่อเข้าระบบก่อน"
            self.alertMessage.addButtonWithTitle("OK")
            self.alertMessage.show()
        }
        else {
        var isLike: Bool = false
        var currentNumLike: Int = 0
        isLike = wsDiscuss.isLike
        wsDiscuss.isLike = (isLike ? false : true) // update value
        
        var index:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        var cell = tableView_.cellForRowAtIndexPath(index) as! DiscussTableViewCell
        currentNumLike = wsDiscuss.number_like
        
        if (isLike){ // go to unlike
            currentNumLike -= 1
            Ws_Discuss.UnLikeDiscuss(getUserID(), discuss_id: wsDiscuss.discuss_id) { (responseData, errorMessage) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    cell.DiscussLike_Button.setImage(UIImage(named: "icon_unlike")!, forState: .Normal)
                    cell.DiscussLike_Button.setTitleColor(UIColor(red: 120/255, green: 127/255, blue: 143/255, alpha: 1.0), forState: .Normal)
                    cell.DiscussLike_Button.setTitle(String(currentNumLike), forState: .Normal)
                    self.wsDiscuss.number_like = currentNumLike
                })
                
            }
        }
        else{ // go to like
            currentNumLike += 1
            Ws_Discuss.LikeDiscuss(getUserID(), discuss_id: wsDiscuss.discuss_id) { (responseData, errorMessage) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    cell.DiscussLike_Button.setImage(UIImage(named: "icon_like")!, forState: .Normal)
                    cell.DiscussLike_Button.setTitleColor(UIColor(red: 238/255, green: 166/255, blue: 52/255, alpha: 1.0), forState: .Normal)
                    cell.DiscussLike_Button.setTitle(String(currentNumLike), forState: .Normal)
                    self.wsDiscuss.number_like = currentNumLike
                })
                
            }
            
        }
        }
    }
    
    func scrollToLastRow() {
        let indexPath = NSIndexPath(forRow: wsDiscuss_reply_list.count, inSection: 0)
        tableView_.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
    }
    
    func btn_discussComment(){
        textFieldKeyboard.becomeFirstResponder()
        toolBarKeyboardView.hidden = false
    }
    
    func drawToolbarKeyboard() -> UIView{
        var view = UIView(frame: CGRect(x: 0, y: HEIGHT-85, width: WIDTH, height: 35))
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 218/255, green: 226/255, blue: 237/255, alpha: 1.0).CGColor
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
       
        textFieldKeyboard = UITextField(frame: CGRect(x: 8, y: 8, width: view.bounds.width-60, height: 25))
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 10))
        textFieldKeyboard.leftView = paddingView
        textFieldKeyboard.font = textFieldKeyboard.font!.fontWithSize(12)
        textFieldKeyboard.leftViewMode = UITextFieldViewMode.Always
        textFieldKeyboard.layer.borderColor = UIColor(red: 218/255, green: 226/255, blue: 237/255, alpha: 1.0).CGColor
        textFieldKeyboard.layer.borderWidth = 1
        textFieldKeyboard.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1.0)
        textFieldKeyboard.layer.cornerRadius = 4
        textFieldKeyboard.attributedPlaceholder = NSAttributedString(string:"ใส่ข้อความ",
                                                               attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        var btnPost: UIButton = UIButton()
        btnPost.frame = CGRect(x: view.bounds.width-48, y: 8, width: 40, height: 25)
        btnPost.setTitle("ส่ง", forState: UIControlState.Normal)
        btnPost.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), forState: UIControlState.Normal)
        btnPost.layer.cornerRadius = 4
        btnPost.titleLabel!.font =  UIFont(name: "Arial-MT", size: 3)
        btnPost.backgroundColor = UIColor(red: 243/255, green: 169/255, blue: 52/255, alpha: 1.0)

        btnPost.addTarget(self, action: "submit_discussReply", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(textFieldKeyboard)
        view.addSubview(btnPost)
        
        return view
    }
    
    func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
        
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.toolBarKeyboardView.frame = CGRectMake(
                0,
                (self.toolBarKeyboardView.frame.origin.y - keyboardFrame.size.height)+48,
                self.view.bounds.width,
                self.view.bounds.height)
            }, completion: nil)
//        tableView_.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
//        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
//        
        var contentInset:UIEdgeInsets = tableView_.contentInset
        contentInset.bottom = keyboardFrame.size.height-45
        tableView_.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){

        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
        
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.toolBarKeyboardView.frame = CGRectMake(
                0,
                (self.toolBarKeyboardView.frame.origin.y + keyboardFrame.size.height)-48,
                self.view.bounds.width,
                self.view.bounds.height)
            }, completion: nil)
        //tableView_.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
        tableView_.contentInset = contentInset
    }
    
    
    func submit_discussReply(){
        if (getUserID() == 0){
            self.alertMessage.title = "คุณไม่สามารถเข้าถึงได้"
            self.alertMessage.message = "โปรดลงชื่อเข้าระบบก่อน"
            self.alertMessage.addButtonWithTitle("OK")
            self.alertMessage.show()
        }
        else {
        var textReply = textFieldKeyboard.text
        
        Ws_Discuss.AddCommentDiscuss(getUserID(), discuss_id: wsDiscuss.discuss_id, message: textReply!) { (responseData, errorMessage) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.isScrollToLastCell = true
                self.refresh_wsGetDiscussReply()
                self.textFieldKeyboard.text = ""
            })
        }
        
        print("submit_discussReply()")
        }
    }
}
