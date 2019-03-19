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
    
    let viewBlack: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.8)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened = false
    fileprivate var velocityOpenThreshold: CGFloat = 500
    
    var leadingAnchorViewRed: NSLayoutConstraint!
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupViews()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
    }
    
    //MARK: - Pan functions
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        
        x = min(menuWidth, x)
        x = max(0, x)
        
        leadingAnchorViewRed.constant = x
        viewBlack.alpha = x / menuWidth
        
        
        if gesture.state == .ended{
            handleEndendGesture(gesture: gesture)
        }
        
    }
    
    
    fileprivate func handleEndendGesture(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened{
            if abs(velocity.x) > velocityOpenThreshold{
                handleClose()
                return
            }
            
            if abs(translation.x) < menuWidth/2{
                handleOpen()
                
            }else{
                handleClose()
            }
           
        }else{
            if abs(velocity.x) > velocityOpenThreshold{
                handleOpen()
                return
            }
            if abs(translation.x) < menuWidth/2{
                handleClose()
                
            }else{
                handleOpen()
            }
        }
    }
    
    //MARK: - Menu open and close functions
    
    @objc func handleOpen(){
        leadingAnchorViewRed.constant = menuWidth
        isMenuOpened = true
        performAnimations()
    }
    
    @objc func handleClose(){
        leadingAnchorViewRed.constant = 0
        isMenuOpened = false
        performAnimations()
        
    }
    
    fileprivate func performAnimations(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.viewBlack.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
    //MARK: - Setup Views
    
    
    fileprivate func setupViews() {
        setupRedView()
        setupBlueView()
        setupBlackView()
    }
    
    fileprivate func setupBlackView() {
        view.addSubview(viewBlack)
        NSLayoutConstraint.activate([
            
            viewBlack.topAnchor.constraint(equalTo: viewRed.topAnchor),
            viewBlack.leadingAnchor.constraint(equalTo: viewRed.leadingAnchor),
            viewBlack.bottomAnchor.constraint(equalTo: viewRed.bottomAnchor),
            viewBlack.trailingAnchor.constraint(equalTo: viewRed.trailingAnchor)
            ])
        viewBlack.alpha = 0
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
    
    //MARK: - Setup ViewControllers
    
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
