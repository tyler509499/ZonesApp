//
//  FirstViewControllerPicker.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 22.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit

class MyPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
 public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerData != nil {
            return pickerData!.count
        } else {
            return 0
        }
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerData != nil {
            return pickerData![row]
        } else {
            return ""
        }
    }

    //Data of the picker
    
public var pickerData: [String]? {
    didSet {
        super.delegate = self
        super.dataSource = self
        self.reloadAllComponents()
    }
}




//Get the selected value from picker

public var selectedValue: String {
    get {
        if pickerData != nil {
            return pickerData![selectedRow(inComponent: 0)]
        } else {
            return ""
        }
    }
}
}
