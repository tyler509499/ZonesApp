//
//  SecondViewController.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 22.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit

protocol SendDataToFirstVCDelegate {
    func sendDataToFirst(zoneArrayFromSecond: [NewZones])
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet public var tableView: UITableView!

    var delegate: SendDataToFirstVCDelegate?
    var zoneArray = [NewZones]()
    var checkComplete: Bool = true

    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //custom cell nib
        
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 91.0
        
       
        
    }
    
    
  //show keyboard func
    @objc private func keyboardWillShow(notification: NSNotification) {
        textFieldDidChange()
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + tableView.rowHeight, right: 0)
            
            
           }
       }
//hide keyboard func
    @objc private func keyboardWillHide(notification: NSNotification) {
        
           tableView.contentInset = .zero
       }
    
    
    //button save to array and send array to firsv controller
    @IBAction func doneButtonSaveReturn(_ sender: Any) {
        textFieldDidChange()
        checkEmptyFields()
        if checkComplete == true {
            self.dismiss(animated: true) {
                self.delegate?.sendDataToFirst(zoneArrayFromSecond: self.zoneArray)
            }
        }
        if zoneArray.isEmpty {
            self.dismiss(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zoneArray.count
        
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell", for: indexPath) as! DemoTableViewCell
        
        let zone = self.zoneArray[indexPath.row]
        
        cell.addDoneButtonTo(cell.zoneTextField)
        cell.addDoneButtonTo(cell.outletTextField)
        
        cell.zoneTextField.placeholder = "Enter name"
        cell.outletTextField.placeholder = "Enter number"
        cell.zoneLabel.text = "Zone " + String(zone.zoneNumber!)
        
        
        cell.zoneTextField.delegate = self
        cell.outletTextField.delegate = self
    
        
        if zone.zoneName != nil {
            cell.zoneTextField.text = zone.zoneName
        }
        
        if zone.outletNumber != nil {
            cell.outletTextField.text = String(zone.outletNumber!)
        }
        
       
       
        
        
        return cell
            
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in 0..<zoneArray.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell : DemoTableViewCell? = self.tableView.cellForRow(at: indexPath) as! DemoTableViewCell?
            let zone = self.zoneArray[indexPath.row]
            zone.zoneName = cell?.zoneTextField.text
            zone.outletNumber = Int(cell?.outletTextField.text ?? "")
            
//            if !zoneArray.isEmpty {
//                cell?.zoneTextField.text = zoneArray[i].zoneName
//                cell?.outletTextField.text = String(zoneArray[i].outletNumber ?? 0)
//            }
    }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //update zone Number
    func refreshZoneOrders() {
        if !zoneArray.isEmpty {
            for i in 0..<zoneArray.count {zoneArray[i].zoneNumber = i + 1}
        }
    }
    
    //insert textfield.text value in array
    func textFieldDidChange() {
        for i in 0..<zoneArray.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell : DemoTableViewCell? = self.tableView.cellForRow(at: indexPath) as! DemoTableViewCell?
            if let zoneText = cell?.zoneTextField.text, let outletText = cell?.outletTextField.text {
                zoneArray[i].zoneName = zoneText
                zoneArray[i].outletNumber = Int(outletText)
            }
        }
    }
    //check textfields for nil, if true - alert
    
    func checkEmptyFields() {
        for i in 0..<zoneArray.count {
            //let zone = self.zoneArray[i]
            let indexPath = IndexPath(row: i, section: 0)
            let cell : DemoTableViewCell? = self.tableView.cellForRow(at: indexPath) as! DemoTableViewCell?
            if cell?.zoneTextField.text == ""{
                cell?.zoneTextField.becomeFirstResponder()
                checkComplete = false
                showAlert(title: "Empty Zone Name", message: "Enter the name of the Zone \(zoneArray[i].zoneNumber!)")
                return
                
            } else {
                checkComplete = true
            }
            if cell?.outletTextField.text == "" {
                cell?.outletTextField.becomeFirstResponder()
                checkComplete = false
                showAlert(title: "Empty No. of Outlet", message: "Enter the outlet's number of the Zone \(zoneArray[i].zoneNumber!)")
                return
                
            } else {
                checkComplete = true
            }
        }
    }
    
    
    
    //       delete row by swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            zoneArray.remove(at: indexPath.row)
            refreshZoneOrders()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.tableView.reloadData()
            }
        }
    }
    //      insert new row button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: self.zoneArray.count, section: 0)
        zoneArray.append(NewZones(zoneNumber: indexPath.row + 1, zoneName: nil , outletNumber: nil))
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
        
    }
    //allert for textfields func
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}










