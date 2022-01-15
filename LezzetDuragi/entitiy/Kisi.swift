//
//  Kisi.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//


import Foundation

class Kisi{
    var kisi_id:Int?
    var kisi_ad:String?
    var kisi_email:String?
    var kisi_sifre:String?
    
    init(){}
    
    init(kisi_id:Int,kisi_ad:String,kisi_email:String,kisi_sifre:String){
        self.kisi_id = kisi_id
        self.kisi_ad = kisi_ad
        self.kisi_email = kisi_email
        self.kisi_sifre = kisi_sifre
    }
}
