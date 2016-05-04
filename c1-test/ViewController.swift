//
//  ViewController.swift
//  c1-test
//
//  Created by Fernando Rocha Silva on 5/3/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var postsArray = [Post]()
    var avatarArray = NSMutableArray()
    
    var isRefreshing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Posts"
        
        //including estimated row height and setting automatic dimension to handle dynamic heights for cells
        tableView.estimatedRowHeight = 105.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //removing blank lines rom table view
        tableView.tableFooterView = UIView()
        
        //initializing refresh control and setting it's action to the method refreshData
        self.refreshControl = UIRefreshControl ()
        self.refreshControl!.addTarget(self, action: #selector(self.refreshData(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        getPostsJSON(Endpoint.Global.url());
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //gets response from API and populates tableview with the parsed data
    func getPostsJSON(URL : String){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: URL)!
        let networkTask = session.dataTaskWithURL(url, completionHandler : {data, response, error -> Void in
            if (error == nil){
                do {
                    let jsonFile = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                
                    guard let data = Data(json: jsonFile!)else {
                        print("Error initializing object")
                        return
                    }
                
                    self.postsArray = (data.entries)!
                    self.populateImageArray(data.entries!)
                
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView!.reloadData()
                        self.isRefreshing = false;
                        
                        self.refreshControl!.endRefreshing()
                        
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    })
                } catch {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.showServerErrorAlert()
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    })
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    self.showServerErrorAlert()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
            }
        })
        
        networkTask.resume()
    }
    
    //function to prepopulate an array with thumbnails, making the request quicker and handling possible reusable cell issues
    func populateImageArray(array: [Post]) {
        //initializing avatarArray
        avatarArray = NSMutableArray()
        
        //for every post, set the correct thumbnail
        for (post) in array {
            //setting the thumbnail
            let imageString : String = post.user.avatarLink
            if !imageString.isEmpty{
                do {
                    let imageURL: NSURL = NSURL(string: imageString)!
                    let imageData: NSData = try NSData(contentsOfURL: imageURL, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                    avatarArray.addObject(UIImage(data: imageData)!)
                }catch {
                    //if the image fails to load, set default image
                    avatarArray.addObject(UIImage(named: "No_Image")!)
                }
            }else{
                //if the image fails to load, set default image
                avatarArray.addObject(UIImage(named: "No_Image")!)
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    //populates the tableview cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "PostTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostTableViewCell
        
        let post : Post = self.postsArray[indexPath.row]
        
        cell.usernameLabel!.text = post.user.username
        
        cell.postLabel!.text = post.text
        
        //setting the thumbnail
        cell.userAvatarImage!.image = (avatarArray.objectAtIndex(indexPath.row) as! UIImage)
        
        cell.userAvatarImage.layer.cornerRadius = 8.0;
        return cell
    }
    
    func refreshData(refreshControl: UIRefreshControl) {
        if (!isRefreshing){
            isRefreshing = true
            getPostsJSON(Endpoint.Global.url());
        }
    }
    
    func showServerErrorAlert(){
        let alert = UIAlertController(title: "Error", message:"Server error", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        self.presentViewController(alert, animated: true){}
        self.isRefreshing = false;
    }
    
}

