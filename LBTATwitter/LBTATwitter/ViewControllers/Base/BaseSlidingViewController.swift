//
//  BaseSlidingViewController.swift
//  LBTATwitter
//
//  Created by Islas Girão Garcia on 17/03/2019.
//  Copyright © 2019 Islas Girão Garcia. All rights reserved.
//

import UIKit

class BaseSlidingViewController: UIViewController {

    
    let viewRed: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let viewBlue: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened = false
    
    
    var leadingAnchorViewRed: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupRedView()
        setupBlueView()
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        
        x = min(menuWidth, x)
        x = max(0, x)
        
        leadingAnchorViewRed.constant = x
        
        if gesture.state == .ended{
            handleEndendGesture(gesture: gesture)
        }
        
    }
    
    fileprivate func handleEndendGesture(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        if translation.x < menuWidth/2{
            leadingAnchorViewRed.constant = 0
            isMenuOpened = false
        }else{
            leadingAnchorViewRed.constant = menuWidth
            isMenuOpened = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    fileprivate func setupRedView() {
        view.addSubview(viewRed)

        NSLayoutConstraint.activate([
            viewRed.topAnchor.constraint(equalTo: view.topAnchor),
            viewRed.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewRed.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        leadingAnchorViewRed = viewRed.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0)
        leadingAnchorViewRed.isActive = true
        
        
        setupHomeViewController()
        
    }
    
    fileprivate func setupHomeViewController(){
        
        let homeVC = HomeViewController()
        let viewHome = homeVC.view!
        viewHome.translatesAutoresizingMaskIntoConstraints = false
        
        viewRed.addSubview(viewHome)
        addChild(homeVC)
        
        NSLayoutConstraint.activate([
            viewHome.topAnchor.constraint(equalTo: viewRed.topAnchor),
            viewHome.trailingAnchor.constraint(equalTo: viewRed.trailingAnchor),
            viewHome.leadingAnchor.constraint(equalTo: viewRed.safeAreaLayoutGuide.leadingAnchor),
            viewHome.bottomAnchor.constraint(equalTo: viewRed.bottomAnchor)
        ])
    }
    
    fileprivate func setupBlueView() {
        view.addSubview(viewBlue)
        NSLayoutConstraint.activate([
            viewBlue.widthAnchor.constraint(equalToConstant: menuWidth),
            viewBlue.topAnchor.constraint(equalTo: view.topAnchor),
            viewBlue.trailingAnchor.constraint(equalTo: viewRed.leadingAnchor),
            viewBlue.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewBlue.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            ])
        setupMenuViewController()
    }
    
    fileprivate func setupMenuViewController(){
        let menuVC = MenuViewController()
        let viewMenu = menuVC.view!
        viewMenu.translatesAutoresizingMaskIntoConstraints = false
        
        
        viewBlue.addSubview(viewMenu)
        addChild(menuVC)
        
        NSLayoutConstraint.activate([
            viewMenu.topAnchor.constraint(equalTo: viewBlue.topAnchor),
            viewMenu.trailingAnchor.constraint(equalTo: viewBlue.trailingAnchor),
            viewMenu.leadingAnchor.constraint(equalTo: viewBlue.leadingAnchor),
            viewMenu.bottomAnchor.constraint(equalTo: viewBlue.bottomAnchor)
            ])
    }

}
