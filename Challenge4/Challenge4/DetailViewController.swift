//
//  DetailViewController.swift
//  Challenge4
//
//  Created by Hrvoje Vuković on 20/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var pictureImageView: UIImageView!
    
    var selectedPicture: Picture?
    
    let defaults = UserDefaults.standard
    
    // MARK: - INIT
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        pictureImageView = UIImageView()
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        pictureImageView.contentMode = .scaleAspectFit
        view.addSubview(pictureImageView)
        
        NSLayoutConstraint.activate([
            pictureImageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            pictureImageView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pictureImageView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let picture = selectedPicture {
            let url = Utils.getDocumentsDirectory().appendingPathComponent(picture.imageName)
            pictureImageView.image = UIImage(contentsOfFile: url.path)
            setupNavigationBar(title: picture.caption)
        }
    }
    
    fileprivate func setupNavigationBar(title pictureCaption: String) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Marker Felt", size: 20)!]
        title = pictureCaption
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    // MARK: - SELECTORS
    
    @objc func shareTapped() {
        guard let image = pictureImageView.image?.jpegData(compressionQuality: 0.8) else { return }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true)
    }
    
}
