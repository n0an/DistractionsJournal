//
//  NotificationsInterfaceController.swift
//  DistractionJournal WatchKit Extension
//
//  Created by nag on 31/05/2019.
//  Copyright © 2019 Anton Novoselov. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications

class NotificationsInterfaceController: WKInterfaceController {

    @IBOutlet weak var picker: WKInterfacePicker!
    
    var hours = 1
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        var pickerItems: [WKPickerItem] = []
        
        for hour in 1...24 {
            let pickerItem = WKPickerItem()
            
            let suffix: String
            
            if hour == 1 {
                suffix = "hour"
            } else{
                suffix = "hours"
            }
            
            pickerItem.title = "\(hour) " + suffix
            pickerItems.append(pickerItem)
        }
        
        picker.setItems(pickerItems)
        
        if let extensionDelegate = WKExtension.shared().delegate as? ExtensionDelegate {
            extensionDelegate.askForNotificationPermission()
        }
    }
    
    
    @IBAction func pickerChanged(_ value: Int) {
        hours = value + 1
    }
    
    @IBAction func startButtonTapped() {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        for hour in 1...hours {
            let content = UNMutableNotificationContent()
            content.body = "Are you still working?"
            
            content.categoryIdentifier = "workingCategory"
            
            let seconds = 20 * hour
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                print("Scheduled")
            }
        }
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            print(requests.count)
        }
        
        pop()
    }
    
    @IBAction func deleteButtonTapped() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            print(requests.count)
        }
        
        pop()
        
    }
}
