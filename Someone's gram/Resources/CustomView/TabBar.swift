//
//  TabBar.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 21.03.2025.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVC = UINavigationController(rootViewController: MainViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        let messagesVC = UINavigationController(rootViewController: MessageViewController())
        let settingsVC = UINavigationController(rootViewController: SettingViewController())
        
        mainVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "house"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        messagesVC.tabBarItem = UITabBarItem(title: "Message", image: UIImage(systemName: "message"), tag: 2)
        settingsVC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gearshape"), tag: 3)
        
        viewControllers = [mainVC, profileVC, messagesVC, settingsVC]
    }
}
