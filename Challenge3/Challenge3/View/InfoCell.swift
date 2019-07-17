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
    
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            textLabel?.text = sectionType.description
            switchControl.isHidden = !sectionType.containsSwitch
            accessoryType = sectionType.isDisclosureIndicator ? .disclosureIndicator : .none
            selectionStyle = sectionType.isDisclosureIndicator ? .default : .none
        }
    }
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = defaults.useShowHint()
        switchControl.onTintColor = Constants.BLUE
        switchControl.translatesAutoresizingMaskIntoConstraints = false
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
        guard let sectionType = sectionType?.description else { return }
        print(sectionType)
        
        if sender.isOn {
            if sectionType == AdvancedOptions.showHint.description { defaults.setUseShowHint(value: true) }
        } else {
            if sectionType == AdvancedOptions.showHint.description { defaults.setUseShowHint(value: false) }
        }
    }

}
