//
//  BlogViewController.swift
//  yinkinChat
//
//  Created by ying kit ng on 10/1/19.
//  Copyright © 2019 ying kit ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
//import Alamofire
//import AlamofireImage



class BlogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, createNewPostDelegate, UserStatus  {
    
    var db: Firestore!
    var documentArray = [Blog]()
    var selectedRow: Int?
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    let dispatchQueue = DispatchQueue(label: "24_7_support")
 
    
    @IBOutlet var insertLinkIcon: UIBarButtonItem!
    var blog = Blog()
    var UserIsLogin: Bool = false

   
    @IBOutlet weak var blogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        blogTableView.delegate = self
        blogTableView.dataSource = self
        
     
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()

        retrieveEntireCollection()
      
    }
    
    // show white screen while loading datas
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (documentArray.count == 0){
            activityIndicatorView.startAnimating()
            self.blogTableView.separatorStyle = .none
            
            dispatchQueue.async { Thread.sleep(forTimeInterval:3) }
        }
        OperationQueue.main.addOperation {
            
            self.activityIndicatorView.stopAnimating()
            self.blogTableView.separatorStyle = .singleLine

        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "blogCell", for: indexPath) as! BlogTableViewCell
        
        cell.titleLabel.text = documentArray[indexPath.row].title
        cell.authorLabel.text = documentArray[indexPath.row].author
  
     
//       guard let url = try? URL(string: documentArray[indexPath.row].thumbnail) else {
//            fatalError("bad image!")
//        }
//            let placeholderImage = UIImage(named: "24_7_support")!
//
//            cell.thumbnail.af_setImage(withURL: url, placeholderImage: placeholderImage)
        
        let usLocale = Locale(identifier: "en_US")
        cell.dateLabel.text = documentArray[indexPath.row].createdDate.description(with: usLocale)
        
        cell.tag = indexPath.row
        return cell
    }
   
    //This method isn’t called when the isEditing property of the table is set to true 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath) as! BlogTableViewCell
        //performSegue(withIdentifier: "goToBlogdetail", sender: cell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Scroll View Methods
    
    
    func showButtonPressed(){
       // performSegue(withIdentifier: "goToBlogDetail", sender: Any?.self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToBlogdetail" {
            
            let destinatin = segue.destination as! BlogDetailViewController
            if let  data = sender as? BlogTableViewCell {
                destinatin.documentArray = self.documentArray[data.tag]
            }
        }
        
        if segue.identifier == "goToLogin" {
            let destinationVC = segue.destination as! loginViewController
            destinationVC.delegate = self
        }

        if segue.identifier == "createNewPost" {
           
                let destinationVC = segue.destination as! NewStoryViewController
                // Use delegate function to return the data
                //let blog = destination.dataDidFinishEnterData()
                destinationVC.delegate = self
                self.blogTableView.reloadData()
                if blog.author != "" && blog.title != "" && blog.content[0] != "" {

                   print(blog.author)
                }
            
        }
        
    }
    
    //MARK: - Protocol Delegate Method
    func dataDidFinishEnterData(blogData: Blog) {
    //        if  titleInput.text?.isEmpty ?? true && authorInput.text?.isEmpty ?? true && contentInput1.text?.isEmpty ?? true && contentInput2.text?.isEmpty ?? true && contentInput3.text?.isEmpty ?? true && tagsInput.text?.isEmpty ?? true {
        self.blog = blogData
        createNewPost()
        
           
    }
    
    func dataDidFinishLogin() {
        if let auth = Auth.auth().currentUser {
            
          } else {
            
            insertLinkIcon.image = nil
        }
    }
    

  
    //MARK Firestore functions
    func retrieveDocumentById(index: Int){
        let docRef = db.collection("blog").document("blodId" + String(index+1))
            
        docRef.getDocument(source: .cache) { (document, error) in
                   
                    if let document = document {
                       //let dataDescription = document.data().map(String.init(describing:)) ?? "nil print("Cached document data: \(dataDescription)")
                      
                        let blog = Blog()
                        
                        blog.author = document["author"] as! String
                        blog.content = document["content"] as![String]
                        blog.pictures = document["pictures"] as! [String]
                        blog.tags = document["tags"] as! [String]
                        blog.thumbnail = document["thumbnail"] as! String
                        blog.title = document["title"] as! String
                        self.documentArray.append(blog)
                        
                    }else {
                         print("Document does not exist in cache")
                    }
            }
        for (blog) in self.documentArray{
                     print(blog.author)
                     print(blog.content)
                     print(blog.pictures)
                     print(blog.tags)
                     print(blog.thumbnail)
                     print(blog.title)
                     print("----")
                     
                 }
        self.blogTableView.reloadData()
    }
    
    // retrieve the collection from firestore and store as generic blog object
    func retrieveEntireCollection(){
            db.collection("blog").getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                //for (blogkey, blogvalue) in document.data() {
                                 //print("\(blogkey) : \(blogvalue)")
                             let blog = Blog()
            
                             blog.author = document.data()["author"] as! String
                             blog.content = document.data()["content"] as![String]
                                blog.createdDate = (document.data()["createdDate"] as! Timestamp).dateValue()
                             blog.pictures = document.data()["pictures"] as! [String]
                             blog.tags = document.data()["tags"] as! [String]
                             blog.thumbnail = document.data()["thumbnail"] as! String
                             blog.title = document.data()["title"] as! String
                             self.documentArray.append(blog)
            
                            }
                        }
                    self.blogTableView.reloadData()
//                      for (blog) in self.documentArray{
//                          print(blog.author) print(blog.content) print(blog.pictures)
//                          print(blog.tags)  print(blog.thumbnail)   print(blog.title)
//                          print("----")   }
            
             }
        
    } // end of retrieveEntireCollection
    
    func createNewPost(){
        //add new document to firestore
        let docData: [String: Any] = [
            "author": blog.author,
            "content": blog.content,
            "createdDate": Timestamp(date: Date()),
            "pictures": ["y.png","k.png"], // need fix
            "tags": blog.tags,  // need fix
            "thumbnail": "placement txt",
            "title": blog.title,
        ]
        let currentNumberOfPost = documentArray.count
        db.collection("blog").document("blodId" +  "\(currentNumberOfPost+1)").setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
   
    
    // pagenate retrieve with a listener function
    func retrieveFivePostCollection(){
        let firstFiveBlog = db.collection("blog")
                .order(by: "createdDate")
                .limit(to: 5)

        firstFiveBlog.addSnapshotListener { (snapshot, error) in
                    guard let snapshot = snapshot else{
                            print(error!)
                    return
                    }
            guard let lastSnapshot = snapshot.documents.last else{
                //collect is empty
                return }
                    
            let next = self.db.collection("blog").order(by: "createdDate").start(afterDocument: lastSnapshot)

        } // listener
    }
    
}//end of BlogViewController





