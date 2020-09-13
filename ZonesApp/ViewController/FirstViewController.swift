//
//  ViewController.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 22.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, PickerViewDelegate {

    @IBOutlet weak var newZonesTextField: UITextField!
    @IBOutlet weak var reuseZonesTextField: UITextField!

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
        
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
       
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
    
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func didTapDone() {
        self.reuseZonesTextField.resignFirstResponder()
    }

    func didTapCancel() {
        self.reuseZonesTextField.text = "0"
        DataManager.default.zoneData.reuseZones = 0
        self.reuseZonesTextField.resignFirstResponder()
    }
}

