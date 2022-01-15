//
//  AdresEkleInteractor.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class AdresEkleInteractor:PresenterToInteractorAdresEkleProtocol{
    let db:FMDatabase?

    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("yemekler.sqlite")

        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func adresEkle(kisi_id:Int,adres_baslik:String,adres_il:String,adres_ilce:String,adres_mahalle:String,adres_aciklama:String) {
        print(kisi_id,adres_baslik,adres_il,adres_ilce,adres_mahalle,adres_aciklama)
        db?.open()

        do{
            try db!.executeUpdate("INSERT INTO adres (adres_baslik,adres_il,adres_ilce,adres_mahalle,adres_aciklama,kisi_id) VALUES (?,?,?,?,?,?)", values: [adres_baslik,adres_il,adres_ilce,adres_mahalle,adres_aciklama,kisi_id])


        }catch{
            print(error.localizedDescription)
        }

        db?.close()
    }
    
    
}
