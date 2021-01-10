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
    @IBAction private func doneButtonSaveReturn(_ sender: Any) {
        checkEmptyFields()

        if checkComplete == true || zoneArray.isEmpty{
            delegate?.sendDataToFirst(zoneArrayFromSecond: self.zoneArray)
            dismiss(animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zoneArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell", for: indexPath) as? DemoTableViewCell else {
            return UITableViewCell()
        }
        
        let zone = self.zoneArray[indexPath.row]
        
        cell.modelToTableViewUpdate(zone)
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //update zone Number
    private func refreshZoneOrders() {
        if !zoneArray.isEmpty {
            for i in 0..<zoneArray.count {zoneArray[i].zoneNumber = i + 1}
        }
        
    }
    
    //check textfields for nil, if true - alert
    
    private func checkEmptyFields() {
        
        for i in 0..<zoneArray.count {
            
            let indexPath = IndexPath(row: i, section: 0)
            let zone = self.zoneArray[indexPath.row]
            //alert for zone Name
            if zone.zoneName == nil || zone.zoneName == "" {
                checkComplete = false
                let alert = UIAlertController(title: "Empty Zone Name", message: "Enter the name of the Zone \(zone.zoneNumber!)", preferredStyle: .alert)
                present(alert, animated: true, completion: nil)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
                    self.tableView.scrollToRow(at: indexPath, at: . middle, animated: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                        let cell : DemoTableViewCell? = self.tableView.cellForRow(at: indexPath) as! DemoTableViewCell?
                        cell?.zoneTextField.becomeFirstResponder()
                        
                    }
                })
                alert.addAction(okAction)
                
                break
            } else {
                checkComplete = true
            }
            
            // alert for No of outlets
            if zone.outletNumber == nil {
                
                checkComplete = false
                let alert = UIAlertController(title: "Empty No. of outlet", message: "Enter the No. of outlet of the Zone \(zone.zoneNumber!)", preferredStyle: .alert)
                present(alert, animated: true, completion: nil)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
                    self.tableView.scrollToRow(at: indexPath, at: . middle, animated: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                        let cell : DemoTableViewCell? = self.tableView.cellForRow(at: indexPath) as! DemoTableViewCell?
                        cell?.outletTextField.becomeFirstResponder()
                    }
                })
                alert.addAction(okAction)
                break
                
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
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: self.zoneArray.count, section: 0)
        zoneArray.append(NewZones(zoneNumber: indexPath.row + 1, zoneName: nil , outletNumber: nil))
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}










