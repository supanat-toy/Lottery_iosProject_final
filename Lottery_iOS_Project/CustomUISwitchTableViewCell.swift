//
//  CustomUISwitchTableViewCell.swift
//  Lottery_iOS_Project
//
//  Created by Rajanart Incharoensakdi on 11/21/2559 BE.
//  Copyright © 2559 ToyStory. All rights reserved.
//

import UIKit

class CustomUISwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchLabel: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpWithModel(signal: MyCustomUISwitchTableViewCellModel){
        nameLabel.text = signal.title
        imageLabel.image = signal.image
        switchLabel.setOn(signal.switchVal, animated: false)
    }
    
    @IBAction func theSwitch(sender: UISwitch) {
        
    }
}
