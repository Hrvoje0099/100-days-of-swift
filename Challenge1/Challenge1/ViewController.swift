//
//  ViewController.swift
//  Challenge1
//
//  Created by Hrvoje Vuković on 03/03/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("png") {
                flags.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "picture", for: indexPath)
        cell.textLabel?.text = (flags[indexPath.row].split(separator: ".").first!).capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detaile") as? DetaileViewController {
            vc.selectedFlag = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

