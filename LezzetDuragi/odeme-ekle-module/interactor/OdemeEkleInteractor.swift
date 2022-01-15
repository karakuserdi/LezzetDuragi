//
//  OdemeEkleInteractor.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class OdemeEkleInteractor:PresenterToInteractorOdemeEkleProtocol{
    let db:FMDatabase?

    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("yemekler.sqlite")

        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func odemeEkle(kisi_id: Int, kart_numara: String, kart_isim: String, kart_son_kullanim: String, kart_cvc: String) {
        db?.open()

        do{
            try db!.executeUpdate("INSERT INTO kart (kart_numara,kart_isim,kart_son_kullanim,kart_cvc,kisi_id) VALUES (?,?,?,?,?)", values: [kart_numara,kart_isim,kart_son_kullanim,kart_cvc,kisi_id])

        }catch{
            print(error.localizedDescription)
        }

        db?.close()
    }
    
}
