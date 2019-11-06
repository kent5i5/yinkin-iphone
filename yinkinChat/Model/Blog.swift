//
//  Blog.swift
//  yinkinChat
//
//  Created by ying kit ng on 10/1/19.
//  Copyright © 2019 ying kit ng. All rights reserved.
//

import Foundation
import Firebase

class Blog{
    var author : String = ""
    var content = [String]()
    var createdDate = Date()
    var pictures = [String]()
    var tags = [String]()
    var thumbnail : String = ""
    var title: String = ""
    
//    init() {
//        author = ""
//        content = []
//        pictures = []
//        tags = []
//        thumbnail = ""
//        title = ""
//    }
    
}

/* author
content 0 1 ...
pictures 0 1 ...
tags 0 1 ...
thumbnail
 title*/
