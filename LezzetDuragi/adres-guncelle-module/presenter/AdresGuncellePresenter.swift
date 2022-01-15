//
//  AdresGuncellePresenter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class AdresGuncellePresenter:ViewToPresenterAdresGuncelleProtocol{
    var adresGuncelleInteractor: PresenterToInteractorAdresGuncelleProtocol?
    
    func guncelle(adres_id: Int, adres_baslik: String, adres_il: String, adres_ilce: String, adres_mahalle: String, adres_aciklama: String) {
        adresGuncelleInteractor?.adresGuncelle(adres_id: adres_id, adres_baslik: adres_baslik, adres_il: adres_il, adres_ilce: adres_ilce, adres_mahalle: adres_mahalle, adres_aciklama: adres_aciklama)
    }
}
