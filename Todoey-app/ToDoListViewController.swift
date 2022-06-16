//
//  ViewController.swift
//  Todoey-app
//
//  Created by Stacy on 16.06.22.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["item1", "item2", "item3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - TableView DataSource methods
    
    // what a cell should display
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel!.text = item.description
        
        return cell
    }
    
    // how many rows should be in a table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - TableView Delegate Methods
    
    // print the selected cell to debug console and checkmark it
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) {
            if selectedCell.accessoryType == .checkmark {
                selectedCell.accessoryType = .none
            } else {
                selectedCell.accessoryType = .checkmark
                print(itemArray[indexPath.row])
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}



