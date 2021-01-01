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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //keyboard Observer
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //custom cell nib
        
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 91.0
        //tableView.isScrollEnabled = true
        
        
   
       
       
        
    }
    
    
  //show keyboard func
    @objc private func keyboardWillShow(notification: NSNotification) {
        
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
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell", for: indexPath) as? DemoTableViewCell else {
             return UITableViewCell()
        }
        
        let zone = self.zoneArray[indexPath.row]
        
        cell.addDoneButtonToZone(cell.zoneTextField)
        cell.addDoneButtonToOutlet(cell.outletTextField)
        
        cell.zoneTextField.placeholder = "Enter name"
        cell.outletTextField.placeholder = "Enter number"
        
        cell.zoneTextField.delegate = self
        cell.outletTextField.delegate = self
        
        cell.zoneTextField.tag = indexPath.row
        cell.outletTextField.tag = indexPath.row
        
        cell.zoneLabel.text = "Zone " + String(zone.zoneNumber!)
        
    
        if zone.zoneName != nil {
            cell.zoneTextField.text = zone.zoneName
        } else {
            cell.zoneTextField.text = ""
        }

        if zone.outletNumber != nil {
            cell.outletTextField.text = String(zone.outletNumber!)
        } else {
            cell.outletTextField.text = ""
        }
        
        return cell
            
    }
    
  
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.becomeFirstResponder()
//    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in 0..<zoneArray.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell : DemoTableViewCell? = self.tableView.cellForRow(at: indexPath) as! DemoTableViewCell?
            let zone = self.zoneArray[indexPath.row]
            
            if cell?.zoneTextField.text != nil {
                zone.zoneName = cell?.zoneTextField.text
            }
            
            if cell?.outletTextField.text != nil {
                zone.outletNumber = Int(cell?.outletTextField.text ?? "")
            }
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
    
   
    
    
    //check textfields for nil, if true - alert
    
    func checkEmptyFields() {
        
  
        for i in 0..<zoneArray.count {

            let indexPath = IndexPath(row: i, section: 0)
            let zone = self.zoneArray[indexPath.row]
            let cell : DemoTableViewCell? = self.tableView.cellForRow(at: indexPath) as! DemoTableViewCell?
            

            if zone.zoneName == nil || zone.zoneName == "" {
                checkComplete = false
                showAlert(title: "Empty Zone Name", message: "Enter the name of the Zone \(zone.zoneNumber!)")
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    cell?.zoneTextField.becomeFirstResponder()
                }
           break
            } else {
                checkComplete = true

            }

    }
    }
                
//        for i in 0..<zoneArray.count {
//            let indexPath = IndexPath(row: i, section: 0)
//            let zone = self.zoneArray[indexPath.row]
//            let cell : DemoTableViewCell? = self.tableView.cellForRow(at: indexPath) as! DemoTableViewCell?
//
//            switch zone.zoneName {
//            case nil:
//                cell?.zoneTextField.tag = indexPath.row
//                checkComplete = false
//                showAlert(title: "Empty Zone Name", message: "Enter the name of the Zone \(zone.zoneNumber!)")
//                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                cell?.zoneTextField.becomeFirstResponder()}
//                break
//            case "":
//                cell?.zoneTextField.tag = indexPath.row
//                checkComplete = false
//                showAlert(title: "Empty Zone Name", message: "Enter the name of the Zone \(zone.zoneNumber!)")
//                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                cell?.zoneTextField.becomeFirstResponder()}
//                break
//            default:
//                checkComplete = true
//            }
//        }
//
//
//
//    }

//            if zone.outletNumber == nil {
//                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//            } else {
//                checkComplete = true
//            }
//                if cell?.outletTextField.text == "" {
//                checkComplete = false
//                cell?.outletTextField.becomeFirstResponder()
//                showAlert(title: "Empty No. of Outlet", message: "Enter the outlet's number of the Zone \(zone.zoneNumber!)")
//                    return
//
  
    
    
    
    
    
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
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}










