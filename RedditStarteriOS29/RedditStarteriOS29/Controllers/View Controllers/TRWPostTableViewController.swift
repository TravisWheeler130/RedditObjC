//
//  TRWPostTableViewController.swift
//  RedditStarteriOS29
//
//  Created by Travis Wheeler on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class TRWPostTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        TRWPostController.shared().fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Posts source of truth is empty")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TRWPostController.shared().posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? TRWPostTableViewCell else {return UITableViewCell()}

        let post = TRWPostController.shared().posts[indexPath.row]
        
        cell.TitleTextView.text = post.title
        
        cell.ImageView.image = nil
        TRWPostController.shared().fetchImage(for: post) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    cell.ImageView.image = image
                }
            }
        }
        // Configure the cell...

        return cell
    }

}
