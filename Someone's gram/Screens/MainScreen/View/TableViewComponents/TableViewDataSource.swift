//
//  TableViewDataSource.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 19.03.2025.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var posts: [PostEntity] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath)
                as? TableViewCell else { fatalError("cell null")}
        
        let post = posts[indexPath.row]
        
        cell.setAvatar(imageURL: post.authorAvatar)
        cell.setImage(imageURL: post.imageUrl)
        cell.setName(post.authorName)
        cell.setDescription(post.desc)
        cell.setNumberOfLikes(post.likes)
        cell.isLiked(post.isLiked)
        cell.setCreatedDate(post.createdDate)
        
        cell.onTapLike = {[] in
            cell.putALike(in: post)
        }
        
        return cell
    }
    
    
    
}

