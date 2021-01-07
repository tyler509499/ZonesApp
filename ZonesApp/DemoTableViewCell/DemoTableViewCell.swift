//
//  DemoTableViewCell.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 23.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit

protocol ZoneTableViewCellDelegate {
    func getTextFieldZoneString(zoneString: String)
}

protocol OutletTableViewCellDelegate {
    func getTextFieldOutletString(outletString: String)
}



class DemoTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet public var zoneLabel: UILabel!
    @IBOutlet public var zoneTextField: UITextField!
    @IBOutlet public var outletTextField: UITextField!
    weak var weakModel: NewZones?
    
    var cellZoneDelegate: ZoneTableViewCellDelegate?
    var cellOutletDelegate: OutletTableViewCellDelegate?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.zoneTextField.delegate = self
        self.outletTextField.delegate = self
           return true
             }
    
    func modelToTableViewUpdate() {
        
        zoneTextField.text = weakModel?.zoneArrayNewZones(zoneName)]
        if let _ = weakModel?.outletNumber {
            outletTextField.text = String((weakModel?.outletNumber)!)
        } else {
            outletTextField.text = ""
        }
          
    }
    
    
    override func prepareForReuse() {
        
        self.zoneTextField.text = nil
        self.outletTextField.text = nil
        super.prepareForReuse()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        cellZoneDelegate?.getTextFieldZoneString(zoneString: self.zoneTextField.text!)
        cellOutletDelegate?.getTextFieldOutletString(outletString: self.outletTextField.text!)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.zoneTextField.delegate = self
        self.outletTextField.delegate = self
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
