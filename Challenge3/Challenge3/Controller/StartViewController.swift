//
//  StartViewController.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 12/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    var titleLabel: UILabel!
    var startButton: UIButton!
    
    //MARK: - INIT
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        addElementsOnView()
        setConstraintsForElements()
    }
    
    fileprivate func addElementsOnView() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "HANGMAN"
        titleLabel.font = UIFont.init(name: "Marker Felt", size: 50)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        startButton = UIButton(type: .system)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("START", for: .normal)
        startButton.layer.borderWidth = 1
        startButton.titleLabel?.font = UIFont.init(name: "Marker Felt", size: 26)
        startButton.tintColor = .black
        startButton.backgroundColor = Constants.myBlue
        startButton.layer.cornerRadius = 5
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        view.addSubview(startButton)
    }
    
    fileprivate func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            titleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.8),
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            startButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 150),
            startButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            startButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
            ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - SELECTORS
    
    @objc func startTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIView.transition(with: appDelegate.window!, duration: 0.3, options: .transitionFlipFromTop, animations: {
            appDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainNavigation") as! UINavigationController
        })
        
    }

}
