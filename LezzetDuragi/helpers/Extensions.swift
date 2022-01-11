//
//  Extensions.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 10.01.2022.
//

import UIKit

extension UIViewController{
    func alertTimer(title:String?,mesaj:String?){
        let alert = UIAlertController(title: "", message: mesaj, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1.5
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get{return self.cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
