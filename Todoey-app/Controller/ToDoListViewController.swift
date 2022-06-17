//
//  ViewController.swift
//  Todoey-app
//
//  Created by Stacy on 16.06.22.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Item1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Item2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Item3"
        itemArray.append(newItem3)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
    }
    
    //MARK: - TableView DataSource methods
    
    // what a cell should display
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel!.text = item.title
        
        //ternary operator==> value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    // how many rows should be in a table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - TableView Delegate Methods
    
    // print the selected cell to debug console and checkmark it
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done // замена if-else
        saveItems()
        //tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add new items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //read textfiled values + safety check
            guard let field = alert.textFields, field.count == 1 else {
                return
            }
            
            let alertField = field[0]
            guard let alert = alertField.text, !alert.isEmpty else {
                print("The string is empty")
                return
            }
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            self.saveItems()
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model manipulation methods
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array,\(error)")
        }
        
        tableView.reloadData()
    }

    
}



