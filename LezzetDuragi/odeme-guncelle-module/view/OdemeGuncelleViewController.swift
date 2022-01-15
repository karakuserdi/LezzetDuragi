//
//  OdemeGuncelleViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import UIKit

protocol OdemeGuncelleViewControllerProtocol{
    func odemeGuncelleWillDisapear(_ modal: UIViewController)
}

class OdemeGuncelleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var kartImageView: UIImageView!
    
    @IBOutlet weak var kartCvcLabel: UILabel!
    @IBOutlet weak var kartNoLAbel: UILabel!
    @IBOutlet weak var kartTarihLabel: UILabel!
    @IBOutlet weak var kartSahibiLabel: UILabel!
    
    
    @IBOutlet weak var kartSahibTextField: UITextField!
    @IBOutlet weak var kartNoTextField: UITextField!
    @IBOutlet weak var kartTarihTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    
    var isOpen = false
    var odemeGuncellePresenterNesnesi:ViewToPresenterOdemeGuncelleProtocol?
    var delegate:OdemeGuncelleViewControllerProtocol?
    var kart:Kart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kartSahibTextField.delegate = self
        kartNoTextField.delegate = self
        kartTarihTextField.delegate = self
        cvcTextField.delegate = self
        
        OdemeGuncelleRouter.createModule(ref: self)
        if let kart = kart{
            kartSahibiLabel.text = kart.kart_isim
            kartNoLAbel.text = kart.kart_numara
            kartTarihLabel.text = kart.kart_son_kullanim
            kartCvcLabel.text = kart.kart_cvc
            
            kartSahibTextField.text = kart.kart_isim
            kartNoTextField.text = kart.kart_numara
            kartTarihTextField.text = kart.kart_son_kullanim
            cvcTextField.text = kart.kart_cvc
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.odemeGuncelleWillDisapear(self)
    }
    
    @IBAction func kartButtonPressed(_ sender: Any) {
        if isOpen{
            isOpen = false
            let image = UIImage(named: "card-front")
            kartImageView.image = image
            UIView.transition(with: kartImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil) { bool in
                self.kartNoLAbel.isHidden = false
                self.kartSahibiLabel.isHidden = false
                self.kartTarihLabel.isHidden = false
                self.kartCvcLabel.isHidden = true
            }
        }else{
            isOpen = true
            let image = UIImage(named: "card-back")
            kartImageView.image = image
            UIView.transition(with: kartImageView, duration: 0.3, options: .transitionFlipFromRight, animations: nil) { bool in
                self.kartNoLAbel.isHidden = true
                self.kartSahibiLabel.isHidden = true
                self.kartTarihLabel.isHidden = true
                self.kartCvcLabel.isHidden = false
            }
        }
    }
    
    @IBAction func guncelleButtonPressed(_ sender: Any) {
        guard let sahibi = kartSahibTextField.text else {return}
        guard let no = kartNoTextField.text else {return}
        guard let tarih = kartTarihTextField.text else {return}
        guard let cvc = cvcTextField.text else {return}
        
        odemeGuncellePresenterNesnesi?.guncelle(kart_id: self.kart!.kart_id!, kart_numara: no, kart_isim: sahibi, kart_son_kullanim: tarih, kart_cvc: cvc)
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let kartSahibi = kartSahibTextField.text else {return}
        guard let kartNo = kartNoTextField.text else {return}
        guard let tarih = kartTarihTextField.text else {return}
        guard let cvc = cvcTextField.text else {return}
        
        kartNoLAbel.text = kartNo
        kartSahibiLabel.text = kartSahibi
        kartTarihLabel.text = tarih
        kartCvcLabel.text = cvc
    }
    
}
