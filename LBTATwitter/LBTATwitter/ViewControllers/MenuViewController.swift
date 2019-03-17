//
//  MenuViewController.swift
//  LBTATwitter
//
//  Created by Islas Girão Garcia on 08/03/19.
//  Copyright © 2019 Islas Girão Garcia. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "Menu item"
        cell.detailTextLabel?.text = "\(indexPath.row)"
        
        return cell
    }

}


