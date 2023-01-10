//
//  ViewController.swift
//  Notepad
//
//  Created by Khayal Alrubaie on 2023-01-07.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var newRow : [(newTitle:String, newNote:String)] = []
    
    static let notePadViewController = "NotePadView"
    
    
   
    @IBOutlet var AddNewRow: UIBarButtonItem!
    
    let nav = UINavigationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HELLO")
        
        title = "Notes"
        
        
    }

@IBAction func addNewRow(_ sender: Any) {

guard let vc = storyboard?.instantiateViewController(identifier: "NewNote") as? NewNoteViewController else {
        return
    }
    vc.title = "New Note"
    vc.navigationItem.largeTitleDisplayMode = .never
    vc.completion = { noteTitle, note in
        self.navigationController?.popToRootViewController(animated: true)
        self.newRow.append((newTitle : noteTitle, newNote: note))
        self.tableView.reloadData()
        
    }
    navigationController?.pushViewController(vc, animated: true)    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newRow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = newRow[indexPath.row].newTitle
        cell.detailTextLabel?.text = newRow[indexPath.row].newNote
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = newRow[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "NewNote") as? NewNoteViewController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        vc.noteTitle = model.newTitle
        vc.note = model.newNote
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            // Delete the row from the data source
            newRow.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
}
