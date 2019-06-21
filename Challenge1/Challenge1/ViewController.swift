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
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "FLAGS"
        
        loadFlags()
    }
    
    fileprivate func loadFlags() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("png") {
                flags.append(item)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return flags.count
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
        let flag = flags[indexPath.section]
        
        cell.imageView?.image = UIImage(named: flag)
        cell.imageView?.layer.borderWidth = 0.5
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        cell.textLabel?.text = (flag.split(separator: ".").first!).capitalized
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: detailViewControllerIdentifier) as? DetailViewController {
            vc.selectedFlag = flags[indexPath.section]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

