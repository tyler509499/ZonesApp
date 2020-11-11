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
    //var rowBeingEdited : Int? = nil
    
    var customCell = DemoTableViewCell()

    
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        //zoneArray.removeAll()
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 91.0
        
}

    @IBAction func doneButtonSaveReturn(_ sender: Any) {
        textFieldDidChange()
        self.dismiss(animated: true) {
            self.delegate?.sendDataToFirst(zoneArrayFromSecond: self.zoneArray)
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
        
        cell.zoneTextField.delegate = self
        cell.outletTextField.delegate = self
        
        cell.zoneTextField.tag = indexPath.row
        cell.outletTextField.tag = indexPath.row
    
        cell.zoneTextField.placeholder = "Enter name"
        cell.outletTextField.placeholder = "Enter number"
        cell.zoneLabel.text = "Zone " + String(zone.zoneNumber!)
        
        
        if zone.zoneName != nil {
            cell.zoneTextField.text = String(zone.zoneName!)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func refreshZoneOrders() {
        if !zoneArray.isEmpty {
        for i in 0..<zoneArray.count {zoneArray[i].zoneNumber = i + 1}
        }
    }
    
    func textFieldDidChange() {
        for i in 0..<zoneArray.count {
                    let indexPath = IndexPath(row: i, section: 0)
                    let cell : DemoTableViewCell? = self.tableView.cellForRow(at: indexPath) as! DemoTableViewCell?
                    if let zoneText = cell?.zoneTextField.text {
                        zoneArray[i].zoneName = zoneText
                    }
            if let outletText = cell?.outletTextField.text {
                zoneArray[i].outletNumber = Int(outletText)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell", for: indexPath as IndexPath) as! DemoTableViewCell
        zoneArray.append(NewZones(zoneNumber: indexPath.row + 1, zoneName: cell.zoneTextField.text, outletNumber: Int(cell.outletTextField.text ?? "")))
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
}


    
    
    
    

