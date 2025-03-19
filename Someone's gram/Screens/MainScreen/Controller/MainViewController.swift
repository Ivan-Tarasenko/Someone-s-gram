//
//  MainViewController.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 17.03.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private var tableView = TableView()
    private let dataSource = TableViewDataSource()
    private let delegate = TableViewDelegate()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configUI()
    }

    

}

private extension MainViewController {
    func configTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    func configUI() {
        title = "News"
    }
}

