//
//  NewWordViewController.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 21/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewWordCell"

class WordViewController: UITableViewController {
    
    // MARK: - INIT

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create New Word"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewWord))
        
        tableView.register(NewWordCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.sectionFooterHeight = 0
    }
    
    // MARK: - TABLE VIEW METHODS
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Constants.BLUE
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = WordLanguages(rawValue: section)?.description.uppercased()
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
        return WordLanguages.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewWord.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewWordCell
        cell.wordType = NewWord(rawValue: indexPath.row)
        return cell
    }
    
    // MARK: - SELECTORS
    
    @objc func saveNewWord() {
        let numberOfSections = WordLanguages.allCases.count
        let numberOfRowsInSection = NewWord.allCases.count
        var newWordParts = [String]()
        
        // for each section get its rows and in eash row cell textfield
        for section in 0..<numberOfSections {
            for row in 0..<numberOfRowsInSection {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableView.cellForRow(at: indexPath) as? NewWordCell {
                    let cellText = cell.textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !checkIsCellEmpty(cellText) { return }
                    newWordParts.append(cellText)
                }
            }
        }
        
        let newWord: Word = createNewWord(from: newWordParts)
        confirmAndSaveToUserDefaults(newWord)
    }
    
    // MARK: - NEW WORD LOGIC
    
    fileprivate func createNewWord(from newWordParts: [String]) -> Word {
        let hrNew: Details = Details(word: newWordParts[0], hint: newWordParts[1])
        let enNew: Details = Details(word: newWordParts[2], hint: newWordParts[3])
        return Word(hr: hrNew, en: enNew)
    }
    
    fileprivate func confirmAndSaveToUserDefaults(_ newWord: Word) {
        let ac = UIAlertController(title: "Save new word?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.appendNewWordToAllWordsdAndPopToRootVC(newWord)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    fileprivate func appendNewWordToAllWordsdAndPopToRootVC(_ newWord: Word) {
        print(newWord)
        let defaults = UserDefaults.standard
        var allWords = defaults.getAllWords()
        allWords.append(newWord)
        defaults.setAllWords(value: allWords)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: .transitionFlipFromRight, animations: { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    // MARK: - HELPER FUNCTIONS
    
    fileprivate func checkIsCellEmpty(_ word: String) -> Bool {
        if word.isEmpty {
            let ac = UIAlertController(title: "All fields must be filled!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
            return false
        }
        return true
    }
    
}
