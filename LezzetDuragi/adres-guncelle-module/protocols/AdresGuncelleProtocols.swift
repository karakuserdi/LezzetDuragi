//
//  AdresGuncelleProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

protocol PresenterToInteractorAdresGuncelleProtocol{
    func adresGuncelle(adres_id:Int,adres_baslik:String,adres_il:String,adres_ilce:String,adres_mahalle:String,adres_aciklama:String)
}

protocol ViewToPresenterAdresGuncelleProtocol{
    var adresGuncelleInteractor:PresenterToInteractorAdresGuncelleProtocol? {get set}
    
    func guncelle(adres_id:Int,adres_baslik:String,adres_il:String,adres_ilce:String,adres_mahalle:String,adres_aciklama:String)
}

protocol PresenterToRouterAdresGuncelleProtocol{
    static func createModule(ref: AdresGuncelleViewController)
}

