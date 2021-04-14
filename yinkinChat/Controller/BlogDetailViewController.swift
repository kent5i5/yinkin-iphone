//
//  BlogDetailViewController.swift
//  yinkinChat
//
//  Created by ying kit ng on 10/1/19.
//  Copyright © 2019 ying kit ng. All rights reserved.
//
//import Alamofire
//import AlamofireImage

import UIKit
import MarkdownKit

class BlogDetailViewController: UIViewController {

    var documentArray = Blog()

    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var contentTextField: UITextView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tagsLabel: UILabel!
    @IBOutlet var thumbnail: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        authorLabel.text = documentArray.author
        titleLabel.text = documentArray.title
        //let size = documentArray.content.count
        contentTextField.text = ""
        let markdownParser = MarkdownParser()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.red,
            .font: UIFont.boldSystemFont(ofSize: 36)
        ]
        let markdown = NSMutableAttributedString(string: "", attributes: attributes)
        for content in documentArray.content{
            
           // let markdown = "I support a *lot* of custom Markdown **Elements**, even `code`!"
            markdown.append(markdownParser.parse(content))
       
            print(markdown)
           
        }
        contentTextField.attributedText = markdown

        

        for tag in documentArray.tags {
            tagsLabel.text = tagsLabel.text! + " " + tag
        }

        let usLocale = Locale(identifier: "en_US")
        timeLabel.text = documentArray.createdDate.description(with: usLocale)
        
        

        
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
