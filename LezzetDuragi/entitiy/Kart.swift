//
//  Kart.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//

import Foundation

class Kart{
    var kart_id:Int?
    var kart_numara:String?
    var kart_isim:String?
    var kart_son_kullanim:String?
    var kart_cvc:String?
    var kisi:Kisi?
    
    init(){}
    
    init(kart_id:Int,kart_numara:String,kart_isim:String,kart_son_kullanim:String,kart_cvc:String,kisi:Kisi){
        self.kart_id = kart_id
        self.kart_numara = kart_numara
        self.kart_isim = kart_isim
        self.kart_son_kullanim = kart_son_kullanim
        self.kart_cvc = kart_cvc
        self.kisi = kisi
    }
}
