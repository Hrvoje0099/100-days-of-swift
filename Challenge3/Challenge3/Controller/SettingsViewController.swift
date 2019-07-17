//
//  WordLanguageViewController.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 02/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

class SettingsViewController: UITableViewController {
    let defaults = UserDefaults.standard
    
    var settingsType: SettingsOptions?
    var data: [String]?
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: CGFloat.leastNormalMagnitude)))
    }
    
    //MARK: - TABLEVIEW METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataCount = data?.count else { return 0 }
        return dataCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SettingsCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        
        if let cellData = data?[indexPath.row] {
            if let settingsType = settingsType {
                switch settingsType {
                case .wordLanguage:
                    cell.labelLeft.text = cellData
                    cell.accessoryType = defaults.getWordLanguage() == cellData ? .checkmark : .none
                case .listOfAllWords:
                    let cellDataSplited = cellData.split(separator: "-")
                    cell.labelLeft.text = String(cellDataSplited[0])
                    cell.labelRight.text = String(cellDataSplited[1])
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let settingsType = settingsType {
            if settingsType == .wordLanguage {
                let selectedWordLang = data![indexPath.row]
                let activeWordLang = defaults.getWordLanguage()
                
                if selectedWordLang != activeWordLang {
                    defaults.setWordLanguage(value: selectedWordLang)
                    
                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                    tableView.reloadData()
                    
                    navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
}
