//
//  LoginViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var hesapYokMuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hesapYokMuButton.setAttributedTitle(NSMutableAttributedString().attributedString(first: "Hesabın yok mu? ", second: "Kayıt ol!", color: UIColor.darkGray, fontSize: 16), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        let kisi = Kisilerdao().kullaniciAra(kisi_email: email, kisi_sifre: password)
        
        if kisi.isEmpty{
            alertTimer(title: "", mesaj: "Yanlış kullanıcı adı veya şifre")
        }else{
            for kisi in kisi {
                UserDefaults.standard.set(kisi.kisi_ad!, forKey: "currentUser")
                UserDefaults.standard.set(kisi.kisi_id!, forKey: "currentUserId")
            }
            
            UserDefaults.standard.set(true, forKey: "login")
            let controller = storyboard?.instantiateViewController(withIdentifier: "tabbarVC") as! UITabBarController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        }
        
    }
}

extension NSAttributedString{
    func attributedString(first:String,second:String,color: UIColor, fontSize: CGFloat) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: first, attributes: [.font:UIFont.systemFont(ofSize: fontSize)])
        
        attributedText.append(NSAttributedString(string: second, attributes: [.font:UIFont.boldSystemFont(ofSize: 13),.foregroundColor: color]))
        return attributedText
    }
}
