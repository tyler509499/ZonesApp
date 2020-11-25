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
            
           return true
             }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.zoneTextField.text = nil
        self.outletTextField.text = nil
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true
        }
             
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                 super.touchesBegan(touches, with: event)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func addDoneButtonTo(_ textField: UITextField) {
        
        let doneToolbar = UIToolbar()
        outletTextField.inputAccessoryView = doneToolbar
        zoneTextField.inputAccessoryView = doneToolbar
        doneToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
    
        doneToolbar.items = [flexBarButton, doneButton]
        
    }
    
    @objc private func didTapDone(_ selector: Selector) {
        
        zoneTextField.resignFirstResponder()
        outletTextField.resignFirstResponder()
        
        
    }
}
