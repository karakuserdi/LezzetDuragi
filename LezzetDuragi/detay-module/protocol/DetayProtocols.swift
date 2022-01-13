//
//  DetayProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation

protocol PresenterToInteractorDetayProtocol{
    var detayPresenter:InteractorToPresenterDetayProtocol? {get set}
    
    func sepettenYemekSil(sepet_yemek_id: Int, kullanici_adi: String)
    func sepetYemekleriAl(kullanici_adi: String,yemek_ad:String)
    func sepeteYemekEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
    func yemekAl(yemek_id: Int)
    func yemekBegenildiMi(yemek_id: Int, yemek_isLiked: String)
}

protocol ViewToPresenterDetayProtocol{
    var detayInteractor:PresenterToInteractorDetayProtocol? {get set}
    var detayView:PresenterToViewDetayProtocol? {get set}
    
    func yemekSil(sepet_yemek_id: Int, kullanici_adi: String)
    func sepetYemekAl(kullanici_adi:String,yemek_ad:String)
    func ekle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
    func al(yemek_id: Int)
    func begenildiMi(yemek_id: Int, yemek_isLiked: String)
}

protocol InteractorToPresenterDetayProtocol{
    func presenteraVeriGonder(yemek_isLikes:String)
    func presentaraYemekGonder(sepetYemek:SepetYemekler)
}

protocol PresenterToViewDetayProtocol{
    func viewaVeriGonder(yemek_isLikes:String)
    func viewaYemekGonder(sepetYemek:SepetYemekler)
}

protocol PresenterToRouterDetayProtocol{
    static func createModule(ref:DetayViewController)
}
