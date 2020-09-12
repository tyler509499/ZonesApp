//
//  SecondViewController.swift
//  ZonesApp
//
//  Created by Galkov Nikita on 22.08.2020.
//  Copyright © 2020 Galkov Nikita. All rights reserved.
//

import UIKit




class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
@IBOutlet public var tableView: UITableView!
    
    
    
    private var privateNewZone = DataManager.default.zoneData.newZones
    
    override func viewDidLoad() {
    super.viewDidLoad()
        

        
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.rowHeight = 91.0
        
    
}

    
    
    @IBAction func doneButtonSaveReturn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell", for: indexPath) as! DemoTableViewCell
        
        let zone = DataManager.default.zoneData.newZones[indexPath.row]
        cell.zoneLabel.text = "Zone " + String(zone.zoneNumber)
        cell.zoneTextField.text = zone.zoneName
        cell.outletTextField.text = String(zone.outletNumber)
        self.tableView.reloadData()
            return cell
        
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
       
//       delete row by swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            tableView.endUpdates()
           }
       }
    
    

    //insert new row button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        DataManager.default.zoneData.newZones.append(NewZones(zoneNumber: DataManager.default.zoneData.newZones.count + 1, zoneName: "", outletNumber: 0))
        let indexPath = IndexPath(row: DataManager.default.zoneData.newZones.count - 1, section: 0)
        
        self.tableView.beginUpdates()
        
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
        }
    }





    
    
    
    

