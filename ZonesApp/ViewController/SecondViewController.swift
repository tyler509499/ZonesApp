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
    
    
    
    //var data = DataManager.default.zoneData
    
    var allCellsZoneLabelText: String = ""
    var allCellsZoneTextfieldText: String = ""
    var allCellsOutletNumber: String = ""
    
    
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
        return 3
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell", for: indexPath) as! DemoTableViewCell
        //let zone = data[indexPath.row]
    
        cell.zoneLabel.text = ""//+ String(data[indexPath.row].zoneNumber)
        cell.zoneTextField.text = ""//data[indexPath.row].zoneName
        cell.outletTextField.text = ""//String(data[indexPath.row].outletNumber)
        //self.tableView.reloadData()
        return cell
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
       
       //delete row by swipe
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//
//           if editingStyle == .delete {
//            tableView.beginUpdates()
//            tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
//            tableView.endUpdates()
//           }
//       }
//
    //insert new row button
//    @IBAction func addButtonTapped(_ sender: UIButton) {
//        let indexPath = IndexPath(row: 1, section:0)
//        tableView.beginUpdates()
//        tableView.insertRows(at: [indexPath], with: .automatic)
//        tableView.endUpdates()
//        }
//    }

    //insert new row function
//    func insertNewRow() {
//
//
//
//
//        let indexPath = IndexPath(row: 1, section: 0)
//
//        tableView.beginUpdates()
//        tableView.insertRows(at: [indexPath], with: .automatic)
//        tableView.endUpdates()
//
//    }


}
    
    
    
    

