//
//  SiparisDetayViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 11.01.2022.
//

import UIKit

class SiparisDetayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let content = UNMutableNotificationContent()
        content.title = "Lezzet Durağı"
        content.subtitle = "Sipariş Bilgilendirme"
        content.body = "Siparişiniz yola çıktı ve en kısa sürede elinize ulaşacak. Afiyet olsun :)"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                                                        
        let bildirim = UNNotificationRequest(identifier: "bildirim", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(bildirim, withCompletionHandler: nil)
    }
    
    
}
