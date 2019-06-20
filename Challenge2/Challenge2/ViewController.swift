//
//  ViewController.swift
//  Challenge2
//
//  Created by Hrvoje Vuković on 10/03/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemToShoppingList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        
        toolbarItems = [shareButton]
        navigationController?.isToolbarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

    @objc func addItemToShoppingList() {
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            
            self?.shoppingList.insert(item, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func clearShoppingList() {
        let ac: UIAlertController
        if shoppingList.count > 0 {
            ac = UIAlertController(title: "Clear shopping list", message: "Are you sure?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: delete))
        } else {
            ac = UIAlertController(title: "Shopping list is empty", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        }
        present(ac, animated: true)
    }
    
    @objc func shareList() {
        print(shoppingList)
        print(shoppingList.joined(separator: "\n"))
        
        let shoppingListJoined = shoppingList.joined(separator: "\n")
        
        let avc = UIActivityViewController(activityItems: [shoppingListJoined], applicationActivities: [])
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true)
    }
    
    func delete(action: UIAlertAction) {
        let count = 0...shoppingList.count - 1
        for _ in count {
            self.shoppingList.remove(at: 0)
            let indexPath = IndexPath(item: 0, section: 0)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

