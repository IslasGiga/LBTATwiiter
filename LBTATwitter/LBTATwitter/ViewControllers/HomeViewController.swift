//
//  ViewController.swift
//  LBTATwitter
//
//  Created by Islas Girão Garcia on 08/03/19.
//  Copyright © 2019 Islas Girão Garcia. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    //MARK: - Properties
    let menuViewController = MenuViewController()
    fileprivate var menuWidth: CGFloat = 300
    fileprivate var isOpenedMenu = false
    fileprivate var velocityOpenThreshold: CGFloat = 500
    fileprivate var darkCoverView = UIView()
    
    //MARK: - fileprivate funcions
    
    
    
    
    //MARK: - ViewDidLoad ans initial setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        setupNavigationBar()
        setupMenuInitialPosition()
        setupDarkCoverView()
        view.backgroundColor = .red
    }
    
    fileprivate func setupNavigationBar() {
        title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleClose))
    }
    
    fileprivate func setupDarkCoverView(){
        let window = UIApplication.shared.keyWindow
        
        darkCoverView.alpha = 0
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        window?.addSubview(darkCoverView)
        darkCoverView.frame = window?.frame ?? .zero
        darkCoverView.isUserInteractionEnabled = false
        
    }
    
    fileprivate func setupMenuInitialPosition() {
        menuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.bounds.height)
        UIApplication.shared.keyWindow?.addSubview(menuViewController.view)
        addChild(menuViewController)
    }
    
    fileprivate func setupGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    //MARK: - Menu functions

    @objc func handlePan(gesture: UIPanGestureRecognizer){
        if gesture.state == .changed{
            let translation = gesture.translation(in: view)
            var x = translation.x
            print("x: \(x)")
           
            if isOpenedMenu{
                x += menuWidth
            }
            
            x = min(menuWidth, x)
            x = max(0, x)
            let transform = CGAffineTransform(translationX: x, y: 0)
            menuViewController.view.transform = transform
            navigationController?.view.transform = transform
            darkCoverView.transform = transform
            darkCoverView.alpha = x / menuWidth
        }else if gesture.state == .ended{
            handleEnded(gesture)
        }
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocicity = gesture.velocity(in: view)
        
        let x = translation.x
        if isOpenedMenu{
            
            if abs(velocicity.x) > velocityOpenThreshold{
                handleClose()
                return
            }
            
            if abs(x) < menuWidth/2{
                handleOpen()
            }else{
                handleClose()
            }
        }else{
            
            if velocicity.x > velocityOpenThreshold{
                handleOpen()
                return
            }
            
            if x < menuWidth/2{
                handleClose()
            }else{
                handleOpen()
            }
        }
    }
    
    @objc func handleOpen(){
        isOpenedMenu = true
        animateMenu(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
    }
    
    @objc func handleClose(){
        isOpenedMenu = false
        animateMenu(transform: .identity)
        
    }
    
    fileprivate func animateMenu(transform: CGAffineTransform){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuViewController.view.transform = transform
            self.navigationController?.view.transform = transform
            self.darkCoverView.transform = transform
            self.darkCoverView.alpha = transform == .identity ? 0 : 1
        })
    }
    
     //MARK: - TableView Datasource
    
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

