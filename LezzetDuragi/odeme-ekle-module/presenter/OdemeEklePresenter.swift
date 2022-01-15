//
//  OdemeEklePresenter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class OdemeEklePresenter:ViewToPresenterOdemeEkleProtocol{
    var odemeEkleInteractor: PresenterToInteractorOdemeEkleProtocol?
    
    func ekle(kisi_id: Int, kart_numara: String, kart_isim: String, kart_son_kullanim: String, kart_cvc: String) {
        odemeEkleInteractor?.odemeEkle(kisi_id: kisi_id, kart_numara: kart_numara, kart_isim: kart_isim, kart_son_kullanim: kart_son_kullanim, kart_cvc: kart_cvc)
    }
}
