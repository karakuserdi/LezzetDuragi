//
//  AdreslerimInteractor.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class AdreslerimInteractor:PresenterToInteractorAdreslerimProtocol{
    var adreslerimPresenter: InteractorToPresenterAdreslerimProtocol?
    
    let db:FMDatabase?

    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("yemekler.sqlite")

        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func adresAl(kisi_id: Int){
        var liste = [Adres]()
        db?.open()

        do {
            let rs = try db!.executeQuery("SELECT * FROM kisi,adres WHERE adres.kisi_id = kisi.kisi_id and adres.kisi_id = ?", values: [kisi_id])

            while rs.next(){
                let list = Kisi(kisi_id: Int(rs.string(forColumn: "kisi_id")!)!, kisi_ad: rs.string(forColumn: "kisi_ad")!, kisi_email: rs.string(forColumn: "kisi_email")!, kisi_sifre: rs.string(forColumn: "kisi_sifre")!)

                let adres = Adres(adres_id: Int(rs.string(forColumn: "adres_id")!)!, adres_baslik: rs.string(forColumn: "adres_baslik")!, adres_il: rs.string(forColumn: "adres_il")!, adres_ilce: rs.string(forColumn: "adres_ilce")!, adres_mahalle: rs.string(forColumn: "adres_mahalle")!, adres_aciklama: rs.string(forColumn: "adres_aciklama")!, kisi: list)

                liste.append(adres)
            }
            adreslerimPresenter?.presenteraVeriGonder(adres: liste)
        } catch {
            print(error.localizedDescription)
        }

        db?.close()
    }
    
    func adresSil(adres_id: Int) {
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM adres WHERE adres_id = ?", values: [adres_id])
            
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
}
