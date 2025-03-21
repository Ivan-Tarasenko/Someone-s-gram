//
//  ActivityIndicator.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 20.03.2025.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        hidesWhenStopped = true
        startAnimating()
        translatesAutoresizingMaskIntoConstraints = false
        accessibilityIdentifier = "activityIndicator"
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
