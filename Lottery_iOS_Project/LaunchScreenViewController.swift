//
//  LaunchScreenViewController.swift
//  Lottery_iOS_Project
//
//  Created by ToyStory on 12/29/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var indicatorLoad: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorLoad.startAnimating()
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
