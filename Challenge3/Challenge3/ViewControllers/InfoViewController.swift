//
//  SettingsViewController.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 30/06/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

private let reuseIdentifier = "InfoCell"

class InfoViewController: UITableViewController {
    var userInfoHeader: UserInfoHeaderView!
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Info & Settings"
        
        tableView.register(InfoCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.sectionFooterHeight = 0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetApp))
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeaderView(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        //tableView.tableFooterView = UIView()
    }
    
    // MARK: - TABLEVIEW METHODS
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Constants.BLUE
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = InfoSection(rawValue: section)?.description
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = .white
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return InfoSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = InfoSection(rawValue: section) else { return 0 }
        
        switch section {
        case .settings: return SettingsOptions.allCases.count
        case .advanced: return AdvancedOptions.allCases.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! InfoCell
        guard let section = InfoSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .settings:
            cell.infoType = SettingsOptions(rawValue: indexPath.row)
        case .advanced:
            cell.infoType = AdvancedOptions(rawValue: indexPath.row)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = InfoSection(rawValue: indexPath.section) else { return }
        let defaults = UserDefaults.standard
        
        switch section {
        case .settings:
            guard let settingsOptions = SettingsOptions(rawValue: indexPath.row) else { return }
            switch settingsOptions {
            case .wordLanguage:
                let settingsVC = SettingsViewController(style: .grouped)
                settingsVC.settingsType = SettingsOptions.wordLanguage
                settingsVC.title = "Word Language"
                settingsVC.data = WordLanguages.allCases.map { $0.description }
                self.navigationController?.pushViewController(settingsVC, animated: true)
                
            case .listOfAllWords:
                let settingsVC = SettingsViewController(style: .grouped)
                settingsVC.settingsType = SettingsOptions.listOfAllWords
                settingsVC.title = "List of Words and Hints"
                
                let activeWordsAndHints = defaults.getLanguageWordsAndHints(language: defaults.getWordLanguage())
                settingsVC.data = joinedWordAndHintInArray(languageWordsAndHints: activeWordsAndHints)
                
                self.navigationController?.pushViewController(settingsVC, animated: true)
            }
        case .advanced:
            print("Advanced")
        }
    }
    
    // MARK: - SELECTORS
    
    @objc func resetApp() {
        let alertController = UIAlertController(title: "Reset all settings and changes!", message: "Are you sure?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let defaults = UserDefaults.standard
            let dictionary = defaults.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
            }
            print("User Defaults reseted!")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            UIView.transition(with: appDelegate.window!, duration: 0.3, options: .transitionFlipFromTop, animations: { [weak appDelegate] in
                appDelegate?.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Start")
            })
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    // MARK: - HELPER FUNCTIONS
    
    fileprivate func joinedWordAndHintInArray(languageWordsAndHints: [Details]) -> [String] {
        return languageWordsAndHints.map({ $0.word + "-(\($0.hint))" })
    }
    
}
