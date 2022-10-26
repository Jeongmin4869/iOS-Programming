//
//  AppDelegate.swift
//  Homepwner
//
//  Created by 이정민 on 2022/09/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let itemStore = ItemStore()
    
    //이미지 저장소 접근권한
    let imageStore = ImageStore()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //self.window = UIWindow(frame: UIScreen.main.bounds)
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let itemsController = storyboard.instantiateViewController(withIdentifier: "ItemsViewController") as! ItemsViewController
        
        let navigationController = window!.rootViewController as! UINavigationController
        let itemsController = navigationController.viewControllers[0] as! ItemsViewController
        
        //초기 데이터 설정
        itemsController.itemStore = itemStore
        //window?.rootViewController = itemsController
        //window?.makeKeyAndVisible()

        itemsController.imageStore = imageStore
        
        
        return true
    }


}

