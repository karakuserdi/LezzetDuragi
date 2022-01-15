//
//  OdemeGuncelleProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

protocol PresenterToInteractorOdemeGuncelleProtocol{
    func odemeGuncelle(kart_id:Int,kart_numara:String,kart_isim:String,kart_son_kullanim:String,kart_cvc:String)
}

protocol ViewToPresenterOdemeGuncelleProtocol{
    var odemeGuncelleInteractor:PresenterToInteractorOdemeGuncelleProtocol? {get set}
    
    func guncelle(kart_id:Int,kart_numara:String,kart_isim:String,kart_son_kullanim:String,kart_cvc:String)
}

protocol PresenterToRouterOdemeGuncelleProtocol{
    static func createModule(ref: OdemeGuncelleViewController)
}
