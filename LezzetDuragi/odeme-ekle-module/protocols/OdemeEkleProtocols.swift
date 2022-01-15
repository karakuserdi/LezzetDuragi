//
//  OdemeEkleProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

protocol PresenterToInteractorOdemeEkleProtocol{
    func odemeEkle(kisi_id:Int,kart_numara:String,kart_isim:String,kart_son_kullanim:String,kart_cvc:String)
}

protocol ViewToPresenterOdemeEkleProtocol{
    var odemeEkleInteractor:PresenterToInteractorOdemeEkleProtocol? {get set}
    
    func ekle(kisi_id:Int,kart_numara:String,kart_isim:String,kart_son_kullanim:String,kart_cvc:String)
}

protocol PresenterToRouterOdemeEkleProtocol{
    static func createModule(ref: OdemeEkleViewController)
}
