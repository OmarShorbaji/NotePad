//
//  LoginViewController.swift
//  Notepad
//
//  Created by Khayal Alrubaie on 2023-01-10.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    static let loginViewController = "LoginVC"
    
    let newViewController = ViewController()
    
    @IBOutlet var EmailTextField: UITextField!
    
    @IBOutlet var PasswordTextField: UITextField!
    
    
    @IBOutlet var Login: UIButton!
    
    @IBOutlet var Error: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            
            showError(error!)
            
            
        }
        
        else {
            
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { result, err in
                if err != nil {
                    
                    self.showError("Error Logging in")
                }
                
                else { self.transitiontoNotePad() }
            }
        }
    }
    
    func setUpElements(){
        
        Utility.styleTextField(EmailTextField)
        Utility.styleTextField(PasswordTextField)
    }
    
    func validateFields() -> String? {
        
        if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
            
        }
        return nil
        
    }
        func showError(_ message:String) {
            
            Error.text = message
            Error.alpha = 1
        }
        
    func transitiontoNotePad() {
        
        
        let NotePadViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: NotePadViewController)
        self.present(navigationController, animated: true, completion: nil)

        print("Hi")
    }
        
}
