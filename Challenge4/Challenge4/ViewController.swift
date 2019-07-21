//
//  ViewController.swift
//  Challenge4
//
//  Created by Hrvoje Vuković on 19/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PictureCell"

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pictures = [Picture]()
    
    let defaults = UserDefaults.standard
    
    // MARK: - INIT

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        
        //resetDefaults()   //if we need reset defaults for testing
        
        pictures = defaults.getPictures()
        
        tableView.register(PictureCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 100
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePhoto))
    }
    
    // MARK: - TABLEVIEW METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PictureCell
        
        let path = Utils.getDocumentsDirectory().appendingPathComponent(pictures[indexPath.row].imageName)
        cell.pictureView.image = UIImage(named: path.path)
        
        cell.captionLabel.text = pictures[indexPath.row].caption
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.selectedPicture = pictures[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pictures.remove(at: indexPath.row)
            defaults.setPicures(value: pictures)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - SELECTORS
    
    @objc func takePhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: - DELETAGE METHODS
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = Utils.getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Caption?", message: "Enter a caption for this image", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            let picture = Picture(imageName: imageName, caption: caption)
            self?.pictures.insert(picture, at: 0)
            if let pictures = self?.pictures {
                self?.defaults.setPicures(value: pictures)
            }
            self?.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        
        present(ac, animated: true)
    }
    
    // MARK: - HELPER METHODS
    
    //if we need reset defaults for testing
    fileprivate func resetDefaults() {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

}

