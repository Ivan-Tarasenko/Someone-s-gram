//
//  TableView.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 19.03.2025.
//

import UIKit

class TableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        accessibilityIdentifier = "tableView"
        registrationCell()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registrationCell() {
        register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
    }
    
    private func setupUI() {
        backgroundColor = .background
        showsVerticalScrollIndicator = false
        separatorStyle = .none
    }
}
