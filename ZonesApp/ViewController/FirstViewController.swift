//
//  ViewController.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 22.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var newZones: UITextField!
    @IBOutlet weak var reuseZones: UITextField!
    var picker: MyPickerView?
    var pickerAccessory: UIToolbar?
    let defaultReuseZonesvalue = "0"
   
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               newZones.resignFirstResponder()
               reuseZones.resignFirstResponder()
               return true
           }
           
          
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
               super.touchesBegan(touches, with: event)
               
               view.endEditing(true)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
        
        reuseZones.text = defaultReuseZonesvalue
        //Picker
        picker = MyPickerView()
        picker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        picker?.backgroundColor = UIColor.white
        picker?.pickerData = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
        reuseZones.inputView = picker
        
        //Toolbar
        pickerAccessory = UIToolbar()
        pickerAccessory?.autoresizingMask = .flexibleHeight
        pickerAccessory?.barStyle = .default
        pickerAccessory?.barTintColor = UIColor.gray
        pickerAccessory?.backgroundColor = UIColor.gray
        pickerAccessory?.isTranslucent = false
        var frame = pickerAccessory?.frame
        frame?.size.height = 44.0
        pickerAccessory?.frame = frame!
        reuseZones.inputAccessoryView = pickerAccessory
        
        addDoneClearButtonTo(reuseZones)
        
    
    }
    
}
extension FirstViewController {
    
    //Toolbar buttons
    
    private func addDoneClearButtonTo(_ textField: UITextField) {

        let cancelButton = UIBarButtonItem(title: "Clear",
                                           style: .done,
                                           target: self,
                                           action: #selector(FirstViewController.cancelBtnClicked(_:)))
        cancelButton.tintColor = UIColor.white

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)

        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(FirstViewController.doneBtnClicked(_:)))
        doneButton.tintColor = UIColor.white


        pickerAccessory?.items = [cancelButton, flexSpace, doneButton]

    
    }
    
    
    

   @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
            reuseZones?.resignFirstResponder()
            reuseZones.text = defaultReuseZonesvalue
    
        }

   @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
            reuseZones?.resignFirstResponder()
            reuseZones.text = picker?.selectedValue
        }
    }

