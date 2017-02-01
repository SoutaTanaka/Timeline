//
//  ViewController.swift
//  Timeline1
//
//  Created by 田中颯太 on 2016/12/23.
//  Copyright © 2016年 田中颯太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var username: [String] = []
    var titlename: [String] = []
    var honbun: [String] = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return honbun.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.tille.text = titlename[indexPath.row]
        cell.users.text = username[indexPath.row]
        cell.bun.text = honbun[indexPath.row]
        return cell
    }
    
    @IBAction func lode (){
        let ref = FIRDatabase.database().reference()
        username.removeAll()
        titlename.removeAll()
        honbun.removeAll()
        
        ref.observe(FIRDataEventType.childAdded, with: { snapshot in
            guard let value = snapshot.value as? [String: String] else { return }
            if let bun = value["bun"],
                let name = value["Users"],
                let title = value["title"] {
                self.username.insert(name, at: 0)
                self.titlename.insert(title, at: 0)
                self.honbun.insert(bun, at: 0)
                self.tableView.reloadData()
            }
        })
        
    }
    
    
}

