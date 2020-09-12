//
//  ViewController.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 22.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, PickerViewDelegate {
//class FirstViewController: UIViewController, UITextFieldDelegate {
//
      @IBOutlet weak var newZonesTextField: UITextField!
      @IBOutlet weak var reuseZonesTextField: UITextField!
//    var picker: MyPickerView?
//    var pickerAccessory: UIToolbar?
//
//
//
//
//    let reusePickerData: [String] = { (0...14).map { "\($0)" }}()
//
//
//    private var privateZone = DataManager.default.zoneData
//
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//               newZonesTextField.resignFirstResponder()
//               reuseZonesTextField.resignFirstResponder()
//               return true
//           }
//
//
////    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////               super.touchesBegan(touches, with: event)
////               picker?.endEditing(true)
////       }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        reuseZonesTextField.text = String(privateZone.reuseZones)
//
//        //Picker
//        picker = MyPickerView()
//        picker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        picker?.backgroundColor = UIColor.white
//        picker?.pickerData = reusePickerData
//        reuseZonesTextField.inputView = picker
//        picker?.selectRow(DataManager.default.zoneData.reuseZones, inComponent: 0, animated: true)
//
//
//
//        //Toolbar
//        pickerAccessory = UIToolbar()
//        pickerAccessory?.autoresizingMask = .flexibleHeight
//        pickerAccessory?.barStyle = .default
//        pickerAccessory?.barTintColor = UIColor.gray
//        pickerAccessory?.backgroundColor = UIColor.gray
//        pickerAccessory?.isTranslucent = false
//        var frame = pickerAccessory?.frame
//        frame?.size.height = 44.0
//        pickerAccessory?.frame = frame!
//        reuseZonesTextField.inputAccessoryView = pickerAccessory
//
//        addDoneClearButtonTo(reuseZonesTextField)
//
//    }
//
//}
//
//extension FirstViewController {
//
//    //Toolbar buttons
//
//    private func addDoneClearButtonTo(_ textField: UITextField) {
//
//        let cancelButton = UIBarButtonItem(title: "Clear",
//                                           style: .done,
//                                           target: self,
//                                           action: #selector(FirstViewController.cancelBtnClicked(_:)))
//        cancelButton.tintColor = UIColor.white
//
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//                                        target: nil,
//                                        action: nil)
//
//        let doneButton = UIBarButtonItem(title: "Done",
//                                         style: .done,
//                                         target: self,
//                                         action: #selector(FirstViewController.doneBtnClicked(_:)))
//        doneButton.tintColor = UIColor.white
//        pickerAccessory?.items = [cancelButton, flexSpace, doneButton]
//
//
//    }
//
//
//
//// clear button clicked
//   @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
//            reuseZonesTextField?.resignFirstResponder()
//            reuseZonesTextField.text = "0"
//            DataManager.default.zoneData.reuseZones = 0
//
//        }
// // done button clicked
//   @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
//            reuseZonesTextField?.resignFirstResponder()
//            reuseZonesTextField.text = picker?.selectedValue
//    if let newValue = picker?.selectedValue {
//        DataManager.default.zoneData.reuseZones = Int(newValue)!
//
//}
//
//}
//}
    private var privateZone = DataManager.default.zoneData

    fileprivate let picker = MyPickerView()
    fileprivate let reusePickerData: [String] = { (0...14).map { "\($0)" }}()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        reuseZonesTextField.text = String(privateZone.reuseZones)
        
        self.reuseZonesTextField.inputView = self.picker
        self.reuseZonesTextField.inputAccessoryView = self.picker.toolbar

        self.picker.dataSource = self
        self.picker.delegate = self
        self.picker.pickerDelegate = self
        self.picker.selectRow(DataManager.default.zoneData.reuseZones, inComponent: 0, animated: true)
        
        self.picker.reloadAllComponents()
    }
    
}

extension FirstViewController {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.reusePickerData.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.reusePickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.reuseZonesTextField.text = self.reusePickerData[row]
        DataManager.default.zoneData.reuseZones = Int(reuseZonesTextField.text!)!
    }
    

}

extension FirstViewController {

    func didTapDone() {
//        let row = self.picker.selectedRow(inComponent: 0)
//        self.picker.selectRow(row, inComponent: 0, animated: false)
//        self.reuseZonesTextField.text = self.reusePickerData[row]
//        DataManager.default.zoneData.reuseZones = Int(self.reusePickerData[row])!
        self.reuseZonesTextField.resignFirstResponder()
    }

    func didTapCancel() {
        self.reuseZonesTextField.text = "0"
        DataManager.default.zoneData.reuseZones = 0
        self.reuseZonesTextField.resignFirstResponder()
    }
}

