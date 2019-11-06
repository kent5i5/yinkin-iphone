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
        for content in documentArray.content{

            contentTextField.text = contentTextField.text! + content
        }
        for tag in documentArray.tags {
            tagsLabel.text = tagsLabel.text! + " " + tag
        }

        let usLocale = Locale(identifier: "en_US")
        timeLabel.text = documentArray.createdDate.description(with: usLocale)
//
//
//        let url = URL(string: documentArray.thumbnail)!
//        let placeholderImage = UIImage(named: "24_7_support")!
//
//        thumbnail.af_setImage(withURL: url, placeholderImage: placeholderImage)
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
