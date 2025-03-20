//
//  MainViewController.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 17.03.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private var tableView = TableView()
    private var dataSource = TableViewDataSource()
    private let delegate = TableViewDelegate()
    
    private let viewModel = ViewModel()
    
    private let netvork = NetworkService()
    
    private var page = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configUI()
        
        setData()
        
        
    }
    
    
    
    
    func setData() {
        
        if CoreDataService.shared.isPostSaved() {
            
            self.dataSource.posts = CoreDataService.shared.fetchSavedPosts()
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self.delegate
            
            print("Открыл из базы")
          
        } else {
            
            netvork.fetchPost(page: page) {[weak self] isPostSaved, error in
                guard let self else { return }
                
                if isPostSaved {
                    self.page += 1
                    print("данные можно отправлять")
                    
                    self.dataSource.posts = CoreDataService.shared.fetchSavedPosts()
                    self.tableView.dataSource = self.dataSource
                    self.tableView.delegate = self.delegate
                    self.tableView.reloadData()
                }
                if error != nil {
                    AlertService.shared.showAlert(title: "Внимание", massage: "Проверьте подключение к сети интернет")
                }
            }
            
        }
    }
}

private extension MainViewController {
    func configTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
//        tableView.dataSource = dataSource
//        tableView.delegate = delegate
//        dataSource.posts = viewModel.fetchPost()
    }
    
    func configUI() {
        title = "News"
    }
}

