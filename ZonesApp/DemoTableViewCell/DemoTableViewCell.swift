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
    weak var weakModel: NewZones?
    
    override func prepareForReuse() {
        self.zoneTextField.text = nil
        self.outletTextField.text = nil
        weakModel = nil
        super.prepareForReuse()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == zoneTextField{
            weakModel?.zoneName = zoneTextField.text ?? ""
        }
        if textField == outletTextField{
            weakModel?.outletNumber = Int(outletTextField.text ?? "")
        }
    }
    
    func modelToTableViewUpdate(_ myModel: NewZones) {
        
        zoneTextField.text = myModel.zoneName ?? ""
        if myModel.outletNumber != nil {
            outletTextField.text = String(myModel.outletNumber!)
        } else {
            outletTextField.text = ""
        }
        weakModel = myModel
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if (self.zoneTextField != nil) {
            self.zoneTextField.delegate = self as UITextFieldDelegate
        }
        if (self.outletTextField != nil) {
            self.outletTextField.delegate = self as UITextFieldDelegate
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addDoneButtonToZone(_ textField: UITextField) {
        
        let doneToolbar = UIToolbar()
        zoneTextField.inputAccessoryView = doneToolbar
        doneToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDoneZone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        doneToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDoneZone(_ selector: Selector) {
        zoneTextField.endEditing(true)
    }
    
    func addDoneButtonToOutlet(_ textField: UITextField) {
        
        let doneToolbar = UIToolbar()
        outletTextField.inputAccessoryView = doneToolbar
        doneToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDoneOutlet))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        doneToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDoneOutlet(_ selector: Selector) {
        outletTextField.endEditing(true)
    }
}
