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

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
@IBOutlet public var tableView: UITableView!
    
    var delegate: SendDataToFirstVCDelegate?
    var zoneArray = [NewZones]()

    
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()

        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 91.0
       
    
}

    
    
    @IBAction func doneButtonSaveReturn(_ sender: Any) {
        
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
       
        var zone = self.zoneArray[indexPath.row]
        cell.zoneTextField.placeholder = "Enter name"
        cell.outletTextField.placeholder = "Enter number"
        
        
        
        zone.zoneNumber = indexPath.row + 1
        cell.zoneLabel.text = "Zone " + String(zone.zoneNumber!)
        cell.zoneTextField.text = zone.zoneName
        
        
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
        
        //zoneArray.append(NewZones(zoneNumber: zone.zoneNumber, zoneName: cell.zoneTextField.text, outletNumber: Int(cell.outletTextField.text ?? "")))
        return cell
        
        
        
      
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
       
//       delete row by swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                zoneArray.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            }
        }
    
    
    //insert new row button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: zoneArray.count, section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        zoneArray.append(NewZones(zoneNumber: indexPath.row + 1, zoneName: nil, outletNumber: nil))
        self.tableView.endUpdates()
  }
    
}



    
    
    
    

