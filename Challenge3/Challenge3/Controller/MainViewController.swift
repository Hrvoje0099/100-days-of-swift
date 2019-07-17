//
//  ViewController.swift
//  Challenge3
//
//  Created by Hrvoje Vuković on 23/06/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var scoreLabel: UILabel!
    var imageView: UIImageView!
    var answerTextfield: UITextField!
    var hintLabel: UILabel!
    var stackView1: UIStackView!
    var stackView2: UIStackView!
    var stackView3: UIStackView!
    var stackView4: UIStackView!
    
    let defaults = UserDefaults.standard
    
    var tappedLetterButtons = [UIButton]()
    
    var wordsLanguage: String = ""
    
    var hiddenWord: String = ""
    var lastHiddenWord: String = ""
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var numberOfMissing: Int = 0 {
        didSet {
            imageView.image = UIImage(named: "Hangman-\(numberOfMissing)")
        }
    }
    
    //MARK: - INIT
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        title = "Hangman"
        
        addElementsOnView()
        setConstraintsForElements()
    }
    
    fileprivate func addElementsOnView() {
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont.init(name: "Marker Felt", size: 26)
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        answerTextfield = UITextField()
        answerTextfield.font = UIFont.init(name: "Marker Felt", size: 26)
        answerTextfield.translatesAutoresizingMaskIntoConstraints = false
        answerTextfield.textAlignment = .center
        answerTextfield.isUserInteractionEnabled = false
        answerTextfield.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answerTextfield)
        
        hintLabel = UILabel()
        hintLabel.font = UIFont.init(name: "Marker Felt", size: 16)
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.textAlignment = .center
        view.addSubview(hintLabel)
        
        stackView1 = UIStackView()
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.distribution = .fillEqually
        stackView1.axis = .horizontal
        view.addSubview(stackView1)
        
        stackView2 = UIStackView()
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.distribution = .fillEqually
        stackView2.axis = .horizontal
        view.addSubview(stackView2)
        
        stackView3 = UIStackView()
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView3.distribution = .fillEqually
        stackView3.axis = .horizontal
        view.addSubview(stackView3)
        
        stackView4 = UIStackView()
        stackView4.translatesAutoresizingMaskIntoConstraints = false
        stackView4.distribution = .fillEqually
        stackView4.axis = .horizontal
        view.addSubview(stackView4)
        
        addLettersRow(startPosition: 0, numberOfLettersInRow: 6, stackView: stackView1)
        addLettersRow(startPosition: 6, numberOfLettersInRow: 7, stackView: stackView2)
        addLettersRow(startPosition: 13, numberOfLettersInRow: 6, stackView: stackView3)
        addLettersRow(startPosition: 19, numberOfLettersInRow: 7, stackView: stackView4)
    }
    
    fileprivate func addLettersRow(startPosition: Int, numberOfLettersInRow: Int, stackView: UIStackView) {
        for letter in 0..<numberOfLettersInRow {
            let letterButton = UIButton(type: .system)
            letterButton.tintColor = Constants.MY_BLUE
            letterButton.titleLabel?.font = UIFont.init(name: "Marker Felt", size: 30)
            letterButton.setTitle(Constants.LETTERS[startPosition + letter], for: .normal)
            letterButton.contentHorizontalAlignment = .center
            letterButton.contentVerticalAlignment = .center
            letterButton.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(letterButton)
        }
    }
    
    fileprivate func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 15),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            answerTextfield.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            answerTextfield.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.7),
            answerTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            hintLabel.topAnchor.constraint(equalTo: answerTextfield.bottomAnchor, constant: 5),
            hintLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.9),
            hintLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            stackView1.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 50),
            stackView1.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1.0),
            stackView1.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 5),
            stackView2.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1.0),
            stackView2.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 5),
            stackView3.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1.0),
            stackView3.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            stackView4.topAnchor.constraint(equalTo: stackView3.bottomAnchor, constant: 5),
            stackView4.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1.0),
            stackView4.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            stackView4.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -5)
        ])
    }
    
    //MARK: - VIEW METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //resetDefaults()   //if we need reset defaults for testing
        
        setupNavigationBar()
        getWordsFromJSON()
        startNewGame()
    }
    
    fileprivate func setupNavigationBar() {
        let font = UIFont.systemFont(ofSize: 26)
        let color = Constants.MY_BLUE
        let attributes = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : color]
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        let infoBarButton = UIBarButtonItem(customView: infoButton)
        navigationItem.leftBarButtonItem = infoBarButton
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startNewGame))
        rightBarButtonItem.setTitleTextAttributes(attributes, for: .normal)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIsLanguageChanged()
        checkIsUseShowHintChanged()
    }
    
    fileprivate func restoreViewAndLetterButtons() {
        self.view.isUserInteractionEnabled = true
        for letterButton in tappedLetterButtons {
            letterButton.isUserInteractionEnabled = true
            letterButton.backgroundColor = .white
        }
    }
    
    //MARK: - JSON METHODS
    
    fileprivate func getWordsFromJSON() {
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                if let jsonResult = try? JSONDecoder().decode([Word].self, from: jsonData) {
                    saveWordsAndHints(from: jsonResult)
                }
            } catch {
                print("Error with parsing JSON: \(error)")
            }
        }
    }
    
    fileprivate func saveWordsAndHints(from jsonResult: [Word]) {
        let croWordsAndHints = jsonResult.map({ $0.hr })
        defaults.setLanguageWordsAndHints(language: WordLanguages.Croatian.description, value: croWordsAndHints)
        
        let engWordsAndHints = jsonResult.map({ $0.en })
        defaults.setLanguageWordsAndHints(language: WordLanguages.English.description, value: engWordsAndHints)
    }
    
    //MARK: - SELECTORS
    
    @objc fileprivate func startNewGame() {
        numberOfMissing = 0
        
        wordsLanguage = defaults.getWordLanguage()
        let activeWordsAndHints = defaults.getLanguageWordsAndHints(language: wordsLanguage)
        createHiddenWord(from: activeWordsAndHints)
        print(hiddenWord)
        
        answerTextfield.text = String.init(repeating: "_ ", count: hiddenWord.count).trimmingCharacters(in: .whitespaces)
        
        if tappedLetterButtons.count > 0 { restoreViewAndLetterButtons() }
    }
    
    @objc func letterButtonTapped(_ letterButton: UIButton) {
        guard let tappedLetter = letterButton.titleLabel?.text else { return }
        
        if(hiddenWord.contains(tappedLetter)) {
            markRightLetter(tappedLetter, letterButton)
        } else {
            markWrongLetter(letterButton)
            if numberOfMissing == 6 {
                return gameOver(letterButton)
            }
        }
        disableAndAppendInTappedButtons(letterButton)
        
        checkWholeWord()
    }
    
    @objc func settingsTapped() {
        let vc = InfoViewController(style: .grouped)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - GAME METHODS
    
    fileprivate func createHiddenWord(from activeWordsAndHints: [Details]) {
        guard let randomWord = activeWordsAndHints.randomElement() else { return }
        hiddenWord = randomWord.word.uppercased()
        
        if hiddenWord == lastHiddenWord { //to prevent repetition of the same word twice in a row
            createHiddenWord(from: activeWordsAndHints)
        } else {
            lastHiddenWord = hiddenWord
            hintLabel.text = randomWord.hint
        }
    }
    
    fileprivate func markRightLetter(_ tappedLetter: String, _ letterButton: UIButton) {
        for (index, char) in hiddenWord.enumerated() where String(char) == tappedLetter {
            let myIndex = index * 2 //multiply with 2 because the space between letters - each space increase index of letter multiplied by 2
            
            let firstPartUpToTappedLetter = answerTextfield.text!.prefix(myIndex)
            let secondPartAfterTappedLetter = answerTextfield.text!.dropFirst(myIndex+1) // +1 to make place for tapped letter
            
            answerTextfield.text? = firstPartUpToTappedLetter + tappedLetter + secondPartAfterTappedLetter
            score += 1
        }
        letterButton.backgroundColor = .green
    }
    
    fileprivate func markWrongLetter(_ letterButton: UIButton) {
        numberOfMissing += 1
        score -= 1
        letterButton.backgroundColor = .red
    }
    
    fileprivate func gameOver(_ letterButton: UIButton) {
        score -= 5
        disableAndAppendInTappedButtons(letterButton)
        return createAlertController(title: "Game over! \nHidden word: \(hiddenWord.uppercased())!", message: "Start new game?")
    }
    
    fileprivate func checkWholeWord() {
        let wordInTextfield = answerTextfield.text!.replacingOccurrences(of: " ", with: "")
        if(hiddenWord == wordInTextfield) {
            score += 10
            return createAlertController(title: "Congratulations!", message: "Start new game?")
        }
    }
    
    //MARK: - SETTINGS METHODS
    
    fileprivate func checkIsLanguageChanged() {
        //check is language changed in settings and if it's start new game
        let savedWordsLanguage = defaults.getWordLanguage()
        if wordsLanguage != savedWordsLanguage {
            startNewGame()
        }
    }
    
    fileprivate func checkIsUseShowHintChanged() {
        let savedUseShowHint: Bool = defaults.useShowHint()
        hintLabel.isHidden = savedUseShowHint ? false : true
    }
    
    //MARK: - HELPER FUNCTIONS
    
    fileprivate func disableAndAppendInTappedButtons(_ letterButton: UIButton) {
        letterButton.isUserInteractionEnabled = false
        tappedLetterButtons.append(letterButton)
    }
    
    fileprivate func createAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        addAlertAction(to: alertController)
        present(alertController, animated: true)
        return
    }
    
    fileprivate func addAlertAction(to alertController: UIAlertController) {
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.startNewGame()
        }))
        alertController.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { [weak self] _ in
            self?.view.isUserInteractionEnabled = false
        }))
    }
    
    //if we need reset defaults for testing
    func resetDefaults() {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}
