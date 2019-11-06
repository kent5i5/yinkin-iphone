//
//  NewStoryViewController.swift
//  yinkinChat
//
//  Created by ying kit ng on 10/3/19.
//  Copyright © 2019 ying kit ng. All rights reserved.
//
//
import UIKit

protocol createNewPostDelegate {
   
    func dataDidFinishEnterData(blogData: Blog)
}

public extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}

class NewStoryViewController: UIViewController , UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var titleInput: UITextField!
    @IBOutlet var authorInput: UITextField!
    @IBOutlet var contentInput1: UITextView!
//    @IBOutlet var contentInput2: UITextView!
//    @IBOutlet var contentInput3: UITextView!
    @IBOutlet var tagsInput: UITextField!
    
    var delegate : createNewPostDelegate?
    var blog = Blog()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.hideKeyboardWhenTappped()
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(self.keyboardNotifications(notification:)),
        name: UIResponder.keyboardWillChangeFrameNotification,
        object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.hideKeyboardWhenTappped()
        
    }
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        var newHeight: CGFloat = 0.0
//         if (textView == self.contentInput3) {
//                   //scrollView.setContentOffset(CGPoint(x: 0, y: 112), animated: true)
//
//                   newHeight = newHeight - 100
//            print(newHeight)
//            self.view.frame.origin.y = newHeight
//        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        var newHeight: CGFloat = 0.0
        if (textField == self.titleInput) {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true )
        }
        else if (textField == self.authorInput) {
           // scrollView.setContentOffset(CGPoint(x: 0, y: 10), animated: true)
            newHeight = 10.0
            self.view.frame.origin.y -= newHeight
        }
//        else if (textField == self.contentInput3) {
//            //scrollView.setContentOffset(CGPoint(x: 0, y: 112), animated: true)
//            newHeight = 100.0
//            self.view.frame.origin.y -= newHeight
//        }
//        else if (textField == self.tagsInput) {
//            scrollView.setContentOffset(CGPoint(x: 0, y: 142), animated: true)
//        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    // This method will notify when keyboard appears/ dissapears
    @objc func keyboardNotifications(notification: NSNotification) {

        var accurateY = 0.0  //Using this we will calculate the selected textFields Y Position

        if let activeTextField = UIResponder.currentFirst() as? UITextField {
            // Here we will get accurate frame of which textField is selected if there are multiple textfields
            let frame = self.view.convert(activeTextField.frame, from:activeTextField.superview)
            accurateY = Double(frame.origin.y) + Double(frame.size.height)
        }

        if let userInfo = notification.userInfo {
            // here we will get frame of keyBoard (i.e. x, y, width, height)

            let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let keyBoardFrameY = keyBoardFrame!.origin.y

            var newHeight: CGFloat = 0.0
            //Check keyboards Y position and according to that move view up and down
            if keyBoardFrameY >= UIScreen.main.bounds.size.height {
                newHeight = 0.0
            } else {
                if accurateY >= Double(keyBoardFrameY) { // if textfields y is greater than keyboards y then only move View to up
                    if #available(iOS 11.0, *) {
                        newHeight = -CGFloat(accurateY - Double(keyBoardFrameY)) - self.view.safeAreaInsets.bottom
                    } else {
                        newHeight = -CGFloat(accurateY - Double(keyBoardFrameY)) - 5
                    }
                }
            }
            //set the Y position of view
            self.view.frame.origin.y = newHeight
        }
    }
    
    
    @IBAction func createBtnPressed(_ sender: Any) {
            blog.title = titleInput.text!
            blog.author = authorInput.text!
            blog.content.append(contentInput1.text!)
//            blog.content.append(contentInput2.text!)
//            blog.content.append(contentInput3.text!)
            blog.tags.append(tagsInput.text!)
               
        delegate?.dataDidFinishEnterData(blogData: blog)
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToPreview"  {
//            let destination = segue.destination as! PreviewViewController
//
//            destination.titleData = titleInput.text!
//            destination.authorData = authorInput.text!
//            destination.content1 = contentInput1.text!
//            destination.content2 = contentInput2.text!
//            destination.content3 = contentInput3.text!
//            destination.tags = tagsInput.text!
//
//        }
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
