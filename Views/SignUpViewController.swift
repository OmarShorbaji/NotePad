//
//  SignUpViewController.swift
//  Notepad
//
//  Created by Khayal Alrubaie on 2023-01-10.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet var FirstNameTextField: UITextField!
    
    
    @IBOutlet var LastNameTextField: UITextField!
    
    
    @IBOutlet var EmailTextField: UITextField!
    
    @IBOutlet var PasswordTextField: UITextField!
    
   
    @IBOutlet var SignUpButton: UIButton!
    
    @IBOutlet var ErrorButton: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    
    func validateFields() -> String? {
        
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            print("1")
            return "Please fill in all fields."
          
        }
        
        let cleanedPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword) == false {
            print("2")
            return "Please ensure that your passwords is at least 8 characters, contains a special character, and a number"
        }
        print("3")
        return nil
        
    }
    
    @IBAction func SignUpTapped(_ sender: UIButton) {
    
        let error = validateFields()
        
        if error != nil {
            
            showError(error!)
            print("4")
            
        }
        
        else {
            
            let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                if err != nil {
                    
                    self.showError("Error creating user")
                    print("5")
                }
                
                else {
                    
                    let db = Firestore.firestore()
                    
                    // Add a new document with a generated ID

                db.collection("users").addDocument(data: [
                        "firstName": firstName,
                        "lastName": lastName,
                        "UID": result!.user.uid
                    ])
                    { (error) in
                        if error != nil {
                            self.showError("Error saving data")
                        }
                        print("6")}
                    
                    print("7")
                    self.transitionHomeScreen()
                    
                }
            }
            
        }
    }
        
        func showError(_ message:String) {
            
            ErrorButton.text = message
            ErrorButton.alpha = 1
            print("8")
        }
        
    
    
    func setUpElements(){
        
        Utility.styleTextField(FirstNameTextField)
        Utility.styleTextField(LastNameTextField)
        Utility.styleTextField(EmailTextField)
        Utility.styleTextField(PasswordTextField)
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        print("9")
        return passwordTest.evaluate(with: password)
    }
    
    func transitionHomeScreen() {
        
        let loginViewcontroller = storyboard?.instantiateViewController(withIdentifier: LoginViewController.loginViewController ) as? LoginViewController
        
        view.window?.rootViewController = loginViewcontroller
        view.window?.makeKeyAndVisible()
        print("10")
        
    }
}
