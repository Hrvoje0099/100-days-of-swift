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
    var userInfoHeader: UserInfoHeader!
    
    //MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Info & Settings"
        
        tableView.register(InfoCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.sectionFooterHeight = 0
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        //tableView.tableFooterView = UIView()
    }
    
    //MARK: - TABLEVIEW METHODS
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Constants.MY_BLUE
        
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
        case .Settings: return SettingsOptions.allCases.count
        case .Advanced: return AdvancedOptions.allCases.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! InfoCell
        guard let section = InfoSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Settings:
            cell.sectionType = SettingsOptions(rawValue: indexPath.row)
        case .Advanced:
            cell.sectionType = AdvancedOptions(rawValue: indexPath.row)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = InfoSection(rawValue: indexPath.section) else { return }
        let defaults = UserDefaults.standard
        
        switch section {
        case .Settings:
            guard let settingsOptions = SettingsOptions(rawValue: indexPath.row) else { return }
            switch settingsOptions {
            case .wordLanguage:
                let vc = SettingsViewController(style: .grouped)
                vc.settingsType = SettingsOptions.wordLanguage
                vc.title = "Word Language"
                vc.data = WordLanguages.allCases.map { $0.description }
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .listOfAllWords:
                let vc = SettingsViewController()
                vc.settingsType = SettingsOptions.listOfAllWords
                vc.title = "List of Words and Hints"
                
                let activeWordsAndHints = defaults.getLanguageWordsAndHints(language: defaults.getWordLanguage())
                vc.data = getJoinedWordAndHintInArray(languageWordsAndHints: activeWordsAndHints)
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .Advanced:
            print(AdvancedOptions(rawValue: indexPath.row)!.description)
        }
    }
    
    //MARK: - HELPER FUNCTIONS
    
    fileprivate func getJoinedWordAndHintInArray(languageWordsAndHints: [Details]) -> [String] {
        return languageWordsAndHints.map({ $0.word + "-(\($0.hint))" })
    }
    
}
