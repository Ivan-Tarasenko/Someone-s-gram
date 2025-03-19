//
//  TableViewDelegate.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 19.03.2025.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    
    var onScrollAction: (() -> Void)?
    var onTapCell: ((Int) -> Void)?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       600
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height {
             onScrollAction?()
         }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onTapCell?(indexPath.row)
    }
}
