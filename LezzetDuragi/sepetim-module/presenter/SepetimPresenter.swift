//
//  SepetimPresenter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation

class SepetimPresenter:ViewToPresenterSepetimProtocol{
    var sepetimInteractor: PresenterToInteractorSepetimProtocol?
    var sepetimView: PresenterToViewSepetimProtocol?
    
    func getir(kullanici_adi: String) {
        sepetimInteractor?.tumSepetiGetir(kullanici_adi: kullanici_adi)
    }
    
    func ekle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        sepetimInteractor?.sepeteYemekEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    func sil(sepet_yemek_id: Int, kullanici_adi: String) {
        sepetimInteractor?.sepettenYemekSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func hepsiniSil(sepet_yemek_id:[Int],kullanici_adi: String) {
        sepetimInteractor?.sepetinHepsiniSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
}

extension SepetimPresenter: InteractorToPresenterSepetimProtocol{
    func presenteraVeriGonder(sepetim: Array<SepetYemekler>) {
        sepetimView?.viewaVeriGonder(sepetim: sepetim)
    }
}

