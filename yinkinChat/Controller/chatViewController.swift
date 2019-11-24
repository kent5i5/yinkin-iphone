
//  chatViewController.swift
//  yinkinChat
//
//  Created by ying kit ng on 8/20/19.
//  Copyright © 2019 ying kit ng. All rights reserved.


import UIKit
import Firebase

class chatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,  UINavigationControllerDelegate {
    
    
    var messageArray : [Message] = [Message]()
//
//   @IBOutlet weak var heighConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextInput: UITextField!
//    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        messageTable.delegate = self
        messageTable.dataSource = self
        
        messageTextInput.delegate = self
    
        // Register MessageCell.xib file
        messageTable.register(UINib(nibName: "messageTableViewCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        retrieveMessages()
        
        messageTable.separatorStyle = .none
        
        self.hideKeyboardWhenTappped()
    }
    
    
    //MARK: - TableView Configuration
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    func configureTableView(){
        
        messageTable.rowHeight = UITableView.automaticDimension
        messageTable.estimatedRowHeight = 120.0
        
    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
//            self.heighConstraint.constant = 358
//            self.view.layoutIfNeeded()
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        UIView.animate(withDuration: 0.5){
//            self.heighConstraint.constant = 50
//            self.view.layoutIfNeeded()
//        }
//    }
    

    //MARK: - TableView DataSource Methods
    
    //MARK: - TableView Config
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! messageTableViewCell
        cell.messageBody.text = messageArray[indexPath.row].MessageBoday
        cell.senderUsername.text = messageArray[indexPath.row].Sender
        
      
        
        return cell
    }
    
//
//    @IBAction func sendButtonPressed(_ sender: Any) {
//
//        messageTextInput.endEditing(true)
//        messageTextInput.isEnabled = false
//        sendButton.isEnabled = false
//
//        let messageDatabase = Database.database().reference().child("Messages")
//
//        let messageDictionary = ["Sender" : Auth.auth().currentUser?.email,
//                                 "MessageBody" : messageTextInput.text]
//
//        messageDatabase.childByAutoId().setValue(messageDictionary) { (error
//            , DatabaseReference) in
//
//            if error != nil {
//                print(error!)
//
//            } else {
//                self.messageTextInput.isEnabled = true
//                self.sendButton.isEnabled = true
//                self.messageTextInput.text = ""
//            }
//        }
//
//
//
//
//    }
//
//    @IBAction func logoutPressed(_ sender: Any) {
//
//        do {
//            try Auth.auth().signOut()
//            navigationController?.popToRootViewController(animated: true)
//        } catch {
//            print ( "there was a problem signing out")
//        }
//
//    }
//
    func retrieveMessages(){

        let messageDatabase = Database.database().reference().child("Messages")

        messageDatabase.observe(.childAdded, with: { (snapshot) in
            let snapshotContext = snapshot.value as! Dictionary<String,String>

            let text = snapshotContext["MessageBody"]!
            let sender = snapshotContext["Sender"]!

            let message = Message()
            message.MessageBoday = text
            message.Sender = sender

            self.messageArray.append(message)

            self.configureTableView()
            self.messageTable.reloadData()

        }) { (error) in
            print(error)

        }

    }
}

