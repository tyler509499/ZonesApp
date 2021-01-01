//
//  DemoTableViewCell.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 23.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit


class DemoTableViewCell: UITableViewCell, UITextFieldDelegate, UIScrollViewDelegate {
    
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        zoneTextField.delegate = self
        outletTextField.delegate = self
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
