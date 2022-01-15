//
//  AdresEkleViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//

import UIKit

protocol AdresEkleViewControllerProtocol: AnyObject {
    func adresEkleWillDisapear(_ modal: UIViewController)
}

class AdresEkleViewController: UIViewController {
    
    weak var delegate:AdresEkleViewControllerProtocol?
    var adresEklePresenterNesnesi:ViewToPresenterAdresEkleProtocol?
    
    @IBOutlet weak var ilTextField: UITextField!
    @IBOutlet weak var ilceTextField: UITextField!
    @IBOutlet weak var mahalleTextField: UITextField!
    @IBOutlet weak var adresTextField: UITextField!
    @IBOutlet weak var adresBaslikTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        AdresEkleRouter.createModule(ref: self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.adresEkleWillDisapear(self)
    }
    
    @IBAction func adresEkleButtonPressed(_ sender: Any) {
        guard let il = ilTextField.text else {return}
        guard let ilce = ilceTextField.text else {return}
        guard let mahalle = mahalleTextField.text else {return}
        guard let adres = adresTextField.text else {return}
        guard let adresBaslik = adresBaslikTextField.text else {return}
        adresEklePresenterNesnesi?.ekle(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"),
                                        adres_baslik: adresBaslik,
                                        adres_il: il,
                                        adres_ilce: ilce,
                                        adres_mahalle: mahalle,
                                        adres_aciklama: adres)
        self.dismiss(animated: true, completion: nil)
    }
}
