//
//  RegisterViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tamAdTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var geriDonButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geriDonButton.setAttributedTitle(NSMutableAttributedString().attributedString(first: "Hesabın var mı? ", second: "Giriş yap!", color: UIColor.darkGray, fontSize: 16), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func kayitOlButtonPressed(_ sender: Any) {
        guard let tamAd = tamAdTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Kisilerdao().kisiEkle(kisi_ad: tamAd, kisi_email: email, kisi_sifre: password)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func geriDonButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
