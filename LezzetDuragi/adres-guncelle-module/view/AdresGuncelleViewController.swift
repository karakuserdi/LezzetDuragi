//
//  AdresGuncelleViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import UIKit

protocol AdresGuncelleViewControllerProtocol{
    func adresGuncelleWillDisapear(_ modal: UIViewController)
}

class AdresGuncelleViewController: UIViewController {
    
    @IBOutlet weak var ilTextField: UITextField!
    @IBOutlet weak var ilceTextField: UITextField!
    @IBOutlet weak var mahalleTextField: UITextField!
    @IBOutlet weak var adresTextField: UITextField!
    @IBOutlet weak var adresBaslikTextField: UITextField!
    
    var adresGuncellePresenterNesnesi:ViewToPresenterAdresGuncelleProtocol?
    var delegate:AdresGuncelleViewControllerProtocol?
    var adres:Adres?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AdresGuncelleRouter.createModule(ref: self)
        if let adres = adres{
            ilTextField.text = adres.adres_il
            ilceTextField.text = adres.adres_ilce
            mahalleTextField.text = adres.adres_mahalle
            adresTextField.text = adres.adres_aciklama
            adresBaslikTextField.text = adres.adres_baslik
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.adresGuncelleWillDisapear(self)
    }
    
    @IBAction func guncelleButtonPressed(_ sender: Any) {
        guard let il = ilTextField.text else {return}
        guard let ilce = ilceTextField.text else {return}
        guard let mahalle = mahalleTextField.text else {return}
        guard let adres = adresTextField.text else {return}
        guard let adresBaslik = adresBaslikTextField.text else {return}
        
        adresGuncellePresenterNesnesi?.guncelle(adres_id: self.adres!.adres_id!, adres_baslik: adresBaslik, adres_il: il, adres_ilce: ilce, adres_mahalle: mahalle, adres_aciklama: adres)
        dismiss(animated: true, completion: nil)
    }
    
}
