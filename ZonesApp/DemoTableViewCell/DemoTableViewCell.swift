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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        zoneTextField.text = nil
        outletTextField.text = nil
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
    
    @objc private func didTapDone() {
        endEditing(true)
    }
}
