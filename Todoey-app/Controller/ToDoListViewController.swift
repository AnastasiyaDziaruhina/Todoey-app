//
//  ViewController.swift
//  Todoey-app
//
//  Created by Stacy on 16.06.22.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var toDoItems: Results<Item>?
    
    var selectedCategory: Category? {
        didSet{
             loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView DataSource methods
    
    // what a cell should display
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel!.text = item.title
            
            //ternary operator==> value = condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done == true ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No Items added"
        }
        
        return cell
    }
    
    // how many rows should be in a table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    //MARK: - TableView Delegate Methods
    
    // print the selected cell to debug console and checkmark it
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                  //  realm.delete(item) // D in CRUD
                   item.done = !item.done
                }
            } catch {
                print("Error saving done status \(error)")
            }
            
        }
            tableView.reloadData()
            
            
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
                
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = textField.text!
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print(error)
                    }
                }
                self.tableView.reloadData()
            }
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
                
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
        
        //MARK: - Model manipulation methods
        
        func loadItems() { // R in CRUD
            
            toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
            
            tableView.reloadData()
        }
        
    }
    
    //MARK: - Search bar methods
    
    
    //extension ToDoListViewController: UISearchBarDelegate {
    //
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //
    //        let request: NSFetchRequest<Item> = Item.fetchRequest()
    //        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    //        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    //
    //        loadItems(with: request)
    //
    //        }
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        if searchBar.text?.count == 0 {
    //            loadItems()
    //
    //            DispatchQueue.main.async {
    //                searchBar.resignFirstResponder()
    //            }
    //
    //        }
    //    }}





