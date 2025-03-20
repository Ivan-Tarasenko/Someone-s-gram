//
//  Bundle+key.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 20.03.2025.
//

import Foundation

extension Bundle {
    var apiKey: String {
        return object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
}
