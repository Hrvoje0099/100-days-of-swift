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
        
        if let settingsType = settingsType {
            if settingsType == .listOfAllWords {
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewWord))
            }
        }
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: CGFloat.leastNormalMagnitude)))
    }
    
    // MARK: - TABLEVIEW METHODS
    
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
                    cell.labelLeft.text = String(cellDataSplited[0]).lowercased()
                    cell.labelRight.text = String(cellDataSplited[1]).lowercased()
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let settingsType = settingsType {
            if settingsType == .wordLanguage {
                if let selectedWordLang = data?[indexPath.row] {
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
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if let settingsType = settingsType {
            if let dataCount = data?.count {
                if settingsType == .listOfAllWords && dataCount > 2 {
                    return .delete
                }
            }
        }
        return .none
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteWord(at: indexPath)
    }
    
    // MARK: - SELECTORS
    
    @objc func addNewWord() {
        let newWordVC = WordViewController(style: .grouped)
        navigationController?.pushViewController(newWordVC, animated: true)
    }
    
    // MARK: - HELPER FUNCTIONS
    
    fileprivate func deleteWord(at indexPath: IndexPath) {
        let ac = UIAlertController(title: "Deleting word...", message: "Are you sure?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.data?.remove(at: indexPath.row)
            var allWords = self?.defaults.getAllWords()
            allWords!.remove(at: indexPath.row)
            self?.defaults.setAllWords(value: allWords!)
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
}
