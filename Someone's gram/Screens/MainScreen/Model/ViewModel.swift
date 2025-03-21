//
//  ViewModel.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 17.03.2025.
//

import Foundation

final class ViewModel {
    
    func setPage() -> Int {
        if !CoreDataService.shared.isSavedContext() {
            return 1
        } else {
            return CoreDataService.shared.fetchSavedContext().count / 10 + 1
        }
    }
}
