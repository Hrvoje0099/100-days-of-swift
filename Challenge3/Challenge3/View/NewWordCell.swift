//
//  NewWordCell.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 21/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class NewWordCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    var wordType: WordType? {
        didSet {
            guard let wordType = wordType else { return }
            textLabel?.text = wordType.description
            //textLabel?.layer.borderWidth = 1
            textField.placeholder = wordType.placeholder
            textField.isHidden = !wordType.containsTextfield
            selectionStyle = .none
        }
    }
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.init(name: "Marker Felt", size: 26)
        textField.textAlignment = .left
        textField.isUserInteractionEnabled = true
        textField.addTarget(self, action: #selector(checkTextfield), for: .editingChanged)
        //textField.layer.borderWidth = 1
        return textField
    }()

    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            //textField.leftAnchor.constraint(equalTo: textLabel!.rightAnchor, constant: -12),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemnted")
    }
    
    @objc func checkTextfield(sender: UITextField) {
        guard let sectionType = wordType?.description else { return }
        if sectionType == NewWord.word.description {
            if sender.text!.checkValidationOfWord {
                //textField.text = sender.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                textField.text = String.init(sender.text!.dropLast()).replacingOccurrences(of: " ", with: "")
            }
        } else if sectionType == NewWord.hint.description {
            if sender.text!.hasPrefix(" ") /*|| sender.text!.hasSuffix(" ")*/ {
                textField.text = sender.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
    //sender.text!.replacingOccurrences(of: " ", with: "")

}

extension String {
    
    var checkValidationOfWord: Bool {
        let regex = ".*[^A-Za-z].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    /*var containsWhitespacesAndNewLines : Bool {
        print("containsWhitespacesAndNewLines")
        print((self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil))
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    var containsDecimalDigits : Bool {
        print("containsDecimalDigits")
        print((self.rangeOfCharacter(from: .decimalDigits) != nil))
        return(self.rangeOfCharacter(from: .decimalDigits) != nil)
    }*/
}
