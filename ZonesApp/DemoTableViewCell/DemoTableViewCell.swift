//
//  DemoTableViewCell.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 23.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit

class DemoTableViewCell: UITableViewCell {
    
    @IBOutlet public var zoneLabel: UILabel!
    @IBOutlet public var zoneTextField: UITextField!
    @IBOutlet public var outletTextField: UITextField!
    
    
   
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                 zoneLabel.resignFirstResponder()
                 zoneTextField.resignFirstResponder()
                 outletTextField.resignFirstResponder()
                 return true
             }
             
            
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                 super.touchesBegan(touches, with: event)
        
    }
    
    
        override func awakeFromNib() {
        super.awakeFromNib()
            
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
