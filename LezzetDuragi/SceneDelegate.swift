//
//  SceneDelegate.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var izinKontrol:Bool = false


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let winScane = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScane)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { granted,error in
            self.izinKontrol = granted
            
            if granted{
                print("izin alma işlemi başarılı")
            }else{
                print("izin alma işlemi başarısız")
            }
        })
        
        //**********************************************************************************************************************
        //Onboarding ekranı veya tabbar
        let login = UserDefaults.standard.bool(forKey: "login")
        let first = UserDefaults.standard.bool(forKey: "firstTime")
        
        if first{
            if login{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "tabbarVC") as! UITabBarController
                window?.rootViewController = vc
                window?.makeKeyAndVisible()
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
                window?.rootViewController = vc
                window?.makeKeyAndVisible()
            }
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "onboardingVC") as! OnboardingViewController
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

