//
//  registerViewController.swift
//  yinkinChat
//
//  Created by ying kit ng on 8/20/19.
//  Copyright © 2019 ying kit ng. All rights reserved.
//
//
import UIKit
import Firebase

//extension UINavigationController{
//    
//    open override var shouldAutorotate: Bool {
//        return true
//    }
//    
//    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return (visibleViewController?.supportedInterfaceOrientations)!
//    }
//}


class registerViewController: UIViewController{

    @IBOutlet weak var emailTextInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappped()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        //register new user with Firebase
        Auth.auth().createUser(withEmail: emailTextInput.text!, password: passwordInput.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                //success
                
                self.performSegue(withIdentifier: "moveToChat", sender: self)
            }
        }
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextInput.text!, password: passwordInput.text!) { (user, error) in
                   if error != nil {
                       print(error!)
                   } else {
                       
                       
                       
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
