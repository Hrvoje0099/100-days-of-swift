//
//  InfoCellTableViewCell.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 03/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    let defaults = UserDefaults.standard
    
    // MARK: - PROPERTIES
    
    var infoType: InfoSectionType? {
        didSet {
            guard let infoType = infoType else { return }
            textLabel?.text = infoType.description
            switchControl.isHidden = !infoType.containsSwitch
            accessoryType = infoType.isDisclosureIndicator ? .disclosureIndicator : .none
            selectionStyle = infoType.isDisclosureIndicator ? .default : .none
        }
    }
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.isOn = defaults.useShowHint()
        switchControl.onTintColor = Constants.BLUE
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(switchControl)
        
        NSLayoutConstraint.activate([
            switchControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemnted")
    }
    
    // MARK: - SELECTORS
    
    @objc func handleSwitchAction(sender: UISwitch) {
        guard let sectionType = infoType?.description else { return }
        if sender.isOn {
            if sectionType == AdvancedOptions.showHint.description { defaults.setUseShowHint(value: true) }
        } else {
            if sectionType == AdvancedOptions.showHint.description { defaults.setUseShowHint(value: false) }
        }
    }

}
