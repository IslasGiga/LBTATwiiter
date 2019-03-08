//
//  ViewController.swift
//  LBTATwitter
//
//  Created by Islas Girão Garcia on 08/03/19.
//  Copyright © 2019 Islas Girão Garcia. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    fileprivate func setupNavigationBar() {
        title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleClose))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .red
        tableView.tableFooterView = UIView()
        
    }
    
    @objc func handleOpen(){
        print("Open menu ...")
        let vc = MenuViewController()
        vc.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 100, height: view.bounds.height)
        UIApplication.shared.keyWindow?.addSubview(vc.view)
    }
    
    @objc func handleClose(){
        print("Close menu ...")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Cell"
        cell.detailTextLabel?.text = "\(indexPath.row + 1)"
        
        return cell
    }
    
}

