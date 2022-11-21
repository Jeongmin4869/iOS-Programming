//
//  AppDelegate.swift
//  Photorama
//
//  Created by 이정민 on 2022/11/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //let rootViewController = window!.rootViewController as! UINavigationController

        let rootViewController = window!.rootViewController as! UINavigationController
        let photoViewController = rootViewController.viewControllers[0] as! PhotoViewController
        photoViewController.photoStore = PhotosStore()
        
        return true
    }

    // MARK: UISceneSession Lifecycle


}

