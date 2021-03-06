//
//  DetayPresenter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation

class DetayPresenter:ViewToPresenterDetayProtocol{
    var detayInteractor: PresenterToInteractorDetayProtocol?
    var detayView: PresenterToViewDetayProtocol?
    
    func yemekSil(sepet_yemek_id: Int, kullanici_adi: String) {
        detayInteractor?.sepettenYemekSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func sepetYemekAl(kullanici_adi: String,yemek_ad:String) {
        detayInteractor?.sepetYemekleriAl(kullanici_adi: kullanici_adi,yemek_ad: yemek_ad)
    }
    
    func ekle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        detayInteractor?.sepeteYemekEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    func al(yemek_id: Int) {
        detayInteractor?.yemekAl(yemek_id: yemek_id)
    }
    
    func begenildiMi(yemek_id: Int, yemek_isLiked: String) {
        detayInteractor?.yemekBegenildiMi(yemek_id: yemek_id, yemek_isLiked: yemek_isLiked)
    }
}

extension DetayPresenter:InteractorToPresenterDetayProtocol{
    func presenteraVeriGonder(yemek_isLikes: String) {
        detayView?.viewaVeriGonder(yemek_isLikes: yemek_isLikes)
    }
    
    func presentaraYemekGonder(sepetYemek:SepetYemekler) {
        detayView?.viewaYemekGonder(sepetYemek:sepetYemek)
    }
}
