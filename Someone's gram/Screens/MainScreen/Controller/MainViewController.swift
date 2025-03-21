//
//  MainViewController.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 17.03.2025.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var tableView = TableView()
    private var dataSource = TableViewDataSource()
    private let delegate = TableViewDelegate()
    
    private let viewModel = ViewModel()
    private let network = NetworkService()
    
    private let activityIndicator = ActivityIndicator(style: .large)
     
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configUI()
        
        setData()
        reloadData()
        
        showDetailViewController()
    }
    
    // MARK: - Load data
    func reloadData() {
        delegate.onScrollAction = { [weak self] in
            guard let self else { return }
            setActivityIndicator()
            let page = viewModel.setPage()
            network.fetchPost(page: page) {[weak self] in
                guard let self else { return }
                self.dataSource.posts = CoreDataService.shared.fetchSavedContext()
                self.tableView.dataSource = self.dataSource
                self.tableView.delegate = self.delegate
                self.tableView.reloadData()
                self.delegate.resetEndOfList()
                self.remoteActivityIndicator()
            }
        }
    }
    
    func setData() {
        if CoreDataService.shared.isSavedContext() {
            dataSource.posts = CoreDataService.shared.fetchSavedContext()
            tableView.dataSource = self.dataSource
            tableView.delegate = self.delegate
            remoteActivityIndicator()
        } else {
            let page = viewModel.setPage()
            activityIndicator.startAnimating()
            network.fetchPost(page: page) {[weak self] in
                guard let self else { return }
                self.dataSource.posts = CoreDataService.shared.fetchSavedContext()
                self.tableView.dataSource = self.dataSource
                self.tableView.delegate = self.delegate
                self.tableView.reloadData()
                self.delegate.resetEndOfList()
                self.remoteActivityIndicator()
            }
            
        }
    }
    
    func showDetailViewController() {
        delegate.onTapCell = { [weak self] index in
            guard let self else { return }
            var imageUrl = String()
            let detailVC = DetailViewController()
            imageUrl = CoreDataService.shared.fetchSavedContext()[index].imageUrl ?? ""
            detailVC.modalPresentationStyle = .fullScreen
            detailVC.urlImage = imageUrl
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func setActivityIndicator() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func remoteActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
}


// MARK: - Configuration
private extension MainViewController {
    func configTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func configUI() {
        title = "News"
        
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

