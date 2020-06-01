//
//  ViewController.swift
//  Project21
//
//  Created by Daniel Gx on 01/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Actions
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                debugPrint("Yay!")
            } else {
                debugPrint("D'oh")
            }
        }
    }
    
    @objc func scheduleLOcal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData" : "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
    }

    // MARK: - Methods
    
    func customizeNavigationController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLOcal))
    }
}

// MARK: - Notification Center Delegate

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            debugPrint("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier: debugPrint("Default identifier")
            case "show": debugPrint("Show more information...")
            default: break
            }
        }
        completionHandler()
    }
    
    private func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
}

