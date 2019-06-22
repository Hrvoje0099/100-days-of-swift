//
//  ViewController.swift
//  Challenge1
//
//  Created by Hrvoje Vuković on 03/03/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let cellIdentifier = "picture"
    let detailViewControllerIdentifier = "detailVC"
    
    var images = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "FLAGS"
        
        loadImages()
    }
    
    fileprivate func loadImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("png") {
                images.append(item)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let imageName = images[indexPath.section]
        
        cell.imageView?.image = UIImage(named: imageName)
        cell.imageView?.layer.borderWidth = 0.5
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        
        let countryName = (imageName.split(separator: ".").first!).capitalized
        cell.textLabel?.text = countryName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: detailViewControllerIdentifier) as? DetailViewController {
            vc.selectedImage = images[indexPath.section]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

