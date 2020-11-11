//
//  DemoTableViewCell.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 23.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit

class DemoTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet public var zoneLabel: UILabel!
    @IBOutlet public var zoneTextField: UITextField!
    @IBOutlet public var outletTextField: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            zoneTextField.resignFirstResponder()
            outletTextField.resignFirstResponder()
           return true
             }
    
   
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true
        }
             
            
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                 super.touchesBegan(touches, with: event)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
//        zoneTextField.delegate = self
//        outletTextField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
