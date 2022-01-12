//
//  SiparisDetayViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 11.01.2022.
//

import UIKit
import Lottie

class SiparisDetayViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieAnimation()
        
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
    
    func lottieAnimation(){
        let animationView = AnimationView(name: "ok-done-complete")
        animationView.frame = CGRect(x: 0, y: 00, width: 200, height: 200)
        
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .playOnce
        
    }
    
}
