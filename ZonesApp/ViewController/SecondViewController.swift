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
    var zoneArray = [NewZones]()

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
        
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.reloadData()
        tableView.rowHeight = 91.0
        
    
}

    
    
    @IBAction func doneButtonSaveReturn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return zoneArray.count
    }

       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell", for: indexPath) as! DemoTableViewCell
        var zone = zoneArray[indexPath.row]
        zone.zoneNumber = indexPath.row + 1
        cell.zoneLabel.text = "Zone " + String(zone.zoneNumber!)
       

        return cell
        
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//           return true
//       }
       
//       delete row by swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
            zoneArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            self.tableView.reloadData()
            //self.perform(#selector(reloadTable), with: nil, afterDelay: 15)
           }
       }
    
   
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let rowToMove = zoneArray[sourceIndexPath.row]
//        zoneArray.remove(at: sourceIndexPath.row)
//        zoneArray.insert(rowToMove, at: destinationIndexPath.row)
//    }
    
    //insert new row button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: zoneArray.count, section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        zoneArray.append(NewZones(zoneNumber: indexPath.row + 1, zoneName: nil, outletNumber: nil))
        self.tableView.endUpdates()
        
  }

}



    
    
    
    

