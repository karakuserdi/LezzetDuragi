//
//  Adres.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//

import Foundation

class Adres{
    var adres_id:Int?
    var adres_baslik:String?
    var adres_il:String?
    var adres_ilce:String?
    var adres_mahalle:String?
    var adres_aciklama:String?
    var kisi:Kisi?
    
    init(){}
    
    init(adres_id:Int,adres_baslik:String,adres_il:String,adres_ilce:String,adres_mahalle:String,adres_aciklama:String,kisi:Kisi){
        self.adres_id = adres_id
        self.adres_baslik = adres_baslik
        self.adres_il = adres_il
        self.adres_ilce = adres_ilce
        self.adres_mahalle = adres_mahalle
        self.adres_aciklama = adres_aciklama
        self.kisi = kisi
    }
}
