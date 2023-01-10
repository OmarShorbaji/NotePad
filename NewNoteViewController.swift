//
//  NewNoteViewController.swift
//  Notepad
//
//  Created by Khayal Alrubaie on 2023-01-07.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet var textField: UITextView!
    
    @IBOutlet var titleField: UITextField!
    
    
    public var completion: ((String, String) -> Void)?
    
    public var noteTitle: String = "Title"
    public var note: String = "Write notes here"

       override func viewDidLoad() {
           super.viewDidLoad()
           titleField.text = noteTitle
           textField.text = note
           
           titleField.becomeFirstResponder()
           
           navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
             }

             @objc func didTapSave() {
                 if let text = titleField.text, !text.isEmpty, !textField.text.isEmpty {
                     completion?(text, textField.text)
                 }
             }

        // Do any additional setup after loading the view.
    }
    

