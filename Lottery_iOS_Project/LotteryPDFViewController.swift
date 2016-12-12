//
//  LotteryPDFViewController.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 10/30/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class LotteryPDFViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet var myWebView: UIWebView!
    @IBOutlet var mySpinner: UIActivityIndicatorView!
    var urlString : String = String()
 
    //"http://www.glo.or.th/glo_seize/file_upload/chk_lotto_20150701160855.pdf"
    var lottery_period_date_thaiName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.title = lottery_period_date_thaiName
        
        // set webview delegate
        self.myWebView.delegate = self
        
        
        // fit content within screen size.
        self.myWebView.scalesPageToFit = true
        
        // start spinner
        self.mySpinner.startAnimating()
        
        // load url content within webview
        if let urlToBrowse = NSURL(string: self.urlString) {
            let urlRequest = NSURLRequest(URL: urlToBrowse)
            self.myWebView.loadRequest(urlRequest)
        }
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        self.mySpinner.stopAnimating()
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
