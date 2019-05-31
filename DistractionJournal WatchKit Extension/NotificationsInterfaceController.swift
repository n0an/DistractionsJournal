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
            extensionDelegate.askForNotification()
        }
        
    }
    
    
    @IBAction func pickerChanged(_ value: Int) {
        
        
        
    }
    
    
    @IBAction func startButtonTapped() {
        
        let content = UNMutableNotificationContent()
        content.body = "Are you still working?"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("Scheduled")
            
            
        }
        
        
        
    }
    
    @IBAction func deleteButtonTapped() {
        
    }
    
    
    
}
