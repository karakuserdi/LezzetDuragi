//
//  AdresEkleProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

protocol PresenterToInteractorAdresEkleProtocol{
    func adresEkle(kisi_id:Int,adres_baslik:String,adres_il:String,adres_ilce:String,adres_mahalle:String,adres_aciklama:String)
}

protocol ViewToPresenterAdresEkleProtocol{
    var adresEkleInteractor:PresenterToInteractorAdresEkleProtocol? {get set}
    
    func ekle(kisi_id:Int,adres_baslik:String,adres_il:String,adres_ilce:String,adres_mahalle:String,adres_aciklama:String)
}

protocol PresenterToRouterAdresEkleProtocol{
    static func createModule(ref: AdresEkleViewController)
}
