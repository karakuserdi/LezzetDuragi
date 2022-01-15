//
//  OdemeEkleViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import UIKit

protocol OdemeEkleViewControllerProtocol: AnyObject {
    func odemeEkleWillDisapear(_ modal: UIViewController)
}

class OdemeEkleViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var kartImageView: UIImageView!
    
    @IBOutlet weak var kartNoLabel: UILabel!
    @IBOutlet weak var kartAdLabel: UILabel!
    @IBOutlet weak var sonKullanimTarihLabel: UILabel!
    @IBOutlet weak var cvcLabel: UILabel!
    
    @IBOutlet weak var kartSahibiTextField: UITextField!
    @IBOutlet weak var kartNoTextField: UITextField!
    @IBOutlet weak var sonKullanimTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    
    var isOpen = false
    weak var delegate:OdemeEkleViewControllerProtocol?
    var odemeEklePresenterNesnesi:ViewToPresenterOdemeEkleProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvcLabel.isHidden = true
        
        kartSahibiTextField.delegate = self
        kartNoTextField.delegate = self
        sonKullanimTextField.delegate = self
        cvcTextField.delegate = self
        
        OdemeEkleRouter.createModule(ref: self)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.odemeEkleWillDisapear(self)
    }
    
    @IBAction func kartButtonPressed(_ sender: Any) {
        if isOpen{
            isOpen = false
            let image = UIImage(named: "card-front")
            kartImageView.image = image
            UIView.transition(with: kartImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil) { bool in
                self.kartNoLabel.isHidden = false
                self.kartAdLabel.isHidden = false
                self.sonKullanimTarihLabel.isHidden = false
                self.cvcLabel.isHidden = true
            }
        }else{
            isOpen = true

            let image = UIImage(named: "card-back")
            kartImageView.image = image
            UIView.transition(with: kartImageView, duration: 0.3, options: .transitionFlipFromRight, animations: nil) { bool in
                self.kartNoLabel.isHidden = true
                self.kartAdLabel.isHidden = true
                self.sonKullanimTarihLabel.isHidden = true
                self.cvcLabel.isHidden = false
            }
        }
    }
    
    @IBAction func kaydetButtonPressed(_ sender: Any) {
        guard let kartSahibi = kartSahibiTextField.text else {return}
        guard let kartNo = kartNoTextField.text else {return}
        guard let tarih = sonKullanimTextField.text else {return}
        guard let cvc = cvcTextField.text else {return}
        
        kartNoLabel.text = kartNo
        kartAdLabel.text = kartSahibi
        sonKullanimTarihLabel.text = tarih
        cvcLabel.text = cvc
        
        odemeEklePresenterNesnesi?.ekle(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"), kart_numara: kartNo, kart_isim: kartSahibi, kart_son_kullanim: tarih, kart_cvc: cvc)
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let kartSahibi = kartSahibiTextField.text else {return}
        guard let kartNo = kartNoTextField.text else {return}
        guard let tarih = sonKullanimTextField.text else {return}
        guard let cvc = cvcTextField.text else {return}
        
        kartNoLabel.text = kartNo
        kartAdLabel.text = kartSahibi
        sonKullanimTarihLabel.text = tarih
        cvcLabel.text = cvc
    }
}
