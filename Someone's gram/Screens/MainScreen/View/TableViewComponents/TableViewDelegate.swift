//
//  TableViewDelegate.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 19.03.2025.
//

import UIKit

final class TableViewDelegate: NSObject, UITableViewDelegate {
    
    var onScrollAction: (() -> Void)?
    
    var isEndOfList: Bool = false
    
    var onTapCell: ((Int) -> Void)?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isAtBottom = scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height - 100
        if isAtBottom, !isEndOfList {
            isEndOfList = true
            onScrollAction?()
        }
    }
    
    func resetEndOfList() {
        isEndOfList = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onTapCell?(indexPath.row)   // передает индекс тапнутой ячейки в MainCV
    }
}
