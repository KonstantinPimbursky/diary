//
//  AppDelegate.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 03.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let calendarController = CalendarController()
        let navigationController = UINavigationController(rootViewController: calendarController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
