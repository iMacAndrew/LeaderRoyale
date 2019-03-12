//
//  AppDelegate.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/18/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        UINavigationBar.appearance().tintColor = .darkRed
        UINavigationBar.appearance().barTintColor = .darkNavBar
        FirebaseApp.configure()

        GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544/2934735716")

        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)


        let controllerId: String
        if CoreDataManager.shared.clans.isEmpty {
            controllerId = "clanSearchVC"
        } else {
            controllerId = "RootNavigationController"
        }

        let initialViewController = storyboard.instantiateViewController(withIdentifier: controllerId)

        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()


        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataStack.saveContext()
    }

}
