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
        zoneTextField.text = nil
        outletTextField.text = nil
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
        
        weakModel = myModel
        
        zoneLabel.text = "Zone " + String(myModel.zoneNumber!)
        zoneTextField.text = myModel.zoneName ?? ""
        if myModel.outletNumber != nil {
            outletTextField.text = String(myModel.outletNumber!)
        } else {
            outletTextField.text = ""
        }
        
        addDoneButtonToZone(zoneTextField)
        addDoneButtonToOutlet(outletTextField)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if (zoneTextField != nil) {
            zoneTextField.delegate = self
            zoneTextField.placeholder = "Enter name"
        }
        if (outletTextField != nil) {
            outletTextField.delegate = self
            outletTextField.placeholder = "Enter number"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    private func addDoneButtonToZone(_ textField: UITextField) {
        
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
    
    private func addDoneButtonToOutlet(_ textField: UITextField) {
        
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
