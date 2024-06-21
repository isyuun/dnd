//
//  AppDelegate5.swift
//  PetTip
//
//  Created by isyuun on 2024/6/21.
//

import UIKit

class AppDelegate5: AppDelegate4 {
    override func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // let ret = super.application(application, configurationForConnecting: connectingSceneSession, options: options)
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate3.self
        return sceneConfig
    }

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let ret = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        // 원하는 시간만큼 sleep 시키기( 초 단위 )
        Thread.sleep(forTimeInterval: 0.5)
        return ret
    }
}
