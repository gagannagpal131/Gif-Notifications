//
//  ViewController.swift
//  GIF Notifications
//
//  Created by Gagandeep Nagpal on 05/05/17.
//  Copyright © 2017 Gagandeep Nagpal. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var r  = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Request permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge , .alert],completionHandler:{ (granted, error) in
            
            if granted{
                
                print("access granted")
                
            }else{
                
                print(error?.localizedDescription ?? "nil")
            }
            
        })
        
        
    }
    
    
  
    @IBAction func buttonTapped(_ sender: Any) {
        
        r = Int(arc4random_uniform(6)) + 1
    
        scheduleNotification(inSeconds: 4, completion: {Success in
        
            if Success{
                
                print("successful notification")
            }else{
                
                print("notification unsuccessful")
            }
        })

    }
    
    // This is the main function that is used for notifications!
    
    func scheduleNotification(inSeconds:TimeInterval,completion:(_ Success : Bool) -> ()){
        
    
        //To attach the gif files
        let myImage = "gif\(r)"
        
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
         
            return
        }
        
        var attachment : UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        //to define the details of the notification
        let notif = UNMutableNotificationContent()
        
        notif.title = "New Notification"
        notif.subtitle = "Amazing! Isn't it ?"
        notif.body = "Gif Notifications have finally worked"
        notif.attachments = [attachment]
        
        //Notification Trigger
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        //Request for Notification
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        //To check if the notification has been successful or not
        UNUserNotificationCenter.current().add(request,withCompletionHandler: { error in
            
            if error != nil{
                
                print(error!)
            }else{
                
                print("success")            }
            
            
            
        })
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

