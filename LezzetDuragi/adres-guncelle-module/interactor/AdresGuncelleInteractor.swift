//
//  AdresGuncelleInteractor.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class AdresGuncelleInteractor:PresenterToInteractorAdresGuncelleProtocol{
    let db:FMDatabase?

    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("yemekler.sqlite")

        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func adresGuncelle(adres_id:Int,adres_baslik:String,adres_il:String,adres_ilce:String,adres_mahalle:String,adres_aciklama:String) {
        db?.open()

        do {
            try db!.executeUpdate("UPDATE adres SET adres_baslik = ?,adres_il = ?,adres_ilce = ?,adres_mahalle = ?,adres_aciklama = ? WHERE adres_id = ?", values: [adres_baslik,adres_il,adres_ilce,adres_mahalle,adres_aciklama,adres_id])
        } catch {
            print(error.localizedDescription)
        }

        db?.close()
    }
}
