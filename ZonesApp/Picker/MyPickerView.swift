//
//  FirstViewControllerPicker.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 22.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit

//class MyPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
//
////var pickerDataFromArray: FirstViewController?
//
//
// public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        if pickerData != nil {
//            return pickerData!.count
//        } else {
//            return 0
//        }
//    }
//
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerData != nil {
//            return pickerData![row]
//        } else {
//            return ""
//        }
//
//    }
//
//    //Data of the picker
//
//public var pickerData: [String]?  {
//    didSet {
//        super.delegate = self
//        super.dataSource = self
//        self.reloadAllComponents()
//    }
//}
//
////Get the selected value from picker
//
//public var selectedValue: String {
//    get {
//        if pickerData != nil {
//            return pickerData![selectedRow(inComponent: 0)]
//        } else {
//            return ""
//        }
//    }
//}
//
//
//}

// протоколы не до конца тему понял, но продолжу работать, что понять все от А до Я
protocol PickerViewDelegate: class {
    func didTapDone()
    func didTapCancel()
}

class MyPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public private(set) var picker: UIPickerView?
    public weak var pickerDelegate: PickerViewDelegate?

    //эти инициализаторы мне ХСОД сам предложил сделать, с ними еще не разобрался
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitToolbar()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitToolbar()
    }


    
    private func commonInitToolbar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.tintColor = .gray
        toolBar.backgroundColor = .gray
        toolBar.barTintColor = .black
        toolBar.sizeToFit()
        toolBar.autoresizingMask = .flexibleHeight

        

        let cancelButton = UIBarButtonItem(title: "Clear",
                                           style: .done,
                                           target: self,
                                           action: #selector(cancelTapped(_:)))
        cancelButton.tintColor = .white

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)

        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneTapped(_:)))
        doneButton.tintColor = .white
        toolBar.items = [cancelButton, flexSpace, doneButton]
        toolBar.isUserInteractionEnabled = true
        
        self.toolbar = toolBar
       
        
    }
    
    

    @objc func doneTapped(_ button: UIBarButtonItem?) {
        self.pickerDelegate?.didTapDone()
    }

    @objc func cancelTapped(_ button: UIBarButtonItem?) {
        self.pickerDelegate?.didTapCancel()
    }
}
