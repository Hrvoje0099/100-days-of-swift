//
//  DetaileViewController.swift
//  Challenge1
//
//  Created by Hrvoje Vuković on 03/03/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedFlag: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flag = selectedFlag {
            imageView.image = UIImage(named: flag)
            
            setupNavigationBar(flag: flag)
        }
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    fileprivate func setupNavigationBar(flag: String) {
        title = (flag.split(separator: ".").first!).uppercased()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else { return }
        
        let vc = UIActivityViewController(activityItems: [image, title ?? "Unknown flag"], applicationActivities: [])
        present(vc, animated: true)
    }

}
