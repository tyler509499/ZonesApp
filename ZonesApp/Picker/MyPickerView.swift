//
//  FirstViewControllerPicker.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 22.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit

protocol PickerViewDelegate: class {
    func didTapDone()
    func didTapCancel()
}

class MyPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public private(set) var picker: UIPickerView?
    public weak var pickerDelegate: PickerViewDelegate?


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
