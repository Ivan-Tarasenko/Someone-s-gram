//
//  TableViewDataSource.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 19.03.2025.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath)
                as? TableViewCell else { fatalError("cell null")}
        
        
        return cell
    }
    
    
    
}

