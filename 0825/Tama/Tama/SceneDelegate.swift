//
//  SceneDelegate.swift
//  Tama
//
//  Created by Song Kim on 8/23/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let tabBarController = UITabBarController()
        
        let vc1 = SelectTamaViewController()
        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "chart.xyaxis.line"), tag: 0)
        
        // 2번 탭
        let vc2 = LottoViewController()
        let nav2 = UINavigationController(rootViewController: vc2)
        nav2.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gamecontroller"), tag: 1)
        
        // 3번 탭
        let vc3 = BoxViewController()
        let nav3 = UINavigationController(rootViewController: vc3)
        nav3.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "movieclapper"), tag: 2)
        
        // 탭바 설정
        tabBarController.viewControllers = [nav1, nav2, nav3]
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
