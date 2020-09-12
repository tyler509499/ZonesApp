//
//  ViewController.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 22.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var newZonesTextField: UITextField!
    @IBOutlet weak var reuseZonesTextField: UITextField!
    var picker: MyPickerView?
    var pickerAccessory: UIToolbar?
    let reusePickerData: [String] = { (0...14).map { "\($0)" }}()
    

    private var privateZone = DataManager.default.zoneData
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               newZonesTextField.resignFirstResponder()
               reuseZonesTextField.resignFirstResponder()
               return true
           }
           
          
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//               super.touchesBegan(touches, with: event)
//               picker?.endEditing(true)
//       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        reuseZonesTextField.text = String(privateZone.reuseZones)
    
        //Picker
        picker = MyPickerView()
        picker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        picker?.backgroundColor = UIColor.white
        picker?.pickerData = reusePickerData
        reuseZonesTextField.inputView = picker
        picker?.selectRow(DataManager.default.zoneData.reuseZones, inComponent: 0, animated: true)
        
        
        
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
        reuseZonesTextField.inputAccessoryView = pickerAccessory
        
        addDoneClearButtonTo(reuseZonesTextField)
        
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
    
    
    
// clear button clicked
   @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
            reuseZonesTextField?.resignFirstResponder()
            reuseZonesTextField.text = "0"
            DataManager.default.zoneData.reuseZones = 0
    
        }
 // done button clicked
   @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
            reuseZonesTextField?.resignFirstResponder()
            reuseZonesTextField.text = picker?.selectedValue
    if let newValue = picker?.selectedValue {
        DataManager.default.zoneData.reuseZones = Int(newValue)!
            
}

}
}



