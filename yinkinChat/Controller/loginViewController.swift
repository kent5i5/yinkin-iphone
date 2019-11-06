//
//  loginViewController.swift
//  yinkinChat
//
//  Created by ying kit ng on 8/20/19.
//  Copyright © 2019 ying kit ng. All rights reserved.
//

import UIKit
import Firebase

protocol UserStatus {
   
    func dataDidFinishLogin()
}

extension UIViewController{
    func hideKeyboardWhenTappped(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    @objc func  dismissKeyboard(){
        
        view.endEditing(true)
    }
}

class loginViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    var delegate : UserStatus?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappped()
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
        Auth.auth().signIn(withEmail: usernameInput.text!, password: passwordInput.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                self.delegate?.dataDidFinishLogin()
                self.dismiss(animated: true, completion: nil)
                //self.performSegue(withIdentifier: "moveToChat", sender: self)
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
