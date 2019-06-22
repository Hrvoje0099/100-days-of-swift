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
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageName = selectedImage {
            imageView.image = UIImage(named: imageName)
            
            setupNavigationBar(title: imageName)
        }
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    fileprivate func setupNavigationBar(title imageName: String) {
        let countryName = (imageName.split(separator: ".").first!).uppercased()
        title = countryName
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else { return }
        
        let vc = UIActivityViewController(activityItems: [image, title ?? "Unknown flag"], applicationActivities: [])
        present(vc, animated: true)
    }

}
