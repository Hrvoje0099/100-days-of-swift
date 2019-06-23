//
//  ViewController.swift
//  Challenge2
//
//  Created by Hrvoje Vuković on 10/03/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    fileprivate var shoppingList: [Item] = [] {
        didSet {
            saveData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        setupNavigationBar()
        setupToolbar()
        loadData()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemToShoppingList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
    }
    
    fileprivate func setupToolbar() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let buttonAbout = UIButton(type: .infoLight)
        buttonAbout.addTarget(self, action: #selector(aboutTapped), for: .touchUpInside)
        let about = UIBarButtonItem(customView: buttonAbout)
        
        toolbarItems = [shareButton, spacer, about]
        navigationController?.isToolbarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row].title
        cell.accessoryType = shoppingList[indexPath.row].done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shoppingList[indexPath.row].done = !shoppingList[indexPath.row].done 
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    @objc func addItemToShoppingList() {
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let itemTitle = ac?.textFields?[0].text, !itemTitle.isEmpty else { return }
            
            if (self?.isItemAlreadyOnShoppingList(itemTitle))! {
                self?.showAlertController(title: "Item present", message: "\"\(itemTitle)\" is already on your shopping list", withCancelButton: false, handler: nil)
                return
            }
            
            self?.insertItem(itemTitle)
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    fileprivate func insertItem(_ itemTitle: String) {
        var newItem = Item()
        newItem.title = itemTitle
        shoppingList.insert(newItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    fileprivate func isItemAlreadyOnShoppingList(_ item: String) -> Bool {
        return shoppingList.contains(where: {
            $0.title.compare(item, options: .caseInsensitive) == .orderedSame
        })
    }
    
    @objc func clearShoppingList() {
        if shoppingList.count > 0 {
            showAlertController(title: "Clear shooping list", message: "Are you sure?", withCancelButton: true, handler: delete(action:))
        } else {
            showAlertController(title: "Shooping list is empty", message: nil, withCancelButton: false, handler: nil)
        }
    }
    
    fileprivate func delete(action: UIAlertAction) {
        let count = 0...shoppingList.count - 1
        for _ in count {
            self.shoppingList.remove(at: 0)
            let indexPath = IndexPath(item: 0, section: 0)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func shareList() {
        let shoppingListJoined = shoppingList.map({$0.title}).joined(separator: "\n")
        let avc = UIActivityViewController(activityItems: [shoppingListJoined], applicationActivities: [])
        present(avc, animated: true)
    }
    
    @objc func aboutTapped() {
        showAlertController(title: "ABOUT", message: "\nCreated by: Hrvoje0099\nApplication for creating a shopping list!", withCancelButton: false, handler: nil)
    }
    
    fileprivate func loadData() {
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "shoppingList") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                shoppingList = try jsonDecoder.decode([Item].self, from: savedPeople)
            } catch {
                print("Failed to load shooping list!")
            }
        }
    }
    
    fileprivate func saveData() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(shoppingList) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "shoppingList")
        }
        print("save")
    }
    
    fileprivate func showAlertController(title: String?, message: String?, withCancelButton: Bool, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        if withCancelButton {
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
        present(ac, animated: true)
    }

}
